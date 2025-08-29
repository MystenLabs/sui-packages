module 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::crash {
    struct CrashEvent has copy, drop {
        player: address,
        stake: u64,
        target_x100: u64,
        crash_x100: u64,
        win: bool,
        payout: u64,
    }

    public fun calculate_payout(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 * 9700 / 1000000
    }

    fun generate_crash_multiplier(arg0: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = 0x2::random::generate_u64_in_range(arg0, 0, 9999) + 1;
        if (v0 <= 5000) {
            101 + v0 * 99 / 5000
        } else if (v0 <= 8000) {
            200 + (v0 - 5000) * 300 / 3000
        } else if (v0 <= 9500) {
            500 + (v0 - 8000) * 500 / 1500
        } else {
            1000 + (v0 - 9500) * 2000 / 500
        }
    }

    public fun get_house_edge_bps() : u64 {
        300
    }

    public fun get_max_target() : u64 {
        3000
    }

    public fun get_min_bet() : u64 {
        100000000
    }

    public fun get_min_target() : u64 {
        101
    }

    public entry fun play(arg0: &0x2::random::Random, arg1: &mut 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::House, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= 100000000, 1);
        assert!(arg2 >= 101, 2);
        assert!(arg2 <= 3000, 4);
        let v1 = calculate_payout(v0, arg2);
        assert!(0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::get_house_balance(arg1) >= v1, 3);
        let v2 = 0x2::random::new_generator(arg0, arg4);
        let v3 = &mut v2;
        let v4 = generate_crash_multiplier(v3);
        let v5 = arg2 <= v4;
        let v6 = CrashEvent{
            player      : 0x2::tx_context::sender(arg4),
            stake       : v0,
            target_x100 : arg2,
            crash_x100  : v4,
            win         : v5,
            payout      : 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::process_game_bet(arg1, arg3, v5, v1, arg4),
        };
        0x2::event::emit<CrashEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

