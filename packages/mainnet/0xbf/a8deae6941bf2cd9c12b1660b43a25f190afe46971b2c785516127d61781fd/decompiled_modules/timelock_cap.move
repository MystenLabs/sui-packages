module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::timelock_cap {
    struct TimelockCap has key {
        id: 0x2::object::UID,
        locked: bool,
        depositor: address,
        beneficiary: address,
        unlock_at_ms: u64,
        min_delay_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CapDeposited has copy, drop {
        timelock: address,
        depositor: address,
        beneficiary: address,
        unlock_at_ms: u64,
    }

    struct CapWithdrawn has copy, drop {
        timelock: address,
        beneficiary: address,
    }

    struct CapCancelled has copy, drop {
        timelock: address,
        depositor: address,
    }

    struct MinDelayUpdated has copy, drop {
        old_delay_ms: u64,
        new_delay_ms: u64,
    }

    public fun beneficiary(arg0: &TimelockCap) : address {
        arg0.beneficiary
    }

    public(friend) entry fun cancel<T0: store + key>(arg0: &mut TimelockCap, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.locked, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.depositor, 4);
        let v0 = arg0.depositor;
        arg0.locked = false;
        arg0.depositor = @0x0;
        arg0.beneficiary = @0x0;
        arg0.unlock_at_ms = 0;
        0x2::transfer::public_transfer<T0>(arg1, v0);
        let v1 = CapCancelled{
            timelock  : 0x2::object::uid_to_address(&arg0.id),
            depositor : v0,
        };
        0x2::event::emit<CapCancelled>(v1);
    }

    public(friend) entry fun deposit<T0: store + key>(arg0: &mut TimelockCap, arg1: address, arg2: u64, arg3: T0, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 6);
        assert!(arg2 >= arg0.min_delay_ms, 7);
        assert!(!arg0.locked, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4) + arg2;
        let v2 = 0x2::object::uid_to_address(&arg0.id);
        arg0.depositor = v0;
        arg0.beneficiary = arg1;
        arg0.unlock_at_ms = v1;
        arg0.locked = true;
        0x2::transfer::public_transfer<T0>(arg3, v2);
        let v3 = CapDeposited{
            timelock     : v2,
            depositor    : v0,
            beneficiary  : arg1,
            unlock_at_ms : v1,
        };
        0x2::event::emit<CapDeposited>(v3);
    }

    public fun depositor(arg0: &TimelockCap) : address {
        arg0.depositor
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TimelockCap{
            id           : 0x2::object::new(arg0),
            locked       : false,
            depositor    : @0x0,
            beneficiary  : @0x0,
            unlock_at_ms : 0,
            min_delay_ms : 172800000,
        };
        0x2::transfer::share_object<TimelockCap>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_locked(arg0: &TimelockCap) : bool {
        arg0.locked
    }

    public fun min_delay_ms(arg0: &TimelockCap) : u64 {
        arg0.min_delay_ms
    }

    public(friend) entry fun set_min_delay(arg0: &AdminCap, arg1: &mut TimelockCap, arg2: u64) {
        arg1.min_delay_ms = arg2;
        let v0 = MinDelayUpdated{
            old_delay_ms : arg1.min_delay_ms,
            new_delay_ms : arg2,
        };
        0x2::event::emit<MinDelayUpdated>(v0);
    }

    public fun unlock_at_ms(arg0: &TimelockCap) : u64 {
        arg0.unlock_at_ms
    }

    public(friend) entry fun withdraw<T0: store + key>(arg0: &mut TimelockCap, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.locked, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.unlock_at_ms, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.beneficiary, 5);
        arg0.locked = false;
        arg0.depositor = @0x0;
        arg0.beneficiary = @0x0;
        arg0.unlock_at_ms = 0;
        0x2::transfer::public_transfer<T0>(arg1, v0);
        let v1 = CapWithdrawn{
            timelock    : 0x2::object::uid_to_address(&arg0.id),
            beneficiary : v0,
        };
        0x2::event::emit<CapWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

