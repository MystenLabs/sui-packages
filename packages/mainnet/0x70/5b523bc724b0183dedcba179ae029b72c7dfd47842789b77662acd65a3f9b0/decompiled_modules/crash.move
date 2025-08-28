module 0x4395891c1542142d74cf1d6a318ba4ecadde4cd70fdca04958c3922ba6c6eb7c::crash {
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
        let v0 = 18446744073709551615 - 0x2::random::generate_u64_in_range(arg0, 1, 18446744073709551615) + 1;
        if (v0 == 0) {
            return 3000
        };
        let v1 = 100 * (18446744073709551615 + 1) / v0;
        if (v1 > 3000) {
            3000
        } else if (v1 < 101) {
            101
        } else {
            v1
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

    public entry fun play(arg0: &0x2::random::Random, arg1: &mut 0x4395891c1542142d74cf1d6a318ba4ecadde4cd70fdca04958c3922ba6c6eb7c::casino::House, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= 100000000, 1);
        assert!(arg2 >= 101, 2);
        assert!(arg2 <= 3000, 4);
        let v1 = calculate_payout(v0, arg2);
        assert!(0x4395891c1542142d74cf1d6a318ba4ecadde4cd70fdca04958c3922ba6c6eb7c::casino::get_house_balance(arg1) >= v1, 3);
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
            payout      : 0x4395891c1542142d74cf1d6a318ba4ecadde4cd70fdca04958c3922ba6c6eb7c::casino::process_game_bet(arg1, arg3, v5, v1, arg4),
        };
        0x2::event::emit<CrashEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

