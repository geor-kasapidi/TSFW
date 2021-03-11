import os

public final class OSUnfairLock {
    private let pointer: os_unfair_lock_t

    public init() {
        self.pointer = .allocate(capacity: 1)
        self.pointer.initialize(to: os_unfair_lock())
    }

    deinit {
        self.pointer.deinitialize(count: 1)
        self.pointer.deallocate()
    }

    public func lock() {
        os_unfair_lock_lock(self.pointer)
    }

    public func unlock() {
        os_unfair_lock_unlock(self.pointer)
    }

    public func execute<T>(_ action: () -> T) -> T {
        self.lock(); defer { self.unlock() }
        return action()
    }
}
