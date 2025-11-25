module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve {
    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        debt: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        cash_reserve: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        cash: u64,
        total_supply: u64,
        borrow_index: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::BorrowIndex,
    }

    struct ReserveBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReserveBalance<phantom T0, phantom T1> has store {
        underlying_balance: 0x2::balance::Balance<T1>,
        ctoken_supply: 0x2::balance::Supply<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        loan_amount: u64,
        fee: u64,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : Reserve<T0> {
        let v0 = Reserve<T0>{
            id           : 0x2::object::new(arg0),
            debt         : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::zero(),
            cash_reserve : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::zero(),
            cash         : 0,
            total_supply : 0,
            borrow_index : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::new(arg1),
        };
        let v1 = ReserveBalanceKey{dummy_field: false};
        let v2 = ReserveBalance<T0, T1>{
            underlying_balance : 0x2::balance::zero<T1>(),
            ctoken_supply      : 0x2::balance::create_supply<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::new<T0, T1>()),
        };
        0x2::dynamic_field::add<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut v0.id, v1, v2);
        v0
    }

    public fun borrow_index<T0>(arg0: &Reserve<T0>) : &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::BorrowIndex {
        &arg0.borrow_index
    }

    public(friend) fun accrue_interest<T0>(arg0: &mut Reserve<T0>, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg2: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg3: u64) {
        let v0 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::last_updated(&arg0.borrow_index);
        if (v0 == arg3) {
            return
        };
        let v1 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::value(&arg0.borrow_index);
        let v2 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::mul_u64(arg2, arg3 - v0);
        let v3 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::mul(arg0.debt, v2);
        arg0.debt = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add(arg0.debt, v3);
        arg0.cash_reserve = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add(arg0.cash_reserve, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::mul(arg1, v3));
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::set_value(&mut arg0.borrow_index, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::mul(v2, v1), v1), arg3);
    }

    public(friend) fun borrow_amount<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert!(arg0.cash - 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::ceil(arg0.cash_reserve) > arg1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::reserve_not_enough_error());
        arg0.debt = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add_u64(&arg0.debt, arg1);
        withdraw_underlying<T0, T1>(arg0, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64, arg2: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) : (0x2::balance::Balance<T1>, FlashLoan<T0, T1>) {
        assert!(arg1 < arg0.cash, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::reserve_flash_loan_more_than_cash());
        let v0 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::int_mul(arg2, arg1);
        assert!(v0 != 0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::reserve_flash_loan_fee_too_small());
        let v1 = FlashLoan<T0, T1>{
            loan_amount : arg1,
            fee         : v0,
        };
        (flash_loan_withdraw<T0, T1>(arg0, arg1), v1)
    }

    public fun borrow_limit_breached<T0>(arg0: &Reserve<T0>, arg1: u64, arg2: u64) : bool {
        let v0 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add_u64(&arg0.debt, arg1);
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::gt_u64(&v0, arg2)
    }

    public(friend) fun burn_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>) : 0x2::balance::Balance<T1> {
        assert!(0x2::coin::value<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(&arg1) > 0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::reserve_zero_coin_not_allowed());
        let v0 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::int_mul(exchange_rate<T0>(arg0), 0x2::coin::value<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(&arg1));
        decrease_ctoken_supply<T0, T1>(arg0, 0x2::coin::into_balance<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(arg1));
        withdraw_underlying<T0, T1>(arg0, v0)
    }

    public fun calculate_borrow_index<T0>(arg0: &Reserve<T0>, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg2: u64) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        let v0 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::value(&arg0.borrow_index);
        let v1 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::last_updated(&arg0.borrow_index);
        if (v1 == arg2) {
            return v0
        };
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::mul(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::mul_u64(arg1, arg2 - v1), v0), v0)
    }

    public fun cash_plus_borrows_minus_reserves<T0>(arg0: &Reserve<T0>) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::sub(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add_u64(&arg0.debt, arg0.cash), arg0.cash_reserve)
    }

    public fun debt<T0>(arg0: &Reserve<T0>) : &0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        &arg0.debt
    }

    fun decrease_ctoken_supply<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>) {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.total_supply = arg0.total_supply - 0x2::balance::value<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(&arg1);
        0x2::balance::decrease_supply<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).ctoken_supply, arg1);
    }

    public fun deposit_limit_breached<T0>(arg0: &Reserve<T0>, arg1: u64, arg2: u64) : bool {
        arg0.cash + arg1 - 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::ceil(arg0.cash_reserve) > arg2
    }

    fun deposit_underlying<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.cash = arg0.cash + 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).underlying_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public(friend) fun drain_liquidity<T0, T1>(arg0: &mut Reserve<T0>) : 0x2::balance::Balance<T1> {
        let v0 = ReserveBalanceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0);
        0x2::balance::split<T1>(&mut v1.underlying_balance, 0x2::balance::value<T1>(&v1.underlying_balance))
    }

    public fun exchange_rate<T0>(arg0: &Reserve<T0>) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        if (arg0.total_supply == 0) {
            return 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(1, 1)
        };
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::div(cash_plus_borrows_minus_reserves<T0>(arg0), 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from(arg0.total_supply))
    }

    public fun fee<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        arg0.fee
    }

    fun flash_loan_repay<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64) {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.cash_reserve = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add(arg0.cash_reserve, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from(arg2));
        arg0.cash = arg0.cash + arg2;
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).underlying_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    fun flash_loan_withdraw<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = ReserveBalanceKey{dummy_field: false};
        0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).underlying_balance, arg1)
    }

    fun increase_ctoken_supply<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>> {
        let v0 = ReserveBalanceKey{dummy_field: false};
        arg0.total_supply = arg0.total_supply + arg1;
        0x2::balance::increase_supply<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0).ctoken_supply, arg1)
    }

    public(friend) fun liquidate_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>, arg2: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) : (0x2::balance::Balance<T1>, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        assert!(0x2::coin::value<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(&arg1) > 0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::reserve_zero_coin_not_allowed());
        let v0 = exchange_rate<T0>(arg0);
        let v1 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::int_mul(v0, 0x2::coin::value<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(&arg1));
        let v2 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::int_mul(arg2, v1);
        arg0.cash_reserve = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add(arg0.cash_reserve, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from(v2));
        decrease_ctoken_supply<T0, T1>(arg0, 0x2::coin::into_balance<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>>(arg1));
        (withdraw_underlying<T0, T1>(arg0, v1 - v2), v0)
    }

    public fun loan_amount<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        arg0.loan_amount
    }

    public(friend) fun mint_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>) : 0x2::balance::Balance<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::ctoken::CToken<T0, T1>> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::reserve_zero_coin_not_allowed());
        let v1 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::int_div(v0, exchange_rate<T0>(arg0));
        deposit_underlying<T0, T1>(arg0, arg1);
        increase_ctoken_supply<T0, T1>(arg0, v1)
    }

    public fun protocol_reserve<T0>(arg0: &Reserve<T0>) : u64 {
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::floor(arg0.cash_reserve)
    }

    public(friend) fun repay_amount<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from(0x2::coin::value<T1>(&arg1));
        if (0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::lt(arg0.debt, v0)) {
            arg0.cash_reserve = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add_u64(&arg0.cash_reserve, 0x2::coin::value<T1>(&arg1) - 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::ceil(arg0.debt));
            arg0.debt = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::zero();
        } else {
            arg0.debt = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::sub(arg0.debt, v0);
        };
        deposit_underlying<T0, T1>(arg0, arg1);
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T1>, arg2: FlashLoan<T0, T1>) {
        let FlashLoan {
            loan_amount : v0,
            fee         : v1,
        } = arg2;
        assert!(0x2::coin::value<T1>(&arg1) == v0 + v1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::flash_loan_repay_not_enough_error());
        flash_loan_repay<T0, T1>(arg0, arg1, v1);
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from(arg1);
        assert!(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::ge(arg0.cash_reserve, v0), 13906835321099649023);
        arg0.cash_reserve = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::sub(arg0.cash_reserve, v0);
        withdraw_underlying<T0, T1>(arg0, arg1)
    }

    public fun util_rate<T0>(arg0: &Reserve<T0>) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        if (0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::is_zero(&arg0.debt)) {
            return 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(0, 1)
        };
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::div(arg0.debt, cash_plus_borrows_minus_reserves<T0>(arg0))
    }

    fun withdraw_underlying<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = ReserveBalanceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ReserveBalanceKey, ReserveBalance<T0, T1>>(&mut arg0.id, v0);
        arg0.cash = arg0.cash - arg1;
        assert!(arg0.cash >= 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::ceil(arg0.cash_reserve), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_cash_reserve_not_enough());
        0x2::balance::split<T1>(&mut v1.underlying_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

