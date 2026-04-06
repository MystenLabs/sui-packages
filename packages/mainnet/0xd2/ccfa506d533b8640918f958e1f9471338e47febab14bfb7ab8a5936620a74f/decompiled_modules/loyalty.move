module 0xd2ccfa506d533b8640918f958e1f9471338e47febab14bfb7ab8a5936620a74f::loyalty {
    struct Loyalty has copy, drop, store {
        dummy_field: bool,
    }

    public fun process_stake_ticket<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1>, arg1: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg2: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::get_adjusted_price_or_zero(arg1, 0x1::type_name::with_defining_ids<T0>(), arg3, arg4);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::update_stake_ticket_oracle_prices<T0, T1>(arg0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::get_unsafe_usd_price_no_checks(arg3), v0);
        let v1 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_single_game_stake_amounts<T0, T1>(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
            if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive(&v0)) {
                v4 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(v0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_scientific(false, *0x1::vector::borrow<u64>(&v2, v3), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::i64::neg_from((0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_coin_decimals<T0>(arg1) as u64))));
            };
            0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&mut v1, v4);
            v3 = v3 + 1;
        };
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::update_stake_ticket_usd_values<T0, T1>(arg0, v1);
        0x25980ae9e9d1a5c204a1a9f7dcccad313305567e9bce7ec99b64009b1680e24f::vip::settle_vip_progress<T0, T1>(arg1, arg0, arg4, arg6);
        let v5 = 0x1::string::utf8(b"partner");
        let v6 = if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg2, &v5)) {
            let v7 = 0x1::string::utf8(b"partner");
            0x1::option::some<address>(0x2::address::from_bytes(*0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg2, &v7)))
        } else {
            0x1::option::none<address>()
        };
        let v8 = 0x1::string::utf8(b"referrer");
        let v9 = if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg2, &v8)) {
            let v10 = 0x1::string::utf8(b"referrer");
            0x1::option::some<address>(0x2::address::from_bytes(*0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg2, &v10)))
        } else {
            0x1::option::none<address>()
        };
        let (v11, v12) = 0x2::vec_map::into_keys_values<0x1::string::String, vector<u8>>(arg2);
        let v13 = v12;
        let v14 = v11;
        while (0x1::vector::length<0x1::string::String>(&v14) > 0) {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_metadata<T0, T1>(arg0, 0x1::vector::pop_back<0x1::string::String>(&mut v14), 0x1::vector::pop_back<vector<u8>>(&mut v13));
        };
        0x1::vector::destroy_empty<0x1::string::String>(v14);
        0x1::vector::destroy_empty<vector<u8>>(v13);
        0xc9aab49056ede316c0d006d4b41ee9354d65d2093c4e7c49ed2f88f8f4aeea78::referral::settle_referral_rewards<T0, T1>(arg1, arg0, v9, v6, arg3, arg4, arg6);
        0xf6e2790a50f0618f65d78c598fdc5852650fcfee86528c24043c0de02af27d9::daily_streak::settle_daily_streak<T0, T1>(arg1, arg0, arg4, arg6);
        0x3705a4999dde4f6a9bf943dc083d83ebba86447d96aa4f62b78fb6b037e3be08::wager_balance::settle_wager_balance<T0, T1>(arg1, arg0, arg4, arg3, arg6);
        0x17058ac0e48d5900a01f8c6125b6f3ce8d07b0af0f8274214c4a5a903145308f::contest::settle_contest_wager<T0, T1>(arg1, arg0, arg4, arg6);
    }

    // decompiled from Move bytecode v6
}

