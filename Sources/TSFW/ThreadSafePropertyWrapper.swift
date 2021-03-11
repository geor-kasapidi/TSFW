@propertyWrapper
@dynamicMemberLookup
public final class ThreadSafe<Root> {
    private let lock = OSUnfairLock()

    private var value: Root

    public init(wrappedValue: Root) {
        self.value = wrappedValue
    }

    public var projectedValue: ThreadSafe<Root> { self }

    public var wrappedValue: Root {
        get { self.lock.execute { self.value } }
        set { self.lock.execute { self.value = newValue } }
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<Root, Value>) -> Value {
        self.lock.execute { self.value[keyPath: keyPath] }
    }

    public func read<Value>(_ action: (Root) -> Value) -> Value {
        self.lock.execute { action(self.value) }
    }

    @discardableResult
    public func write<Value>(_ action: (inout Root) -> Value) -> Value {
        self.lock.execute { action(&self.value) }
    }
}
