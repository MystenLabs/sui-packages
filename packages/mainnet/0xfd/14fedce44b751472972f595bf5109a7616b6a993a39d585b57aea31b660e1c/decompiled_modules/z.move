module 0xfd14fedce44b751472972f595bf5109a7616b6a993a39d585b57aea31b660e1c::z {
    public fun b<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223372431991767039);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg14), arg14);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223372509301178367);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v9, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v9, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v10, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v10, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v11, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v11, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v12, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v12, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v13, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v13, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v14, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v14, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v15, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v15, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v16, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v16, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v17, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v17, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v18, arg2, arg13, arg12, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v18, arg14);
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v19, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg14);
            if (v19 == 0) {
                return
            };
            let (v21, v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v19, 4295048016, arg14);
            let v24 = v23;
            0x2::balance::destroy_zero<T0>(v21);
            let (v25, v26) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v22, arg15), arg10, arg11, arg14, arg15);
            let v27 = v26;
            let v28 = v25;
            if (0x2::coin::value<T1>(&v28) == 0) {
                0x2::coin::destroy_zero<T1>(v28);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v28, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v27, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v24), arg15)), 0x2::balance::zero<T1>(), v24);
            let v29 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
            assert!(((v29 & 18446744073709551615) as u64) ^ ((v29 >> 64 & 18446744073709551615) as u64) ^ ((v29 >> 128 & 18446744073709551615) as u64) ^ ((v29 >> 192) as u64) == 9459194608057385379, 9223372981747580927);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v27, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg14);
            if (v30 == 0) {
                return
            };
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v30, 79226673515401279992447579055, arg14);
            let v35 = v34;
            0x2::balance::destroy_zero<T1>(v33);
            let (v36, v37) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v32, arg15), arg10, arg11, arg14, arg15);
            let v38 = v37;
            let v39 = v36;
            if (0x2::coin::value<T0>(&v39) == 0) {
                0x2::coin::destroy_zero<T0>(v39);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v39, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v38, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v35), arg15)), v35);
            let v40 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
            assert!(((v40 & 18446744073709551615) as u64) ^ ((v40 >> 64 & 18446744073709551615) as u64) ^ ((v40 >> 128 & 18446744073709551615) as u64) ^ ((v40 >> 192) as u64) == 9459194608057385379, 9223373114891567103);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v38, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun c<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223373437014114303);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg15), arg15);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223373535798362111);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v10 = if (v9 == 1) {
                arg14
            } else {
                arg13
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v10, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v11, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v13 = if (v12 == 1) {
                arg14
            } else {
                arg13
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v14, arg2, v13, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v14, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v16 = if (v15 == 1) {
                arg14
            } else {
                arg13
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v17, arg2, v16, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v17, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v19 = if (v18 == 1) {
                arg14
            } else {
                arg13
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v20, arg2, v19, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v20, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v22 = if (v21 == 1) {
                arg14
            } else {
                arg13
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v23, arg2, v22, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v23, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v25 = if (v24 == 1) {
                arg14
            } else {
                arg13
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v26, arg2, v25, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v26, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v28 = if (v27 == 1) {
                arg14
            } else {
                arg13
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v29, arg2, v28, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v29, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v31 = if (v30 == 1) {
                arg14
            } else {
                arg13
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v32, arg2, v31, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v32, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v34 = if (v33 == 1) {
                arg14
            } else {
                arg13
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v35, arg2, v34, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v35, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v36 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v37 = if (v36 == 1) {
                arg14
            } else {
                arg13
            };
            let v38 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v38, arg2, v37, arg12, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v38, arg15);
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v39, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg15);
            if (v39 == 0) {
                return
            };
            let (v41, v42, v43) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v39, 4295048016, arg15);
            let v44 = v43;
            0x2::balance::destroy_zero<T0>(v41);
            let (v45, v46) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v42, arg16), arg10, arg11, arg15, arg16);
            let v47 = v46;
            let v48 = v45;
            if (0x2::coin::value<T1>(&v48) == 0) {
                0x2::coin::destroy_zero<T1>(v48);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v48, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v47, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v44), arg16)), 0x2::balance::zero<T1>(), v44);
            let v49 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
            assert!(((v49 & 18446744073709551615) as u64) ^ ((v49 >> 64 & 18446744073709551615) as u64) ^ ((v49 >> 128 & 18446744073709551615) as u64) ^ ((v49 >> 192) as u64) == 9459194608057385379, 9223374008244764671);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v47, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v50, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg15);
            if (v50 == 0) {
                return
            };
            let (v52, v53, v54) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v50, 79226673515401279992447579055, arg15);
            let v55 = v54;
            0x2::balance::destroy_zero<T1>(v53);
            let (v56, v57) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v52, arg16), arg10, arg11, arg15, arg16);
            let v58 = v57;
            let v59 = v56;
            if (0x2::coin::value<T0>(&v59) == 0) {
                0x2::coin::destroy_zero<T0>(v59);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v59, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v58, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v55), arg16)), v55);
            let v60 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
            assert!(((v60 & 18446744073709551615) as u64) ^ ((v60 >> 64 & 18446744073709551615) as u64) ^ ((v60 >> 128 & 18446744073709551615) as u64) ^ ((v60 >> 192) as u64) == 9459194608057385379, 9223374141388750847);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v58, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun d<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223374472101232639);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg16), arg16);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223374592360316927);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v10 = &v9;
            let v11 = if (*v10 == 1) {
                arg14
            } else if (*v10 == 2) {
                arg15
            } else {
                arg13
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v12, arg2, v11, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v12, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v14 = &v13;
            let v15 = if (*v14 == 1) {
                arg14
            } else if (*v14 == 2) {
                arg15
            } else {
                arg13
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v16, arg2, v15, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v16, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v18 = &v17;
            let v19 = if (*v18 == 1) {
                arg14
            } else if (*v18 == 2) {
                arg15
            } else {
                arg13
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v20, arg2, v19, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v20, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v22 = &v21;
            let v23 = if (*v22 == 1) {
                arg14
            } else if (*v22 == 2) {
                arg15
            } else {
                arg13
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v24, arg2, v23, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v24, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v26 = &v25;
            let v27 = if (*v26 == 1) {
                arg14
            } else if (*v26 == 2) {
                arg15
            } else {
                arg13
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v28, arg2, v27, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v28, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v30 = &v29;
            let v31 = if (*v30 == 1) {
                arg14
            } else if (*v30 == 2) {
                arg15
            } else {
                arg13
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v32, arg2, v31, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v32, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v34 = &v33;
            let v35 = if (*v34 == 1) {
                arg14
            } else if (*v34 == 2) {
                arg15
            } else {
                arg13
            };
            let v36 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v36, arg2, v35, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v36, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v37 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v38 = &v37;
            let v39 = if (*v38 == 1) {
                arg14
            } else if (*v38 == 2) {
                arg15
            } else {
                arg13
            };
            let v40 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v40, arg2, v39, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v40, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v41 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v42 = &v41;
            let v43 = if (*v42 == 1) {
                arg14
            } else if (*v42 == 2) {
                arg15
            } else {
                arg13
            };
            let v44 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v44, arg2, v43, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v44, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v45 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v46 = &v45;
            let v47 = if (*v46 == 1) {
                arg14
            } else if (*v46 == 2) {
                arg15
            } else {
                arg13
            };
            let v48 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v48, arg2, v47, arg12, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v48, arg16);
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v49, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg16);
            if (v49 == 0) {
                return
            };
            let (v51, v52, v53) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v49, 4295048016, arg16);
            let v54 = v53;
            0x2::balance::destroy_zero<T0>(v51);
            let (v55, v56) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v52, arg17), arg10, arg11, arg16, arg17);
            let v57 = v56;
            let v58 = v55;
            if (0x2::coin::value<T1>(&v58) == 0) {
                0x2::coin::destroy_zero<T1>(v58);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v58, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v57, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v54), arg17)), 0x2::balance::zero<T1>(), v54);
            let v59 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
            assert!(((v59 & 18446744073709551615) as u64) ^ ((v59 >> 64 & 18446744073709551615) as u64) ^ ((v59 >> 128 & 18446744073709551615) as u64) ^ ((v59 >> 192) as u64) == 9459194608057385379, 9223375064806719487);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v57, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v60, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg16);
            if (v60 == 0) {
                return
            };
            let (v62, v63, v64) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v60, 79226673515401279992447579055, arg16);
            let v65 = v64;
            0x2::balance::destroy_zero<T1>(v63);
            let (v66, v67) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v62, arg17), arg10, arg11, arg16, arg17);
            let v68 = v67;
            let v69 = v66;
            if (0x2::coin::value<T0>(&v69) == 0) {
                0x2::coin::destroy_zero<T0>(v69);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v69, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v68, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v65), arg17)), v65);
            let v70 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
            assert!(((v70 & 18446744073709551615) as u64) ^ ((v70 >> 64 & 18446744073709551615) as u64) ^ ((v70 >> 128 & 18446744073709551615) as u64) ^ ((v70 >> 192) as u64) == 9459194608057385379, 9223375197950705663);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v68, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    public fun e<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223375537253122047);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg17), arg17);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223375678987042815);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v10 = &v9;
            let v11 = if (*v10 == 1) {
                arg14
            } else if (*v10 == 2) {
                arg15
            } else if (*v10 == 3) {
                arg16
            } else {
                arg13
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v12, arg2, v11, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg11, v12, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v14 = &v13;
            let v15 = if (*v14 == 1) {
                arg14
            } else if (*v14 == 2) {
                arg15
            } else if (*v14 == 3) {
                arg16
            } else {
                arg13
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v16, arg2, v15, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg11, v16, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v18 = &v17;
            let v19 = if (*v18 == 1) {
                arg14
            } else if (*v18 == 2) {
                arg15
            } else if (*v18 == 3) {
                arg16
            } else {
                arg13
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v20, arg2, v19, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg11, v20, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v22 = &v21;
            let v23 = if (*v22 == 1) {
                arg14
            } else if (*v22 == 2) {
                arg15
            } else if (*v22 == 3) {
                arg16
            } else {
                arg13
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v24, arg2, v23, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg11, v24, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v26 = &v25;
            let v27 = if (*v26 == 1) {
                arg14
            } else if (*v26 == 2) {
                arg15
            } else if (*v26 == 3) {
                arg16
            } else {
                arg13
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v28, arg2, v27, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg11, v28, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v30 = &v29;
            let v31 = if (*v30 == 1) {
                arg14
            } else if (*v30 == 2) {
                arg15
            } else if (*v30 == 3) {
                arg16
            } else {
                arg13
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v32, arg2, v31, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg11, v32, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v34 = &v33;
            let v35 = if (*v34 == 1) {
                arg14
            } else if (*v34 == 2) {
                arg15
            } else if (*v34 == 3) {
                arg16
            } else {
                arg13
            };
            let v36 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v36, arg2, v35, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg11, v36, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v37 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v38 = &v37;
            let v39 = if (*v38 == 1) {
                arg14
            } else if (*v38 == 2) {
                arg15
            } else if (*v38 == 3) {
                arg16
            } else {
                arg13
            };
            let v40 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v40, arg2, v39, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg11, v40, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v41 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v42 = &v41;
            let v43 = if (*v42 == 1) {
                arg14
            } else if (*v42 == 2) {
                arg15
            } else if (*v42 == 3) {
                arg16
            } else {
                arg13
            };
            let v44 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v44, arg2, v43, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg11, v44, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v45 = 0x1::vector::pop_back<u8>(&mut arg4);
            let v46 = &v45;
            let v47 = if (*v46 == 1) {
                arg14
            } else if (*v46 == 2) {
                arg15
            } else if (*v46 == 3) {
                arg16
            } else {
                arg13
            };
            let v48 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg11);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v48, arg2, v47, arg12, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg11, v48, arg17);
        };
        if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
            let (v49, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg8, arg9, arg10, arg11, arg17);
            if (v49 == 0) {
                return
            };
            let (v51, v52, v53) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, false, v49, 4295048016, arg17);
            let v54 = v53;
            0x2::balance::destroy_zero<T0>(v51);
            let (v55, v56) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v52, arg18), arg10, arg11, arg17, arg18);
            let v57 = v56;
            let v58 = v55;
            if (0x2::coin::value<T1>(&v58) == 0) {
                0x2::coin::destroy_zero<T1>(v58);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v58, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v57, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v54), arg18)), 0x2::balance::zero<T1>(), v54);
            let v59 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v59 & 18446744073709551615) as u64) ^ ((v59 >> 64 & 18446744073709551615) as u64) ^ ((v59 >> 128 & 18446744073709551615) as u64) ^ ((v59 >> 192) as u64) == 9459194608057385379, 9223376151433445375);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v57, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        } else {
            let (v60, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg8, arg9, arg10, arg11, arg17);
            if (v60 == 0) {
                return
            };
            let (v62, v63, v64) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, false, false, v60, 79226673515401279992447579055, arg17);
            let v65 = v64;
            0x2::balance::destroy_zero<T1>(v63);
            let (v66, v67) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v62, arg18), arg10, arg11, arg17, arg18);
            let v68 = v67;
            let v69 = v66;
            if (0x2::coin::value<T0>(&v69) == 0) {
                0x2::coin::destroy_zero<T0>(v69);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v69, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v68, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v65), arg18)), v65);
            let v70 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v70 & 18446744073709551615) as u64) ^ ((v70 >> 64 & 18446744073709551615) as u64) ^ ((v70 >> 128 & 18446744073709551615) as u64) ^ ((v70 >> 192) as u64) == 9459194608057385379, 9223376284577431551);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v68, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
    }

    // decompiled from Move bytecode v7
}

