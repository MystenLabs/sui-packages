module 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a5484a7b2caf45727 {
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

    struct A0bd1b8c85944d7f5 has copy, drop {
        afd94b072972e9180: address,
        ab68e65b0e9b4e2c7: address,
        a18751e423005e357: u64,
        aa645bf066bacc38b: u64,
        a14a1161d798a5502: u64,
        aba17ec94fa735110: u64,
        a71046d94b4c1fd10: u64,
        afe06293f68567953: u64,
        ac26cd795c07654cc: u64,
        a0a9dc6ff20587b68: u64,
        a175c20364eb82b0c: u64,
        a4f1293823a0e97d2: u64,
        a4868d57d9526e6de: u64,
        aab159116549728b8: u64,
        timestamp_ms: u64,
    }

    struct Ad9862fe87d0a60b3 has copy, drop {
        afd94b072972e9180: address,
        ab68e65b0e9b4e2c7: address,
        a18751e423005e357: u64,
        aa645bf066bacc38b: u64,
        a855e3b86142847f7: u64,
        ad0088de8c9e14450: u64,
        a4ccdb52d64bec0e8: u64,
        a18c0c70d5a286122: u64,
        a2d986675197e732d: u64,
        ab91e95deac0b3700: u64,
        a6327162b9d7d18cc: u64,
        a27eabb798234e4b8: u64,
        ac1275a445604f292: u64,
        aab159116549728b8: u64,
        timestamp_ms: u64,
    }

    public(friend) fun a03c3514643cc676c<T0, T1, T2>(arg0: &0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (!0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::a3e97cb17cc8b4c07(arg0)) {
            return
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, arg7, arg11);
        let (v1, v2) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg3, arg4, arg5, arg6, arg10, &mut v0, arg11);
        let v3 = v1;
        let v4 = 0x2::coin::value<T1>(&v0);
        if (v4 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, v0, arg11);
        } else {
            0x2::coin::destroy_zero<T1>(v0);
        };
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg3, arg6, arg10, v3, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v2), arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg1, v5, arg11);
        let v6 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3);
        let v7 = Ad9862fe87d0a60b3{
            afd94b072972e9180 : 0x2::object::id_to_address(&arg4),
            ab68e65b0e9b4e2c7 : 0x2::object::id_to_address(&v6),
            a18751e423005e357 : arg5,
            aa645bf066bacc38b : arg6,
            a855e3b86142847f7 : 0x2::coin::value<T1>(&v0) - v4,
            ad0088de8c9e14450 : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(&v3),
            a4ccdb52d64bec0e8 : 0x2::coin::value<T2>(&v5),
            a18c0c70d5a286122 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1),
            a2d986675197e732d : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg1),
            ab91e95deac0b3700 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1),
            a6327162b9d7d18cc : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg1),
            a27eabb798234e4b8 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1) + (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1) as u128) * (arg2 as u128) / (1000000000 as u128)) as u64),
            ac1275a445604f292 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1) + (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1) as u128) * (arg2 as u128) / (1000000000 as u128)) as u64),
            aab159116549728b8 : arg2,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<Ad9862fe87d0a60b3>(v7);
    }

    public fun a5a9339fe7dd9e4a6(arg0: &0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::A0ea878587b719a64, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock) {
        if (!0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::a3e97cb17cc8b4c07(arg0)) {
            return
        };
        let v0 = A0bd1b8c85944d7f5{
            afd94b072972e9180 : arg1,
            ab68e65b0e9b4e2c7 : arg2,
            a18751e423005e357 : arg3,
            aa645bf066bacc38b : arg4,
            a14a1161d798a5502 : arg5,
            aba17ec94fa735110 : arg6,
            a71046d94b4c1fd10 : arg7,
            afe06293f68567953 : arg8,
            ac26cd795c07654cc : arg9,
            a0a9dc6ff20587b68 : arg10,
            a175c20364eb82b0c : arg11,
            a4f1293823a0e97d2 : arg12,
            a4868d57d9526e6de : arg13,
            aab159116549728b8 : arg14,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg15),
        };
        0x2::event::emit<A0bd1b8c85944d7f5>(v0);
    }

    public fun a6d9db2e1527a4602(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>> {
        if (0x1::option::is_none<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(&arg2)) {
            return arg2
        };
        0x1::option::some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x1::option::destroy_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>>(arg2), arg3, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg5), arg4))
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

    public(friend) fun a820350afdaf0c518<T0, T1>(arg0: &0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u8, arg4: u8, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        if (!0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::a3e97cb17cc8b4c07(arg0)) {
            return
        };
        let v0 = !0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg15, arg7, arg6, arg5);
        let v1 = if (v0) {
            let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg15, arg7, arg6, arg4, arg5);
            let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg15, arg7, arg6, arg3, arg5);
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
            timestamp_ms      : 0x2::clock::timestamp_ms(arg15),
        };
        0x2::event::emit<Aac56ae4c64df67f8>(v8);
        let v9 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::a28c70aa22a06b7eb(arg0);
        let v10 = if (v1 < v9) {
            v1
        } else {
            v9
        };
        let v11 = v10;
        let v12 = if (arg4 != 0) {
            if (arg4 != 10) {
                if (arg4 != 8) {
                    if (arg4 != 11) {
                        arg4 != 3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v12) {
            let v13 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::ad4985d21e71b208e(arg0);
            let v14 = if (v10 < v13) {
                v10
            } else {
                v13
            };
            v11 = v14;
        };
        if (!v0 || v11 == 0) {
            return
        };
        let v15 = if (!0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::a611ed42baa1839e4(arg0)) {
            if (arg4 != 10) {
                arg4 != 0
            } else {
                false
            }
        } else {
            false
        };
        if (v15) {
            return
        };
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v18 = a82f12b2b8269c603<T0>(arg1, arg7, arg3, arg15);
        let v19 = a82f12b2b8269c603<T1>(arg1, arg7, arg4, arg15);
        let v20 = v18 + v19;
        let v21 = if (arg3 == 10) {
            let v22 = a96caec0cf7d2a62c(arg0, arg1, arg2, v11, arg13, arg14, arg15, arg16);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v22, arg16)
        } else if (arg3 == 0) {
            let v23 = a9d7347eddbc97a66(arg0, arg1, arg2, v11, arg13, arg14, arg15, arg16);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v23, arg16)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg16)
        };
        let v24 = v21;
        let v25 = 0x2::coin::value<T0>(&v24);
        if (v25 == 0) {
            0x2::coin::destroy_zero<T0>(v24);
            return
        };
        let (v26, v27) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg15, arg7, arg6, arg3, arg8, 0x2::coin::into_balance<T0>(v24), arg4, arg12, arg5, arg9, arg10, arg11, arg16);
        let v28 = v27;
        let v29 = v26;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v29, arg16), arg16);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v28, arg16), arg16);
        let v30 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v32 = a82f12b2b8269c603<T0>(arg1, arg7, arg3, arg15);
        let v33 = v32 + a82f12b2b8269c603<T1>(arg1, arg7, arg4, arg15);
        assert!(v33 >= v20, 13906835647517163519);
        let v34 = Af454e845b3b480b6{
            aef66ea9fdfdf6d38 : arg5,
            ab48a9f34af22058d : arg3,
            aa6e55145993bf678 : arg4,
            ab3f5c67f76a778b6 : v11,
            a855e3b86142847f7 : v25 - 0x2::balance::value<T0>(&v28),
            aae7919b761f17521 : 0x2::balance::value<T1>(&v29),
            a18c0c70d5a286122 : v16,
            a2d986675197e732d : v17,
            ab91e95deac0b3700 : v30,
            a6327162b9d7d18cc : v31,
            a27eabb798234e4b8 : v20,
            ac1275a445604f292 : v33,
            aab159116549728b8 : arg2,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg15),
        };
        0x2::event::emit<Af454e845b3b480b6>(v34);
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

    fun a96caec0cf7d2a62c(arg0: &0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v1 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        let v2 = v1;
        let v3 = 0;
        if (v1 < arg3) {
            v3 = arg3 - v1;
        };
        if (v3 > 0 && 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::a02b2fbebbd0b1747(arg0)) {
            let v4 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::ac89fc20276c7e30c(arg0, v3, arg2);
            let v5 = if (v4 < v0) {
                v4
            } else {
                v0
            };
            let v6 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a2ec4300f6df080d1::a099d08408fdb4a75(1);
            let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4);
            let v8 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a2ec4300f6df080d1::a213fd2a6b463b66d(&v6, v7, arg2 * 99 / 100);
            if (v7 < v8 && v5 > 0) {
                let (_, _) = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a2ec4300f6df080d1::a07270e6afe6ed38d(arg1, arg4, arg5, v5, v8, arg6, arg7);
            };
            v2 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
            0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        };
        if (v2 < arg3) {
            v2
        } else {
            arg3
        }
    }

    fun a9d7347eddbc97a66(arg0: &0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v1 = v0;
        0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        let v2 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::ac89fc20276c7e30c(arg0, arg3, arg2);
        let v3 = 0;
        if (v0 < v2) {
            v3 = v2 - v0;
        };
        if (v3 > 0 && 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a783956f993d811bc::a02b2fbebbd0b1747(arg0)) {
            let v4 = if (v3 < v0) {
                v3
            } else {
                v0
            };
            let v5 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a2ec4300f6df080d1::a099d08408fdb4a75(1);
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4);
            let v7 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a2ec4300f6df080d1::ac019152139aa990a(&v5, v6, arg2 * 100 / 99);
            if (v6 > v7 && v4 > 0) {
                let (_, _) = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a2ec4300f6df080d1::a35a29cc990f6dc81(arg1, arg4, arg5, v4, v7, arg6, arg7);
            };
            0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
            v1 = 0x4ab183439ca8ef617e19d90a46b48bfa6fa8d99fa35c4b83f8c330ae498c6ba4::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        };
        if (v1 < v2) {
            v1
        } else {
            v2
        }
    }

    public fun af56f3eeee63722ad(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 10, 13906836751323758591);
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

