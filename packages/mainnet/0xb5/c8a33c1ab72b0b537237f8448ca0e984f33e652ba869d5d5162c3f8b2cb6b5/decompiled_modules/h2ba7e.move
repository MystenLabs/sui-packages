module 0xb5c8a33c1ab72b0b537237f8448ca0e984f33e652ba869d5d5162c3f8b2cb6b5::h2ba7e {
    struct H78683 has copy, drop {
        h8e156: u64,
        hbda43: u32,
        h850e3: u32,
        h8de33: u64,
        he685a: u64,
    }

    struct Hffcbd has copy, drop {
        h8e156: u64,
        h316ad: u64,
        hf47fa: u64,
        h6ff6b: u64,
        h056cd: u64,
    }

    struct H86095 has copy, drop {
        h8e156: u64,
        h06023: 0x1::ascii::String,
        h16137: u64,
    }

    public fun h484e5<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        if (0x2::clock::timestamp_ms(arg4) > arg9) {
            abort 13906834560890568707
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v2 = if (arg8) {
            v0
        } else {
            v1
        };
        let v3 = h7d43b(arg7, v2);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg5);
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg6);
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v4);
        let v8 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v5);
        let v9 = if (arg8) {
            v1
        } else {
            v0
        };
        let (v10, v11) = if (arg8) {
            let v12 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_b_for_liquidity(v7, v6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amount_a(v6, v8, (v3 as u128))) as u64);
            if (v12 <= v9) {
                (v3, v12)
            } else {
                ((0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_a_for_liquidity(v6, v8, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amount_b(v7, v6, (v9 as u128))) as u64), v9)
            }
        } else {
            let v13 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_a_for_liquidity(v6, v8, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amount_b(v7, v6, (v3 as u128))) as u64);
            if (v13 <= v9) {
                (v13, v3)
            } else {
                (v9, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_b_for_liquidity(v7, v6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amount_a(v6, v8, (v9 as u128))) as u64))
            }
        };
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amounts(v6, v7, v8, (v10 as u128), (v11 as u128)) > 0, 13906834930257625089);
        assert!(v10 <= v0 && v11 <= v1, 13906834934552854533);
        let v14 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v10, arg11));
        let v15 = 0x1::vector::empty<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>();
        0x1::vector::push_back<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut v15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v11, arg11));
        let (v16, v17, v18) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, arg1, v14, v15, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v5), v10, v11, 0, 0, 18446744073709551615, arg4, arg3, arg11);
        let v19 = v18;
        let v20 = v17;
        let v21 = H78683{
            h8e156 : arg10,
            hbda43 : arg5,
            h850e3 : arg6,
            h8de33 : v10 - 0x2::coin::value<0x2::sui::SUI>(&v20),
            he685a : v11 - 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v19),
        };
        0x2::event::emit<H78683>(v21);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, v20, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v19, arg11);
        v16
    }

    fun h69c93<T0>(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            let v0 = H86095{
                h8e156 : arg0,
                h06023 : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                h16137 : arg1,
            };
            0x2::event::emit<H86095>(v0);
        };
    }

    fun h7d43b(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun hec00f<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<0x2::sui::SUI>, arg6: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg6));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, arg1, &mut arg6, v2, 0, 0, 18446744073709551615, arg8, arg3, arg9);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, arg1, &mut arg6, 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg9), 18446744073709551615, arg8, arg3, arg9);
        let v9 = v8;
        let v10 = v7;
        let v11 = Hffcbd{
            h8e156 : arg7,
            h316ad : 0x2::coin::value<0x2::sui::SUI>(&v6),
            hf47fa : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v5),
            h6ff6b : 0x2::coin::value<0x2::sui::SUI>(&v10),
            h056cd : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v9),
        };
        0x2::event::emit<Hffcbd>(v11);
        0x2::coin::join<0x2::sui::SUI>(&mut v6, v10);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v5, v9);
        let v12 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0, 0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg0, arg1, &mut arg6, arg4, 0, 18446744073709551615, 0x2::tx_context::sender(arg9), 18446744073709551615, arg8, arg3, arg9);
        let v13 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0, 0x2::sui::SUI>(arg0, arg1, &mut arg6, arg5, 1, 18446744073709551615, 0x2::tx_context::sender(arg9), 18446744073709551615, arg8, arg3, arg9);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg6, arg3, arg9);
        h69c93<0x2::sui::SUI>(arg7, 0x2::coin::value<0x2::sui::SUI>(&v13));
        0x2::coin::join<0x2::sui::SUI>(&mut v6, v13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, v6, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v5, arg9);
        let v14 = 0x2::coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&v12);
        h69c93<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg7, v14);
        if (v14 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg2, v12, arg9);
        } else {
            0x2::coin::destroy_zero<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(v12);
        };
    }

    // decompiled from Move bytecode v6
}

