module 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market_clm {
    struct CollateralRoutedToLLV has copy, drop {
        market_id: u64,
        llv_pool_id: 0x2::object::ID,
        user: address,
        asset_amount: u64,
        llv_shares_minted: u128,
        timestamp_ms: u64,
    }

    struct CollateralRecalledFromLLV has copy, drop {
        market_id: u64,
        llv_pool_id: 0x2::object::ID,
        user: address,
        caller: address,
        shares_burned: u128,
        asset_received: u64,
        user_ltv: u128,
        timestamp_ms: u64,
    }

    struct RouteToLLVReceipt<phantom T0> {
        market_id: u64,
        user: address,
        amount: u64,
        expected_llv_pool_id: 0x2::object::ID,
    }

    struct RecallFromLLVReceipt<phantom T0> {
        market_id: u64,
        user: address,
        shares_to_recall: u128,
        expected_llv_pool_id: 0x2::object::ID,
    }

    public fun assert_assets_match(arg0: u128, arg1: u64) {
        assert!(arg0 == (arg1 as u128), 109);
    }

    public fun assert_recall_enabled(arg0: u64) {
        assert!(arg0 > 0, 110);
    }

    public fun assert_recall_shares_match(arg0: u128, arg1: u128) {
        assert!(arg1 > 0 && arg1 <= arg0, 111);
    }

    public fun assert_shares_match(arg0: u128, arg1: u128) {
        assert!(arg0 == arg1, 108);
    }

    public fun begin_recall_from_llv<T0, T1>(arg0: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::CLMCap, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: u64, arg3: address, arg4: u64, arg5: address, arg6: &vector<address>, arg7: &0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::pyth_oracle::Oracle, arg8: &0x2::clock::Clock, arg9: u128, arg10: u128, arg11: u128, arg12: bool) : (RecallFromLLVReceipt<T1>, u128) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::assert_clm_cap_market(arg0, arg2);
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_market_llv_config(arg1, arg2);
        let v2 = v1;
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 104);
        assert_recall_enabled(v0);
        if (arg12) {
            assert!(arg5 == arg3, 103);
        } else if (!0x1::vector::contains<address>(arg6, &arg5)) {
            assert!(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_user_ltv_with_llv<T0, T1>(arg1, arg2, arg3, arg7, arg8, arg9) >= (v0 as u128), 103);
        };
        let v3 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_position_llv_shares(arg1, arg2, arg3);
        assert!(v3 > 0, 105);
        let v4 = calculate_shares_for_amount(arg4, arg10, arg11);
        let v5 = if (v4 > v3) {
            v3
        } else {
            v4
        };
        let v6 = RecallFromLLVReceipt<T1>{
            market_id            : arg2,
            user                 : arg3,
            shares_to_recall     : v5,
            expected_llv_pool_id : *0x1::option::borrow<0x2::object::ID>(&v2),
        };
        (v6, v5)
    }

    public fun begin_route_to_llv<T0, T1>(arg0: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::CLMCap, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: u64, arg3: address, arg4: 0x2::coin::Coin<T1>, arg5: &0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::pyth_oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : (RouteToLLVReceipt<T1>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::assert_clm_cap_market(arg0, arg2);
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::supply_collateral<T1>(arg1, arg2, arg3, arg4, arg8);
        let v2 = v1;
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
        let (v3, v4) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_market_llv_config(arg1, arg2);
        let v5 = v4;
        if (0x1::option::is_none<0x2::object::ID>(&v5) || v3 == 0) {
            let v6 = RouteToLLVReceipt<T1>{
                market_id            : arg2,
                user                 : arg3,
                amount               : 0,
                expected_llv_pool_id : 0x2::object::id_from_address(@0x0),
            };
            return (v6, 0x1::option::none<0x2::coin::Coin<T1>>())
        };
        if (0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_user_ltv_with_llv<T0, T1>(arg1, arg2, arg3, arg5, arg6, arg7) >= (v3 as u128)) {
            let v7 = RouteToLLVReceipt<T1>{
                market_id            : arg2,
                user                 : arg3,
                amount               : 0,
                expected_llv_pool_id : *0x1::option::borrow<0x2::object::ID>(&v5),
            };
            return (v7, 0x1::option::none<0x2::coin::Coin<T1>>())
        };
        assert!(v0 <= 18446744073709551615, 106);
        let v8 = (v0 as u64);
        let v9 = RouteToLLVReceipt<T1>{
            market_id            : arg2,
            user                 : arg3,
            amount               : v8,
            expected_llv_pool_id : *0x1::option::borrow<0x2::object::ID>(&v5),
        };
        (v9, 0x1::option::some<0x2::coin::Coin<T1>>(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::extract_from_collateral_reserve<T1>(arg1, arg2, v8, arg8)))
    }

    public fun calculate_assets_for_shares(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg2 == 0) {
            return 0
        };
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::math::mul_div_down(arg0, arg1, arg2)
    }

    public fun calculate_shares_for_amount(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0 || arg2 == 0) {
            return (arg0 as u128)
        };
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::math::mul_div_up((arg0 as u128), arg2, arg1)
    }

    public fun can_recall<T0, T1>(arg0: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::CLMCap, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: u64, arg3: address, arg4: address, arg5: &vector<address>, arg6: &0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::pyth_oracle::Oracle, arg7: &0x2::clock::Clock, arg8: u128) : bool {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::assert_clm_cap_market(arg0, arg2);
        if (0x1::vector::contains<address>(arg5, &arg4)) {
            return true
        };
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_market_llv_config(arg1, arg2);
        let v2 = v1;
        if (0x1::option::is_none<0x2::object::ID>(&v2) || v0 == 0) {
            return false
        };
        if (0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_position_llv_shares(arg1, arg2, arg3) == 0) {
            return false
        };
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_user_ltv_with_llv<T0, T1>(arg1, arg2, arg3, arg6, arg7, arg8) >= (v0 as u128)
    }

    public fun finish_recall_from_llv<T0, T1>(arg0: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::CLMCap, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: RecallFromLLVReceipt<T1>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: address, arg6: &0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::pyth_oracle::Oracle, arg7: &0x2::clock::Clock, arg8: u128) {
        let RecallFromLLVReceipt {
            market_id            : v0,
            user                 : v1,
            shares_to_recall     : v2,
            expected_llv_pool_id : v3,
        } = arg2;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::assert_clm_cap_market(arg0, v0);
        assert_recall_shares_match(v2, arg4);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::deposit_to_collateral_reserve<T1>(arg1, v0, arg3);
        if (arg4 > 0) {
            0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::update_position_llv_shares(arg1, v0, v1, arg4, false, v3);
            let v4 = CollateralRecalledFromLLV{
                market_id      : v0,
                llv_pool_id    : v3,
                user           : v1,
                caller         : arg5,
                shares_burned  : arg4,
                asset_received : 0x2::coin::value<T1>(&arg3),
                user_ltv       : 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_user_ltv_with_llv<T0, T1>(arg1, v0, v1, arg6, arg7, arg8),
                timestamp_ms   : 0x2::clock::timestamp_ms(arg7),
            };
            0x2::event::emit<CollateralRecalledFromLLV>(v4);
        };
    }

    public fun finish_route_to_llv<T0>(arg0: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::CLMCap, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: RouteToLLVReceipt<T0>, arg3: u128, arg4: &0x2::clock::Clock) {
        let RouteToLLVReceipt {
            market_id            : v0,
            user                 : v1,
            amount               : v2,
            expected_llv_pool_id : v3,
        } = arg2;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::assert_clm_cap_market(arg0, v0);
        if (v2 == 0) {
            return
        };
        assert!(arg3 > 0, 107);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::update_position_llv_shares(arg1, v0, v1, arg3, true, v3);
        let v4 = CollateralRoutedToLLV{
            market_id         : v0,
            llv_pool_id       : v3,
            user              : v1,
            asset_amount      : v2,
            llv_shares_minted : arg3,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CollateralRoutedToLLV>(v4);
    }

    public fun recall_receipt_llv_pool_id<T0>(arg0: &RecallFromLLVReceipt<T0>) : 0x2::object::ID {
        arg0.expected_llv_pool_id
    }

    public fun recall_receipt_market_id<T0>(arg0: &RecallFromLLVReceipt<T0>) : u64 {
        arg0.market_id
    }

    public fun recall_receipt_shares<T0>(arg0: &RecallFromLLVReceipt<T0>) : u128 {
        arg0.shares_to_recall
    }

    public fun recall_receipt_user<T0>(arg0: &RecallFromLLVReceipt<T0>) : address {
        arg0.user
    }

    public fun route_receipt_amount<T0>(arg0: &RouteToLLVReceipt<T0>) : u64 {
        arg0.amount
    }

    public fun route_receipt_llv_pool_id<T0>(arg0: &RouteToLLVReceipt<T0>) : 0x2::object::ID {
        arg0.expected_llv_pool_id
    }

    public fun route_receipt_market_id<T0>(arg0: &RouteToLLVReceipt<T0>) : u64 {
        arg0.market_id
    }

    public fun route_receipt_user<T0>(arg0: &RouteToLLVReceipt<T0>) : address {
        arg0.user
    }

    public fun should_route_to_llv<T0, T1>(arg0: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::CLMCap, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: u64, arg3: address, arg4: &0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::pyth_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u128) : bool {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::assert_clm_cap_market(arg0, arg2);
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_market_llv_config(arg1, arg2);
        let v2 = v1;
        if (0x1::option::is_none<0x2::object::ID>(&v2) || v0 == 0) {
            return false
        };
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::get_user_ltv_with_llv<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6) < (v0 as u128)
    }

    // decompiled from Move bytecode v6
}

