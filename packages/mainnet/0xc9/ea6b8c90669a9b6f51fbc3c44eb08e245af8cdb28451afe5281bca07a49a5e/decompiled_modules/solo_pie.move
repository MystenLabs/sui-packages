module 0xc9ea6b8c90669a9b6f51fbc3c44eb08e245af8cdb28451afe5281bca07a49a5e::solo_pie {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Played has copy, drop {
        player: address,
        bet_amount: u64,
        win_amount: u64,
        payout_amount: u64,
        round_count: u16,
        random_numbers: vector<u64>,
        win_probability_e9: u64,
        multiplier_e9: u64,
    }

    fun get_kelly_fraction_e9(arg0: u64, arg1: u64) : u64 {
        let v0 = get_win_probability_e9(arg0);
        (1000000000 - v0) * 1000000000 / (arg0 * (10000 - arg1) / 10000 - 1000000000) - v0
    }

    entry fun get_max_round_count(arg0: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg1: &0x2::tx_context::TxContext) : u16 {
        *0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::borrow_game_config_dynamic_field<vector<u8>, u16, Witness>(arg0, b"max_round_count")
    }

    fun get_win_probability_e9(arg0: u64) : u64 {
        1000000000 * 1000000000 / arg0
    }

    entry fun play<T0>(arg0: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg1: &mut 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u16, arg6: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg7: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg8: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg8, 1);
        assert!(arg3 >= 105 * 1000000000 / 100 && arg3 <= 50 * 1000000000, 13906834371912400905);
        assert!(arg5 > 0 && arg5 <= get_max_round_count(arg0, arg11), 13906834401977040903);
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::check_bet_amount<T0, 0x2::sui::SUI, Witness>(arg0, arg1, get_kelly_fraction_e9(arg3, 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::liquidity_fee_bp(0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::borrow_game_config<Witness>(arg0))), 0x2::coin::value<0x2::sui::SUI>(&arg2), arg11);
        let v0 = arg4 * (arg5 as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0 && 0x2::coin::value<0x2::sui::SUI>(&arg2) == v0, 13906834444926582789);
        let v1 = 0x2::random::new_generator(arg9, arg11);
        let v2 = 0;
        let v3 = 0;
        let v4 = vector[];
        let v5 = get_win_probability_e9(arg3);
        while (v3 < arg5) {
            let v6 = 0x2::random::generate_u64_in_range(&mut v1, 1, 1000000000);
            if (v5 >= v6) {
                let v7 = 0x1::u256::try_as_u64((arg4 as u256) * (arg3 as u256) / (1000000000 as u256));
                v2 = v2 + 0x1::option::extract<u64>(&mut v7);
            };
            0x1::vector::push_back<u64>(&mut v4, v6);
            v3 = v3 + 1;
        };
        let v8 = Witness{dummy_field: false};
        let v9 = 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::handle_payout_with_referral<T0, Witness>(arg0, arg1, arg2, v2, 0x2::tx_context::sender(arg11), v8, arg7, arg8, arg11);
        let v10 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play<Witness>(arg6, v0, 0x2::tx_context::sender(arg11), &v10, arg10, arg11);
        if (v9 > 0) {
            let v11 = Witness{dummy_field: false};
            0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play_activity<Witness>(arg6, false, 0, v2, v9, 0x2::tx_context::sender(arg11), &v11);
        };
        let v12 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::emit_play_history<Witness>(arg6, 0x1::string::utf8(b""), 0x2::address::to_string(0x2::tx_context::sender(arg11)), v0, v2, v9, &v12);
        let v13 = Played{
            player             : 0x2::tx_context::sender(arg11),
            bet_amount         : v0,
            win_amount         : v2,
            payout_amount      : v9,
            round_count        : arg5,
            random_numbers     : v4,
            win_probability_e9 : v5,
            multiplier_e9      : arg3,
        };
        0x2::event::emit<Played>(v13);
    }

    entry fun update_max_round_count(arg0: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::AdminCap, arg1: &mut 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::remove_if_exists_game_config_dynamic_field<vector<u8>, u16, Witness>(arg1, b"max_round_count", v0);
        let v1 = Witness{dummy_field: false};
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::add_game_config_dynamic_field<vector<u8>, u16, Witness>(arg1, b"max_round_count", arg2, v1);
    }

    // decompiled from Move bytecode v6
}

