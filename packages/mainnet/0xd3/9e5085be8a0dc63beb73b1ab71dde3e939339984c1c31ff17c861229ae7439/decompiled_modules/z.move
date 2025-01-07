module 0xd39e5085be8a0dc63beb73b1ab71dde3e939339984c1c31ff17c861229ae7439::z {
    public fun b<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223372449171636223);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg17), arg17);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223372526481047551);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v9 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v9, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v9, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v10, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v10, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v11, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v11, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v12, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v12, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v13, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v13, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v14, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v14, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v15, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v15, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v16, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v16, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v17, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v17, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v18, arg2, arg16, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v18, arg17);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg17, arg18);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v19, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg17);
            if (v19 == 0) {
                return
            };
            let (v21, v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v19, 4295048016, arg17);
            let v24 = v23;
            0x2::balance::destroy_zero<T0>(v21);
            let (v25, v26) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v22, arg18), arg10, arg11, arg17, arg18);
            let v27 = v26;
            let v28 = v25;
            if (0x2::coin::value<T1>(&v28) == 0) {
                0x2::coin::destroy_zero<T1>(v28);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v28, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v27, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v24), arg18)), 0x2::balance::zero<T1>(), v24);
            let v29 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v29 & 18446744073709551615) as u64) ^ ((v29 >> 64 & 18446744073709551615) as u64) ^ ((v29 >> 128 & 18446744073709551615) as u64) ^ ((v29 >> 192) as u64) == 9459194608057385379, 9223373084826796031);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v27, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg17);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v30, 79226673515401279992447579055, arg17);
            let v35 = v34;
            0x2::balance::destroy_zero<T1>(v33);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v32, arg18), arg10, arg11, arg17, arg18);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T0>(&v39) == 0) {
                0x2::coin::destroy_zero<T0>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg18)), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223373217970782207);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun c<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223373557273198591);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg18), arg18);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223373656057446399);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v10, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v11, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v11, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v12, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v12, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v13, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v13, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v14, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v14, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v15, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v15, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v16, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v16, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v17, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v17, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v18, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v18, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg17;
            } else {
                v9 = arg16;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v19, arg2, v9, arg12, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v19, arg18);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg18, arg19);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v20, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg18);
            if (v20 == 0) {
                return
            };
            let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v20, 4295048016, arg18);
            let v25 = v24;
            0x2::balance::destroy_zero<T0>(v22);
            let (v26, v27) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v23, arg19), arg10, arg11, arg18, arg19);
            let v28 = v27;
            let v29 = v26;
            if (0x2::coin::value<T1>(&v29) == 0) {
                0x2::coin::destroy_zero<T1>(v29);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v29, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v28, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v25), arg19)), 0x2::balance::zero<T1>(), v25);
            let v30 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
            assert!(((v30 & 18446744073709551615) as u64) ^ ((v30 >> 64 & 18446744073709551615) as u64) ^ ((v30 >> 128 & 18446744073709551615) as u64) ^ ((v30 >> 192) as u64) == 9459194608057385379, 9223374214403194879);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v28, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v31, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg18);
            if (v31 == 0) {
                return
            };
            let (v33, v34, v35) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v31, 79226673515401279992447579055, arg18);
            let v36 = v35;
            0x2::balance::destroy_zero<T1>(v34);
            let (v37, v38) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v33, arg19), arg10, arg11, arg18, arg19);
            let v39 = v38;
            let v40 = v37;
            if (0x2::coin::value<T0>(&v40) == 0) {
                0x2::coin::destroy_zero<T0>(v40);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v40, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v39, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v36), arg19)), v36);
            let v41 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
            assert!(((v41 & 18446744073709551615) as u64) ^ ((v41 >> 64 & 18446744073709551615) as u64) ^ ((v41 >> 128 & 18446744073709551615) as u64) ^ ((v41 >> 192) as u64) == 9459194608057385379, 9223374347547181055);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun d<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223374695439532031);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg19), arg19);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223374815698616319);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg17;
            } else if (v10 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v11, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg17;
            } else if (v12 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v13, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg17;
            } else if (v14 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v15, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg17;
            } else if (v16 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v17, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg17;
            } else if (v18 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v19, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg17;
            } else if (v20 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v21, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg17;
            } else if (v22 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v23, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg17;
            } else if (v24 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v25, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg17;
            } else if (v26 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v27, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg17;
            } else if (v28 == 2) {
                v9 = arg18;
            } else {
                v9 = arg16;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg12, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v29, arg19);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg19, arg20);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg19);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v30, 4295048016, arg19);
            let v35 = v34;
            0x2::balance::destroy_zero<T0>(v32);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v33, arg20), arg10, arg11, arg19, arg20);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T1>(&v39) == 0) {
                0x2::coin::destroy_zero<T1>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg20)), 0x2::balance::zero<T1>(), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223375374044364799);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v41, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg19);
            if (v41 == 0) {
                return
            };
            let (v43, v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v41, 79226673515401279992447579055, arg19);
            let v46 = v45;
            0x2::balance::destroy_zero<T1>(v44);
            let (v47, v48) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v43, arg20), arg10, arg11, arg19, arg20);
            let v49 = v48;
            let v50 = v47;
            if (0x2::coin::value<T0>(&v50) == 0) {
                0x2::coin::destroy_zero<T0>(v50);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v50, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v49, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v46), arg20)), v46);
            let v51 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
            assert!(((v51 & 18446744073709551615) as u64) ^ ((v51 >> 64 & 18446744073709551615) as u64) ^ ((v51 >> 128 & 18446744073709551615) as u64) ^ ((v51 >> 192) as u64) == 9459194608057385379, 9223375507188350975);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v49, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun e<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223375863670636543);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg20), arg20);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223376005404557311);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg17;
            } else if (v10 == 2) {
                v9 = arg18;
            } else if (v10 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v11, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg17;
            } else if (v12 == 2) {
                v9 = arg18;
            } else if (v12 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v13, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg17;
            } else if (v14 == 2) {
                v9 = arg18;
            } else if (v14 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v15, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg17;
            } else if (v16 == 2) {
                v9 = arg18;
            } else if (v16 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v17, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg17;
            } else if (v18 == 2) {
                v9 = arg18;
            } else if (v18 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v19, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg17;
            } else if (v20 == 2) {
                v9 = arg18;
            } else if (v20 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v21, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg17;
            } else if (v22 == 2) {
                v9 = arg18;
            } else if (v22 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v23, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg17;
            } else if (v24 == 2) {
                v9 = arg18;
            } else if (v24 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v25, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg17;
            } else if (v26 == 2) {
                v9 = arg18;
            } else if (v26 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v27, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg17;
            } else if (v28 == 2) {
                v9 = arg18;
            } else if (v28 == 3) {
                v9 = arg19;
            } else {
                v9 = arg16;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg12, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v29, arg20);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg20, arg21);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg20);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v30, 4295048016, arg20);
            let v35 = v34;
            0x2::balance::destroy_zero<T0>(v32);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v33, arg21), arg10, arg11, arg20, arg21);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T1>(&v39) == 0) {
                0x2::coin::destroy_zero<T1>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg21)), 0x2::balance::zero<T1>(), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223376563750305791);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v41, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg20);
            if (v41 == 0) {
                return
            };
            let (v43, v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v41, 79226673515401279992447579055, arg20);
            let v46 = v45;
            0x2::balance::destroy_zero<T1>(v44);
            let (v47, v48) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v43, arg21), arg10, arg11, arg20, arg21);
            let v49 = v48;
            let v50 = v47;
            if (0x2::coin::value<T0>(&v50) == 0) {
                0x2::coin::destroy_zero<T0>(v50);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v50, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v49, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v46), arg21)), v46);
            let v51 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
            assert!(((v51 & 18446744073709551615) as u64) ^ ((v51 >> 64 & 18446744073709551615) as u64) ^ ((v51 >> 128 & 18446744073709551615) as u64) ^ ((v51 >> 192) as u64) == 9459194608057385379, 9223376696894291967);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v49, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun f<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223377061966512127);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg21), arg21);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223377225175269375);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg17;
            } else if (v10 == 2) {
                v9 = arg18;
            } else if (v10 == 3) {
                v9 = arg19;
            } else if (v10 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v11, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg17;
            } else if (v12 == 2) {
                v9 = arg18;
            } else if (v12 == 3) {
                v9 = arg19;
            } else if (v12 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v13, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg17;
            } else if (v14 == 2) {
                v9 = arg18;
            } else if (v14 == 3) {
                v9 = arg19;
            } else if (v14 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v15, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg17;
            } else if (v16 == 2) {
                v9 = arg18;
            } else if (v16 == 3) {
                v9 = arg19;
            } else if (v16 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v17, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg17;
            } else if (v18 == 2) {
                v9 = arg18;
            } else if (v18 == 3) {
                v9 = arg19;
            } else if (v18 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v19, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg17;
            } else if (v20 == 2) {
                v9 = arg18;
            } else if (v20 == 3) {
                v9 = arg19;
            } else if (v20 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v21, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg17;
            } else if (v22 == 2) {
                v9 = arg18;
            } else if (v22 == 3) {
                v9 = arg19;
            } else if (v22 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v23, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg17;
            } else if (v24 == 2) {
                v9 = arg18;
            } else if (v24 == 3) {
                v9 = arg19;
            } else if (v24 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v25, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg17;
            } else if (v26 == 2) {
                v9 = arg18;
            } else if (v26 == 3) {
                v9 = arg19;
            } else if (v26 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v27, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg17;
            } else if (v28 == 2) {
                v9 = arg18;
            } else if (v28 == 3) {
                v9 = arg19;
            } else if (v28 == 4) {
                v9 = arg20;
            } else {
                v9 = arg16;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg12, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v29, arg21);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg21, arg22);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg21);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v30, 4295048016, arg21);
            let v35 = v34;
            0x2::balance::destroy_zero<T0>(v32);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v33, arg22), arg10, arg11, arg21, arg22);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T1>(&v39) == 0) {
                0x2::coin::destroy_zero<T1>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg22)), 0x2::balance::zero<T1>(), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223377783521017855);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v41, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg21);
            if (v41 == 0) {
                return
            };
            let (v43, v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v41, 79226673515401279992447579055, arg21);
            let v46 = v45;
            0x2::balance::destroy_zero<T1>(v44);
            let (v47, v48) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v43, arg22), arg10, arg11, arg21, arg22);
            let v49 = v48;
            let v50 = v47;
            if (0x2::coin::value<T0>(&v50) == 0) {
                0x2::coin::destroy_zero<T0>(v50);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v50, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v49, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v46), arg22)), v46);
            let v51 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
            assert!(((v51 & 18446744073709551615) as u64) ^ ((v51 >> 64 & 18446744073709551615) as u64) ^ ((v51 >> 128 & 18446744073709551615) as u64) ^ ((v51 >> 192) as u64) == 9459194608057385379, 9223377916665004031);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v49, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun g<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223378290327158783);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg22), arg22);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223378475010752511);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg17;
            } else if (v10 == 2) {
                v9 = arg18;
            } else if (v10 == 3) {
                v9 = arg19;
            } else if (v10 == 4) {
                v9 = arg20;
            } else if (v10 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v11, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg17;
            } else if (v12 == 2) {
                v9 = arg18;
            } else if (v12 == 3) {
                v9 = arg19;
            } else if (v12 == 4) {
                v9 = arg20;
            } else if (v12 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v13, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg17;
            } else if (v14 == 2) {
                v9 = arg18;
            } else if (v14 == 3) {
                v9 = arg19;
            } else if (v14 == 4) {
                v9 = arg20;
            } else if (v14 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v15, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg17;
            } else if (v16 == 2) {
                v9 = arg18;
            } else if (v16 == 3) {
                v9 = arg19;
            } else if (v16 == 4) {
                v9 = arg20;
            } else if (v16 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v17, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg17;
            } else if (v18 == 2) {
                v9 = arg18;
            } else if (v18 == 3) {
                v9 = arg19;
            } else if (v18 == 4) {
                v9 = arg20;
            } else if (v18 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v19, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg17;
            } else if (v20 == 2) {
                v9 = arg18;
            } else if (v20 == 3) {
                v9 = arg19;
            } else if (v20 == 4) {
                v9 = arg20;
            } else if (v20 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v21, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg17;
            } else if (v22 == 2) {
                v9 = arg18;
            } else if (v22 == 3) {
                v9 = arg19;
            } else if (v22 == 4) {
                v9 = arg20;
            } else if (v22 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v23, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg17;
            } else if (v24 == 2) {
                v9 = arg18;
            } else if (v24 == 3) {
                v9 = arg19;
            } else if (v24 == 4) {
                v9 = arg20;
            } else if (v24 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v25, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg17;
            } else if (v26 == 2) {
                v9 = arg18;
            } else if (v26 == 3) {
                v9 = arg19;
            } else if (v26 == 4) {
                v9 = arg20;
            } else if (v26 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v27, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg17;
            } else if (v28 == 2) {
                v9 = arg18;
            } else if (v28 == 3) {
                v9 = arg19;
            } else if (v28 == 4) {
                v9 = arg20;
            } else if (v28 == 5) {
                v9 = arg21;
            } else {
                v9 = arg16;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg12, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v29, arg22);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg22, arg23);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg22);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v30, 4295048016, arg22);
            let v35 = v34;
            0x2::balance::destroy_zero<T0>(v32);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v33, arg23), arg10, arg11, arg22, arg23);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T1>(&v39) == 0) {
                0x2::coin::destroy_zero<T1>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg23)), 0x2::balance::zero<T1>(), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223379033356500991);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v41, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg22);
            if (v41 == 0) {
                return
            };
            let (v43, v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v41, 79226673515401279992447579055, arg22);
            let v46 = v45;
            0x2::balance::destroy_zero<T1>(v44);
            let (v47, v48) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v43, arg23), arg10, arg11, arg22, arg23);
            let v49 = v48;
            let v50 = v47;
            if (0x2::coin::value<T0>(&v50) == 0) {
                0x2::coin::destroy_zero<T0>(v50);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v50, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v49, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v46), arg23)), v46);
            let v51 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
            assert!(((v51 & 18446744073709551615) as u64) ^ ((v51 >> 64 & 18446744073709551615) as u64) ^ ((v51 >> 128 & 18446744073709551615) as u64) ^ ((v51 >> 192) as u64) == 9459194608057385379, 9223379166500487167);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v49, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun h<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223379548752576511);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg23), arg23);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223379754911006719);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg17;
            } else if (v10 == 2) {
                v9 = arg18;
            } else if (v10 == 3) {
                v9 = arg19;
            } else if (v10 == 4) {
                v9 = arg20;
            } else if (v10 == 5) {
                v9 = arg21;
            } else if (v10 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v11, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg17;
            } else if (v12 == 2) {
                v9 = arg18;
            } else if (v12 == 3) {
                v9 = arg19;
            } else if (v12 == 4) {
                v9 = arg20;
            } else if (v12 == 5) {
                v9 = arg21;
            } else if (v12 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v13, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg17;
            } else if (v14 == 2) {
                v9 = arg18;
            } else if (v14 == 3) {
                v9 = arg19;
            } else if (v14 == 4) {
                v9 = arg20;
            } else if (v14 == 5) {
                v9 = arg21;
            } else if (v14 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v15, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg17;
            } else if (v16 == 2) {
                v9 = arg18;
            } else if (v16 == 3) {
                v9 = arg19;
            } else if (v16 == 4) {
                v9 = arg20;
            } else if (v16 == 5) {
                v9 = arg21;
            } else if (v16 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v17, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg17;
            } else if (v18 == 2) {
                v9 = arg18;
            } else if (v18 == 3) {
                v9 = arg19;
            } else if (v18 == 4) {
                v9 = arg20;
            } else if (v18 == 5) {
                v9 = arg21;
            } else if (v18 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v19, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg17;
            } else if (v20 == 2) {
                v9 = arg18;
            } else if (v20 == 3) {
                v9 = arg19;
            } else if (v20 == 4) {
                v9 = arg20;
            } else if (v20 == 5) {
                v9 = arg21;
            } else if (v20 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v21, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg17;
            } else if (v22 == 2) {
                v9 = arg18;
            } else if (v22 == 3) {
                v9 = arg19;
            } else if (v22 == 4) {
                v9 = arg20;
            } else if (v22 == 5) {
                v9 = arg21;
            } else if (v22 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v23, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg17;
            } else if (v24 == 2) {
                v9 = arg18;
            } else if (v24 == 3) {
                v9 = arg19;
            } else if (v24 == 4) {
                v9 = arg20;
            } else if (v24 == 5) {
                v9 = arg21;
            } else if (v24 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v25, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg17;
            } else if (v26 == 2) {
                v9 = arg18;
            } else if (v26 == 3) {
                v9 = arg19;
            } else if (v26 == 4) {
                v9 = arg20;
            } else if (v26 == 5) {
                v9 = arg21;
            } else if (v26 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v27, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg17;
            } else if (v28 == 2) {
                v9 = arg18;
            } else if (v28 == 3) {
                v9 = arg19;
            } else if (v28 == 4) {
                v9 = arg20;
            } else if (v28 == 5) {
                v9 = arg21;
            } else if (v28 == 6) {
                v9 = arg22;
            } else {
                v9 = arg16;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg12, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v29, arg23);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg23, arg24);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg23);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v30, 4295048016, arg23);
            let v35 = v34;
            0x2::balance::destroy_zero<T0>(v32);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v33, arg24), arg10, arg11, arg23, arg24);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T1>(&v39) == 0) {
                0x2::coin::destroy_zero<T1>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg24)), 0x2::balance::zero<T1>(), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223380313256755199);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v41, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg23);
            if (v41 == 0) {
                return
            };
            let (v43, v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v41, 79226673515401279992447579055, arg23);
            let v46 = v45;
            0x2::balance::destroy_zero<T1>(v44);
            let (v47, v48) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v43, arg24), arg10, arg11, arg23, arg24);
            let v49 = v48;
            let v50 = v47;
            if (0x2::coin::value<T0>(&v50) == 0) {
                0x2::coin::destroy_zero<T0>(v50);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v50, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v49, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v46), arg24)), v46);
            let v51 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
            assert!(((v51 & 18446744073709551615) as u64) ^ ((v51 >> 64 & 18446744073709551615) as u64) ^ ((v51 >> 128 & 18446744073709551615) as u64) ^ ((v51 >> 192) as u64) == 9459194608057385379, 9223380446400741375);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v49, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun i<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg15: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223380837242765311);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg24), arg24);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223381064876031999);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg17;
            } else if (v10 == 2) {
                v9 = arg18;
            } else if (v10 == 3) {
                v9 = arg19;
            } else if (v10 == 4) {
                v9 = arg20;
            } else if (v10 == 5) {
                v9 = arg21;
            } else if (v10 == 6) {
                v9 = arg22;
            } else if (v10 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v11, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg17;
            } else if (v12 == 2) {
                v9 = arg18;
            } else if (v12 == 3) {
                v9 = arg19;
            } else if (v12 == 4) {
                v9 = arg20;
            } else if (v12 == 5) {
                v9 = arg21;
            } else if (v12 == 6) {
                v9 = arg22;
            } else if (v12 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v13, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg17;
            } else if (v14 == 2) {
                v9 = arg18;
            } else if (v14 == 3) {
                v9 = arg19;
            } else if (v14 == 4) {
                v9 = arg20;
            } else if (v14 == 5) {
                v9 = arg21;
            } else if (v14 == 6) {
                v9 = arg22;
            } else if (v14 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v15, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg17;
            } else if (v16 == 2) {
                v9 = arg18;
            } else if (v16 == 3) {
                v9 = arg19;
            } else if (v16 == 4) {
                v9 = arg20;
            } else if (v16 == 5) {
                v9 = arg21;
            } else if (v16 == 6) {
                v9 = arg22;
            } else if (v16 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v17, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg17;
            } else if (v18 == 2) {
                v9 = arg18;
            } else if (v18 == 3) {
                v9 = arg19;
            } else if (v18 == 4) {
                v9 = arg20;
            } else if (v18 == 5) {
                v9 = arg21;
            } else if (v18 == 6) {
                v9 = arg22;
            } else if (v18 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v19, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg17;
            } else if (v20 == 2) {
                v9 = arg18;
            } else if (v20 == 3) {
                v9 = arg19;
            } else if (v20 == 4) {
                v9 = arg20;
            } else if (v20 == 5) {
                v9 = arg21;
            } else if (v20 == 6) {
                v9 = arg22;
            } else if (v20 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v21, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg17;
            } else if (v22 == 2) {
                v9 = arg18;
            } else if (v22 == 3) {
                v9 = arg19;
            } else if (v22 == 4) {
                v9 = arg20;
            } else if (v22 == 5) {
                v9 = arg21;
            } else if (v22 == 6) {
                v9 = arg22;
            } else if (v22 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v23, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg17;
            } else if (v24 == 2) {
                v9 = arg18;
            } else if (v24 == 3) {
                v9 = arg19;
            } else if (v24 == 4) {
                v9 = arg20;
            } else if (v24 == 5) {
                v9 = arg21;
            } else if (v24 == 6) {
                v9 = arg22;
            } else if (v24 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v25, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg17;
            } else if (v26 == 2) {
                v9 = arg18;
            } else if (v26 == 3) {
                v9 = arg19;
            } else if (v26 == 4) {
                v9 = arg20;
            } else if (v26 == 5) {
                v9 = arg21;
            } else if (v26 == 6) {
                v9 = arg22;
            } else if (v26 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v27, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg17;
            } else if (v28 == 2) {
                v9 = arg18;
            } else if (v28 == 3) {
                v9 = arg19;
            } else if (v28 == 4) {
                v9 = arg20;
            } else if (v28 == 5) {
                v9 = arg21;
            } else if (v28 == 6) {
                v9 = arg22;
            } else if (v28 == 7) {
                v9 = arg23;
            } else {
                v9 = arg16;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg12, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v29, arg24);
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg13, arg14, arg15, arg8, arg9, arg10, arg11, arg24, arg25);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg8)) {
                return
            };
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg24);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v30, 4295048016, arg24);
            let v35 = v34;
            0x2::balance::destroy_zero<T0>(v32);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v33, arg25), arg10, arg11, arg24, arg25);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T1>(&v39) == 0) {
                0x2::coin::destroy_zero<T1>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg25)), 0x2::balance::zero<T1>(), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223381623221780479);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v41, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg24);
            if (v41 == 0) {
                return
            };
            let (v43, v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v41, 79226673515401279992447579055, arg24);
            let v46 = v45;
            0x2::balance::destroy_zero<T1>(v44);
            let (v47, v48) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v43, arg25), arg10, arg11, arg24, arg25);
            let v49 = v48;
            let v50 = v47;
            if (0x2::coin::value<T0>(&v50) == 0) {
                0x2::coin::destroy_zero<T0>(v50);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v50, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v49, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v46), arg25)), v46);
            let v51 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
            assert!(((v51 & 18446744073709551615) as u64) ^ ((v51 >> 64 & 18446744073709551615) as u64) ^ ((v51 >> 128 & 18446744073709551615) as u64) ^ ((v51 >> 192) as u64) == 9459194608057385379, 9223381756365766655);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v49, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    // decompiled from Move bytecode v7
}

