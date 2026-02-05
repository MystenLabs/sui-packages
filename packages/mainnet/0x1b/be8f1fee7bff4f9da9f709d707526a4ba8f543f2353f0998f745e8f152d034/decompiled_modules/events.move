module 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::events {
    struct SetOwnerEvent has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct SetFeeEvent has copy, drop {
        market_id: u64,
        new_fee: u128,
    }

    struct SetFlashLoanFeeEvent has copy, drop {
        market_id: u64,
        new_flashloan_fee: u128,
    }

    struct SetFeeRecipientEvent has copy, drop {
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    struct EnableLltvEvent has copy, drop {
        lltv: u64,
    }

    struct CreateMarketEvent has copy, drop {
        market_id: u64,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
        oracle_id: u64,
        ltv: u64,
        lltv: u64,
        fee: u128,
        flashloan_fee: u128,
        title: vector<u8>,
        base_token_decimals: u64,
        quote_token_decimals: u64,
    }

    struct SupplyEvent has copy, drop {
        market_id: u64,
        caller: address,
        on_behalf: address,
        assets: u128,
        shares: u128,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
    }

    struct WithdrawEvent has copy, drop {
        market_id: u64,
        caller: address,
        on_behalf: address,
        receiver: address,
        assets: u128,
        shares: u128,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
    }

    struct BorrowEvent has copy, drop {
        market_id: u64,
        caller: address,
        on_behalf: address,
        receiver: address,
        assets: u128,
        shares: u128,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
    }

    struct RepayEvent has copy, drop {
        market_id: u64,
        caller: address,
        on_behalf: address,
        assets: u128,
        shares: u128,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
    }

    struct SupplyCollateralEvent has copy, drop {
        market_id: u64,
        caller: address,
        on_behalf: address,
        assets: u128,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
    }

    struct WithdrawCollateralEvent has copy, drop {
        market_id: u64,
        caller: address,
        on_behalf: address,
        receiver: address,
        assets: u128,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
    }

    struct LiquidateEvent has copy, drop {
        market_id: u64,
        caller: address,
        borrower: address,
        repaid_assets: u128,
        repaid_shares: u128,
        seized_assets: u128,
        bad_debt_assets: u128,
        bad_debt_shares: u128,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
    }

    struct FlashLoanEvent has copy, drop {
        caller: address,
        token_type: 0x1::type_name::TypeName,
        assets: u128,
    }

    struct SetAuthorizationEvent has copy, drop {
        caller: address,
        owner: address,
        operator: address,
        is_authorized: bool,
        market_id: 0x1::option::Option<u64>,
    }

    struct AccrueInterestEvent has copy, drop {
        market_id: u64,
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
        borrow_rate: u128,
        interest: u128,
        fee_shares: u128,
    }

    struct MigrateEvent has copy, drop {
        new_version: u64,
    }

    struct SetGlobalPauseEvent has copy, drop {
        paused: bool,
    }

    struct SetMarketPauseEvent has copy, drop {
        market_id: u64,
        paused: bool,
    }

    struct SetMarketSupplyPauseEvent has copy, drop {
        market_id: u64,
        paused: bool,
    }

    struct SetMarketWithdrawPauseEvent has copy, drop {
        market_id: u64,
        paused: bool,
    }

    struct SetMarketSupplyCollateralPauseEvent has copy, drop {
        market_id: u64,
        paused: bool,
    }

    struct SetMarketWithdrawCollateralPauseEvent has copy, drop {
        market_id: u64,
        paused: bool,
    }

    struct SetMarketBorrowPauseEvent has copy, drop {
        market_id: u64,
        paused: bool,
    }

    struct SetMarketRepayPauseEvent has copy, drop {
        market_id: u64,
        paused: bool,
    }

    struct SetVaultDepositPauseEvent has copy, drop {
        vault_id: address,
        paused: bool,
    }

    struct SetVaultWithdrawPauseEvent has copy, drop {
        vault_id: address,
        paused: bool,
    }

    struct BorrowRateUpdateEvent has copy, drop {
        market_id: u64,
        avg_borrow_rate: u128,
        rate_at_target: u128,
    }

    public(friend) fun emit_accrue_interest(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u128, arg4: u128, arg5: u128) {
        let v0 = AccrueInterestEvent{
            market_id             : arg0,
            loan_token_type       : arg1,
            collateral_token_type : arg2,
            borrow_rate           : arg3,
            interest              : arg4,
            fee_shares            : arg5,
        };
        0x2::event::emit<AccrueInterestEvent>(v0);
    }

    public(friend) fun emit_borrow(arg0: u64, arg1: address, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: 0x1::type_name::TypeName, arg7: 0x1::type_name::TypeName) {
        let v0 = BorrowEvent{
            market_id             : arg0,
            caller                : arg1,
            on_behalf             : arg2,
            receiver              : arg3,
            assets                : arg4,
            shares                : arg5,
            loan_token_type       : arg6,
            collateral_token_type : arg7,
        };
        0x2::event::emit<BorrowEvent>(v0);
    }

    public(friend) fun emit_borrow_rate_update(arg0: u64, arg1: u128, arg2: u128) {
        let v0 = BorrowRateUpdateEvent{
            market_id       : arg0,
            avg_borrow_rate : arg1,
            rate_at_target  : arg2,
        };
        0x2::event::emit<BorrowRateUpdateEvent>(v0);
    }

    public(friend) fun emit_create_market(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: vector<u8>, arg9: u64, arg10: u64) {
        let v0 = CreateMarketEvent{
            market_id             : arg0,
            loan_token_type       : arg1,
            collateral_token_type : arg2,
            oracle_id             : arg3,
            ltv                   : arg4,
            lltv                  : arg5,
            fee                   : arg6,
            flashloan_fee         : arg7,
            title                 : arg8,
            base_token_decimals   : arg9,
            quote_token_decimals  : arg10,
        };
        0x2::event::emit<CreateMarketEvent>(v0);
    }

    public(friend) fun emit_enable_lltv(arg0: u64) {
        let v0 = EnableLltvEvent{lltv: arg0};
        0x2::event::emit<EnableLltvEvent>(v0);
    }

    public(friend) fun emit_flash_loan(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u128) {
        let v0 = FlashLoanEvent{
            caller     : arg0,
            token_type : arg1,
            assets     : arg2,
        };
        0x2::event::emit<FlashLoanEvent>(v0);
    }

    public(friend) fun emit_liquidate(arg0: u64, arg1: address, arg2: address, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: 0x1::type_name::TypeName, arg9: 0x1::type_name::TypeName) {
        let v0 = LiquidateEvent{
            market_id             : arg0,
            caller                : arg1,
            borrower              : arg2,
            repaid_assets         : arg3,
            repaid_shares         : arg4,
            seized_assets         : arg5,
            bad_debt_assets       : arg6,
            bad_debt_shares       : arg7,
            loan_token_type       : arg8,
            collateral_token_type : arg9,
        };
        0x2::event::emit<LiquidateEvent>(v0);
    }

    public(friend) fun emit_migrate(arg0: u64) {
        let v0 = MigrateEvent{new_version: arg0};
        0x2::event::emit<MigrateEvent>(v0);
    }

    public(friend) fun emit_repay(arg0: u64, arg1: address, arg2: address, arg3: u128, arg4: u128, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName) {
        let v0 = RepayEvent{
            market_id             : arg0,
            caller                : arg1,
            on_behalf             : arg2,
            assets                : arg3,
            shares                : arg4,
            loan_token_type       : arg5,
            collateral_token_type : arg6,
        };
        0x2::event::emit<RepayEvent>(v0);
    }

    public(friend) fun emit_set_authorization(arg0: address, arg1: address, arg2: address, arg3: bool, arg4: 0x1::option::Option<u64>) {
        let v0 = SetAuthorizationEvent{
            caller        : arg0,
            owner         : arg1,
            operator      : arg2,
            is_authorized : arg3,
            market_id     : arg4,
        };
        0x2::event::emit<SetAuthorizationEvent>(v0);
    }

    public(friend) fun emit_set_fee(arg0: u64, arg1: u128) {
        let v0 = SetFeeEvent{
            market_id : arg0,
            new_fee   : arg1,
        };
        0x2::event::emit<SetFeeEvent>(v0);
    }

    public(friend) fun emit_set_fee_recipient(arg0: address, arg1: address) {
        let v0 = SetFeeRecipientEvent{
            old_fee_recipient : arg0,
            new_fee_recipient : arg1,
        };
        0x2::event::emit<SetFeeRecipientEvent>(v0);
    }

    public(friend) fun emit_set_flashloan_fee(arg0: u64, arg1: u128) {
        let v0 = SetFlashLoanFeeEvent{
            market_id         : arg0,
            new_flashloan_fee : arg1,
        };
        0x2::event::emit<SetFlashLoanFeeEvent>(v0);
    }

    public(friend) fun emit_set_global_pause(arg0: bool) {
        let v0 = SetGlobalPauseEvent{paused: arg0};
        0x2::event::emit<SetGlobalPauseEvent>(v0);
    }

    public(friend) fun emit_set_market_borrow_pause(arg0: u64, arg1: bool) {
        let v0 = SetMarketBorrowPauseEvent{
            market_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<SetMarketBorrowPauseEvent>(v0);
    }

    public(friend) fun emit_set_market_pause(arg0: u64, arg1: bool) {
        let v0 = SetMarketPauseEvent{
            market_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<SetMarketPauseEvent>(v0);
    }

    public(friend) fun emit_set_market_repay_pause(arg0: u64, arg1: bool) {
        let v0 = SetMarketRepayPauseEvent{
            market_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<SetMarketRepayPauseEvent>(v0);
    }

    public(friend) fun emit_set_market_supply_collateral_pause(arg0: u64, arg1: bool) {
        let v0 = SetMarketSupplyCollateralPauseEvent{
            market_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<SetMarketSupplyCollateralPauseEvent>(v0);
    }

    public(friend) fun emit_set_market_supply_pause(arg0: u64, arg1: bool) {
        let v0 = SetMarketSupplyPauseEvent{
            market_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<SetMarketSupplyPauseEvent>(v0);
    }

    public(friend) fun emit_set_market_withdraw_collateral_pause(arg0: u64, arg1: bool) {
        let v0 = SetMarketWithdrawCollateralPauseEvent{
            market_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<SetMarketWithdrawCollateralPauseEvent>(v0);
    }

    public(friend) fun emit_set_market_withdraw_pause(arg0: u64, arg1: bool) {
        let v0 = SetMarketWithdrawPauseEvent{
            market_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<SetMarketWithdrawPauseEvent>(v0);
    }

    public(friend) fun emit_set_owner(arg0: address, arg1: address) {
        let v0 = SetOwnerEvent{
            old_owner : arg0,
            new_owner : arg1,
        };
        0x2::event::emit<SetOwnerEvent>(v0);
    }

    public(friend) fun emit_set_vault_deposit_pause(arg0: address, arg1: bool) {
        let v0 = SetVaultDepositPauseEvent{
            vault_id : arg0,
            paused   : arg1,
        };
        0x2::event::emit<SetVaultDepositPauseEvent>(v0);
    }

    public(friend) fun emit_set_vault_withdraw_pause(arg0: address, arg1: bool) {
        let v0 = SetVaultWithdrawPauseEvent{
            vault_id : arg0,
            paused   : arg1,
        };
        0x2::event::emit<SetVaultWithdrawPauseEvent>(v0);
    }

    public(friend) fun emit_supply(arg0: u64, arg1: address, arg2: address, arg3: u128, arg4: u128, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName) {
        let v0 = SupplyEvent{
            market_id             : arg0,
            caller                : arg1,
            on_behalf             : arg2,
            assets                : arg3,
            shares                : arg4,
            loan_token_type       : arg5,
            collateral_token_type : arg6,
        };
        0x2::event::emit<SupplyEvent>(v0);
    }

    public(friend) fun emit_supply_collateral(arg0: u64, arg1: address, arg2: address, arg3: u128, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName) {
        let v0 = SupplyCollateralEvent{
            market_id             : arg0,
            caller                : arg1,
            on_behalf             : arg2,
            assets                : arg3,
            loan_token_type       : arg4,
            collateral_token_type : arg5,
        };
        0x2::event::emit<SupplyCollateralEvent>(v0);
    }

    public(friend) fun emit_withdraw(arg0: u64, arg1: address, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: 0x1::type_name::TypeName, arg7: 0x1::type_name::TypeName) {
        let v0 = WithdrawEvent{
            market_id             : arg0,
            caller                : arg1,
            on_behalf             : arg2,
            receiver              : arg3,
            assets                : arg4,
            shares                : arg5,
            loan_token_type       : arg6,
            collateral_token_type : arg7,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun emit_withdraw_collateral(arg0: u64, arg1: address, arg2: address, arg3: address, arg4: u128, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName) {
        let v0 = WithdrawCollateralEvent{
            market_id             : arg0,
            caller                : arg1,
            on_behalf             : arg2,
            receiver              : arg3,
            assets                : arg4,
            loan_token_type       : arg5,
            collateral_token_type : arg6,
        };
        0x2::event::emit<WithdrawCollateralEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

