module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::compact_sui_usdc {
    struct QuoteCursor has key {
        id: 0x2::object::UID,
        publisher: address,
        operator: address,
        has_position: bool,
        last_checkpoint: u64,
        last_ordinal: u64,
        last_route_key: u8,
        last_outcome: u8,
        last_reason: u8,
        last_fingerprint_hi: u128,
        last_fingerprint_lo: u128,
    }

    struct QuoteAdminCap has store, key {
        id: 0x2::object::UID,
        cursor: 0x2::object::ID,
    }

    struct QuotePacket has copy, drop {
        cursor: 0x2::object::ID,
        checkpoint: u64,
        ordinal: u64,
        route_key: u8,
        amount: u64,
        min_leg_one_output: u64,
        min_repayment_output: u64,
        min_repayment_surplus: u64,
        min_profit: u64,
        deadline_ms: u64,
        loan_pool: 0x2::object::ID,
        venue_one: 0x2::object::ID,
        venue_two: 0x2::object::ID,
        guard_one: 0x2::object::ID,
        guard_two: 0x2::object::ID,
        clock: 0x2::object::ID,
        state_fingerprint_hi: u128,
        state_fingerprint_lo: u128,
    }

    struct CursorStatusV1 has copy, drop {
        cursor: 0x2::object::ID,
        publisher: address,
        operator: address,
        has_position: bool,
        last_checkpoint: u64,
        last_ordinal: u64,
        last_route_key: u8,
        last_outcome: u8,
        last_reason: u8,
        last_fingerprint_hi: u128,
        last_fingerprint_lo: u128,
    }

    struct DecisionV1 has copy, drop {
        operator: address,
        cursor: 0x2::object::ID,
        checkpoint: u64,
        ordinal: u64,
        route_key: u8,
        outcome: u8,
        reason: u8,
        hot_event_version: u8,
        hot_route_family: u8,
        quote_loan: bool,
        amount: u64,
        loan_pool: 0x2::object::ID,
        venue_one: 0x2::object::ID,
        venue_two: 0x2::object::ID,
        deadline_ms: u64,
        state_fingerprint_hi: u128,
        state_fingerprint_lo: u128,
        exact_debt_known: bool,
        exact_debt: u64,
        exact_profit_known: bool,
        exact_profit: u64,
    }

    struct OperatorUpdated has copy, drop {
        cursor: 0x2::object::ID,
        publisher: address,
        previous_operator: address,
        new_operator: address,
    }

    fun advance_position(arg0: &mut bool, arg1: &mut u64, arg2: &mut u64, arg3: u64, arg4: u64) {
        assert!(identity_is_newer(*arg0, *arg1, *arg2, arg3, arg4), 201);
        *arg0 = true;
        *arg1 = arg3;
        *arg2 = arg4;
    }

    fun begin_packet(arg0: &mut QuoteCursor, arg1: &QuotePacket, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : bool {
        validate_binding(arg0.operator, 0x2::tx_context::sender(arg9), 0x2::object::id<QuoteCursor>(arg0), arg1.cursor);
        validate_route_and_objects(arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::object::id<0x2::clock::Clock>(arg8));
        let (v0, v1, v2) = route_metadata_internal(arg2);
        let v3 = 0x2::clock::timestamp_ms(arg8);
        let v4 = &mut arg0.has_position;
        let v5 = &mut arg0.last_checkpoint;
        let v6 = &mut arg0.last_ordinal;
        let v7 = pre_borrow_reason(v4, v5, v6, v3, arg1.checkpoint, arg1.ordinal, arg1.deadline_ms);
        if (v7 != 0) {
            if (v7 == 1) {
                update_cursor_decision(arg0, arg1, 0, v7);
            };
            emit_decision(arg0, arg1, 0, v7, v0, v1, v2, true);
            false
        } else {
            validate_economics(v3, arg1);
            true
        }
    }

    public fun bluefin_cetus_base_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 13, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_bluefin_cetus_base_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun bluefin_cetus_quote_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 14, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_bluefin_cetus_quote_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun bluefin_momentum_base_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 21, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_bluefin_momentum_base_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun bluefin_momentum_quote_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 22, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_bluefin_momentum_quote_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun bluefin_turbos_base_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 19, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_bluefin_turbos_base_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun bluefin_turbos_quote_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 20, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_bluefin_turbos_quote_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun cetus_bluefin_base_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 15, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_cetus_bluefin_base_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun cetus_bluefin_quote_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 16, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_cetus_bluefin_quote_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun cetus_momentum_base_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 11, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_cetus_momentum_base_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun cetus_momentum_quote_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 12, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_cetus_momentum_quote_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun cetus_turbos_base_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 3, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_cetus_turbos_base_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun cetus_turbos_quote_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 4, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_cetus_turbos_quote_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun cursor_position(arg0: &QuoteCursor) : (bool, u64, u64) {
        (arg0.has_position, arg0.last_checkpoint, arg0.last_ordinal)
    }

    public fun cursor_status_v1(arg0: &QuoteCursor) : CursorStatusV1 {
        CursorStatusV1{
            cursor              : 0x2::object::id<QuoteCursor>(arg0),
            publisher           : arg0.publisher,
            operator            : arg0.operator,
            has_position        : arg0.has_position,
            last_checkpoint     : arg0.last_checkpoint,
            last_ordinal        : arg0.last_ordinal,
            last_route_key      : arg0.last_route_key,
            last_outcome        : arg0.last_outcome,
            last_reason         : arg0.last_reason,
            last_fingerprint_hi : arg0.last_fingerprint_hi,
            last_fingerprint_lo : arg0.last_fingerprint_lo,
        }
    }

    public fun decision_codes() : (u8, u8, u8, u8, u8) {
        (0, 1, 1, 2, 3)
    }

    fun emit_decision(arg0: &QuoteCursor, arg1: &QuotePacket, arg2: u8, arg3: u8, arg4: u8, arg5: bool, arg6: u8, arg7: bool) {
        let v0 = DecisionV1{
            operator             : arg0.operator,
            cursor               : 0x2::object::id<QuoteCursor>(arg0),
            checkpoint           : arg1.checkpoint,
            ordinal              : arg1.ordinal,
            route_key            : arg1.route_key,
            outcome              : arg2,
            reason               : arg3,
            hot_event_version    : arg6,
            hot_route_family     : arg4,
            quote_loan           : arg5,
            amount               : arg1.amount,
            loan_pool            : arg1.loan_pool,
            venue_one            : arg1.venue_one,
            venue_two            : arg1.venue_two,
            deadline_ms          : arg1.deadline_ms,
            state_fingerprint_hi : arg1.state_fingerprint_hi,
            state_fingerprint_lo : arg1.state_fingerprint_lo,
            exact_debt_known     : arg7,
            exact_debt           : 0,
            exact_profit_known   : arg7,
            exact_profit         : 0,
        };
        0x2::event::emit<DecisionV1>(v0);
    }

    fun finish_routed(arg0: &mut QuoteCursor, arg1: &QuotePacket) {
        let v0 = &mut arg0.has_position;
        let v1 = &mut arg0.last_checkpoint;
        let v2 = &mut arg0.last_ordinal;
        advance_position(v0, v1, v2, arg1.checkpoint, arg1.ordinal);
        update_cursor_decision(arg0, arg1, 1, 3);
        let (v3, v4, v5) = route_metadata_internal(arg1.route_key);
        emit_decision(arg0, arg1, 1, 3, v3, v4, v5, false);
    }

    fun identity_is_newer(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (!arg0) {
            true
        } else if (arg3 > arg1) {
            true
        } else {
            arg3 == arg1 && arg4 > arg2
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = QuoteCursor{
            id                  : 0x2::object::new(arg0),
            publisher           : v0,
            operator            : v0,
            has_position        : false,
            last_checkpoint     : 0,
            last_ordinal        : 0,
            last_route_key      : 0,
            last_outcome        : 0,
            last_reason         : 0,
            last_fingerprint_hi : 0,
            last_fingerprint_lo : 0,
        };
        let v2 = QuoteAdminCap{
            id     : 0x2::object::new(arg0),
            cursor : 0x2::object::id<QuoteCursor>(&v1),
        };
        0x2::transfer::transfer<QuoteAdminCap>(v2, v0);
        0x2::transfer::share_object<QuoteCursor>(v1);
    }

    public fun momentum_bluefin_base_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 23, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_momentum_bluefin_base_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun momentum_bluefin_quote_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 24, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_momentum_bluefin_quote_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun momentum_cetus_base_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 9, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_momentum_cetus_base_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun momentum_cetus_quote_v1<T0>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 10, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_momentum_cetus_quote_v2<T0, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun momentum_turbos_base_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 7, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_momentum_turbos_base_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun momentum_turbos_quote_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 8, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_momentum_turbos_quote_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun new_packet_v1(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::object::ID, arg11: 0x2::object::ID, arg12: 0x2::object::ID, arg13: 0x2::object::ID, arg14: 0x2::object::ID, arg15: 0x2::object::ID, arg16: u128, arg17: u128) : QuotePacket {
        QuotePacket{
            cursor                : arg0,
            checkpoint            : arg1,
            ordinal               : arg2,
            route_key             : arg3,
            amount                : arg4,
            min_leg_one_output    : arg5,
            min_repayment_output  : arg6,
            min_repayment_surplus : arg7,
            min_profit            : arg8,
            deadline_ms           : arg9,
            loan_pool             : arg10,
            venue_one             : arg11,
            venue_two             : arg12,
            guard_one             : arg13,
            guard_two             : arg14,
            clock                 : arg15,
            state_fingerprint_hi  : arg16,
            state_fingerprint_lo  : arg17,
        }
    }

    public fun packet_fingerprint(arg0: &QuotePacket) : (u128, u128) {
        (arg0.state_fingerprint_hi, arg0.state_fingerprint_lo)
    }

    public fun packet_identity(arg0: &QuotePacket) : (0x2::object::ID, u64, u64, u8) {
        (arg0.cursor, arg0.checkpoint, arg0.ordinal, arg0.route_key)
    }

    public fun packet_limits(arg0: &QuotePacket) : (u64, u64, u64, u64, u64, u64) {
        (arg0.amount, arg0.min_leg_one_output, arg0.min_repayment_output, arg0.min_repayment_surplus, arg0.min_profit, arg0.deadline_ms)
    }

    public fun packet_objects(arg0: &QuotePacket) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        (arg0.loan_pool, arg0.venue_one, arg0.venue_two, arg0.guard_one, arg0.guard_two, arg0.clock)
    }

    fun pre_borrow_reason(arg0: &mut bool, arg1: &mut u64, arg2: &mut u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u8 {
        if (!identity_is_newer(*arg0, *arg1, *arg2, arg4, arg5)) {
            2
        } else if (arg3 > arg6) {
            advance_position(arg0, arg1, arg2, arg4, arg5);
            1
        } else {
            0
        }
    }

    public fun route_metadata(arg0: u8) : (u8, bool, u8) {
        route_metadata_internal(arg0)
    }

    fun route_metadata_internal(arg0: u8) : (u8, bool, u8) {
        if (arg0 == 1) {
            (9, false, 2)
        } else if (arg0 == 2) {
            (9, true, 2)
        } else if (arg0 == 3) {
            (21, false, 3)
        } else if (arg0 == 4) {
            (21, true, 3)
        } else if (arg0 == 5) {
            (15, false, 3)
        } else if (arg0 == 6) {
            (15, true, 3)
        } else if (arg0 == 7) {
            (16, false, 3)
        } else if (arg0 == 8) {
            (16, true, 3)
        } else if (arg0 == 9) {
            (22, false, 3)
        } else if (arg0 == 10) {
            (22, true, 3)
        } else if (arg0 == 11) {
            (23, false, 3)
        } else if (arg0 == 12) {
            (23, true, 3)
        } else if (arg0 == 13) {
            (11, false, 3)
        } else if (arg0 == 14) {
            (11, true, 3)
        } else if (arg0 == 15) {
            (12, false, 3)
        } else if (arg0 == 16) {
            (12, true, 3)
        } else if (arg0 == 17) {
            (13, false, 3)
        } else if (arg0 == 18) {
            (13, true, 3)
        } else if (arg0 == 19) {
            (14, false, 3)
        } else if (arg0 == 20) {
            (14, true, 3)
        } else if (arg0 == 21) {
            (17, false, 3)
        } else if (arg0 == 22) {
            (17, true, 3)
        } else if (arg0 == 23) {
            (18, false, 3)
        } else {
            assert!(arg0 == 24, 202);
            (18, true, 3)
        }
    }

    public fun set_operator(arg0: &mut QuoteCursor, arg1: &QuoteAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<QuoteCursor>(arg0);
        arg0.operator = validated_operator_update(arg0.publisher, 0x2::tx_context::sender(arg3), v0, arg1.cursor, arg2);
        let v1 = OperatorUpdated{
            cursor            : v0,
            publisher         : arg0.publisher,
            previous_operator : arg0.operator,
            new_operator      : arg2,
        };
        0x2::event::emit<OperatorUpdated>(v1);
    }

    public fun turbos_bluefin_base_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 17, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg5), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_turbos_bluefin_base_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun turbos_bluefin_quote_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 18, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg5), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_turbos_bluefin_quote_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun turbos_cetus_base_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_turbos_cetus_base_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun turbos_cetus_quote_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_turbos_cetus_quote_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun turbos_momentum_base_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 5, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg5), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_turbos_momentum_base_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    public fun turbos_momentum_quote_v1<T0, T1>(arg0: &mut QuoteCursor, arg1: QuotePacket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_packet(arg0, &arg1, 6, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(arg5), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg6), arg7, arg8);
        if (!v0) {
            return
        };
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb::deepbook_sui_turbos_momentum_quote_v2<T0, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg1.amount, arg1.min_repayment_surplus, arg1.min_leg_one_output, arg1.min_repayment_output, arg1.min_profit, arg1.deadline_ms, arg8);
        finish_routed(arg0, &arg1);
    }

    fun update_cursor_decision(arg0: &mut QuoteCursor, arg1: &QuotePacket, arg2: u8, arg3: u8) {
        arg0.last_route_key = arg1.route_key;
        arg0.last_outcome = arg2;
        arg0.last_reason = arg3;
        arg0.last_fingerprint_hi = arg1.state_fingerprint_hi;
        arg0.last_fingerprint_lo = arg1.state_fingerprint_lo;
    }

    fun validate_binding(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(arg1 == arg0, 200);
        assert!(arg3 == arg2, 201);
    }

    fun validate_economics(arg0: u64, arg1: &QuotePacket) {
        assert!(arg1.min_leg_one_output > 0, 204);
        assert!(arg1.min_repayment_output > 0, 204);
        assert!(arg1.min_profit > 0, 205);
        assert!(arg1.state_fingerprint_hi != 0 || arg1.state_fingerprint_lo != 0, 206);
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::request_guard::validate_request_at(arg0, arg1.amount, arg1.min_repayment_surplus, arg1.min_repayment_output, arg1.deadline_ms);
    }

    fun validate_route_and_objects(arg0: &QuotePacket, arg1: u8, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID) {
        assert!(arg0.route_key == arg1, 202);
        let v0 = if (arg0.loan_pool == arg2) {
            if (arg0.venue_one == arg3) {
                if (arg0.venue_two == arg4) {
                    if (arg0.guard_one == arg5) {
                        if (arg0.guard_two == arg6) {
                            arg0.clock == arg7
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
            }
        } else {
            false
        };
        assert!(v0, 203);
    }

    fun validated_operator_update(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address) : address {
        assert!(arg1 == arg0, 207);
        assert!(arg3 == arg2, 208);
        assert!(arg4 != @0x0, 209);
        arg4
    }

    // decompiled from Move bytecode v7
}

