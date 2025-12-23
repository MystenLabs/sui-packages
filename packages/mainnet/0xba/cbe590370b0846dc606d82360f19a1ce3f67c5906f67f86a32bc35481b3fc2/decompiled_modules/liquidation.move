module 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::liquidation {
    struct LiquidationOppportunityEvent has copy, drop {
        borrower: address,
        debt_asset_id: u8,
        collateral_asset_id: u8,
        is_liquidatable: bool,
        liquidateable_amount_debt: u64,
        timestamp_ms: u64,
    }

    struct LiquidationEvent has copy, drop {
        borrower: address,
        debt_asset_id: u8,
        collateral_asset_id: u8,
        liquidateable_amount_debt: u64,
        amount_liquidated_debt: u64,
        seized_collateral: u64,
        usdc_balance_before: u64,
        sui_balance_before: u64,
        usdc_balance_after: u64,
        sui_balance_after: u64,
        estimated_sui_valuation: u64,
        timestamp_ms: u64,
    }

    struct NaviUserData has copy, drop {
        user: address,
        collateral_assets: vector<u8>,
        collateral_asset_raw_amounts: vector<u256>,
        debt_assets: vector<u8>,
        debt_asset_raw_amounts: vector<u256>,
    }

    public fun get_navi_user_data(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (vector<NaviUserData>, u64) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<NaviUserData>();
        while (v0 < 0x1::vector::length<address>(&arg2) && v0 < arg4) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            v0 = v0 + 1;
            if (((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg5, arg1, arg0, v2) * 1000000 / 1000000000) as u64) < arg3) {
                continue
            };
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, v2);
            let v5 = v4;
            let v6 = v3;
            let v7 = vector[];
            let v8 = vector[];
            let v9 = &v6;
            let v10 = 0;
            while (v10 < 0x1::vector::length<u8>(v9)) {
                let (v11, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, *0x1::vector::borrow<u8>(v9, v10), v2);
                0x1::vector::push_back<u256>(&mut v7, v11);
                v10 = v10 + 1;
            };
            let v13 = &v5;
            let v14 = 0;
            while (v14 < 0x1::vector::length<u8>(v13)) {
                let (_, v16) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, *0x1::vector::borrow<u8>(v13, v14), v2);
                0x1::vector::push_back<u256>(&mut v8, v16);
                v14 = v14 + 1;
            };
            let v17 = NaviUserData{
                user                         : v2,
                collateral_assets            : v6,
                collateral_asset_raw_amounts : v7,
                debt_assets                  : v5,
                debt_asset_raw_amounts       : v8,
            };
            0x1::vector::push_back<NaviUserData>(&mut v1, v17);
        };
        (v1, v0)
    }

    public(friend) fun liquidate_position(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u8, arg4: u8, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg13: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg17: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg19: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg20: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg21: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg22: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = !0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg23, arg7, arg6, arg5);
        let v1 = if (v0) {
            let (v2, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg6, arg3);
            ((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg23, arg7, arg6, arg4, arg5) * v2 / 1000000000000000000000000000 * 1000000000 / 1000000) as u64)
        } else {
            0
        };
        let v5 = LiquidationOppportunityEvent{
            borrower                  : arg5,
            debt_asset_id             : arg3,
            collateral_asset_id       : arg4,
            is_liquidatable           : v0,
            liquidateable_amount_debt : v1,
            timestamp_ms              : 0x2::clock::timestamp_ms(arg23),
        };
        0x2::event::emit<LiquidationOppportunityEvent>(v5);
        if (!v0 || v1 == 0) {
            return
        };
        if (arg3 != 10 || arg4 != 0) {
            return
        };
        let v6 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg1);
        let v7 = v6;
        let v8 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg1);
        let v9 = v8;
        let v10 = 0;
        if (v8 < v1) {
            v10 = v1 - v8;
        };
        if (v10 > 0) {
            let v11 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg0, v10, arg2);
            let v12 = if (v11 < v6) {
                v11
            } else {
                v6
            };
            let v13 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(1);
            let (_, _) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::swap_sell(&v13, arg1, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, v12, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::decrease_sqrt_price(&v13, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(&v13, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22), arg2 * 99 / 100), arg23, arg24);
            v9 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg1);
            v7 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg1);
        };
        let v16 = if (v9 < v1) {
            v9
        } else {
            v1
        };
        let (v17, v18) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg23, arg7, arg6, arg3, arg8, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v16, arg24)), arg4, arg12, arg5, arg9, arg10, arg11, arg24);
        let v19 = v18;
        let v20 = v17;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v20, arg24), arg24);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v19, arg24), arg24);
        let v21 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg1);
        let v22 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg1);
        assert!(v22 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v21, arg2) >= v9 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v7, arg2), 13906835364049321983);
        let v23 = LiquidationEvent{
            borrower                  : arg5,
            debt_asset_id             : arg3,
            collateral_asset_id       : arg4,
            liquidateable_amount_debt : v1,
            amount_liquidated_debt    : v16 - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v19),
            seized_collateral         : 0x2::balance::value<0x2::sui::SUI>(&v20),
            usdc_balance_before       : v9,
            sui_balance_before        : v7,
            usdc_balance_after        : v22,
            sui_balance_after         : v21,
            estimated_sui_valuation   : arg2,
            timestamp_ms              : 0x2::clock::timestamp_ms(arg23),
        };
        0x2::event::emit<LiquidationEvent>(v23);
    }

    // decompiled from Move bytecode v6
}

