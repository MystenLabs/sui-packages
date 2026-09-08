module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::vault_events {
    struct ExpiryCashReceived has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        expiry_market_id: 0x2::object::ID,
        settlement_price: u64,
        amount: u64,
    }

    struct ExpiryCashRebalanced has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        expiry_market_id: 0x2::object::ID,
        amount: u64,
        to_expiry: bool,
        target_cash: u64,
        protocol_profit_realized: u64,
    }

    struct ExpiryProfitMaterialized has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        expiry_market_id: 0x2::object::ID,
        lp_profit: u64,
        protocol_profit: u64,
        protocol_reserve_balance_after: u64,
        profit_basis_after: u64,
        pending_protocol_profit_after: u64,
    }

    struct SupplyRequested has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        index: u64,
        amount: u64,
        min_plp_out: u64,
        requests_pending_after: u64,
    }

    struct WithdrawRequested has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        index: u64,
        amount: u64,
        min_usdc_out: u64,
        requests_pending_after: u64,
    }

    struct RequestCancelled has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        index: u64,
        amount: u64,
        is_supply: bool,
        reason: u8,
        requests_pending_after: u64,
    }

    struct RequestLimitMissed has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        index: u64,
        amount: u64,
        is_supply: bool,
        quoted_output: u64,
        min_output: u64,
        missed_flushes: u64,
        max_misses: u64,
    }

    struct SupplyFilled has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        index: u64,
        usdc_amount: u64,
        shares_minted: u64,
        fee_usdc: u64,
        usdc_remaining: u64,
        requests_pending_after: u64,
    }

    struct WithdrawFilled has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        index: u64,
        shares_burned: u64,
        usdc_amount: u64,
        fee_usdc: u64,
        shares_remaining: u64,
        requests_pending_after: u64,
    }

    struct FlushExecuted has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        epoch: u64,
        pool_value: u64,
        total_supply: u64,
        supply_fee_rate: u64,
        withdraw_fee_rate: u64,
        active_market_nav: u64,
        market_count: u64,
        idle_balance_before: u64,
        frozen_idle_balance: u64,
        supplies_filled: u64,
        withdrawals_filled: u64,
        requests_processed: u64,
        idle_balance_after: u64,
        total_supply_after: u64,
        supply_request_cutoff: u64,
        withdraw_request_cutoff: u64,
        snapshot_timestamp_ms: u64,
    }

    struct FlushRestarted has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        expected_market_count: u64,
        valued_market_count: u64,
    }

    struct CapitalLocked has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct FeeIncentivesSponsored has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        reserve_after: u64,
    }

    struct FeeIncentivesAllocated has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        expiry_market_id: 0x2::object::ID,
        amount: u64,
        pool_reserve_after: u64,
        expiry_incentive_balance_after: u64,
        expiry_incentives_allocated_after: u64,
    }

    struct FeeIncentivesReturned has copy, drop, store {
        pool_vault_id: 0x2::object::ID,
        expiry_market_id: 0x2::object::ID,
        amount: u64,
        pool_reserve_after: u64,
    }

    public(friend) fun emit_capital_locked(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = CapitalLocked{
            pool_vault_id : arg0,
            amount        : arg1,
        };
        0x2::event::emit<CapitalLocked>(v0);
    }

    public(friend) fun emit_expiry_cash_rebalanced(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = ExpiryCashRebalanced{
            pool_vault_id            : arg0,
            expiry_market_id         : arg1,
            amount                   : arg2,
            to_expiry                : arg3,
            target_cash              : arg4,
            protocol_profit_realized : arg5,
        };
        0x2::event::emit<ExpiryCashRebalanced>(v0);
    }

    public(friend) fun emit_expiry_cash_received(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ExpiryCashReceived{
            pool_vault_id    : arg0,
            expiry_market_id : arg1,
            settlement_price : arg2,
            amount           : arg3,
        };
        0x2::event::emit<ExpiryCashReceived>(v0);
    }

    public(friend) fun emit_expiry_profit_materialized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = ExpiryProfitMaterialized{
            pool_vault_id                  : arg0,
            expiry_market_id               : arg1,
            lp_profit                      : arg2,
            protocol_profit                : arg3,
            protocol_reserve_balance_after : arg4,
            profit_basis_after             : arg5,
            pending_protocol_profit_after  : arg6,
        };
        0x2::event::emit<ExpiryProfitMaterialized>(v0);
    }

    public(friend) fun emit_fee_incentives_allocated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = FeeIncentivesAllocated{
            pool_vault_id                     : arg0,
            expiry_market_id                  : arg1,
            amount                            : arg2,
            pool_reserve_after                : arg3,
            expiry_incentive_balance_after    : arg4,
            expiry_incentives_allocated_after : arg5,
        };
        0x2::event::emit<FeeIncentivesAllocated>(v0);
    }

    public(friend) fun emit_fee_incentives_returned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = FeeIncentivesReturned{
            pool_vault_id      : arg0,
            expiry_market_id   : arg1,
            amount             : arg2,
            pool_reserve_after : arg3,
        };
        0x2::event::emit<FeeIncentivesReturned>(v0);
    }

    public(friend) fun emit_fee_incentives_sponsored(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = FeeIncentivesSponsored{
            pool_vault_id : arg0,
            sponsor       : arg1,
            amount        : arg2,
            reserve_after : arg3,
        };
        0x2::event::emit<FeeIncentivesSponsored>(v0);
    }

    public(friend) fun emit_flush_executed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64) {
        let v0 = FlushExecuted{
            pool_vault_id           : arg0,
            epoch                   : arg1,
            pool_value              : arg2,
            total_supply            : arg3,
            supply_fee_rate         : arg4,
            withdraw_fee_rate       : arg5,
            active_market_nav       : arg6,
            market_count            : arg7,
            idle_balance_before     : arg8,
            frozen_idle_balance     : arg9,
            supplies_filled         : arg10,
            withdrawals_filled      : arg11,
            requests_processed      : arg12,
            idle_balance_after      : arg13,
            total_supply_after      : arg14,
            supply_request_cutoff   : arg15,
            withdraw_request_cutoff : arg16,
            snapshot_timestamp_ms   : arg17,
        };
        0x2::event::emit<FlushExecuted>(v0);
    }

    public(friend) fun emit_flush_restarted(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = FlushRestarted{
            pool_vault_id         : arg0,
            expected_market_count : arg1,
            valued_market_count   : arg2,
        };
        0x2::event::emit<FlushRestarted>(v0);
    }

    public(friend) fun emit_request_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: bool, arg6: u8, arg7: u64) {
        let v0 = RequestCancelled{
            pool_vault_id          : arg0,
            account_id             : arg1,
            recipient              : arg2,
            index                  : arg3,
            amount                 : arg4,
            is_supply              : arg5,
            reason                 : arg6,
            requests_pending_after : arg7,
        };
        0x2::event::emit<RequestCancelled>(v0);
    }

    public(friend) fun emit_request_limit_missed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = RequestLimitMissed{
            pool_vault_id  : arg0,
            account_id     : arg1,
            recipient      : arg2,
            index          : arg3,
            amount         : arg4,
            is_supply      : arg5,
            quoted_output  : arg6,
            min_output     : arg7,
            missed_flushes : arg8,
            max_misses     : arg9,
        };
        0x2::event::emit<RequestLimitMissed>(v0);
    }

    public(friend) fun emit_supply_filled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = SupplyFilled{
            pool_vault_id          : arg0,
            account_id             : arg1,
            recipient              : arg2,
            index                  : arg3,
            usdc_amount            : arg4,
            shares_minted          : arg5,
            fee_usdc               : arg6,
            usdc_remaining         : arg7,
            requests_pending_after : arg8,
        };
        0x2::event::emit<SupplyFilled>(v0);
    }

    public(friend) fun emit_supply_requested(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = SupplyRequested{
            pool_vault_id          : arg0,
            account_id             : arg1,
            recipient              : arg2,
            index                  : arg3,
            amount                 : arg4,
            min_plp_out            : arg5,
            requests_pending_after : arg6,
        };
        0x2::event::emit<SupplyRequested>(v0);
    }

    public(friend) fun emit_withdraw_filled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = WithdrawFilled{
            pool_vault_id          : arg0,
            account_id             : arg1,
            recipient              : arg2,
            index                  : arg3,
            shares_burned          : arg4,
            usdc_amount            : arg5,
            fee_usdc               : arg6,
            shares_remaining       : arg7,
            requests_pending_after : arg8,
        };
        0x2::event::emit<WithdrawFilled>(v0);
    }

    public(friend) fun emit_withdraw_requested(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = WithdrawRequested{
            pool_vault_id          : arg0,
            account_id             : arg1,
            recipient              : arg2,
            index                  : arg3,
            amount                 : arg4,
            min_usdc_out           : arg5,
            requests_pending_after : arg6,
        };
        0x2::event::emit<WithdrawRequested>(v0);
    }

    // decompiled from Move bytecode v7
}

