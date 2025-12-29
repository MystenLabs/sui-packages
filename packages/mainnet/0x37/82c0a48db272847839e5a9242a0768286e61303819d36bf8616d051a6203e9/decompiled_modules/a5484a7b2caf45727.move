module 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a5484a7b2caf45727 {
    struct Aac56ae4c64df67f8 has copy, drop {
        aef66ea9fdfdf6d38: address,
        ab48a9f34af22058d: u8,
        aa6e55145993bf678: u8,
        a336ab9dffa65c9af: bool,
        ab3f5c67f76a778b6: u64,
        timestamp_ms: u64,
    }

    struct Af454e845b3b480b6 has copy, drop {
        aef66ea9fdfdf6d38: address,
        ab48a9f34af22058d: u8,
        aa6e55145993bf678: u8,
        ab3f5c67f76a778b6: u64,
        a855e3b86142847f7: u64,
        aae7919b761f17521: u64,
        a18c0c70d5a286122: u64,
        a2d986675197e732d: u64,
        ab91e95deac0b3700: u64,
        a6327162b9d7d18cc: u64,
        a27eabb798234e4b8: u64,
        ac1275a445604f292: u64,
        aab159116549728b8: u64,
        timestamp_ms: u64,
    }

    struct Ae5618fec1f8e816b has copy, drop {
        ae9ea603231b993f7: address,
        a884fe2d741a55d6d: vector<u8>,
        ac1de6c9b6c718861: vector<u256>,
        a33e0038d6ac161bf: vector<u8>,
        a0ada78908f255730: vector<u256>,
    }

    public fun a2d3ee8ca94596444(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>> {
        if (0x1::option::is_none<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(&arg2)) {
            return arg2
        };
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg8, arg4, arg5, arg6, arg3, arg7);
        0x1::option::some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x1::option::destroy_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(arg2), arg3, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg9), arg8))
    }

    public fun a71a3c2cbe8aac741(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (vector<Ae5618fec1f8e816b>, u64) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<Ae5618fec1f8e816b>();
        while (v0 < 0x1::vector::length<address>(&arg2) && 0x1::vector::length<Ae5618fec1f8e816b>(&v1) < arg4) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            v0 = v0 + 1;
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, v2);
            let v5 = 0;
            let v6 = v4;
            0x1::vector::reverse<u8>(&mut v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<u8>(&v6)) {
                let v8 = 0x1::vector::pop_back<u8>(&mut v6);
                let (_, v10) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, v8, v2);
                let (_, v12, v13) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg5, arg1, v8);
                v5 = v5 + ((v10 * v12 / (0x2::math::pow(10, v13) as u256) * 1000000 / 1000000000) as u64);
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<u8>(v6);
            if (v5 < arg3) {
                continue
            };
            let v14 = vector[];
            let v15 = vector[];
            let v16 = v3;
            0x1::vector::reverse<u8>(&mut v16);
            let v17 = 0;
            while (v17 < 0x1::vector::length<u8>(&v16)) {
                let (v18, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, 0x1::vector::pop_back<u8>(&mut v16), v2);
                0x1::vector::push_back<u256>(&mut v14, v18);
                v17 = v17 + 1;
            };
            0x1::vector::destroy_empty<u8>(v16);
            let v20 = v4;
            0x1::vector::reverse<u8>(&mut v20);
            let v21 = 0;
            while (v21 < 0x1::vector::length<u8>(&v20)) {
                let (_, v23) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, 0x1::vector::pop_back<u8>(&mut v20), v2);
                0x1::vector::push_back<u256>(&mut v15, v23);
                v21 = v21 + 1;
            };
            0x1::vector::destroy_empty<u8>(v20);
            let v24 = Ae5618fec1f8e816b{
                ae9ea603231b993f7 : v2,
                a884fe2d741a55d6d : v3,
                ac1de6c9b6c718861 : v14,
                a33e0038d6ac161bf : v4,
                a0ada78908f255730 : v15,
            };
            0x1::vector::push_back<Ae5618fec1f8e816b>(&mut v1, v24);
        };
        (v1, v0)
    }

    public(friend) fun a820350afdaf0c518<T0, T1>(arg0: &0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u8, arg4: u8, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg17: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg19: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg20: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg21: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg22: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = !0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg23, arg7, arg6, arg5);
        let v1 = if (v0) {
            let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg23, arg7, arg6, arg4, arg5);
            let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg23, arg7, arg6, arg3, arg5);
            let v4 = if (v2 < v3) {
                v2
            } else {
                v3
            };
            let (v5, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg6, arg3);
            ((v4 * v5 / 1000000000000000000000000000 * 1000000000 / 1000000) as u64)
        } else {
            0
        };
        let v8 = Aac56ae4c64df67f8{
            aef66ea9fdfdf6d38 : arg5,
            ab48a9f34af22058d : arg3,
            aa6e55145993bf678 : arg4,
            a336ab9dffa65c9af : v0,
            ab3f5c67f76a778b6 : v1,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg23),
        };
        0x2::event::emit<Aac56ae4c64df67f8>(v8);
        if (!v0 || v1 == 0) {
            return
        };
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v11 = a82f12b2b8269c603<T0>(arg1, arg7, arg3, arg23);
        let v12 = a82f12b2b8269c603<T1>(arg1, arg7, arg4, arg23);
        let v13 = v11 + v12;
        let v14 = if (arg3 == 10) {
            let v15 = a96caec0cf7d2a62c(arg0, arg1, arg2, v1, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v15, arg24)
        } else if (arg3 == 0) {
            let v16 = a9d7347eddbc97a66(arg0, arg1, arg2, v1, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v16, arg24)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg24)
        };
        let v17 = v14;
        let v18 = 0x2::coin::value<T0>(&v17);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T0>(v17);
            return
        };
        let (v19, v20) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg23, arg7, arg6, arg3, arg8, 0x2::coin::into_balance<T0>(v17), arg4, arg12, arg5, arg9, arg10, arg11, arg24);
        let v21 = v20;
        let v22 = v19;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v22, arg24), arg24);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v21, arg24), arg24);
        let v23 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v25 = a82f12b2b8269c603<T0>(arg1, arg7, arg3, arg23);
        let v26 = v25 + a82f12b2b8269c603<T1>(arg1, arg7, arg4, arg23);
        assert!(v26 >= v13, 13906835475718471679);
        let v27 = Af454e845b3b480b6{
            aef66ea9fdfdf6d38 : arg5,
            ab48a9f34af22058d : arg3,
            aa6e55145993bf678 : arg4,
            ab3f5c67f76a778b6 : v1,
            a855e3b86142847f7 : v18 - 0x2::balance::value<T0>(&v21),
            aae7919b761f17521 : 0x2::balance::value<T1>(&v22),
            a18c0c70d5a286122 : v9,
            a2d986675197e732d : v10,
            ab91e95deac0b3700 : v23,
            a6327162b9d7d18cc : v24,
            a27eabb798234e4b8 : v13,
            ac1275a445604f292 : v26,
            aab159116549728b8 : arg2,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg23),
        };
        0x2::event::emit<Af454e845b3b480b6>(v27);
    }

    fun a82f12b2b8269c603<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: u8, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg3, arg1, (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0) as u256), arg2);
        let (_, _, v3) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg3, arg1, arg2);
        if (v3 >= 6) {
            let v4 = v3;
            while (v4 > 6) {
                v0 = v0 / 10;
                v4 = v4 - 1;
            };
        } else {
            let v5 = 6;
            while (v5 > v3) {
                v0 = v0 * 10;
                v5 = v5 - 1;
            };
        };
        (v0 as u64)
    }

    public fun a8d6bc20df49e7a14(arg0: bool, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64) : bool {
        if (arg0) {
            return arg0
        };
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        arg2 > 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1)
    }

    public fun a8e335ef307cfb492(arg0: bool, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>> {
        if (!arg0) {
            return 0x1::option::none<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>()
        };
        0x1::option::some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, arg3, arg5), arg5))
    }

    fun a96caec0cf7d2a62c(arg0: &0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v1 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        let v2 = v1;
        let v3 = 0;
        if (v1 < arg3) {
            v3 = arg3 - v1;
        };
        if (v3 > 0) {
            let v4 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::ac89fc20276c7e30c(arg0, v3, arg2);
            let v5 = if (v4 < v0) {
                v4
            } else {
                v0
            };
            let v6 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::a099d08408fdb4a75(1);
            let (_, _) = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::af81a08da76e37dc0(&v6, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v5, 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::a213fd2a6b463b66d(&v6, 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(&v6, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), arg2 * 99 / 100), arg14, arg15);
            v2 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
            0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        };
        if (v2 < arg3) {
            v2
        } else {
            arg3
        }
    }

    fun a9d7347eddbc97a66(arg0: &0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v1 = v0;
        0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        let v2 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::ac89fc20276c7e30c(arg0, arg3, arg2);
        let v3 = 0;
        if (v0 < v2) {
            v3 = v2 - v0;
        };
        if (v3 > 0) {
            let v4 = if (v3 < v0) {
                v3
            } else {
                v0
            };
            let v5 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::a099d08408fdb4a75(1);
            let (_, _) = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::a44e5f8062dd6fde6(&v5, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v4, 0, 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::ac019152139aa990a(&v5, 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(&v5, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), arg2 * 100 / 99), arg14, arg15);
            0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
            v1 = 0x3782c0a48db272847839e5a9242a0768286e61303819d36bf8616d051a6203e9::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        };
        if (v1 < v2) {
            v1
        } else {
            v2
        }
    }

    public fun af655226522d21a0f(arg0: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>) {
        if (0x1::option::is_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(&arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x1::option::destroy_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(arg0));
        } else {
            0x1::option::destroy_none<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

