module 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::blend {
    struct BlendEvent has copy, drop {
        player: address,
        stake: u64,
        depth: u8,
        steps_survived: u8,
        win: bool,
        payout: u64,
    }

    public fun calculate_multiplier_bp(arg0: u8) : u64 {
        if (arg0 == 0) {
            return 0
        };
        97 * power_of_3(arg0) * 10000 / 100 * power_of_2(arg0)
    }

    public fun calculate_payout(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0) {
            return 0
        };
        arg0 * 97 * power_of_3(arg1) / 100 * power_of_2(arg1)
    }

    public fun calculate_win_probability_percent(arg0: u8) : u64 {
        if (arg0 == 0) {
            return 100
        };
        power_of_2(arg0) * 100 / power_of_3(arg0)
    }

    fun generate_trit(arg0: &mut u256) : u8 {
        let v0;
        loop {
            *arg0 = (*arg0 * 1103515245 + 12345) % 4294967296;
            v0 = ((*arg0 % 256) as u8);
            if (v0 < 255) {
                break
            };
        };
        v0 % 3
    }

    public fun play_blend(arg0: u8, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::House, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 6, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 10000000, 1);
        assert!(v0 <= 10000000000, 3);
        let v1 = calculate_payout(v0, arg0);
        let v2 = 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::get_house_balance(arg3);
        assert!(v2 >= v1, 2);
        assert!(v1 * 100 <= v2 * 20, 2);
        let v3 = 0x2::random::new_generator(arg2, arg4);
        let v4 = simulate_ladder(0x2::random::generate_u256(&mut v3), arg0);
        let v5 = v4 == arg0;
        let v6 = BlendEvent{
            player         : 0x2::tx_context::sender(arg4),
            stake          : v0,
            depth          : arg0,
            steps_survived : v4,
            win            : v5,
            payout         : 0xb2a6c0ebfe6fdac6d8261fd0df496cc90522d745aada4a0bf699c5f32406d583::casino::process_game_bet(arg3, arg1, v5, v1, arg4),
        };
        0x2::event::emit<BlendEvent>(v6);
    }

    fun power_of_2(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 2;
            v1 = v1 + 1;
        };
        v0
    }

    fun power_of_3(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 3;
            v1 = v1 + 1;
        };
        v0
    }

    fun simulate_ladder(arg0: u256, arg1: u8) : u8 {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = &mut arg0;
            if (generate_trit(v1) == 2) {
                return v0
            };
            v0 = v0 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v6
}

