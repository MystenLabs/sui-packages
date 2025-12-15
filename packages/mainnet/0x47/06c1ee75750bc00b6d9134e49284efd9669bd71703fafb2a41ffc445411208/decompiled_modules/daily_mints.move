module 0x4706c1ee75750bc00b6d9134e49284efd9669bd71703fafb2a41ffc445411208::daily_mints {
    struct DailyMints has store, key {
        id: 0x2::object::UID,
        today: 0x2::table::Table<address, u64>,
        nostalgia: 0x2::table::Table<address, u64>,
        last_reward_ms: 0x2::table::Table<address, u64>,
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DailyMints{
            id             : 0x2::object::new(arg0),
            today          : 0x2::table::new<address, u64>(arg0),
            nostalgia      : 0x2::table::new<address, u64>(arg0),
            last_reward_ms : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<DailyMints>(v0);
    }

    public fun record_mint_activity(arg0: &mut DailyMints, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) {
        if (arg2 == 1) {
            if (0x2::table::contains<address, u64>(&mut arg0.today, arg1)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.today, arg1) = 0x2::clock::timestamp_ms(arg3) / 86400000;
            } else {
                0x2::table::add<address, u64>(&mut arg0.today, arg1, 0x2::clock::timestamp_ms(arg3) / 86400000);
            };
        } else if (0x2::table::contains<address, u64>(&mut arg0.nostalgia, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.nostalgia, arg1) = 0x2::clock::timestamp_ms(arg3) / 86400000;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nostalgia, arg1, 0x2::clock::timestamp_ms(arg3) / 86400000);
        };
    }

    public fun try_claim_global_reward(arg0: &mut DailyMints, arg1: address, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (0x2::table::contains<address, u64>(&arg0.last_reward_ms, arg1)) {
            if (v0 < *0x2::table::borrow<address, u64>(&arg0.last_reward_ms, arg1) + 86400000) {
                return false
            };
            *0x2::table::borrow_mut<address, u64>(&mut arg0.last_reward_ms, arg1) = v0;
            return true
        };
        0x2::table::add<address, u64>(&mut arg0.last_reward_ms, arg1, v0);
        true
    }

    // decompiled from Move bytecode v6
}

