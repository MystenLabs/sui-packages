module 0xdd010b3376422ac3554065bd15ddbedbb0f53b569e7d4e96641e7283b76a13a7::pyth {
    public fun update_1(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1);
        if (v2 > v0) {
            if (v2 - v0 < 0x1::option::get_with_default<u64>(&arg3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0))) {
                return
            };
        } else if (v0 - v2 < 0x1::option::get_with_default<u64>(&arg3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0))) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg4, arg5, arg7), arg7), arg2, 0x2::coin::split<0x2::sui::SUI>(arg6, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg8), arg7));
    }

    public fun update_2(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<u64>, arg6: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg7: vector<u8>, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg9) / 1000;
        let v2 = true;
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3);
        if (v4 > v1) {
            if (v4 - v1 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
                v2 = false;
                /* goto 10 */
            };
        } else if (v1 - v4 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
            v2 = false;
            /* goto 10 */
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5);
        if (v6 > v1) {
            if (v6 - v1 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
                v2 = false;
            };
        } else if (v1 - v6 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
            v2 = false;
        };
        /* label 10 */
        if (v2) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg6, arg7, arg9), arg9), arg2, 0x2::coin::split<0x2::sui::SUI>(arg8, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg10), arg9), arg4, 0x2::coin::split<0x2::sui::SUI>(arg8, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg10), arg9));
    }

    public fun update_3(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<u64>, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x1::option::Option<u64>, arg8: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg9: vector<u8>, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg11) / 1000;
        let v2 = true;
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg6);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3);
        if (v4 > v1) {
            if (v4 - v1 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
                v2 = false;
                /* goto 15 */
            };
        } else if (v1 - v4 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
            v2 = false;
            /* goto 15 */
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5);
        if (v6 > v1) {
            if (v6 - v1 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
                v2 = false;
                /* goto 15 */
            };
        } else if (v1 - v6 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
            v2 = false;
            /* goto 15 */
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v7);
        if (v8 > v1) {
            if (v8 - v1 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
                v2 = false;
            };
        } else if (v1 - v8 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
            v2 = false;
        };
        /* label 15 */
        if (v2) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg8, arg9, arg11), arg11), arg2, 0x2::coin::split<0x2::sui::SUI>(arg10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg12), arg11), arg4, 0x2::coin::split<0x2::sui::SUI>(arg10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg12), arg11), arg6, 0x2::coin::split<0x2::sui::SUI>(arg10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg12), arg11));
    }

    public fun update_4(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<u64>, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x1::option::Option<u64>, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x1::option::Option<u64>, arg10: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg11: vector<u8>, arg12: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg13) / 1000;
        let v2 = true;
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg8);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3);
        if (v4 > v1) {
            if (v4 - v1 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
                v2 = false;
                /* goto 20 */
            };
        } else if (v1 - v4 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
            v2 = false;
            /* goto 20 */
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg6);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5);
        if (v6 > v1) {
            if (v6 - v1 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
                v2 = false;
                /* goto 20 */
            };
        } else if (v1 - v6 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
            v2 = false;
            /* goto 20 */
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v7);
        if (v8 > v1) {
            if (v8 - v1 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
                v2 = false;
                /* goto 20 */
            };
        } else if (v1 - v8 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
            v2 = false;
            /* goto 20 */
        };
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v9);
        if (v10 > v1) {
            if (v10 - v1 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
                v2 = false;
            };
        } else if (v1 - v10 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
            v2 = false;
        };
        /* label 20 */
        if (v2) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg10, arg11, arg13), arg13), arg2, 0x2::coin::split<0x2::sui::SUI>(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg14), arg13), arg4, 0x2::coin::split<0x2::sui::SUI>(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg14), arg13), arg6, 0x2::coin::split<0x2::sui::SUI>(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg14), arg13), arg8, 0x2::coin::split<0x2::sui::SUI>(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg14), arg13));
    }

    public fun update_5(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<u64>, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x1::option::Option<u64>, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x1::option::Option<u64>, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: 0x1::option::Option<u64>, arg12: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg13: vector<u8>, arg14: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg15) / 1000;
        let v2 = true;
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg10);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3);
        if (v4 > v1) {
            if (v4 - v1 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
                v2 = false;
                /* goto 25 */
            };
        } else if (v1 - v4 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
            v2 = false;
            /* goto 25 */
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg8);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5);
        if (v6 > v1) {
            if (v6 - v1 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
                v2 = false;
                /* goto 25 */
            };
        } else if (v1 - v6 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
            v2 = false;
            /* goto 25 */
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg6);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v7);
        if (v8 > v1) {
            if (v8 - v1 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
                v2 = false;
                /* goto 25 */
            };
        } else if (v1 - v8 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
            v2 = false;
            /* goto 25 */
        };
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v9);
        if (v10 > v1) {
            if (v10 - v1 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
                v2 = false;
                /* goto 25 */
            };
        } else if (v1 - v10 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
            v2 = false;
            /* goto 25 */
        };
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v11);
        if (v12 > v1) {
            if (v12 - v1 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
                v2 = false;
            };
        } else if (v1 - v12 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
            v2 = false;
        };
        /* label 25 */
        if (v2) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg12, arg13, arg15), arg15), arg2, 0x2::coin::split<0x2::sui::SUI>(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg16), arg15), arg4, 0x2::coin::split<0x2::sui::SUI>(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg16), arg15), arg6, 0x2::coin::split<0x2::sui::SUI>(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg16), arg15), arg8, 0x2::coin::split<0x2::sui::SUI>(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg16), arg15), arg10, 0x2::coin::split<0x2::sui::SUI>(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg16), arg15));
    }

    public fun update_6(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<u64>, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x1::option::Option<u64>, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x1::option::Option<u64>, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: 0x1::option::Option<u64>, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: 0x1::option::Option<u64>, arg14: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg15: vector<u8>, arg16: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg17) / 1000;
        let v2 = true;
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg12);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3);
        if (v4 > v1) {
            if (v4 - v1 >= 0x1::option::get_with_default<u64>(&arg13, v0)) {
                v2 = false;
                /* goto 30 */
            };
        } else if (v1 - v4 >= 0x1::option::get_with_default<u64>(&arg13, v0)) {
            v2 = false;
            /* goto 30 */
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg10);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5);
        if (v6 > v1) {
            if (v6 - v1 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
                v2 = false;
                /* goto 30 */
            };
        } else if (v1 - v6 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
            v2 = false;
            /* goto 30 */
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg8);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v7);
        if (v8 > v1) {
            if (v8 - v1 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
                v2 = false;
                /* goto 30 */
            };
        } else if (v1 - v8 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
            v2 = false;
            /* goto 30 */
        };
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg6);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v9);
        if (v10 > v1) {
            if (v10 - v1 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
                v2 = false;
                /* goto 30 */
            };
        } else if (v1 - v10 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
            v2 = false;
            /* goto 30 */
        };
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v11);
        if (v12 > v1) {
            if (v12 - v1 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
                v2 = false;
                /* goto 30 */
            };
        } else if (v1 - v12 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
            v2 = false;
            /* goto 30 */
        };
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v14 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v13);
        if (v14 > v1) {
            if (v14 - v1 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
                v2 = false;
            };
        } else if (v1 - v14 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
            v2 = false;
        };
        /* label 30 */
        if (v2) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg14, arg15, arg17), arg17), arg2, 0x2::coin::split<0x2::sui::SUI>(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg18), arg17), arg4, 0x2::coin::split<0x2::sui::SUI>(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg18), arg17), arg6, 0x2::coin::split<0x2::sui::SUI>(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg18), arg17), arg8, 0x2::coin::split<0x2::sui::SUI>(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg18), arg17), arg10, 0x2::coin::split<0x2::sui::SUI>(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg18), arg17), arg12, 0x2::coin::split<0x2::sui::SUI>(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg18), arg17));
    }

    public fun update_7(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<u64>, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x1::option::Option<u64>, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x1::option::Option<u64>, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: 0x1::option::Option<u64>, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: 0x1::option::Option<u64>, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: 0x1::option::Option<u64>, arg16: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg17: vector<u8>, arg18: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg19) / 1000;
        let v2 = true;
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg14);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3);
        if (v4 > v1) {
            if (v4 - v1 >= 0x1::option::get_with_default<u64>(&arg15, v0)) {
                v2 = false;
                /* goto 35 */
            };
        } else if (v1 - v4 >= 0x1::option::get_with_default<u64>(&arg15, v0)) {
            v2 = false;
            /* goto 35 */
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg12);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5);
        if (v6 > v1) {
            if (v6 - v1 >= 0x1::option::get_with_default<u64>(&arg13, v0)) {
                v2 = false;
                /* goto 35 */
            };
        } else if (v1 - v6 >= 0x1::option::get_with_default<u64>(&arg13, v0)) {
            v2 = false;
            /* goto 35 */
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg10);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v7);
        if (v8 > v1) {
            if (v8 - v1 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
                v2 = false;
                /* goto 35 */
            };
        } else if (v1 - v8 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
            v2 = false;
            /* goto 35 */
        };
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg8);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v9);
        if (v10 > v1) {
            if (v10 - v1 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
                v2 = false;
                /* goto 35 */
            };
        } else if (v1 - v10 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
            v2 = false;
            /* goto 35 */
        };
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg6);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v11);
        if (v12 > v1) {
            if (v12 - v1 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
                v2 = false;
                /* goto 35 */
            };
        } else if (v1 - v12 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
            v2 = false;
            /* goto 35 */
        };
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v14 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v13);
        if (v14 > v1) {
            if (v14 - v1 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
                v2 = false;
                /* goto 35 */
            };
        } else if (v1 - v14 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
            v2 = false;
            /* goto 35 */
        };
        let v15 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v16 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v15);
        if (v16 > v1) {
            if (v16 - v1 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
                v2 = false;
            };
        } else if (v1 - v16 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
            v2 = false;
        };
        /* label 35 */
        if (v2) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg16, arg17, arg19), arg19), arg2, 0x2::coin::split<0x2::sui::SUI>(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg20), arg19), arg4, 0x2::coin::split<0x2::sui::SUI>(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg20), arg19), arg6, 0x2::coin::split<0x2::sui::SUI>(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg20), arg19), arg8, 0x2::coin::split<0x2::sui::SUI>(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg20), arg19), arg10, 0x2::coin::split<0x2::sui::SUI>(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg20), arg19), arg12, 0x2::coin::split<0x2::sui::SUI>(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg20), arg19), arg14, 0x2::coin::split<0x2::sui::SUI>(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg20), arg19));
    }

    public fun update_8(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<u64>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<u64>, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x1::option::Option<u64>, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x1::option::Option<u64>, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: 0x1::option::Option<u64>, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: 0x1::option::Option<u64>, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: 0x1::option::Option<u64>, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: 0x1::option::Option<u64>, arg18: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg19: vector<u8>, arg20: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg21) / 1000;
        let v2 = true;
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg16);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3);
        if (v4 > v1) {
            if (v4 - v1 >= 0x1::option::get_with_default<u64>(&arg17, v0)) {
                v2 = false;
                /* goto 40 */
            };
        } else if (v1 - v4 >= 0x1::option::get_with_default<u64>(&arg17, v0)) {
            v2 = false;
            /* goto 40 */
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg14);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5);
        if (v6 > v1) {
            if (v6 - v1 >= 0x1::option::get_with_default<u64>(&arg15, v0)) {
                v2 = false;
                /* goto 40 */
            };
        } else if (v1 - v6 >= 0x1::option::get_with_default<u64>(&arg15, v0)) {
            v2 = false;
            /* goto 40 */
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg12);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v7);
        if (v8 > v1) {
            if (v8 - v1 >= 0x1::option::get_with_default<u64>(&arg13, v0)) {
                v2 = false;
                /* goto 40 */
            };
        } else if (v1 - v8 >= 0x1::option::get_with_default<u64>(&arg13, v0)) {
            v2 = false;
            /* goto 40 */
        };
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg10);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v9);
        if (v10 > v1) {
            if (v10 - v1 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
                v2 = false;
                /* goto 40 */
            };
        } else if (v1 - v10 >= 0x1::option::get_with_default<u64>(&arg11, v0)) {
            v2 = false;
            /* goto 40 */
        };
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg8);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v11);
        if (v12 > v1) {
            if (v12 - v1 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
                v2 = false;
                /* goto 40 */
            };
        } else if (v1 - v12 >= 0x1::option::get_with_default<u64>(&arg9, v0)) {
            v2 = false;
            /* goto 40 */
        };
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg6);
        let v14 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v13);
        if (v14 > v1) {
            if (v14 - v1 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
                v2 = false;
                /* goto 40 */
            };
        } else if (v1 - v14 >= 0x1::option::get_with_default<u64>(&arg7, v0)) {
            v2 = false;
            /* goto 40 */
        };
        let v15 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v16 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v15);
        if (v16 > v1) {
            if (v16 - v1 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
                v2 = false;
                /* goto 40 */
            };
        } else if (v1 - v16 >= 0x1::option::get_with_default<u64>(&arg5, v0)) {
            v2 = false;
            /* goto 40 */
        };
        let v17 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v18 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v17);
        if (v18 > v1) {
            if (v18 - v1 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
                v2 = false;
            };
        } else if (v1 - v18 >= 0x1::option::get_with_default<u64>(&arg3, v0)) {
            v2 = false;
        };
        /* label 40 */
        if (v2) {
            return
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg18, arg19, arg21), arg21), arg2, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21), arg4, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21), arg6, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21), arg8, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21), arg10, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21), arg12, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21), arg14, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21), arg16, 0x2::coin::split<0x2::sui::SUI>(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg22), arg21));
    }

    public fun update_all(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>, arg2: vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg3: vector<0x1::option::Option<u64>>, arg4: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject> {
        let v0 = 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(&arg2);
        let v1 = 0;
        let v2 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let v3 = true;
        while (v1 < v0) {
            let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(&arg2, v1));
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v4);
            if (v5 > v2) {
                if (v5 - v2 >= 0x1::option::get_with_default<u64>(0x1::vector::borrow<0x1::option::Option<u64>>(&arg3, v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0))) {
                    v3 = false;
                    break
                };
            } else if (v2 - v5 < 0x1::option::get_with_default<u64>(0x1::vector::borrow<0x1::option::Option<u64>>(&arg3, v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_stale_price_threshold_secs(arg0))) {
                v3 = false;
                break
            };
            v1 = v1 + 1;
        };
        if (v3) {
            return arg2
        };
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg4, arg5, arg7), arg7);
        v1 = 0;
        while (v1 < v0) {
            v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, v6, 0x1::vector::borrow_mut<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(&mut arg2, v1), 0x2::coin::split<0x2::sui::SUI>(arg6, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0), arg8), arg7);
            v1 = v1 + 1;
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        arg2
    }

    // decompiled from Move bytecode v6
}

