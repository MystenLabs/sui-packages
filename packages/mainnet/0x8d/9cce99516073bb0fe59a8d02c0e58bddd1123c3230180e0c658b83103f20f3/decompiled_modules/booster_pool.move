module 0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::booster_pool {
    struct BoosterPool has key {
        id: 0x2::object::UID,
        maya_balance: 0x2::balance::Balance<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>,
        burnt_maya_balance: 0x2::balance::Balance<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>,
        last_refill_timestamp: u64,
        total_refill: u64,
    }

    public(friend) fun burn_maya(arg0: &mut BoosterPool, arg1: 0x2::balance::Balance<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>) : u64 {
        0x2::balance::join<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(&mut arg0.burnt_maya_balance, arg1);
        0x2::balance::value<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(&arg1)
    }

    public(friend) fun calc_bonus(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / 1000) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BoosterPool{
            id                    : 0x2::object::new(arg0),
            maya_balance          : 0x2::balance::zero<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(),
            burnt_maya_balance    : 0x2::balance::zero<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(),
            last_refill_timestamp : 0,
            total_refill          : 0,
        };
        0x2::transfer::share_object<BoosterPool>(v0);
    }

    public(friend) fun take_bonus(arg0: &mut BoosterPool, arg1: u64) : 0x2::balance::Balance<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA> {
        assert!(0x2::balance::value<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(&arg0.maya_balance) >= arg1, 0);
        0x2::balance::split<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(&mut arg0.maya_balance, arg1)
    }

    public fun top_up(arg0: &mut BoosterPool, arg1: 0x2::coin::Coin<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>, arg2: &0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(arg1);
        arg0.total_refill = arg0.total_refill + 0x2::balance::value<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(&v0);
        arg0.last_refill_timestamp = 0x2::clock::timestamp_ms(arg3);
        0x2::balance::join<0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya::MAYA>(&mut arg0.maya_balance, v0);
    }

    // decompiled from Move bytecode v6
}

