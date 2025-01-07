module 0x8f2df5102958dbf09eadb84c8ddf8435fbc733aee4d2c01162cfb757be12e7f3::booster_pool {
    struct TopUpEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct BoosterPool has key {
        id: 0x2::object::UID,
        maya_balance: 0x2::balance::Balance<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>,
        burnt_maya_balance: 0x2::balance::Balance<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>,
        last_refill_timestamp: u64,
        total_refill: u64,
    }

    public(friend) fun burn_maya(arg0: &mut BoosterPool, arg1: 0x2::balance::Balance<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>) : u64 {
        0x2::balance::join<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&mut arg0.burnt_maya_balance, arg1);
        0x2::balance::value<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&arg1)
    }

    public fun burnt_maya_balance(arg0: &BoosterPool) : u64 {
        0x2::balance::value<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&arg0.burnt_maya_balance)
    }

    public(friend) fun calc_bonus(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / 1000) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BoosterPool{
            id                    : 0x2::object::new(arg0),
            maya_balance          : 0x2::balance::zero<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(),
            burnt_maya_balance    : 0x2::balance::zero<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(),
            last_refill_timestamp : 0,
            total_refill          : 0,
        };
        0x2::transfer::share_object<BoosterPool>(v0);
    }

    public fun last_refill_timestamp(arg0: &BoosterPool) : u64 {
        arg0.last_refill_timestamp
    }

    public fun maya_balance(arg0: &BoosterPool) : u64 {
        0x2::balance::value<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&arg0.maya_balance)
    }

    public(friend) fun take_bonus(arg0: &mut BoosterPool, arg1: u64) : 0x2::balance::Balance<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA> {
        assert!(0x2::balance::value<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&arg0.maya_balance) >= arg1, 0);
        0x2::balance::split<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&mut arg0.maya_balance, arg1)
    }

    public fun top_up(arg0: &mut BoosterPool, arg1: 0x2::coin::Coin<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>, arg2: &0x8f2df5102958dbf09eadb84c8ddf8435fbc733aee4d2c01162cfb757be12e7f3::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(arg1);
        arg0.total_refill = arg0.total_refill + 0x2::balance::value<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&v0);
        arg0.last_refill_timestamp = 0x2::clock::timestamp_ms(arg3);
        0x2::balance::join<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&mut arg0.maya_balance, v0);
        let v1 = TopUpEvent{
            sender : 0x2::tx_context::sender(arg4),
            amount : 0x2::balance::value<0xa1a3142246c2ce30ca9c6c5c8e6fb70e5bd6e54c02edbca7001913472b267662::staging_maya::STAGING_MAYA>(&v0),
        };
        0x2::event::emit<TopUpEvent>(v1);
    }

    public fun total_refill(arg0: &BoosterPool) : u64 {
        arg0.total_refill
    }

    // decompiled from Move bytecode v6
}

