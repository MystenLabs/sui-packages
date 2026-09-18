module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events {
    struct LogUserPosition has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        vault_id: u64,
        position_mint: 0x2::object::ID,
        tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        col: u64,
        borrow: u64,
    }

    struct LogOperate has copy, drop {
        signer: address,
        nft_id: 0x2::object::ID,
        new_col: u64,
        new_col_negative: bool,
        new_debt: u64,
        new_debt_negative: bool,
        to: address,
    }

    struct LogPositionOpened has copy, drop {
        position: 0x2::object::ID,
        vault: 0x2::object::ID,
        cap: 0x2::object::ID,
        opened_by: address,
    }

    struct LogClosePosition has copy, drop {
        signer: address,
        position_id: 0x2::object::ID,
        vault_id: u64,
        position_mint: 0x2::object::ID,
    }

    struct LogLiquidateInfo has copy, drop {
        vault_id: u64,
        start_tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        end_tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
    }

    struct LogLiquidate has copy, drop {
        signer: address,
        col_amount: u64,
        debt_amount: u64,
        to: address,
    }

    struct LogAbsorb has copy, drop {
        col_amount: u64,
        debt_amount: u64,
    }

    struct LogRebalance has copy, drop {
        vault_id: u64,
        col_supplied: u64,
        col_withdrawn: u64,
        debt_paid_back: u64,
        debt_borrowed: u64,
    }

    struct LogUpdateAuths has copy, drop {
        account: address,
        value: bool,
    }

    struct LogUpdateSupplyRateMagnifier has copy, drop {
        supply_rate_magnifier: u16,
        supply_rate_magnifier_negative: bool,
    }

    struct LogUpdateBorrowRateMagnifier has copy, drop {
        borrow_rate_magnifier: u16,
        borrow_rate_magnifier_negative: bool,
    }

    struct LogUpdateCollateralFactor has copy, drop {
        collateral_factor: u16,
    }

    struct LogUpdateLiquidationThreshold has copy, drop {
        liquidation_threshold: u16,
    }

    struct LogUpdateLiquidationMaxLimit has copy, drop {
        liquidation_max_limit: u16,
    }

    struct LogUpdateWithdrawGap has copy, drop {
        withdraw_gap: u16,
    }

    struct LogUpdateLiquidationPenalty has copy, drop {
        liquidation_penalty: u16,
    }

    struct LogUpdateBorrowFee has copy, drop {
        borrow_fee: u8,
    }

    struct LogUpdateExchangePrices has copy, drop {
        vault_supply_exchange_price: u128,
        vault_borrow_exchange_price: u128,
        liquidity_supply_exchange_price: u128,
        liquidity_borrow_exchange_price: u128,
    }

    struct LogUpdateCoreSettings has copy, drop {
        supply_rate_magnifier: u16,
        supply_rate_magnifier_negative: bool,
        borrow_rate_magnifier: u16,
        borrow_rate_magnifier_negative: bool,
        collateral_factor: u16,
        liquidation_threshold: u16,
        liquidation_max_limit: u16,
        withdraw_gap: u16,
        liquidation_penalty: u16,
        borrow_fee: u8,
    }

    struct LogUpdateOracle has copy, drop {
        new_oracle: 0x2::object::ID,
    }

    struct LogUpdateRebalancer has copy, drop {
        market: 0x2::object::ID,
        account: address,
        value: bool,
    }

    struct LogInitVaultConfig has copy, drop {
        vault_config: 0x2::object::ID,
        vault_id: u64,
    }

    struct LogInitVaultState has copy, drop {
        vault_state: 0x2::object::ID,
    }

    struct LogAddAdmin has copy, drop {
        owner: address,
    }

    struct LogRemoveAdmin has copy, drop {
        owner: address,
    }

    struct LogLiquidationRoundingDiff has copy, drop {
        vault_id: u64,
        actual_debt_amt: u64,
        debt_amount: u64,
        diff: u64,
    }

    struct LogMigrate has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public(friend) fun emit_log_absorb(arg0: u64, arg1: u64) {
        let v0 = LogAbsorb{
            col_amount  : arg0,
            debt_amount : arg1,
        };
        0x2::event::emit<LogAbsorb>(v0);
    }

    public(friend) fun emit_log_add_admin(arg0: address) {
        let v0 = LogAddAdmin{owner: arg0};
        0x2::event::emit<LogAddAdmin>(v0);
    }

    public(friend) fun emit_log_close_position(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID) {
        let v0 = LogClosePosition{
            signer        : arg0,
            position_id   : arg1,
            vault_id      : arg2,
            position_mint : arg3,
        };
        0x2::event::emit<LogClosePosition>(v0);
    }

    public(friend) fun emit_log_init_vault_config(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LogInitVaultConfig{
            vault_config : arg0,
            vault_id     : arg1,
        };
        0x2::event::emit<LogInitVaultConfig>(v0);
    }

    public(friend) fun emit_log_init_vault_state(arg0: 0x2::object::ID) {
        let v0 = LogInitVaultState{vault_state: arg0};
        0x2::event::emit<LogInitVaultState>(v0);
    }

    public(friend) fun emit_log_liquidate(arg0: address, arg1: u64, arg2: u64, arg3: address) {
        let v0 = LogLiquidate{
            signer      : arg0,
            col_amount  : arg1,
            debt_amount : arg2,
            to          : arg3,
        };
        0x2::event::emit<LogLiquidate>(v0);
    }

    public(friend) fun emit_log_liquidate_info(arg0: u64, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        let v0 = LogLiquidateInfo{
            vault_id   : arg0,
            start_tick : arg1,
            end_tick   : arg2,
        };
        0x2::event::emit<LogLiquidateInfo>(v0);
    }

    public(friend) fun emit_log_liquidation_rounding_diff(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = LogLiquidationRoundingDiff{
            vault_id        : arg0,
            actual_debt_amt : arg1,
            debt_amount     : arg2,
            diff            : arg3,
        };
        0x2::event::emit<LogLiquidationRoundingDiff>(v0);
    }

    public(friend) fun emit_log_migrate(arg0: u64, arg1: u64) {
        let v0 = LogMigrate{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<LogMigrate>(v0);
    }

    public(friend) fun emit_log_operate(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: address) {
        let v0 = LogOperate{
            signer            : arg0,
            nft_id            : arg1,
            new_col           : arg2,
            new_col_negative  : arg3,
            new_debt          : arg4,
            new_debt_negative : arg5,
            to                : arg6,
        };
        0x2::event::emit<LogOperate>(v0);
    }

    public(friend) fun emit_log_position_opened(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) {
        let v0 = LogPositionOpened{
            position  : arg0,
            vault     : arg1,
            cap       : arg2,
            opened_by : arg3,
        };
        0x2::event::emit<LogPositionOpened>(v0);
    }

    public(friend) fun emit_log_rebalance(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LogRebalance{
            vault_id       : arg0,
            col_supplied   : arg1,
            col_withdrawn  : arg2,
            debt_paid_back : arg3,
            debt_borrowed  : arg4,
        };
        0x2::event::emit<LogRebalance>(v0);
    }

    public(friend) fun emit_log_remove_admin(arg0: address) {
        let v0 = LogRemoveAdmin{owner: arg0};
        0x2::event::emit<LogRemoveAdmin>(v0);
    }

    public(friend) fun emit_log_update_auths(arg0: address, arg1: bool) {
        let v0 = LogUpdateAuths{
            account : arg0,
            value   : arg1,
        };
        0x2::event::emit<LogUpdateAuths>(v0);
    }

    public(friend) fun emit_log_update_borrow_fee(arg0: u8) {
        let v0 = LogUpdateBorrowFee{borrow_fee: arg0};
        0x2::event::emit<LogUpdateBorrowFee>(v0);
    }

    public(friend) fun emit_log_update_borrow_rate_magnifier(arg0: u16, arg1: bool) {
        let v0 = LogUpdateBorrowRateMagnifier{
            borrow_rate_magnifier          : arg0,
            borrow_rate_magnifier_negative : arg1,
        };
        0x2::event::emit<LogUpdateBorrowRateMagnifier>(v0);
    }

    public(friend) fun emit_log_update_collateral_factor(arg0: u16) {
        let v0 = LogUpdateCollateralFactor{collateral_factor: arg0};
        0x2::event::emit<LogUpdateCollateralFactor>(v0);
    }

    public(friend) fun emit_log_update_core_settings(arg0: u16, arg1: bool, arg2: u16, arg3: bool, arg4: u16, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u8) {
        let v0 = LogUpdateCoreSettings{
            supply_rate_magnifier          : arg0,
            supply_rate_magnifier_negative : arg1,
            borrow_rate_magnifier          : arg2,
            borrow_rate_magnifier_negative : arg3,
            collateral_factor              : arg4,
            liquidation_threshold          : arg5,
            liquidation_max_limit          : arg6,
            withdraw_gap                   : arg7,
            liquidation_penalty            : arg8,
            borrow_fee                     : arg9,
        };
        0x2::event::emit<LogUpdateCoreSettings>(v0);
    }

    public(friend) fun emit_log_update_exchange_prices(arg0: u128, arg1: u128, arg2: u128, arg3: u128) {
        let v0 = LogUpdateExchangePrices{
            vault_supply_exchange_price     : arg0,
            vault_borrow_exchange_price     : arg1,
            liquidity_supply_exchange_price : arg2,
            liquidity_borrow_exchange_price : arg3,
        };
        0x2::event::emit<LogUpdateExchangePrices>(v0);
    }

    public(friend) fun emit_log_update_liquidation_max_limit(arg0: u16) {
        let v0 = LogUpdateLiquidationMaxLimit{liquidation_max_limit: arg0};
        0x2::event::emit<LogUpdateLiquidationMaxLimit>(v0);
    }

    public(friend) fun emit_log_update_liquidation_penalty(arg0: u16) {
        let v0 = LogUpdateLiquidationPenalty{liquidation_penalty: arg0};
        0x2::event::emit<LogUpdateLiquidationPenalty>(v0);
    }

    public(friend) fun emit_log_update_liquidation_threshold(arg0: u16) {
        let v0 = LogUpdateLiquidationThreshold{liquidation_threshold: arg0};
        0x2::event::emit<LogUpdateLiquidationThreshold>(v0);
    }

    public(friend) fun emit_log_update_oracle(arg0: 0x2::object::ID) {
        let v0 = LogUpdateOracle{new_oracle: arg0};
        0x2::event::emit<LogUpdateOracle>(v0);
    }

    public(friend) fun emit_log_update_rebalancer(arg0: 0x2::object::ID, arg1: address, arg2: bool) {
        let v0 = LogUpdateRebalancer{
            market  : arg0,
            account : arg1,
            value   : arg2,
        };
        0x2::event::emit<LogUpdateRebalancer>(v0);
    }

    public(friend) fun emit_log_update_supply_rate_magnifier(arg0: u16, arg1: bool) {
        let v0 = LogUpdateSupplyRateMagnifier{
            supply_rate_magnifier          : arg0,
            supply_rate_magnifier_negative : arg1,
        };
        0x2::event::emit<LogUpdateSupplyRateMagnifier>(v0);
    }

    public(friend) fun emit_log_update_withdraw_gap(arg0: u16) {
        let v0 = LogUpdateWithdrawGap{withdraw_gap: arg0};
        0x2::event::emit<LogUpdateWithdrawGap>(v0);
    }

    public(friend) fun emit_log_user_position(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, arg5: u64, arg6: u64) {
        let v0 = LogUserPosition{
            user          : arg0,
            nft_id        : arg1,
            vault_id      : arg2,
            position_mint : arg3,
            tick          : arg4,
            col           : arg5,
            borrow        : arg6,
        };
        0x2::event::emit<LogUserPosition>(v0);
    }

    // decompiled from Move bytecode v7
}

