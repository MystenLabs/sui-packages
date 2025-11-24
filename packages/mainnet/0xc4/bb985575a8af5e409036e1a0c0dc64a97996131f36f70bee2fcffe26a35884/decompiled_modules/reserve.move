module 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::reserve {
    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        debt: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        cash_reserve: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        cash: u64,
        total_supply: u64,
        borrow_index: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::BorrowIndex,
    }

    struct ReserveBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReserveBalance<phantom T0, phantom T1> has store {
        underlying_balance: 0x2::balance::Balance<T1>,
        ctoken_supply: 0x2::balance::Supply<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>,
    }

    struct ReserveFlashLoan<phantom T0, phantom T1> {
        amount: u64,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : Reserve<T0> {
        let v0 = Reserve<T0>{
            id           : 0x2::object::new(arg0),
            debt         : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::zero(),
            cash_reserve : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::zero(),
            cash         : 0,
            total_supply : 0,
            borrow_index : 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::new(arg1),
        };
        let v1 = ReserveBalanceKey{dummy_field: false};
        let v2 = ReserveBalance<T0, T1>{
            underlying_balance : 0x2::balance::zero<T1>(),
            ctoken_supply      : 0x2::balance::create_supply<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::new<T0, T1>()),
        };
        0x2::dynamic_field::add<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut v0.id, v1, v2);
        v0
    }

    public(friend) fun borrow_index<T0>(arg0: &Reserve<T0>) : &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::BorrowIndex {
        &arg0.borrow_index
    }

    public(friend) fun accrue_interest<T0>(arg0: &mut Reserve<T0>, arg1: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal, arg2: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal, arg3: u64) {
        let v0 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::last_updated(&arg0.borrow_index);
        if (v0 == arg3) {
            return
        };
        let v1 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::value(&arg0.borrow_index);
        let v2 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::mul_u64(arg2, arg3 - v0);
        let v3 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::mul(arg0.debt, v2);
        arg0.debt = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add(arg0.debt, v3);
        arg0.cash_reserve = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add(arg0.cash_reserve, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::mul(arg1, v3));
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::set_value(&mut arg0.borrow_index, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::mul(v2, v1), v1), arg3);
    }

    public(friend) fun amount<T0, T1>(arg0: &ReserveFlashLoan<T0, T1>) : u64 {
        arg0.amount
    }

    public(friend) fun borrow_amount<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert!(arg0.cash - 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::ceil(arg0.cash_reserve) > arg1, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::error::reserve_not_enough_error());
        arg0.debt = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add_u64(&arg0.debt, arg1);
        withdraw_underlying<T0, T1>(arg0, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : (0x2::balance::Balance<T1>, ReserveFlashLoan<T0, T1>) {
        assert!(arg1 < arg0.cash, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::error::reserve_flash_loan_more_than_cash());
        let v0 = ReserveFlashLoan<T0, T1>{amount: arg1};
        (flash_loan_withdraw<T0, T1>(arg0, arg1), v0)
    }

    public(friend) fun borrow_limit_breached<T0>(arg0: &Reserve<T0>, arg1: u64, arg2: u64) : bool {
        let v0 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add_u64(&arg0.debt, arg1);
        0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::gt_u64(&v0, arg2)
    }

    public(friend) fun burn_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>) : 0x2::balance::Balance<T1> {
        assert!(0x2::coin::value<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(&arg1) > 0, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::error::reserve_zero_coin_not_allowed());
        let v0 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::int_mul(exchange_rate<T0>(arg0), 0x2::coin::value<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(&arg1));
        decrease_ctoken_supply<T0, T1>(arg0, 0x2::coin::into_balance<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(arg1));
        withdraw_underlying<T0, T1>(arg0, v0)
    }

    public(friend) fun calculate_borrow_index<T0>(arg0: &Reserve<T0>, arg1: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal, arg2: u64) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        let v0 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::value(&arg0.borrow_index);
        let v1 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::last_updated(&arg0.borrow_index);
        if (v1 == arg2) {
            return v0
        };
        0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::mul(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::mul_u64(arg1, arg2 - v1), v0), v0)
    }

    public(friend) fun cash_plus_borrows_minus_reserves<T0>(arg0: &Reserve<T0>) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::sub(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add_u64(&arg0.debt, arg0.cash), arg0.cash_reserve)
    }

    public(friend) fun debt<T0>(arg0: &Reserve<T0>) : &0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        &arg0.debt
    }

    fun decrease_ctoken_supply<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>) {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.total_supply = arg0.total_supply - 0x2::balance::value<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(&arg1);
        0x2::balance::decrease_supply<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).ctoken_supply, arg1);
    }

    public(friend) fun deposit_limit_breached<T0>(arg0: &Reserve<T0>, arg1: u64, arg2: u64) : bool {
        arg0.cash + arg1 - 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::ceil(arg0.cash_reserve) > arg2
    }

    fun deposit_underlying<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.cash = arg0.cash + 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).underlying_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public(friend) fun exchange_rate<T0>(arg0: &Reserve<T0>) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        if (arg0.total_supply == 0) {
            return 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(1, 1)
        };
        0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::div(cash_plus_borrows_minus_reserves<T0>(arg0), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(arg0.total_supply))
    }

    fun flash_loan_withdraw<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = ReserveBalanceKey{dummy_field: false};
        0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).underlying_balance, arg1)
    }

    fun increase_ctoken_supply<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>> {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.total_supply = arg0.total_supply + arg1;
        0x2::balance::increase_supply<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).ctoken_supply, arg1)
    }

    fun increase_reserve_only<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.cash_reserve = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add(arg0.cash_reserve, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(0x2::coin::value<T1>(&arg1)));
        arg0.cash = arg0.cash + 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).underlying_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public(friend) fun liquidate_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>, arg2: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal) : 0x2::balance::Balance<T1> {
        assert!(0x2::coin::value<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(&arg1) > 0, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::error::reserve_zero_coin_not_allowed());
        let v0 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::int_mul(exchange_rate<T0>(arg0), 0x2::coin::value<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(&arg1));
        let v1 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::int_mul(arg2, v0);
        arg0.cash_reserve = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add(arg0.cash_reserve, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(v1));
        decrease_ctoken_supply<T0, T1>(arg0, 0x2::coin::into_balance<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>>(arg1));
        withdraw_underlying<T0, T1>(arg0, v0 - v1)
    }

    public(friend) fun mint_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>) : 0x2::balance::Balance<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::ctoken::CToken<T0, T1>> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::error::reserve_zero_coin_not_allowed());
        let v1 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::int_div(v0, exchange_rate<T0>(arg0));
        deposit_underlying<T0, T1>(arg0, arg1);
        increase_ctoken_supply<T0, T1>(arg0, v1)
    }

    public(friend) fun protocol_reserve<T0>(arg0: &Reserve<T0>) : u64 {
        0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(arg0.cash_reserve)
    }

    public(friend) fun repay_amount<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(0x2::coin::value<T1>(&arg1));
        if (0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::lt(arg0.debt, v0)) {
            arg0.cash_reserve = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::add_u64(&arg0.cash_reserve, 0x2::coin::value<T1>(&arg1) - 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::ceil(arg0.debt));
            arg0.debt = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::zero();
        } else {
            arg0.debt = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::sub(arg0.debt, v0);
        };
        deposit_underlying<T0, T1>(arg0, arg1);
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Reserve<T0>, arg1: ReserveFlashLoan<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T1>) {
        let v0 = ReserveBalanceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0);
        let ReserveFlashLoan { amount: v2 } = arg1;
        assert!(0x2::coin::value<T1>(&arg2) == v2, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::error::reserve_flash_loan_not_paid_enough());
        0x2::balance::join<T1>(&mut v1.underlying_balance, 0x2::coin::into_balance<T1>(arg2));
        if (0x2::coin::value<T1>(&arg3) == 0) {
            0x2::coin::destroy_zero<T1>(arg3);
            return
        };
        increase_reserve_only<T0, T1>(arg0, arg3);
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(arg1);
        assert!(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::ge(arg0.cash_reserve, v0), 13906835286739910655);
        arg0.cash_reserve = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::sub(arg0.cash_reserve, v0);
        withdraw_underlying<T0, T1>(arg0, arg1)
    }

    public(friend) fun util_rate<T0>(arg0: &Reserve<T0>) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        if (0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::is_zero(&arg0.debt)) {
            return 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(0, 1)
        };
        0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::div(arg0.debt, cash_plus_borrows_minus_reserves<T0>(arg0))
    }

    fun withdraw_underlying<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = ReserveBalanceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0);
        arg0.cash = arg0.cash - arg1;
        assert!(arg0.cash >= 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::ceil(arg0.cash_reserve), 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::error::market_cash_reserve_not_enough());
        0x2::balance::split<T1>(&mut v1.underlying_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

