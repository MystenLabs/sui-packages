module 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::margin_account {
    struct EventNewMarginAccount has copy, drop {
        protected_margin_account_id: 0x2::object::ID,
        margin_account_cap_id: 0x2::object::ID,
    }

    struct EventDepositCollateral<phantom T0> has copy, drop {
        margin_account_id: 0x2::object::ID,
        amount: u64,
    }

    struct MustCheckBorrowLimit {
        margin_account_id: 0x2::object::ID,
    }

    struct ProtectedMarginAccount has key {
        id: 0x2::object::UID,
        margin_account: 0x2::borrow::Referent<MarginAccount>,
    }

    struct MarginAccount has store, key {
        id: 0x2::object::UID,
        collateral: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::Collateral,
        debt: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::DebtSnapshot,
    }

    struct MarginAccountCap has store, key {
        id: 0x2::object::UID,
        protected_margin_account_id: 0x2::object::ID,
    }

    struct OutstandingDebt<phantom T0> has store {
        value: u64,
    }

    struct ToxicPosition {
        collateral: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::Collateral,
        debt: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::debt::Debt,
    }

    public fun destroy(arg0: ToxicPosition) {
        assert!(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::is_empty(&arg0.collateral), 4);
        assert!(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::debt::is_empty(&arg0.debt), 3);
        let ToxicPosition {
            collateral : v0,
            debt       : v1,
        } = arg0;
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::destroy_empty(v0);
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::debt::destroy_empty(v1);
    }

    fun assert_borrow_limit_for_margin_account(arg0: MustCheckBorrowLimit, arg1: &MarginAccount) {
        let MustCheckBorrowLimit { margin_account_id: v0 } = arg0;
        assert!(&v0 == 0x2::object::uid_as_inner(&arg1.id), 0);
    }

    fun assert_for_margin_account(arg0: &MarginAccountCap, arg1: &ProtectedMarginAccount) {
        let v0 = arg0.protected_margin_account_id;
        assert!(0x2::object::uid_as_inner(&arg1.id) == &v0, 0);
    }

    public fun borrow_collateral<T0>(arg0: &mut MarginAccount, arg1: u64) : (0x2::balance::Balance<T0>, MustCheckBorrowLimit) {
        let v0 = MustCheckBorrowLimit{margin_account_id: 0x2::object::id<MarginAccount>(arg0)};
        (0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::partial_withdraw<T0>(&mut arg0.collateral, arg1), v0)
    }

    public fun borrow_debt(arg0: &MarginAccount) : &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::DebtSnapshot {
        &arg0.debt
    }

    public fun borrow_margin_account(arg0: &mut ProtectedMarginAccount, arg1: &MarginAccountCap) : (MarginAccount, 0x2::borrow::Borrow) {
        assert_for_margin_account(arg1, arg0);
        0x2::borrow::borrow<MarginAccount>(&mut arg0.margin_account)
    }

    fun burn_outstanding_debt<T0>(arg0: OutstandingDebt<T0>) {
        let OutstandingDebt {  } = arg0;
    }

    public fun check_borrow_limits(arg0: &MarginAccount, arg1: &mut 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams, arg3: MustCheckBorrowLimit) {
        assert_borrow_limit_for_margin_account(arg3, arg0);
        assert!(within_borrow_limits(arg0, arg1, arg2), 1);
    }

    public fun collateral_value<T0>(arg0: &MarginAccount) : u64 {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::value<T0>(&arg0.collateral)
    }

    public fun create_margin_account(arg0: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : MarginAccountCap {
        let (v0, v1) = internal_create_margin_account(arg0, arg1, arg2);
        0x2::transfer::share_object<ProtectedMarginAccount>(v1);
        v0
    }

    public fun decrease_debt<T0>(arg0: &mut MarginAccount, arg1: OutstandingDebt<T0>, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::decrease_debt<T0>(&mut arg0.debt, outstanding_debt_value<T0>(&arg1), arg2, arg3, arg4);
        burn_outstanding_debt<T0>(arg1);
    }

    public fun deposit_collateral<T0>(arg0: &mut MarginAccount, arg1: 0x2::balance::Balance<T0>, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams) {
        assert!(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::is_allowed_collateral<T0>(arg2), 8);
        let v0 = EventDepositCollateral<T0>{
            margin_account_id : 0x2::object::id<MarginAccount>(arg0),
            amount            : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<EventDepositCollateral<T0>>(v0);
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::deposit<T0>(&mut arg0.collateral, arg1);
    }

    public fun destroy_protected_margin_account(arg0: ProtectedMarginAccount, arg1: MarginAccountCap) {
        assert_for_margin_account(&arg1, &arg0);
        let ProtectedMarginAccount {
            id             : v0,
            margin_account : v1,
        } = arg0;
        0x2::object::delete(v0);
        let MarginAccount {
            id         : v2,
            collateral : v3,
            debt       : v4,
        } = 0x2::borrow::destroy<MarginAccount>(v1);
        let v5 = v4;
        let v6 = v3;
        0x2::object::delete(v2);
        assert!(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::is_empty(&v6), 4);
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::destroy_empty(v6);
        assert!(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::debt::is_empty(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::total_debt(&v5)), 3);
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::destroy_empty_debt_snapshot(v5);
        let MarginAccountCap {
            id                          : v7,
            protected_margin_account_id : _,
        } = arg1;
        0x2::object::delete(v7);
    }

    public(friend) fun destroy_zero_outstanding_debt<T0>(arg0: OutstandingDebt<T0>) {
        assert!(arg0.value == 0, 3);
        burn_outstanding_debt<T0>(arg0);
    }

    fun empty_margin_account(arg0: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : MarginAccount {
        MarginAccount{
            id         : 0x2::object::new(arg2),
            collateral : 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::new(arg2),
            debt       : 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::new(arg0, arg1, arg2),
        }
    }

    public(friend) fun empty_outstanding_debt<T0>() : OutstandingDebt<T0> {
        OutstandingDebt<T0>{value: 0}
    }

    public fun inscrease_debt<T0>(arg0: &mut MarginAccount, arg1: u64, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (OutstandingDebt<T0>, MustCheckBorrowLimit) {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::increase_debt<T0>(&mut arg0.debt, arg1, arg2, arg3, arg4);
        let v0 = MustCheckBorrowLimit{margin_account_id: 0x2::object::id<MarginAccount>(arg0)};
        (mint_outstanding_debt<T0>(arg1), v0)
    }

    fun internal_create_margin_account(arg0: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (MarginAccountCap, ProtectedMarginAccount) {
        let v0 = 0x2::object::new(arg2);
        let v1 = empty_margin_account(arg0, arg1, arg2);
        let v2 = ProtectedMarginAccount{
            id             : v0,
            margin_account : 0x2::borrow::new<MarginAccount>(v1, arg2),
        };
        let v3 = MarginAccountCap{
            id                          : 0x2::object::new(arg2),
            protected_margin_account_id : 0x2::object::id<ProtectedMarginAccount>(&v2),
        };
        let v4 = EventNewMarginAccount{
            protected_margin_account_id : 0x2::object::id<ProtectedMarginAccount>(&v2),
            margin_account_cap_id       : 0x2::object::id<MarginAccountCap>(&v3),
        };
        0x2::event::emit<EventNewMarginAccount>(v4);
        (v3, v2)
    }

    public fun join_must_check_borrow_limits(arg0: &MustCheckBorrowLimit, arg1: MustCheckBorrowLimit) {
        assert!(arg0.margin_account_id == arg1.margin_account_id, 5);
        let MustCheckBorrowLimit {  } = arg1;
    }

    public(friend) fun join_outstanding_debt<T0>(arg0: &mut OutstandingDebt<T0>, arg1: OutstandingDebt<T0>) {
        let OutstandingDebt { value: v0 } = arg1;
        arg0.value = arg0.value + v0;
    }

    fun mint_outstanding_debt<T0>(arg0: u64) : OutstandingDebt<T0> {
        OutstandingDebt<T0>{value: arg0}
    }

    public fun open_debt<T0>(arg0: &MarginAccount) : u64 {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::value<T0>(&arg0.debt)
    }

    public(friend) fun outstanding_debt_value<T0>(arg0: &OutstandingDebt<T0>) : u64 {
        arg0.value
    }

    public fun repay_debt<T0>(arg0: &mut ToxicPosition, arg1: OutstandingDebt<T0>) {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::debt::decrease<T0>(&mut arg0.debt, arg1.value);
        burn_outstanding_debt<T0>(arg1);
    }

    public fun return_margin_account(arg0: &mut ProtectedMarginAccount, arg1: MarginAccount, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<MarginAccount>(&mut arg0.margin_account, arg1, arg2);
    }

    public(friend) fun split_outstanding_debt<T0>(arg0: &mut OutstandingDebt<T0>, arg1: u64) : OutstandingDebt<T0> {
        assert!(arg0.value >= arg1, 7);
        arg0.value = arg0.value - arg1;
        OutstandingDebt<T0>{value: arg1}
    }

    public fun start_liquidation(arg0: ProtectedMarginAccount, arg1: &mut 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams) : ToxicPosition {
        let ProtectedMarginAccount {
            id             : v0,
            margin_account : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x2::borrow::destroy<MarginAccount>(v1);
        assert!(!within_liquidation_limits(&v2, arg1, arg2), 2);
        let MarginAccount {
            id         : v3,
            collateral : v4,
            debt       : v5,
        } = v2;
        0x2::object::delete(v3);
        ToxicPosition{
            collateral : v4,
            debt       : 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::debt_snapshot_into_total_debt_for_liquidation(v5),
        }
    }

    public fun transition_to_debt_settlement(arg0: &mut ProtectedMarginAccount, arg1: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::borrow::borrow<MarginAccount>(&mut arg0.margin_account);
        let v2 = v0;
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::make_snapshot(&mut v2.debt, arg1, arg2, arg3);
        0x2::borrow::put_back<MarginAccount>(&mut arg0.margin_account, v2, v1);
    }

    public fun withdraw_collateral<T0>(arg0: &mut ToxicPosition) : 0x2::balance::Balance<T0> {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::withdraw<T0>(&mut arg0.collateral)
    }

    fun within_borrow_limits(arg0: &MarginAccount, arg1: &mut 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams) : bool {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::debt::calc_debt_raw(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::total_debt(&arg0.debt), 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::common_unit(arg2), arg1) <= 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::calc_value_raw(&arg0.collateral, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::common_unit(arg2), arg1, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::ltv_table(arg2))
    }

    fun within_liquidation_limits(arg0: &MarginAccount, arg1: &mut 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::RiskParams) : bool {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::debt::calc_debt_raw(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::snapshot::total_debt(&arg0.debt), 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::common_unit(arg2), arg1) < 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral::calc_value_raw(&arg0.collateral, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::common_unit(arg2), arg1, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::risk_params::liquidation_table(arg2))
    }

    // decompiled from Move bytecode v6
}

