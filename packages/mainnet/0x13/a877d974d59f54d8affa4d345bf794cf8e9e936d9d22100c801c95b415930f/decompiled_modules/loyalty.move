module 0x13a877d974d59f54d8affa4d345bf794cf8e9e936d9d22100c801c95b415930f::loyalty {
    struct Loyalty has copy, drop, store {
        dummy_field: bool,
    }

    public fun process_stake_ticket<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::get_adjusted_price_or_zero(arg1, 0x1::type_name::with_defining_ids<T0>(), arg3, arg4);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::update_stake_ticket_oracle_prices<T0, T1>(arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::get_unsafe_usd_price_no_checks(arg3), v0);
        let v1 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_single_game_stake_amounts<T0, T1>(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero();
            if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive(&v0)) {
                v4 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_scientific(false, *0x1::vector::borrow<u64>(&v2, v3), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::neg_from((0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::get_coin_decimals<T0>(arg1) as u64))));
            };
            0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&mut v1, v4);
            v3 = v3 + 1;
        };
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::update_stake_ticket_usd_values<T0, T1>(arg0, v1);
        0x12936bef50c5ce93fd6e0ec805ac760660d7c5c58a860e920a6fd8ff47c26af8::vip::settle_vip_progress<T0, T1>(arg1, arg0, arg4, arg6);
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
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_metadata<T0, T1>(arg0, 0x1::vector::pop_back<0x1::string::String>(&mut v14), 0x1::vector::pop_back<vector<u8>>(&mut v13));
        };
        0x1::vector::destroy_empty<0x1::string::String>(v14);
        0x1::vector::destroy_empty<vector<u8>>(v13);
        0xdaa3f8b4f88d04695ec91161b4a2c1dfe1fbea6c9268eeb1801b0e12e642441d::referral::settle_referral_rewards<T0, T1>(arg1, arg0, v9, v6, arg3, arg4, arg6);
        0x10cd0f1d830557ec565ca2efa018dcede8a9afcdfde98019e0c8c7726edd91f5::daily_streak::settle_daily_streak<T0, T1>(arg1, arg0, arg4, arg6);
        0x9d0743400d8771a077196faa4bca0fb4e9c033e43fdc27d0d575fbdf2f525278::wager_balance::settle_wager_balance<T0, T1>(arg1, arg0, arg4, arg3, arg6);
        0xa0e74b8f6fed4167e16515446f7cbb808b9269bbfae990c5132dcd399a7925e3::contest::settle_contest_wager<T0, T1>(arg1, arg0, arg4, arg6);
    }

    // decompiled from Move bytecode v6
}

