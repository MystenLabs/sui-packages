module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
    }

    struct ReserveAdded has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: 0x2::object::ID,
        coin_decimals: u8,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        supplier: address,
        amount: u64,
        shares_minted: u128,
        share_ratio_1e18: u256,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        supplier: address,
        amount: u64,
        shares_burned: u128,
        share_ratio_1e18: u256,
    }

    struct BorrowEvent has copy, drop {
        pool_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        borrower: address,
        amount: u64,
        fee: u64,
    }

    struct RepayEvent has copy, drop {
        pool_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        payer: address,
        amount: u64,
    }

    struct CollateralAdded has copy, drop {
        obligation_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        shares: u128,
    }

    struct CollateralRemoved has copy, drop {
        obligation_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        shares: u128,
    }

    struct ReserveAccrued has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        cumulative_borrow_index_1e18: u256,
        borrowed_amount_1e18: u256,
        utilization_1e18: u256,
        interest_accrued_1e18: u256,
        now_s: u64,
    }

    struct ObligationOpened has copy, drop {
        obligation_id: 0x2::object::ID,
        owner: address,
    }

    struct LiquidationEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        withdraw_type: 0x1::type_name::TypeName,
        repaid: u64,
        seized_shares: u128,
        bonus_bps: u64,
        protocol_fee_shares: u128,
        liquidator: address,
    }

    struct BadDebtEvent has copy, drop {
        pool_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        deficit_usd_1e18: u256,
    }

    struct FlashBorrowEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    struct FlashRepayEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    struct ConfigChanged has copy, drop {
        config_id: 0x2::object::ID,
        field: vector<u8>,
        new_version: u64,
    }

    public(friend) fun emit_bad_debt(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u256) {
        let v0 = BadDebtEvent{
            pool_id          : arg0,
            obligation_id    : arg1,
            coin_type        : arg2,
            deficit_usd_1e18 : arg3,
        };
        0x2::event::emit<BadDebtEvent>(v0);
    }

    public(friend) fun emit_borrow(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: address, arg4: u64, arg5: u64) {
        let v0 = BorrowEvent{
            pool_id       : arg0,
            obligation_id : arg1,
            coin_type     : arg2,
            borrower      : arg3,
            amount        : arg4,
            fee           : arg5,
        };
        0x2::event::emit<BorrowEvent>(v0);
    }

    public(friend) fun emit_collateral_added(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u128) {
        let v0 = CollateralAdded{
            obligation_id : arg0,
            coin_type     : arg1,
            shares        : arg2,
        };
        0x2::event::emit<CollateralAdded>(v0);
    }

    public(friend) fun emit_collateral_removed(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u128) {
        let v0 = CollateralRemoved{
            obligation_id : arg0,
            coin_type     : arg1,
            shares        : arg2,
        };
        0x2::event::emit<CollateralRemoved>(v0);
    }

    public(friend) fun emit_config_changed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = ConfigChanged{
            config_id   : arg0,
            field       : arg1,
            new_version : arg2,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public(friend) fun emit_deposit(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: u128, arg5: u256) {
        let v0 = DepositEvent{
            pool_id          : arg0,
            coin_type        : arg1,
            supplier         : arg2,
            amount           : arg3,
            shares_minted    : arg4,
            share_ratio_1e18 : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_flash_borrow(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = FlashBorrowEvent{
            pool_id   : arg0,
            coin_type : arg1,
            amount    : arg2,
            fee       : arg3,
        };
        0x2::event::emit<FlashBorrowEvent>(v0);
    }

    public(friend) fun emit_flash_repay(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = FlashRepayEvent{
            pool_id   : arg0,
            coin_type : arg1,
            amount    : arg2,
            fee       : arg3,
        };
        0x2::event::emit<FlashRepayEvent>(v0);
    }

    public(friend) fun emit_liquidation(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u128, arg5: u64, arg6: u128, arg7: address) {
        let v0 = LiquidationEvent{
            obligation_id       : arg0,
            repay_type          : arg1,
            withdraw_type       : arg2,
            repaid              : arg3,
            seized_shares       : arg4,
            bonus_bps           : arg5,
            protocol_fee_shares : arg6,
            liquidator          : arg7,
        };
        0x2::event::emit<LiquidationEvent>(v0);
    }

    public(friend) fun emit_obligation_opened(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ObligationOpened{
            obligation_id : arg0,
            owner         : arg1,
        };
        0x2::event::emit<ObligationOpened>(v0);
    }

    public(friend) fun emit_pool_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) {
        let v0 = PoolCreated{
            pool_id   : arg0,
            config_id : arg1,
            market    : arg2,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun emit_repay(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: address, arg4: u64) {
        let v0 = RepayEvent{
            pool_id       : arg0,
            obligation_id : arg1,
            coin_type     : arg2,
            payer         : arg3,
            amount        : arg4,
        };
        0x2::event::emit<RepayEvent>(v0);
    }

    public(friend) fun emit_reserve_accrued(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u64) {
        let v0 = ReserveAccrued{
            pool_id                      : arg0,
            coin_type                    : arg1,
            cumulative_borrow_index_1e18 : arg2,
            borrowed_amount_1e18         : arg3,
            utilization_1e18             : arg4,
            interest_accrued_1e18        : arg5,
            now_s                        : arg6,
        };
        0x2::event::emit<ReserveAccrued>(v0);
    }

    public(friend) fun emit_reserve_added(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: u8) {
        let v0 = ReserveAdded{
            pool_id       : arg0,
            coin_type     : arg1,
            reserve_id    : arg2,
            coin_decimals : arg3,
        };
        0x2::event::emit<ReserveAdded>(v0);
    }

    public(friend) fun emit_withdraw(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: u128, arg5: u256) {
        let v0 = WithdrawEvent{
            pool_id          : arg0,
            coin_type        : arg1,
            supplier         : arg2,
            amount           : arg3,
            shares_burned    : arg4,
            share_ratio_1e18 : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

