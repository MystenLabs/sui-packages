module 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker {
    struct LoyaltyRecord has store, key {
        id: 0x2::object::UID,
        owner: address,
        stake_start_ms: u64,
        last_checkpoint_ms: u64,
        streak_days: u64,
    }

    public fun days_staked(arg0: &LoyaltyRecord, arg1: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg1) - arg0.stake_start_ms) / 86400000
    }

    public fun multiplier_bp(arg0: &LoyaltyRecord, arg1: &0x2::clock::Clock) : u64 {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.stake_start_ms) / 86400000;
        let v1 = if (v0 >= 365) {
            20000
        } else if (v0 >= 180) {
            18000
        } else if (v0 >= 90) {
            15000
        } else if (v0 >= 30) {
            12000
        } else {
            10000
        };
        let v2 = v1 + arg0.streak_days * 3000 / 30;
        if (v2 > 20000) {
            20000
        } else {
            v2
        }
    }

    public fun new_record(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : LoyaltyRecord {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        LoyaltyRecord{
            id                 : 0x2::object::new(arg1),
            owner              : 0x2::tx_context::sender(arg1),
            stake_start_ms     : v0,
            last_checkpoint_ms : v0,
            streak_days        : 0,
        }
    }

    public fun owner(arg0: &LoyaltyRecord) : address {
        arg0.owner
    }

    public fun reset(arg0: &mut LoyaltyRecord, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.stake_start_ms = v0;
        arg0.last_checkpoint_ms = v0;
        arg0.streak_days = 0;
    }

    public fun streak_days(arg0: &LoyaltyRecord) : u64 {
        arg0.streak_days
    }

    public fun tick(arg0: &mut LoyaltyRecord, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0 - arg0.last_checkpoint_ms;
        if (v1 >= 86400000) {
            arg0.streak_days = arg0.streak_days + v1 / 86400000;
            if (arg0.streak_days > 30) {
                arg0.streak_days = 30;
            };
            arg0.last_checkpoint_ms = v0;
        };
    }

    // decompiled from Move bytecode v7
}

