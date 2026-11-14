module 0x49d525986b52160298166c58009937c1d63f361c298579cd061e8d778e410532::safe_spool {
    struct Spool has store, key {
        id: 0x2::object::UID,
        index: u64,
        rewards: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SpoolAccount has store, key {
        id: 0x2::object::UID,
        spool_id: 0x2::object::ID,
        stake: u64,
        index: u64,
        points: u64,
    }

    public fun new_spool(arg0: u64, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : Spool {
        Spool{
            id      : 0x2::object::new(arg2),
            index   : arg0,
            rewards : arg1,
        }
    }

    public fun open_account(arg0: &Spool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SpoolAccount {
        SpoolAccount{
            id       : 0x2::object::new(arg2),
            spool_id : 0x2::object::id<Spool>(arg0),
            stake    : arg1,
            index    : arg0.index,
            points   : 0,
        }
    }

    public fun points(arg0: &SpoolAccount) : u64 {
        arg0.points
    }

    public fun redeem_rewards(arg0: &mut SpoolAccount, arg1: &mut Spool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.spool_id == 0x2::object::id<Spool>(arg1), 1);
        arg0.points = 0;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.rewards, arg0.points), arg2)
    }

    public fun rewards_value(arg0: &Spool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.rewards)
    }

    public fun update_points(arg0: &mut SpoolAccount, arg1: &Spool) {
        assert!(arg0.spool_id == 0x2::object::id<Spool>(arg1), 1);
        arg0.points = arg0.points + arg0.stake * (arg1.index - arg0.index);
        arg0.index = arg1.index;
    }

    // decompiled from Move bytecode v7
}

