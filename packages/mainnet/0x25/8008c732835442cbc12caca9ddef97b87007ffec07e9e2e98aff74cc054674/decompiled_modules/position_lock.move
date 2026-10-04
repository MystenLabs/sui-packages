module 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::position_lock {
    struct PositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionLock has key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        snapshot: 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::Snapshot,
        locked_at_ms: u64,
        unlock_at_ms: u64,
        unlocked: bool,
    }

    struct LockCap has key {
        id: 0x2::object::UID,
        lock_id: 0x2::object::ID,
    }

    struct FeeBorrow {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower_bits: u32,
        tick_upper_bits: u32,
        liquidity: u128,
        locked_at_ms: u64,
        unlock_at_ms: u64,
        creator: address,
    }

    struct LockExtended has copy, drop {
        lock_id: 0x2::object::ID,
        previous_unlock_at_ms: u64,
        unlock_at_ms: u64,
    }

    struct PositionBorrowed has copy, drop {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct PositionReturned has copy, drop {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct PositionUnlocked has copy, drop {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        recipient: address,
        unlocked_at_ms: u64,
    }

    struct LockMadePermanent has copy, drop {
        lock_id: 0x2::object::ID,
        previous_unlock_at_ms: u64,
    }

    struct CapTransferred has copy, drop {
        lock_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    public fun borrow<T0: store + key>(arg0: &mut PositionLock, arg1: &LockCap) : (T0, FeeBorrow) {
        assert_position_type<T0>();
        borrow_unchecked<T0>(arg0, arg1)
    }

    public fun new<T0: store + key>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (PositionLock, LockCap) {
        assert_position_type<T0>();
        new_unchecked<T0>(arg0, arg1, arg2, arg3)
    }

    public fun liquidity(arg0: &PositionLock) : u128 {
        0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::liquidity(&arg0.snapshot)
    }

    public fun pool_id(arg0: &PositionLock) : 0x2::object::ID {
        0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::pool_id(&arg0.snapshot)
    }

    public fun tick_lower_bits(arg0: &PositionLock) : u32 {
        0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_lower_bits(&arg0.snapshot)
    }

    public fun tick_upper_bits(arg0: &PositionLock) : u32 {
        0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_upper_bits(&arg0.snapshot)
    }

    fun assert_cap(arg0: &PositionLock, arg1: &LockCap) {
        assert!(arg1.lock_id == 0x2::object::id<PositionLock>(arg0), 5);
    }

    fun assert_position_type<T0>() {
        assert!(0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::is_cetus_position<T0>(), 0);
    }

    fun assert_valid_unlock(arg0: u64, arg1: u64) {
        assert!(arg1 > arg0, 1);
        assert!(arg1 - arg0 <= 315360000000, 2);
        assert!(arg1 % 86400000 == 0, 3);
    }

    public(friend) fun borrow_unchecked<T0: store + key>(arg0: &mut PositionLock, arg1: &LockCap) : (T0, FeeBorrow) {
        assert_cap(arg0, arg1);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<PositionKey, T0>(&arg0.id, v0), 7);
        let v1 = PositionKey{dummy_field: false};
        let v2 = 0x2::object::id<PositionLock>(arg0);
        let v3 = PositionBorrowed{
            lock_id     : v2,
            position_id : arg0.position_id,
        };
        0x2::event::emit<PositionBorrowed>(v3);
        let v4 = FeeBorrow{
            lock_id     : v2,
            position_id : arg0.position_id,
        };
        (0x2::dynamic_object_field::remove<PositionKey, T0>(&mut arg0.id, v1), v4)
    }

    public fun cap_id(arg0: &PositionLock) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun cap_lock_id(arg0: &LockCap) : 0x2::object::ID {
        arg0.lock_id
    }

    public fun extend(arg0: &mut PositionLock, arg1: &LockCap, arg2: &0x2::clock::Clock, arg3: u64) {
        assert_cap(arg0, arg1);
        assert!(arg0.unlock_at_ms != 18446744073709551615, 14);
        assert!(arg3 > arg0.unlock_at_ms, 4);
        assert_valid_unlock(0x2::clock::timestamp_ms(arg2), arg3);
        arg0.unlock_at_ms = arg3;
        let v0 = LockExtended{
            lock_id               : 0x2::object::id<PositionLock>(arg0),
            previous_unlock_at_ms : arg0.unlock_at_ms,
            unlock_at_ms          : arg3,
        };
        0x2::event::emit<LockExtended>(v0);
    }

    public fun held_position_id(arg0: &PositionLock) : 0x1::option::Option<0x2::object::ID> {
        let v0 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::id<PositionKey>(&arg0.id, v0)
    }

    public fun is_permanent(arg0: &PositionLock) : bool {
        arg0.unlock_at_ms == 18446744073709551615
    }

    public fun is_unlockable(arg0: &PositionLock, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.unlocked) {
            if (!is_permanent(arg0)) {
                0x2::clock::timestamp_ms(arg1) >= arg0.unlock_at_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_unlocked(arg0: &PositionLock) : bool {
        arg0.unlocked
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_position_type<T0>();
        lock_unchecked<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun lock_unchecked<T0: store + key>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_unchecked<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<LockCap>(v1, 0x2::tx_context::sender(arg3));
        share(v0);
    }

    public fun locked_at_ms(arg0: &PositionLock) : u64 {
        arg0.locked_at_ms
    }

    public fun make_permanent(arg0: &mut PositionLock, arg1: &LockCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.unlock_at_ms != 18446744073709551615, 14);
        arg0.unlock_at_ms = 18446744073709551615;
        let v0 = LockMadePermanent{
            lock_id               : 0x2::object::id<PositionLock>(arg0),
            previous_unlock_at_ms : arg0.unlock_at_ms,
        };
        0x2::event::emit<LockMadePermanent>(v0);
    }

    public(friend) fun new_unchecked<T0: store + key>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (PositionLock, LockCap) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert_valid_unlock(v0, arg2);
        let v1 = 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::read<T0>(&arg0);
        let v2 = 0x2::object::id<T0>(&arg0);
        let v3 = 0x2::object::new(arg3);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = LockCap{
            id      : 0x2::object::new(arg3),
            lock_id : v4,
        };
        let v6 = 0x2::object::id<LockCap>(&v5);
        let v7 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, T0>(&mut v3, v7, arg0);
        let v8 = LockCreated{
            lock_id         : v4,
            cap_id          : v6,
            position_id     : v2,
            pool_id         : 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::pool_id(&v1),
            tick_lower_bits : 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_lower_bits(&v1),
            tick_upper_bits : 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_upper_bits(&v1),
            liquidity       : 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::liquidity(&v1),
            locked_at_ms    : v0,
            unlock_at_ms    : arg2,
            creator         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LockCreated>(v8);
        let v9 = PositionLock{
            id           : v3,
            position_id  : v2,
            cap_id       : v6,
            snapshot     : v1,
            locked_at_ms : v0,
            unlock_at_ms : arg2,
            unlocked     : false,
        };
        (v9, v5)
    }

    public fun position_id(arg0: &PositionLock) : 0x2::object::ID {
        arg0.position_id
    }

    public fun repay<T0: store + key>(arg0: &mut PositionLock, arg1: T0, arg2: FeeBorrow) {
        assert_position_type<T0>();
        repay_unchecked<T0>(arg0, arg1, arg2);
    }

    public(friend) fun repay_unchecked<T0: store + key>(arg0: &mut PositionLock, arg1: T0, arg2: FeeBorrow) {
        let FeeBorrow {
            lock_id     : v0,
            position_id : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<PositionLock>(arg0), 8);
        assert!(0x2::object::id<T0>(&arg1) == v1, 9);
        let v2 = 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::read<T0>(&arg1);
        let v3 = &arg0.snapshot;
        assert!(0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::pool_id(&v2) == 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::pool_id(v3), 10);
        assert!(0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_lower_bits(&v2) == 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_lower_bits(v3) && 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_upper_bits(&v2) == 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::tick_upper_bits(v3), 11);
        assert!(0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::liquidity(&v2) == 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::liquidity(v3), 12);
        let v4 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, T0>(&mut arg0.id, v4, arg1);
        let v5 = PositionReturned{
            lock_id     : v0,
            position_id : v1,
        };
        0x2::event::emit<PositionReturned>(v5);
    }

    public fun share(arg0: PositionLock) {
        0x2::transfer::share_object<PositionLock>(arg0);
    }

    public fun snapshot(arg0: &PositionLock) : 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout::Snapshot {
        arg0.snapshot
    }

    public fun transfer_cap(arg0: LockCap, arg1: address) {
        assert!(arg1 != @0x0, 13);
        let v0 = CapTransferred{
            lock_id   : arg0.lock_id,
            cap_id    : 0x2::object::id<LockCap>(&arg0),
            recipient : arg1,
        };
        0x2::event::emit<CapTransferred>(v0);
        0x2::transfer::transfer<LockCap>(arg0, arg1);
    }

    public fun unlock<T0: store + key>(arg0: &mut PositionLock, arg1: LockCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_position_type<T0>();
        unlock_unchecked<T0>(arg0, arg1, arg2, arg3);
    }

    public fun unlock_at_ms(arg0: &PositionLock) : u64 {
        arg0.unlock_at_ms
    }

    public(friend) fun unlock_unchecked<T0: store + key>(arg0: &mut PositionLock, arg1: LockCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_cap(arg0, &arg1);
        assert!(arg0.unlock_at_ms != 18446744073709551615, 14);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.unlock_at_ms, 6);
        let v1 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<PositionKey, T0>(&arg0.id, v1), 7);
        let v2 = PositionKey{dummy_field: false};
        let LockCap {
            id      : v3,
            lock_id : _,
        } = arg1;
        0x2::object::delete(v3);
        arg0.unlocked = true;
        let v5 = 0x2::tx_context::sender(arg3);
        let v6 = PositionUnlocked{
            lock_id        : 0x2::object::id<PositionLock>(arg0),
            position_id    : arg0.position_id,
            recipient      : v5,
            unlocked_at_ms : v0,
        };
        0x2::event::emit<PositionUnlocked>(v6);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<PositionKey, T0>(&mut arg0.id, v2), v5);
    }

    // decompiled from Move bytecode v7
}

