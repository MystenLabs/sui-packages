module 0x72eb7f6bb6c242bfb78e4db52b1010afb24680d977c26a8d9af0026a3a596765::bit_roll {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Played has copy, drop {
        player: address,
        bet_amount: u64,
        win_amount: u64,
        payout_amount: u64,
        digits: u8,
        random_number: u64,
        multiplier_bp: u16,
    }

    entry fun get_multiplier_bp_list(arg0: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg1: &0x2::tx_context::TxContext) : vector<u16> {
        *0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::borrow_game_config_dynamic_field<vector<u8>, vector<u16>, Witness>(arg0, b"multiplier_bp_list")
    }

    entry fun play<T0>(arg0: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg1: &mut 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: u16, arg5: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg6: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg7: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg7, 1);
        let v0 = get_multiplier_bp_list(arg0, arg10);
        assert!(0x1::vector::contains<u16>(&v0, &arg4), 13906834371912335368);
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::check_bet_amount<T0, 0x2::sui::SUI, Witness>(arg0, arg1, 30601582, 0x2::coin::value<0x2::sui::SUI>(&arg2), arg10);
        assert!(arg3 > 0 && arg3 <= 12, 13906834384797368330);
        let v1 = 0x1::u64::pow(2, arg3) - 1;
        let v2 = v1 * 1000000000 * (arg4 as u64) / 10000 / 2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0 && 0x2::coin::value<0x2::sui::SUI>(&arg2) == v2, 13906834401976975366);
        let v3 = 0x2::random::new_generator(arg8, arg10);
        let v4 = 0x2::random::generate_u64_in_range(&mut v3, 0, v1);
        let v5 = v4 * 1000000000 * (arg4 as u64) / 10000;
        let v6 = Witness{dummy_field: false};
        let v7 = 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::handle_payout_with_referral<T0, Witness>(arg0, arg1, arg2, v5, 0x2::tx_context::sender(arg10), v6, arg6, arg7, arg10);
        let v8 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play<Witness>(arg5, v2, 0x2::tx_context::sender(arg10), &v8, arg9, arg10);
        if (v7 > 0) {
            let v9 = Witness{dummy_field: false};
            0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play_activity<Witness>(arg5, false, 0, v5, v7, 0x2::tx_context::sender(arg10), &v9);
        };
        let v10 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::emit_play_history<Witness>(arg5, 0x1::string::utf8(b""), 0x2::address::to_string(0x2::tx_context::sender(arg10)), v2, v5, v7, &v10);
        let v11 = Played{
            player        : 0x2::tx_context::sender(arg10),
            bet_amount    : v2,
            win_amount    : v5,
            payout_amount : v7,
            digits        : arg3,
            random_number : v4,
            multiplier_bp : arg4,
        };
        0x2::event::emit<Played>(v11);
    }

    entry fun update_multiplier_bp_list(arg0: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::AdminCap, arg1: &mut 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg2: vector<u16>, arg3: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::remove_if_exists_game_config_dynamic_field<vector<u8>, vector<u16>, Witness>(arg1, b"multiplier_bp_list", v0);
        let v1 = Witness{dummy_field: false};
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::add_game_config_dynamic_field<vector<u8>, vector<u16>, Witness>(arg1, b"multiplier_bp_list", arg2, v1);
    }

    // decompiled from Move bytecode v6
}

