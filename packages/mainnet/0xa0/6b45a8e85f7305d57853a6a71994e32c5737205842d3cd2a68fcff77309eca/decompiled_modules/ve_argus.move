module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::ve_argus {
    struct VeArgus has key {
        id: 0x2::object::UID,
        locked: 0x2::balance::Balance<0x2::sui::SUI>,
        unlock_ts_ms: u64,
        created_ts_ms: u64,
    }

    struct VeLockCreated has copy, drop {
        owner: address,
        amount: u64,
        unlock_ts_ms: u64,
        initial_voting_power: u64,
    }

    struct VeLockExtended has copy, drop {
        ve_id: address,
        new_unlock_ts_ms: u64,
        new_voting_power: u64,
    }

    struct VeWithdrawn has copy, drop {
        ve_id: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun created_ts(arg0: &VeArgus) : u64 {
        arg0.created_ts_ms
    }

    public fun extend_lock(arg0: &mut VeArgus, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 >= 604800000, 3);
        assert!(arg1 <= 126144000000, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 + arg1;
        assert!(v1 > arg0.unlock_ts_ms, 3);
        arg0.unlock_ts_ms = v1;
        let v2 = VeLockExtended{
            ve_id            : 0x2::object::uid_to_address(&arg0.id),
            new_unlock_ts_ms : v1,
            new_voting_power : voting_power_at(arg0, v0),
        };
        0x2::event::emit<VeLockExtended>(v2);
    }

    public fun increase_amount(arg0: &mut VeArgus, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun lock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 604800000, 3);
        assert!(arg1 <= 126144000000, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + arg1;
        let v3 = VeArgus{
            id            : 0x2::object::new(arg3),
            locked        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            unlock_ts_ms  : v2,
            created_ts_ms : v1,
        };
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = VeLockCreated{
            owner                : v4,
            amount               : v0,
            unlock_ts_ms         : v2,
            initial_voting_power : voting_power_at(&v3, v1),
        };
        0x2::event::emit<VeLockCreated>(v5);
        0x2::transfer::transfer<VeArgus>(v3, v4);
    }

    public fun locked_amount(arg0: &VeArgus) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.locked)
    }

    public fun unlock_ts(arg0: &VeArgus) : u64 {
        arg0.unlock_ts_ms
    }

    public fun voting_power(arg0: &VeArgus, arg1: &0x2::clock::Clock) : u64 {
        voting_power_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun voting_power_at(arg0: &VeArgus, arg1: u64) : u64 {
        if (arg1 >= arg0.unlock_ts_ms) {
            return 0
        };
        (((0x2::balance::value<0x2::sui::SUI>(&arg0.locked) as u128) * ((arg0.unlock_ts_ms - arg1) as u128) / (126144000000 as u128)) as u64)
    }

    public fun withdraw(arg0: VeArgus, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.unlock_ts_ms, 1);
        let VeArgus {
            id            : v1,
            locked        : v2,
            unlock_ts_ms  : _,
            created_ts_ms : _,
        } = arg0;
        let v5 = v2;
        let v6 = v1;
        0x2::object::delete(v6);
        let v7 = VeWithdrawn{
            ve_id        : 0x2::object::uid_to_address(&v6),
            amount       : 0x2::balance::value<0x2::sui::SUI>(&v5),
            timestamp_ms : v0,
        };
        0x2::event::emit<VeWithdrawn>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg2)
    }

    // decompiled from Move bytecode v7
}

