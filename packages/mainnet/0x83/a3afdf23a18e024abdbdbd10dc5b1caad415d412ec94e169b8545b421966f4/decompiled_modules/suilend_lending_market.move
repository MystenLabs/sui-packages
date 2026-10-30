module 0x83a3afdf23a18e024abdbdbd10dc5b1caad415d412ec94e169b8545b421966f4::suilend_lending_market {
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

    public fun emit_auto_hold_duration<T0: drop>(arg0: T0, arg1: address, arg2: u64) {
        let v0 = AutoHoldDurationEvent<T0>{
            lending_market_id : arg1,
            duration_ms       : arg2,
        };
        0x2::event::emit<AutoHoldDurationEvent<T0>>(v0);
    }

    public fun emit_operation_hold<T0: drop>(arg0: T0, arg1: address, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = OperationHoldEvent<T0>{
            lending_market_id : arg1,
            operation         : arg2,
            until_ms          : arg3,
            generation        : arg4,
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

