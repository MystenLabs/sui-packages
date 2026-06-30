module 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::pu {
    public fun ap(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg6), arg5, arg6, arg7));
    }

    fun authenticated_updates(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg4), arg4)
    }

    public fun bp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg7), arg5, arg7, arg8);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v0, arg6, arg7, arg8));
    }

    public fun cp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg8), arg5, arg8, arg9);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg8, arg9);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v1, arg7, arg8, arg9));
    }

    public fun dp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg9), arg5, arg9, arg10);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg9, arg10);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg9, arg10);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v2, arg8, arg9, arg10));
    }

    public fun ep(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg10), arg5, arg10, arg11);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg10, arg11);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg10, arg11);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg10, arg11);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v3, arg9, arg10, arg11));
    }

    public fun fp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg11), arg5, arg11, arg12);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg11, arg12);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg11, arg12);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg11, arg12);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg11, arg12);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v4, arg10, arg11, arg12));
    }

    public fun gp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg12), arg5, arg12, arg13);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg12, arg13);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg12, arg13);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg12, arg13);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg12, arg13);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg12, arg13);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v5, arg11, arg12, arg13));
    }

    public fun hp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg13), arg5, arg13, arg14);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg13, arg14);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg13, arg14);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg13, arg14);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg13, arg14);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg13, arg14);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg13, arg14);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v6, arg12, arg13, arg14));
    }

    public fun ip(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg14), arg5, arg14, arg15);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg14, arg15);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg14, arg15);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg14, arg15);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg14, arg15);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg14, arg15);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg14, arg15);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg14, arg15);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v7, arg13, arg14, arg15));
    }

    public fun jp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg15), arg5, arg15, arg16);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg15, arg16);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg15, arg16);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg15, arg16);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg15, arg16);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg15, arg16);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg15, arg16);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg15, arg16);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg15, arg16);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v8, arg14, arg15, arg16));
    }

    public fun kp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg16), arg5, arg16, arg17);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg16, arg17);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg16, arg17);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg16, arg17);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg16, arg17);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg16, arg17);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg16, arg17);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg16, arg17);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg16, arg17);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg16, arg17);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v9, arg15, arg16, arg17));
    }

    public fun lp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg17), arg5, arg17, arg18);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg17, arg18);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg17, arg18);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg17, arg18);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg17, arg18);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg17, arg18);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg17, arg18);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg17, arg18);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg17, arg18);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg17, arg18);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg17, arg18);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v10, arg16, arg17, arg18));
    }

    public fun mp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg18), arg5, arg18, arg19);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg18, arg19);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg18, arg19);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg18, arg19);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg18, arg19);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg18, arg19);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg18, arg19);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg18, arg19);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg18, arg19);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg18, arg19);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg18, arg19);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg18, arg19);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v11, arg17, arg18, arg19));
    }

    public fun np(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg19), arg5, arg19, arg20);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg19, arg20);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg19, arg20);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg19, arg20);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg19, arg20);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg19, arg20);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg19, arg20);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg19, arg20);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg19, arg20);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg19, arg20);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg19, arg20);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg19, arg20);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg19, arg20);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v12, arg18, arg19, arg20));
    }

    public fun op(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg20), arg5, arg20, arg21);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg20, arg21);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg20, arg21);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg20, arg21);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg20, arg21);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg20, arg21);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg20, arg21);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg20, arg21);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg20, arg21);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg20, arg21);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg20, arg21);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg20, arg21);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg20, arg21);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg20, arg21);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v13, arg19, arg20, arg21));
    }

    public fun pp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg21), arg5, arg21, arg22);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg21, arg22);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg21, arg22);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg21, arg22);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg21, arg22);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg21, arg22);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg21, arg22);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg21, arg22);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg21, arg22);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg21, arg22);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg21, arg22);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg21, arg22);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg21, arg22);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg21, arg22);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg21, arg22);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v14, arg20, arg21, arg22));
    }

    public fun qp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg22), arg5, arg22, arg23);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg22, arg23);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg22, arg23);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg22, arg23);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg22, arg23);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg22, arg23);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg22, arg23);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg22, arg23);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg22, arg23);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg22, arg23);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg22, arg23);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg22, arg23);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg22, arg23);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg22, arg23);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg22, arg23);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg22, arg23);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v15, arg21, arg22, arg23));
    }

    public fun rp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg23), arg5, arg23, arg24);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg23, arg24);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg23, arg24);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg23, arg24);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg23, arg24);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg23, arg24);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg23, arg24);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg23, arg24);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg23, arg24);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg23, arg24);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg23, arg24);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg23, arg24);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg23, arg24);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg23, arg24);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg23, arg24);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg23, arg24);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg23, arg24);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v16, arg22, arg23, arg24));
    }

    public fun sp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg24), arg5, arg24, arg25);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg24, arg25);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg24, arg25);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg24, arg25);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg24, arg25);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg24, arg25);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg24, arg25);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg24, arg25);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg24, arg25);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg24, arg25);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg24, arg25);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg24, arg25);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg24, arg25);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg24, arg25);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg24, arg25);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg24, arg25);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg24, arg25);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg24, arg25);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v17, arg23, arg24, arg25));
    }

    public fun tp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg25), arg5, arg25, arg26);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg25, arg26);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg25, arg26);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg25, arg26);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg25, arg26);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg25, arg26);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg25, arg26);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg25, arg26);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg25, arg26);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg25, arg26);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg25, arg26);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg25, arg26);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg25, arg26);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg25, arg26);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg25, arg26);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg25, arg26);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg25, arg26);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg25, arg26);
        let v18 = update_price_feed(arg4, arg1, v17, arg23, arg25, arg26);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v18, arg24, arg25, arg26));
    }

    public fun up(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg26), arg5, arg26, arg27);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg26, arg27);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg26, arg27);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg26, arg27);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg26, arg27);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg26, arg27);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg26, arg27);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg26, arg27);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg26, arg27);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg26, arg27);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg26, arg27);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg26, arg27);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg26, arg27);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg26, arg27);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg26, arg27);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg26, arg27);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg26, arg27);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg26, arg27);
        let v18 = update_price_feed(arg4, arg1, v17, arg23, arg26, arg27);
        let v19 = update_price_feed(arg4, arg1, v18, arg24, arg26, arg27);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v19, arg25, arg26, arg27));
    }

    fun update_price_feed(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1), arg5), arg4)
    }

    public fun vp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &0x2::clock::Clock, arg28: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg27), arg5, arg27, arg28);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg27, arg28);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg27, arg28);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg27, arg28);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg27, arg28);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg27, arg28);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg27, arg28);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg27, arg28);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg27, arg28);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg27, arg28);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg27, arg28);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg27, arg28);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg27, arg28);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg27, arg28);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg27, arg28);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg27, arg28);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg27, arg28);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg27, arg28);
        let v18 = update_price_feed(arg4, arg1, v17, arg23, arg27, arg28);
        let v19 = update_price_feed(arg4, arg1, v18, arg24, arg27, arg28);
        let v20 = update_price_feed(arg4, arg1, v19, arg25, arg27, arg28);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v20, arg26, arg27, arg28));
    }

    public fun wp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg28), arg5, arg28, arg29);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg28, arg29);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg28, arg29);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg28, arg29);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg28, arg29);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg28, arg29);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg28, arg29);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg28, arg29);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg28, arg29);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg28, arg29);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg28, arg29);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg28, arg29);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg28, arg29);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg28, arg29);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg28, arg29);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg28, arg29);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg28, arg29);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg28, arg29);
        let v18 = update_price_feed(arg4, arg1, v17, arg23, arg28, arg29);
        let v19 = update_price_feed(arg4, arg1, v18, arg24, arg28, arg29);
        let v20 = update_price_feed(arg4, arg1, v19, arg25, arg28, arg29);
        let v21 = update_price_feed(arg4, arg1, v20, arg26, arg28, arg29);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v21, arg27, arg28, arg29));
    }

    public fun xp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg29), arg5, arg29, arg30);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg29, arg30);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg29, arg30);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg29, arg30);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg29, arg30);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg29, arg30);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg29, arg30);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg29, arg30);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg29, arg30);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg29, arg30);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg29, arg30);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg29, arg30);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg29, arg30);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg29, arg30);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg29, arg30);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg29, arg30);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg29, arg30);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg29, arg30);
        let v18 = update_price_feed(arg4, arg1, v17, arg23, arg29, arg30);
        let v19 = update_price_feed(arg4, arg1, v18, arg24, arg29, arg30);
        let v20 = update_price_feed(arg4, arg1, v19, arg25, arg29, arg30);
        let v21 = update_price_feed(arg4, arg1, v20, arg26, arg29, arg30);
        let v22 = update_price_feed(arg4, arg1, v21, arg27, arg29, arg30);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v22, arg28, arg29, arg30));
    }

    public fun yp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &0x2::clock::Clock, arg31: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg30), arg5, arg30, arg31);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg30, arg31);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg30, arg31);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg30, arg31);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg30, arg31);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg30, arg31);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg30, arg31);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg30, arg31);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg30, arg31);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg30, arg31);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg30, arg31);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg30, arg31);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg30, arg31);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg30, arg31);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg30, arg31);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg30, arg31);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg30, arg31);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg30, arg31);
        let v18 = update_price_feed(arg4, arg1, v17, arg23, arg30, arg31);
        let v19 = update_price_feed(arg4, arg1, v18, arg24, arg30, arg31);
        let v20 = update_price_feed(arg4, arg1, v19, arg25, arg30, arg31);
        let v21 = update_price_feed(arg4, arg1, v20, arg26, arg30, arg31);
        let v22 = update_price_feed(arg4, arg1, v21, arg27, arg30, arg31);
        let v23 = update_price_feed(arg4, arg1, v22, arg28, arg30, arg31);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v23, arg29, arg30, arg31));
    }

    public fun zp(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: &0x2::clock::Clock, arg32: &mut 0x2::tx_context::TxContext) {
        let v0 = update_price_feed(arg4, arg1, authenticated_updates(arg0, arg1, arg2, arg3, arg31), arg5, arg31, arg32);
        let v1 = update_price_feed(arg4, arg1, v0, arg6, arg31, arg32);
        let v2 = update_price_feed(arg4, arg1, v1, arg7, arg31, arg32);
        let v3 = update_price_feed(arg4, arg1, v2, arg8, arg31, arg32);
        let v4 = update_price_feed(arg4, arg1, v3, arg9, arg31, arg32);
        let v5 = update_price_feed(arg4, arg1, v4, arg10, arg31, arg32);
        let v6 = update_price_feed(arg4, arg1, v5, arg11, arg31, arg32);
        let v7 = update_price_feed(arg4, arg1, v6, arg12, arg31, arg32);
        let v8 = update_price_feed(arg4, arg1, v7, arg13, arg31, arg32);
        let v9 = update_price_feed(arg4, arg1, v8, arg14, arg31, arg32);
        let v10 = update_price_feed(arg4, arg1, v9, arg15, arg31, arg32);
        let v11 = update_price_feed(arg4, arg1, v10, arg16, arg31, arg32);
        let v12 = update_price_feed(arg4, arg1, v11, arg17, arg31, arg32);
        let v13 = update_price_feed(arg4, arg1, v12, arg18, arg31, arg32);
        let v14 = update_price_feed(arg4, arg1, v13, arg19, arg31, arg32);
        let v15 = update_price_feed(arg4, arg1, v14, arg20, arg31, arg32);
        let v16 = update_price_feed(arg4, arg1, v15, arg21, arg31, arg32);
        let v17 = update_price_feed(arg4, arg1, v16, arg22, arg31, arg32);
        let v18 = update_price_feed(arg4, arg1, v17, arg23, arg31, arg32);
        let v19 = update_price_feed(arg4, arg1, v18, arg24, arg31, arg32);
        let v20 = update_price_feed(arg4, arg1, v19, arg25, arg31, arg32);
        let v21 = update_price_feed(arg4, arg1, v20, arg26, arg31, arg32);
        let v22 = update_price_feed(arg4, arg1, v21, arg27, arg31, arg32);
        let v23 = update_price_feed(arg4, arg1, v22, arg28, arg31, arg32);
        let v24 = update_price_feed(arg4, arg1, v23, arg29, arg31, arg32);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(update_price_feed(arg4, arg1, v24, arg30, arg31, arg32));
    }

    // decompiled from Move bytecode v7
}

