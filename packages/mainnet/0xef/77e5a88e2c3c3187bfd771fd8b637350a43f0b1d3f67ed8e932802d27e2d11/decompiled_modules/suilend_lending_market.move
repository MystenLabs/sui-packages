module 0xef77e5a88e2c3c3187bfd771fd8b637350a43f0b1d3f67ed8e932802d27e2d11::suilend_lending_market {
    struct ReserveRateLimiterExemptEvent<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        exempt: bool,
    }

    struct OperationHoldEvent<phantom T0> has copy, drop {
        lending_market_id: address,
        operation: u8,
        until_ms: u64,
        generation: u64,
        reason: u8,
        asset: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct WithdrawHoldExemptEvent<phantom T0> has copy, drop {
        lending_market_id: address,
        obligation_id: address,
        exempt: bool,
        generation: u64,
    }

    struct ProtocolLiquidationFeeLoweredEvent<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        previous_protocol_liquidation_fee_bps: u64,
        protocol_liquidation_fee_bps: u64,
    }

    struct AutoHoldDurationEvent<phantom T0> has copy, drop {
        lending_market_id: address,
        duration_ms: u64,
    }

    struct ReserveHoldOverrideEvent<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        borrow_generation: u64,
        withdraw_generation: u64,
    }

    struct StablePauseTrippedEvent<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        coin_type: 0x1::type_name::TypeName,
        spot: u256,
        anchor_bps: u64,
        threshold_bps: u64,
        gap_bps: u64,
        until_ms: u64,
    }

    public fun emit_auto_hold_duration<T0: drop>(arg0: T0, arg1: address, arg2: u64) {
        let v0 = AutoHoldDurationEvent<T0>{
            lending_market_id : arg1,
            duration_ms       : arg2,
        };
        0x2::event::emit<AutoHoldDurationEvent<T0>>(v0);
    }

    public fun emit_operation_hold<T0: drop>(arg0: T0, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u8, arg6: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = OperationHoldEvent<T0>{
            lending_market_id : arg1,
            operation         : arg2,
            until_ms          : arg3,
            generation        : arg4,
            reason            : arg5,
            asset             : arg6,
        };
        0x2::event::emit<OperationHoldEvent<T0>>(v0);
    }

    public fun emit_protocol_liquidation_fee_lowered<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = ProtocolLiquidationFeeLoweredEvent<T0>{
            lending_market_id                     : arg1,
            reserve_id                            : arg2,
            previous_protocol_liquidation_fee_bps : arg3,
            protocol_liquidation_fee_bps          : arg4,
        };
        0x2::event::emit<ProtocolLiquidationFeeLoweredEvent<T0>>(v0);
    }

    public fun emit_reserve_hold_override<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = ReserveHoldOverrideEvent<T0>{
            lending_market_id   : arg1,
            reserve_id          : arg2,
            borrow_generation   : arg3,
            withdraw_generation : arg4,
        };
        0x2::event::emit<ReserveHoldOverrideEvent<T0>>(v0);
    }

    public fun emit_reserve_rate_limiter_exempt<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: bool) {
        let v0 = ReserveRateLimiterExemptEvent<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            exempt            : arg3,
        };
        0x2::event::emit<ReserveRateLimiterExemptEvent<T0>>(v0);
    }

    public fun emit_stable_pause_tripped<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: 0x1::type_name::TypeName, arg4: u256, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = StablePauseTrippedEvent<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            coin_type         : arg3,
            spot              : arg4,
            anchor_bps        : arg5,
            threshold_bps     : arg6,
            gap_bps           : arg7,
            until_ms          : arg8,
        };
        0x2::event::emit<StablePauseTrippedEvent<T0>>(v0);
    }

    public fun emit_withdraw_hold_exempt<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: bool, arg4: u64) {
        let v0 = WithdrawHoldExemptEvent<T0>{
            lending_market_id : arg1,
            obligation_id     : arg2,
            exempt            : arg3,
            generation        : arg4,
        };
        0x2::event::emit<WithdrawHoldExemptEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

