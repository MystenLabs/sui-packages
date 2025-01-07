module 0x5ecdaeb30ff790aa3a5a6ccdfb73b4c4dde0e73b0c9c5605b5daab140ed9c87c::z {
    public fun b<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223372358977323007);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg13), arg13);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg14)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223372436286734335);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg13, arg12);
    }

    public fun c<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223372612380393471);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg14), arg14);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg15)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223372711164641279);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg14, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg14, arg13);
    }

    public fun d<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223372913028104191);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg15), arg15);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg16)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223373033287188479);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg15, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg15, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg15, arg14);
    }

    public fun e<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223373260920455167);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg16), arg16);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg17)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223373402654375935);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg16, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg16, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg16, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg16, arg15);
    }

    public fun f<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223373656057446399);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg17), arg17);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 4) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg18)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223373819266203647);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg17, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg17, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg17, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg17, arg15);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 4) & 127) as u64), arg17, arg16);
    }

    public fun g<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223374098439077887);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg18), arg18);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 4) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 5) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg19)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223374283122671615);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg18, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg18, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg18, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg18, arg15);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 4) & 127) as u64), arg18, arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 5) & 127) as u64), arg18, arg17);
    }

    public fun h<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223374588065349631);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg19), arg19);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 4) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 5) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 6) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg20)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223374794223779839);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg19, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg19, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg19, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg19, arg15);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 4) & 127) as u64), arg19, arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 5) & 127) as u64), arg19, arg17);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 6) & 127) as u64), arg19, arg18);
    }

    public fun i<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223375124936261631);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg20), arg20);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 4) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 5) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 6) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 7) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg21)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223375352569528319);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg20, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg20, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg20, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg20, arg15);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 4) & 127) as u64), arg20, arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 5) & 127) as u64), arg20, arg17);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 6) & 127) as u64), arg20, arg18);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 7) & 127) as u64), arg20, arg19);
    }

    public fun j<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223375709051813887);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg21), arg21);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 4) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 5) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 6) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 7) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 8) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg22)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223375958159917055);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg21, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg21, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg21, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg21, arg15);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 4) & 127) as u64), arg21, arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 5) & 127) as u64), arg21, arg17);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 6) & 127) as u64), arg21, arg18);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 7) & 127) as u64), arg21, arg19);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 8) & 127) as u64), arg21, arg20);
    }

    public fun k<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223376340412006399);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg22), arg22);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 4) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 5) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 6) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 7) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 8) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 9) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg23)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223376610994946047);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg22, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg22, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg22, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg22, arg15);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 4) & 127) as u64), arg22, arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 5) & 127) as u64), arg22, arg17);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 6) & 127) as u64), arg22, arg18);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 7) & 127) as u64), arg22, arg19);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 8) & 127) as u64), arg22, arg20);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 9) & 127) as u64), arg22, arg21);
    }

    public fun l<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223377019016839167);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64)), arg23), arg23);
            let v2 = v1;
            if (*0x1::vector::borrow<u8>(&arg4, 0) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v1, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 1) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 2) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 3) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 4) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 5) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 6) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 7) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 8) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 9) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (*0x1::vector::borrow<u8>(&arg4, 10) > 127) {
                v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v2, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        };
        assert!(((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 0 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 64 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 128 & 18446744073709551615) as u64) ^ ((0x2::address::to_u256(0x2::tx_context::sender(arg24)) >> 192 & 18446744073709551615) as u64) == 2781108151421525394, 9223377311074615295);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 0) & 127) as u64), arg23, arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 1) & 127) as u64), arg23, arg13);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 2) & 127) as u64), arg23, arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 3) & 127) as u64), arg23, arg15);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 4) & 127) as u64), arg23, arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 5) & 127) as u64), arg23, arg17);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 6) & 127) as u64), arg23, arg18);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 7) & 127) as u64), arg23, arg19);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 8) & 127) as u64), arg23, arg20);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 9) & 127) as u64), arg23, arg21);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg7, ((*0x1::vector::borrow<u8>(&arg4, 10) & 127) as u64), arg23, arg22);
    }

    // decompiled from Move bytecode v6
}

