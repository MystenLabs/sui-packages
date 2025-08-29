module 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::pump {
    struct PumpEvent has copy, drop {
        player: address,
        stake: u64,
        threshold: u8,
        result: u8,
        win: bool,
        payout: u64,
    }

    public fun calculate_multiplier_bp(arg0: u8) : u64 {
        if (arg0 == 0) {
            return 0
        };
        970000 / (arg0 as u64)
    }

    public fun calculate_payout(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0) {
            return 0
        };
        arg0 * 97 / (arg1 as u64)
    }

    public fun calculate_win_probability(arg0: u8) : u8 {
        arg0
    }

    fun generate_uniform_u8(arg0: &mut 0x2::random::RandomGenerator, arg1: u8) : u8 {
        assert!(arg1 > 0, 0);
        let v0;
        loop {
            v0 = 0x2::random::generate_u8(arg0);
            if ((v0 as u16) < 256 - 256 % (arg1 as u16)) {
                break
            };
        };
        v0 % arg1
    }

    public fun play_pump_or_dump(arg0: u8, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::House, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 98, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 10000000, 1);
        assert!(v0 <= 10000000000, 3);
        let v1 = v0 * 97 / (arg0 as u64);
        let v2 = 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::get_house_balance(arg3);
        assert!(v2 >= v1, 2);
        assert!(v1 * 100 <= v2 * 20, 2);
        let v3 = 0x2::random::new_generator(arg2, arg4);
        let v4 = &mut v3;
        let v5 = generate_uniform_u8(v4, 100);
        let v6 = v5 < arg0;
        let v7 = PumpEvent{
            player    : 0x2::tx_context::sender(arg4),
            stake     : v0,
            threshold : arg0,
            result    : v5,
            win       : v6,
            payout    : 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::process_game_bet(arg3, arg1, v6, v1, arg4),
        };
        0x2::event::emit<PumpEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

