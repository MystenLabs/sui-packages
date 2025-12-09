module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::reserve {
    struct BalanceSheets has drop {
        dummy_field: bool,
    }

    struct BalanceSheet has copy, store {
        debt: u64,
        revenue: u64,
    }

    struct FlashLoan<phantom T0> {
        loan_amount: u64,
        fee: u64,
    }

    struct MarketCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Reserve has store, key {
        id: 0x2::object::UID,
        revenue_balances: 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::BalanceBag,
        balance_sheets: 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::WitTable<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>,
    }

    struct BorrowFeeVaultKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Reserve {
        let v0 = BalanceSheets{dummy_field: false};
        Reserve{
            id               : 0x2::object::new(arg0),
            revenue_balances : 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::new(arg0),
            balance_sheets   : 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::new<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, true, arg0),
        }
    }

    public(friend) fun add_borrow_fee<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BorrowFeeVaultKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<BorrowFeeVaultKey, 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::BalanceBag>(&arg0.id, v0)) {
            0x2::dynamic_field::add<BorrowFeeVaultKey, 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::BalanceBag>(&mut arg0.id, v0, 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::new(arg2));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<BorrowFeeVaultKey, 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::BalanceBag>(&mut arg0.id, v0);
        if (!0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::contains<T0>(v1)) {
            0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::init_balance<T0>(v1);
        };
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::join<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(v1, arg1);
    }

    public fun asset_types(arg0: &Reserve) : vector<0x1::type_name::TypeName> {
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::keys<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(&arg0.balance_sheets)
    }

    public fun balance_sheet(arg0: &BalanceSheet) : (u64, u64) {
        (arg0.debt, arg0.revenue)
    }

    public fun balance_sheets(arg0: &Reserve) : &0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::WitTable<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet> {
        &arg0.balance_sheets
    }

    public(friend) fun borrow_flash_loan(arg0: &mut Reserve, arg1: u64) : FlashLoan<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD> {
        let v0 = 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::u64::mul_div(arg1, 1, 1000);
        let v1 = v0;
        if (arg1 > 0 && arg1 % 1000 != 0) {
            v1 = v0 + 1;
        };
        FlashLoan<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>{
            loan_amount : arg1,
            fee         : v1,
        }
    }

    public fun flash_loan_fee(arg0: &FlashLoan<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>) : u64 {
        arg0.fee
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Reserve, arg1: u64) {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        v1.debt = v1.debt + arg1;
    }

    public(friend) fun handle_liquidation<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        let v2 = 0x2::balance::value<T0>(&arg1) + 0x2::balance::value<T0>(&arg2);
        let v3 = 0x2::balance::value<T0>(&arg2);
        let v4 = if (v1.debt >= v2) {
            v2
        } else {
            v1.debt
        };
        let v5 = v2 - v4;
        if (v5 > 0) {
            v1.revenue = v1.revenue + v5;
        };
        if (v1.debt >= v4) {
            v1.debt = v1.debt - v4;
        } else {
            v1.debt = 0;
        };
        0x2::balance::join<T0>(&mut arg1, arg2);
        let v6 = arg3 + v3;
        let v7 = if (v4 > v6) {
            v4 - v6
        } else {
            0
        };
        if (v7 == 0) {
            v1.revenue = v1.revenue + v3;
            0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::join<T0>(&mut arg0.revenue_balances, arg1);
            return 0x2::balance::zero<T0>()
        };
        if (0x2::balance::value<T0>(&arg1) > 0) {
            v1.revenue = v1.revenue + v3;
            0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::join<T0>(&mut arg0.revenue_balances, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        0x2::balance::split<T0>(&mut arg1, v7)
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Reserve, arg1: 0x2::coin::Coin<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>, arg2: u64) : 0x2::balance::Balance<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD> {
        let v0 = 0x2::coin::into_balance<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(arg1);
        let v1 = 0x2::balance::value<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&v0);
        let v2 = BalanceSheets{dummy_field: false};
        let v3 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v2, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        let v4 = if (v3.debt >= v1) {
            v1
        } else {
            v3.debt
        };
        let v5 = v1 - v4;
        if (v3.debt >= v1) {
            v3.debt = v3.debt - v1;
        } else {
            v3.debt = 0;
        };
        if (v5 > 0) {
            v3.revenue = v3.revenue + v5;
        };
        let v6 = v4 - arg2;
        if (v6 == 0) {
            0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::join<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&mut arg0.revenue_balances, v0);
            return 0x2::balance::zero<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>()
        };
        if (v5 + arg2 > 0) {
            0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::join<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&mut arg0.revenue_balances, v0);
        } else {
            0x2::balance::destroy_zero<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(v0);
        };
        0x2::balance::split<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&mut v0, v6)
    }

    public(friend) fun increase_debt(arg0: &mut Reserve, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32) {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(v1.debt, arg2);
        v1.debt = v1.debt + v2;
        v1.revenue = v1.revenue + v2;
    }

    public(friend) fun register_coin<T0>(arg0: &mut Reserve) {
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::init_balance<T0>(&mut arg0.revenue_balances);
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = BalanceSheet{
            debt    : 0,
            revenue : 0,
        };
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::add<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>(), v1);
    }

    public(friend) fun repay_flash_loan(arg0: &mut Reserve, arg1: 0x2::coin::Coin<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>, arg2: FlashLoan<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD> {
        let FlashLoan {
            loan_amount : v0,
            fee         : v1,
        } = arg2;
        let v2 = 0x2::coin::value<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&arg1);
        assert!(v2 >= v0 + v1, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::flash_loan_repay_not_enough_error());
        let v3 = 0x2::coin::into_balance<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(arg1);
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::join<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&mut arg0.revenue_balances, v3);
        let v4 = BalanceSheets{dummy_field: false};
        let v5 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v4, &mut arg0.balance_sheets, 0x1::type_name::get<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>());
        v5.revenue = v5.revenue + v2 - v0;
        0x2::coin::from_balance<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(0x2::balance::split<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&mut v3, v0), arg3)
    }

    public fun revenue_balances(arg0: &Reserve) : &0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::BalanceBag {
        &arg0.revenue_balances
    }

    public(friend) fun take_borrow_fee<T0>(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BorrowFeeVaultKey{dummy_field: false};
        0x2::coin::from_balance<T0>(0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::split<T0>(0x2::dynamic_field::borrow_mut<BorrowFeeVaultKey, 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::BalanceBag>(&mut arg0.id, v0), arg1), arg2)
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        let v2 = 0x2::math::min(arg1, 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::value<T0>(&arg0.revenue_balances));
        v1.revenue = v1.revenue - v2;
        0x2::coin::from_balance<T0>(0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::balance_bag::split<T0>(&mut arg0.revenue_balances, v2), arg2)
    }

    // decompiled from Move bytecode v6
}

