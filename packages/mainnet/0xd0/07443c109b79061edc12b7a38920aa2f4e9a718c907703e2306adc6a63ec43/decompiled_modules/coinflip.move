module 0xd007443c109b79061edc12b7a38920aa2f4e9a718c907703e2306adc6a63ec43::coinflip {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Played has copy, drop {
        player: address,
        bet_amount: u64,
        win_amount: u64,
        payout_amount: u64,
        is_head: bool,
        is_win: bool,
    }

    entry fun play<T0>(arg0: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg1: &mut 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg5: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg6: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg6, 1);
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::check_bet_amount<T0, 0x2::sui::SUI, Witness>(arg0, arg1, 10204081, 0x2::coin::value<0x2::sui::SUI>(&arg2), arg9);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 13906834341847236611);
        let v1 = 0x2::random::new_generator(arg7, arg9);
        let v2 = 0x2::random::generate_bool(&mut v1) == arg3;
        let v3 = if (v2) {
            v0 * 2
        } else {
            0
        };
        let v4 = Witness{dummy_field: false};
        let v5 = 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::handle_payout_with_referral<T0, Witness>(arg0, arg1, arg2, v3, 0x2::tx_context::sender(arg9), v4, arg5, arg6, arg9);
        let v6 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play<Witness>(arg4, v0, 0x2::tx_context::sender(arg9), &v6, arg8, arg9);
        if (v5 > 0) {
            let v7 = Witness{dummy_field: false};
            0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play_activity<Witness>(arg4, false, 0, v3, v5, 0x2::tx_context::sender(arg9), &v7);
        };
        let v8 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::emit_play_history<Witness>(arg4, 0x1::string::utf8(b""), 0x2::address::to_string(0x2::tx_context::sender(arg9)), v0, v3, v5, &v8);
        let v9 = Played{
            player        : 0x2::tx_context::sender(arg9),
            bet_amount    : v0,
            win_amount    : v3,
            payout_amount : v5,
            is_head       : arg3,
            is_win        : v2,
        };
        0x2::event::emit<Played>(v9);
    }

    // decompiled from Move bytecode v6
}

