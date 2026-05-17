module 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::actions {
    fun assert_adapter<T0>(arg0: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg1: &0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_id<T0>(arg0) == 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::id(arg1), 65);
        0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::assert_asset<T0>(arg1);
    }

    fun assert_min_sui_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 66);
    }

    fun assert_treasury<T0>(arg0: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<T0>) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::treasury_id<T0>(arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<T0>(arg1), 176);
    }

    public fun claim_yield<T0>(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<T0>, arg4: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg5: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_adapter<T0>(arg2, arg4);
        assert_treasury<T0>(arg2, arg3);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(arg1);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(arg0) == v0, 67);
        let v1 = refresh_and_observe(arg4, arg6, arg7, arg8);
        let v2 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        let (v3, v4, v5, v6) = if (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::is_pt_consumed<T0>(arg1)) {
            let v7 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::drain_yt_after_pt_closed<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg1, arg2, &v2);
            let v8 = 0x2::balance::value<T0>(&v7);
            (v7, v8, v8, false)
        } else {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::yield_out_into_balance<T0>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::realize_yield_capped<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg1, arg2, &v2, v1, arg8))
        };
        let v9 = v3;
        let v10 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::realize_internal<T0>(arg4, v9, arg5, arg6, arg7, arg8, arg10);
        let (v11, v12) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::collect_fee<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v2, v10, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::claim_fee_bps<T0>(arg1));
        let v13 = v11;
        if (v12 > 0) {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_fee_collected_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg2, &v2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<T0>(arg3), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::op_claim(), v12, 0x2::balance::value<0x2::sui::SUI>(&v10));
        };
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v13);
        assert_min_sui_out(v14, arg9);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::set_yield_debt<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg2, &v2, v1);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_yield_claimed_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg2, &v2, v0, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::id(arg0), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::yield_debt(arg0), v1, 0x2::balance::value<T0>(&v9), v14, v5, v4, v6, v12);
        0x2::coin::from_balance<0x2::sui::SUI>(v13, arg10)
    }

    public fun collect_yield_begin<T0, T1>(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg2: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<T0> {
        assert_adapter<T0>(arg1, arg2);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_yt_vault<T0>(arg1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<T0, T1>(arg0));
        let v0 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::begin_collect_yield<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg1, &v0, arg5, refresh_and_observe(arg2, arg3, arg4, arg5), arg6)
    }

    public fun collect_yield_cancel<T0, T1>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<T0>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::cancel_collect_yield<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg1, &v0, arg2);
    }

    public fun collect_yield_finalize<T0, T1>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<T0>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<T0>, arg4: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg5: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_adapter<T0>(arg2, arg4);
        assert_treasury<T0>(arg2, arg3);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_yt_vault<T0>(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<T0, T1>(arg1));
        let v0 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::refresh_yield_index_for_market<T0>(arg4, arg2, arg6, arg7, arg8);
        if (0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::is_paused(arg4)) {
            let v1 = if (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::receipt_next_index<T0>(&arg0) == 0) {
                if (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::receipt_yt_count<T0>(&arg0) == 0) {
                    0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::active_collect_sy_value<T0, T1>(arg1) == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::cancel_collect_due_to_adapter_pause<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg1, &v0, arg8);
            } else {
                0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<T0>>(arg0, 0x2::tx_context::sender(arg10));
            };
            return
        };
        let (v2, v3) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::take_collect_sy<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg1, &v0);
        let v4 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::realize_internal<T0>(arg4, v3, arg5, arg6, arg7, arg8, arg10);
        let (v5, v6) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::collect_fee<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v0, v4, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::claim_fee_bps<T0>(arg2));
        let v7 = v5;
        if (v6 > 0) {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_fee_collected_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg2, &v0, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<T0>(arg3), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::op_vault_claim(), v6, 0x2::balance::value<0x2::sui::SUI>(&v4));
        };
        assert_min_sui_out(0x2::balance::value<0x2::sui::SUI>(&v7), arg9);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::finalize_collect_yield<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(v2, v7, v6, arg1, &v0);
    }

    public fun collect_yield_step<T0, T1>(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<T0>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        let v0 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_yt_vault<T0>(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<T0, T1>(arg1));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::collect_step<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg1, arg2, arg3, arg4, &v0, arg5);
    }

    public fun combine<T0>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, arg1: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg4: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<T0>, arg5: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg6: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_adapter<T0>(arg3, arg5);
        assert_treasury<T0>(arg3, arg4);
        let v0 = refresh_and_observe(arg5, arg7, arg8, arg9);
        let v1 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        let (v2, v3) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::combine::combine<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg2, arg3, arg0, arg1, &v1, v0, arg9);
        let v4 = v2;
        let v5 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::realize_internal<T0>(arg5, v3, arg6, arg7, arg8, arg9, arg11);
        let (v6, v7) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::collect_fee<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg4, &v1, v5, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::combine_fee_bps<T0>(&arg2));
        let v8 = v6;
        if (v7 > 0) {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_fee_collected_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<T0>(arg4), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::op_combine(), v7, 0x2::balance::value<0x2::sui::SUI>(&v5));
        };
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v8);
        assert_min_sui_out(v9, arg10);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_combine_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(&arg2), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::id(&arg0), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::id(&arg1), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::notional(&arg0), v9, 0x2::balance::value<T0>(&v4), v7);
        (0x2::coin::from_balance<T0>(v4, arg11), 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg11))
    }

    public fun deposit_yt<T0, T1>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg4: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<T0>, arg5: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg6: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_adapter<T0>(arg3, arg5);
        assert_treasury<T0>(arg3, arg4);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_yt_vault<T0>(arg3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<T0, T1>(arg2));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_entry_open<T0>(arg3, 0x2::clock::timestamp_ms(arg9));
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(&arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(arg1), 67);
        let v0 = refresh_and_observe(arg5, arg7, arg8, arg9);
        let v1 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        let (v2, _, _, _) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::yield_out_into_balance<T0>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::realize_yield_capped<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg1, arg3, &v1, v0, arg9));
        let v6 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::realize_internal<T0>(arg5, v2, arg6, arg7, arg8, arg9, arg11);
        let (v7, v8) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::collect_fee<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg4, &v1, v6, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::claim_fee_bps<T0>(arg1));
        let v9 = v7;
        if (v8 > 0) {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_fee_collected_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<T0>(arg4), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::op_claim(), v8, 0x2::balance::value<0x2::sui::SUI>(&v6));
        };
        let v10 = 0x2::balance::value<0x2::sui::SUI>(&v9);
        assert_min_sui_out(v10, arg10);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::set_yield_debt<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(&mut arg0, arg3, &v1, v0);
        (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::deposit_yt_primitive<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg1, arg2, arg3, v10, v8, &v1, arg9, arg11), 0x2::coin::from_balance<0x2::sui::SUI>(v9, arg11))
    }

    public fun destroy_spent_yt<T0>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg2: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::market_core_id<T0>(arg1) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::id<T0>(arg2), 68);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::market_core_id(&arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::id<T0>(arg2), 68);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(&arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(arg1), 67);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::is_yt_consumed<T0>(arg1), 69);
        let v0 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::destroy<0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, &v0);
    }

    public fun redeem_pt_direct<T0>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<T0>, arg4: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg5: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_adapter<T0>(arg2, arg4);
        assert_treasury<T0>(arg2, arg3);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(arg1);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::escrow_id(&arg0) == v0, 67);
        let v1 = refresh_and_observe(arg4, arg6, arg7, arg8);
        let v2 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        let v3 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::realize_internal<T0>(arg4, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::close_pt_side<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg1, arg2, &v2, arg8, v1), arg5, arg6, arg7, arg8, arg10);
        let (v4, v5) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::collect_fee<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v2, v3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::redeem_fee_bps<T0>(arg1));
        let v6 = v4;
        if (v5 > 0) {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_fee_collected_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg2, &v2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<T0>(arg3), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::op_redeem(), v5, 0x2::balance::value<0x2::sui::SUI>(&v3));
        };
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        assert_min_sui_out(v7, arg9);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::destroy<0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, &v2);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_pt_redeemed_direct_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg2, &v2, v0, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::id(&arg0), v7, v5);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg10)
    }

    public fun redeem_pt_vault_step<T0, T1>(arg0: &mut 0x2::coin::Coin<T1>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::PTVault<T0, T1>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg4: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<T0>, arg5: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg6: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_adapter<T0>(arg3, arg5);
        assert_treasury<T0>(arg3, arg4);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_pt_vault<T0>(arg3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::id<T0, T1>(arg1));
        let v0 = refresh_and_observe(arg5, arg7, arg8, arg9);
        let v1 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::redeem_step<T0, T1, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, arg1, arg3, arg2, &v1, arg9, v0, arg11);
        let v3 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::realize_internal<T0>(arg5, v2, arg6, arg7, arg8, arg9, arg11);
        let (v4, v5) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::collect_fee<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg4, &v1, v3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::redeem_fee_bps<T0>(arg2));
        let v6 = v4;
        if (v5 > 0) {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_fee_collected_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<T0>(arg4), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::op_pt_vault_redeem(), v5, 0x2::balance::value<0x2::sui::SUI>(&v3));
        };
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        assert_min_sui_out(v7, arg10);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_pt_redeemed_from_vault_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg3, &v1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::id<T0, T1>(arg1), 0x2::coin::value<T1>(arg0) - 0x2::coin::value<T1>(arg0), 0x2::balance::value<T0>(&v2), 1, v7, v5);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg11)
    }

    fun refresh_and_observe(arg0: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) : u128 {
        0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::refresh_yield_index(arg0, arg1, arg2, arg3);
        0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::observe_yield_index(arg0, arg3)
    }

    public fun split<T0>(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg1: &mut 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::ScallopSuiAdapter, arg2: 0x2::coin::Coin<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject) {
        assert_adapter<T0>(arg0, arg1);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_entry_open<T0>(arg0, 0x2::clock::timestamp_ms(arg5));
        let v0 = refresh_and_observe(arg1, arg3, arg4, arg5);
        let v1 = 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::mint_auth();
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::new<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, &v1, 0x2::coin::into_balance<T0>(arg2), v0, arg6);
        let v3 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(&v2);
        let v4 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::notional<T0>(&v2);
        let v5 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::new<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, &v1, v3, v4, v0, arg6);
        let v6 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::new<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, &v1, v3, v4, v0, arg6);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_split_for_adapter<T0, 0x11fc4b08ff11c4a5dbd3635d534cde807d5394b846c8b2ef7cb6ed92271edc5::scallop_sui_adapter::SCALLOP_AUTH>(arg0, &v1, v3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::id(&v5), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::id(&v6), v4, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::max_yield_extractable_sy<T0>(&v2), v0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::share<T0>(v2);
        (v5, v6)
    }

    // decompiled from Move bytecode v7
}

