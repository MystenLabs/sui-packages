module 0x62d9f3edbba233a0d962e0583ecdf5b881e08d8f0eae8cae268c02d158c33c1a::pyth {
    public fun update1(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg8: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg9: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg5, arg8, arg9, arg10, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg7, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg7, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg6, arg0, arg5), arg5), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg5));
    }

    public fun update10(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x2::clock::Clock, arg15: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg17: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg18: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg19: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg17, arg18, arg19, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg16, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg16, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg15, arg0, arg14), arg14), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg14));
    }

    public fun update11(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x2::clock::Clock, arg16: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg17: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg18: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg19: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg20: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg18, arg19, arg20, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg17, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg17, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg16, arg0, arg15), arg15), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg15));
    }

    public fun update12(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg19: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg20: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg21: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg19, arg20, arg21, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg18, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg18, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg17, arg0, arg16), arg16), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg16));
    }

    public fun update13(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg19: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg20: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg21: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg22: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg20, arg21, arg22, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg19, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg19, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg18, arg0, arg17), arg17), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg17));
    }

    public fun update14(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg21: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg22: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg23: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg21, arg22, arg23, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg20, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg20, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg19, arg0, arg18), arg18), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg18));
    }

    public fun update15(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg21: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg22: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg23: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg24: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg22, arg23, arg24, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg21, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg21, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg20, arg0, arg19), arg19), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg19));
    }

    public fun update16(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg22: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg23: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg24: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg25: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg23, arg24, arg25, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg22, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg22, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg21, arg0, arg20), arg20), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg20));
    }

    public fun update17(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &0x2::clock::Clock, arg22: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg23: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg24: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg25: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg26: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg24, arg25, arg26, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg23, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg23, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg22, arg0, arg21), arg21), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg21));
    }

    public fun update18(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &0x2::clock::Clock, arg23: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg24: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg25: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg26: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg27: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg25, arg26, arg27, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg24, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg24, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg23, arg0, arg22), arg22), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg22));
    }

    public fun update19(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &0x2::clock::Clock, arg24: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg25: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg26: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg27: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg28: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg26, arg27, arg28, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg25, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg25, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg24, arg0, arg23), arg23), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg23));
    }

    public fun update2(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg9: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg10: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg6, arg9, arg10, arg11, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg6, arg9, arg10, arg11, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg8, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg8, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg8, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg7, arg0, arg6), arg6), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg6), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg6));
    }

    public fun update20(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &0x2::clock::Clock, arg25: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg26: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg27: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg28: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg29: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg27, arg28, arg29, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg26, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg26, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg25, arg0, arg24), arg24), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg24));
    }

    public fun update21(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &0x2::clock::Clock, arg26: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg27: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg28: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg29: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg30: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg28, arg29, arg30, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg27, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg27, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg26, arg0, arg25), arg25), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg25));
    }

    public fun update22(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &0x2::clock::Clock, arg27: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg28: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg29: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg30: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg31: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg29, arg30, arg31, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg28, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg28, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg27, arg0, arg26), arg26), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg26));
    }

    public fun update23(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &0x2::clock::Clock, arg28: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg29: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg30: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg31: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg32: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg30, arg31, arg32, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg29, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg29, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg28, arg0, arg27), arg27), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg27));
    }

    public fun update24(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &0x2::clock::Clock, arg29: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg30: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg31: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg32: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg33: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        let v23 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v23) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg31, arg32, arg33, arg27, 0x1::vector::pop_back<address>(&mut v23));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg30, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg30, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg29, arg0, arg28), arg28), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28), arg27, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg28));
    }

    public fun update25(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &0x2::clock::Clock, arg30: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg31: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg32: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg33: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg34: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        let v23 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v23) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg27, 0x1::vector::pop_back<address>(&mut v23));
        };
        let v24 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v24) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg32, arg33, arg34, arg28, 0x1::vector::pop_back<address>(&mut v24));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg31, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg31, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg30, arg0, arg29), arg29), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg27, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29), arg28, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg29));
    }

    public fun update26(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &0x2::clock::Clock, arg31: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg32: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg33: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg34: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg35: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        let v23 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v23) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg27, 0x1::vector::pop_back<address>(&mut v23));
        };
        let v24 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v24) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg28, 0x1::vector::pop_back<address>(&mut v24));
        };
        let v25 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v25) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg33, arg34, arg35, arg29, 0x1::vector::pop_back<address>(&mut v25));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg32, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg32, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg31, arg0, arg30), arg30), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg27, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg28, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30), arg29, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg30));
    }

    public fun update27(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: &0x2::clock::Clock, arg32: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg33: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg34: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg35: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg36: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        let v23 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v23) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg27, 0x1::vector::pop_back<address>(&mut v23));
        };
        let v24 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v24) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg28, 0x1::vector::pop_back<address>(&mut v24));
        };
        let v25 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v25) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg29, 0x1::vector::pop_back<address>(&mut v25));
        };
        let v26 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v26) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg34, arg35, arg36, arg30, 0x1::vector::pop_back<address>(&mut v26));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg33, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg33, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg32, arg0, arg31), arg31), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg27, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg28, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg29, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31), arg30, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg31));
    }

    public fun update28(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg32: &0x2::clock::Clock, arg33: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg34: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg35: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg36: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg37: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        let v23 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v23) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg27, 0x1::vector::pop_back<address>(&mut v23));
        };
        let v24 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v24) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg28, 0x1::vector::pop_back<address>(&mut v24));
        };
        let v25 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v25) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg29, 0x1::vector::pop_back<address>(&mut v25));
        };
        let v26 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v26) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg30, 0x1::vector::pop_back<address>(&mut v26));
        };
        let v27 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v27) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg35, arg36, arg37, arg31, 0x1::vector::pop_back<address>(&mut v27));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg34, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg34, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg33, arg0, arg32), arg32), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg27, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg28, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg29, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg30, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32), arg31, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg32));
    }

    public fun update29(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg32: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg33: &0x2::clock::Clock, arg34: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg35: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg36: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg37: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg38: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        let v23 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v23) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg27, 0x1::vector::pop_back<address>(&mut v23));
        };
        let v24 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v24) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg28, 0x1::vector::pop_back<address>(&mut v24));
        };
        let v25 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v25) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg29, 0x1::vector::pop_back<address>(&mut v25));
        };
        let v26 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v26) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg30, 0x1::vector::pop_back<address>(&mut v26));
        };
        let v27 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v27) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg31, 0x1::vector::pop_back<address>(&mut v27));
        };
        let v28 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v28) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg36, arg37, arg38, arg32, 0x1::vector::pop_back<address>(&mut v28));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg35, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg35, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg34, arg0, arg33), arg33), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg27, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg28, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg29, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg30, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg31, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33), arg32, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg33));
    }

    public fun update3(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg10: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg11: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg7, arg10, arg11, arg12, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg7, arg10, arg11, arg12, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg7, arg10, arg11, arg12, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg9, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg9, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg9, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg9, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg8, arg0, arg7), arg7), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg7), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg7), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg7));
    }

    public fun update30(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg32: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg33: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg34: &0x2::clock::Clock, arg35: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg36: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg37: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg38: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg39: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        let v9 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v9) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg13, 0x1::vector::pop_back<address>(&mut v9));
        };
        let v10 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v10) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg14, 0x1::vector::pop_back<address>(&mut v10));
        };
        let v11 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v11) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg15, 0x1::vector::pop_back<address>(&mut v11));
        };
        let v12 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v12) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg6, 0x1::vector::pop_back<address>(&mut v12));
        };
        let v13 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v13) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg17, 0x1::vector::pop_back<address>(&mut v13));
        };
        let v14 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v14) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg18, 0x1::vector::pop_back<address>(&mut v14));
        };
        let v15 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v15) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg9, 0x1::vector::pop_back<address>(&mut v15));
        };
        let v16 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v16) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg20, 0x1::vector::pop_back<address>(&mut v16));
        };
        let v17 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v17) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg21, 0x1::vector::pop_back<address>(&mut v17));
        };
        let v18 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v18) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg22, 0x1::vector::pop_back<address>(&mut v18));
        };
        let v19 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v19) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg23, 0x1::vector::pop_back<address>(&mut v19));
        };
        let v20 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v20) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg24, 0x1::vector::pop_back<address>(&mut v20));
        };
        let v21 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v21) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg25, 0x1::vector::pop_back<address>(&mut v21));
        };
        let v22 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v22) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg26, 0x1::vector::pop_back<address>(&mut v22));
        };
        let v23 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v23) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg27, 0x1::vector::pop_back<address>(&mut v23));
        };
        let v24 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v24) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg28, 0x1::vector::pop_back<address>(&mut v24));
        };
        let v25 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v25) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg29, 0x1::vector::pop_back<address>(&mut v25));
        };
        let v26 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v26) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg30, 0x1::vector::pop_back<address>(&mut v26));
        };
        let v27 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v27) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg31, 0x1::vector::pop_back<address>(&mut v27));
        };
        let v28 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v28) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg32, 0x1::vector::pop_back<address>(&mut v28));
        };
        let v29 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v29) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg37, arg38, arg39, arg33, 0x1::vector::pop_back<address>(&mut v29));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg36, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg36, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg35, arg0, arg34), arg34), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg13, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg14, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg16, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg17, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg18, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg19, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg20, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg21, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg22, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg23, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg24, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg25, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg26, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg27, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg28, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg29, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg30, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg31, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg32, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34), arg33, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg34));
    }

    public fun update4(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg11: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        let v0 = 0x1::vector::borrow_mut<vector<address>>(&mut arg3, 0);
        while (0x1::vector::length<address>(v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg8, arg11, arg12, arg13, arg4, 0x1::vector::pop_back<address>(v0));
        };
        let v1 = 0x1::vector::borrow_mut<vector<address>>(&mut arg3, 1);
        while (0x1::vector::length<address>(v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg8, arg11, arg12, arg13, arg5, 0x1::vector::pop_back<address>(v1));
        };
        let v2 = 0x1::vector::borrow_mut<vector<address>>(&mut arg3, 2);
        while (0x1::vector::length<address>(v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg8, arg11, arg12, arg13, arg6, 0x1::vector::pop_back<address>(v2));
        };
        let v3 = 0x1::vector::borrow_mut<vector<address>>(&mut arg3, 3);
        while (0x1::vector::length<address>(v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg8, arg11, arg12, arg13, arg7, 0x1::vector::pop_back<address>(v3));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg10, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg9, arg0, arg8), arg8), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg8), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg8), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg8), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg8));
    }

    public fun update5(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg13: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg14: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg9, arg12, arg13, arg14, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg9, arg12, arg13, arg14, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg9, arg12, arg13, arg14, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg9, arg12, arg13, arg14, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg9, arg12, arg13, arg14, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg11, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg11, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg11, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg11, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg11, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg11, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg10, arg0, arg9), arg9), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg9), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg9), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg9), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg9), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg9));
    }

    public fun update6(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg13: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg14: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg15: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg10, arg13, arg14, arg15, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg10, arg13, arg14, arg15, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg10, arg13, arg14, arg15, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg10, arg13, arg14, arg15, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg10, arg13, arg14, arg15, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg10, arg13, arg14, arg15, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg12, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg12, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg11, arg0, arg10), arg10), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg10), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg10), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg10), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg10), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg10), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg10));
    }

    public fun update7(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg13: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg14: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg15: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg16: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg14, arg15, arg16, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg14, arg15, arg16, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg14, arg15, arg16, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg14, arg15, arg16, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg14, arg15, arg16, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg14, arg15, arg16, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg14, arg15, arg16, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg13, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg13, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg13, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg13, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg13, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg13, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg13, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg13, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg12, arg0, arg11), arg11), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg11), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg11), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg11), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg11), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg11), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg11), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg11));
    }

    public fun update8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x2::clock::Clock, arg13: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg15: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg16: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg17: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg15, arg16, arg17, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg14, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg14, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg13, arg0, arg12), arg12), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg12));
    }

    public fun update9(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: vector<vector<address>>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0x2::clock::Clock, arg14: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg15: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg16: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg17: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg18: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x1::vector::reverse<vector<address>>(&mut arg3);
        let v0 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v0) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg4, 0x1::vector::pop_back<address>(&mut v0));
        };
        let v1 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v1) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg5, 0x1::vector::pop_back<address>(&mut v1));
        };
        let v2 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v2) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg6, 0x1::vector::pop_back<address>(&mut v2));
        };
        let v3 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v3) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg7, 0x1::vector::pop_back<address>(&mut v3));
        };
        let v4 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v4) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg8, 0x1::vector::pop_back<address>(&mut v4));
        };
        let v5 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v5) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg9, 0x1::vector::pop_back<address>(&mut v5));
        };
        let v6 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v6) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg10, 0x1::vector::pop_back<address>(&mut v6));
        };
        let v7 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v7) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg11, 0x1::vector::pop_back<address>(&mut v7));
        };
        let v8 = 0x1::vector::pop_back<vector<address>>(&mut arg3);
        while (0x1::vector::length<address>(&v8) > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg16, arg17, arg18, arg12, 0x1::vector::pop_back<address>(&mut v8));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg15, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg15, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg14, arg0, arg13), arg13), arg4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg5, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg6, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg7, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg8, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13), arg12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), arg13));
    }

    // decompiled from Move bytecode v6
}

