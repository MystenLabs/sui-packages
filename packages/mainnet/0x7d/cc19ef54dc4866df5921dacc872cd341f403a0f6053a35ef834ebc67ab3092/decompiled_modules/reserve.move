module 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::reserve {
    struct BalanceSheets has drop {
        dummy_field: bool,
    }

    struct BalanceSheet has copy, store {
        debt: u64,
        revenue: u64,
        market_coin_supply: u64,
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
        market_coin_supplies: 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::supply_bag::SupplyBag,
        underlying_balances: 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::BalanceBag,
        balance_sheets: 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::WitTable<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>,
    }

    struct BorrowFeeVaultKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Reserve {
        let v0 = BalanceSheets{dummy_field: false};
        Reserve{
            id                   : 0x2::object::new(arg0),
            market_coin_supplies : 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::supply_bag::new(arg0),
            underlying_balances  : 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::new(arg0),
            balance_sheets       : 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::new<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, true, arg0),
        }
    }

    public(friend) fun add_borrow_fee<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BorrowFeeVaultKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<BorrowFeeVaultKey, 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::BalanceBag>(&arg0.id, v0)) {
            0x2::dynamic_field::add<BorrowFeeVaultKey, 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::BalanceBag>(&mut arg0.id, v0, 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::new(arg2));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<BorrowFeeVaultKey, 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::BalanceBag>(&mut arg0.id, v0);
        if (!0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::contains<T0>(v1)) {
            0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::init_balance<T0>(v1);
        };
        0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::join<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(v1, arg1);
    }

    public fun asset_types(arg0: &Reserve) : vector<0x1::type_name::TypeName> {
        0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::keys<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(&arg0.balance_sheets)
    }

    public fun balance_sheet(arg0: &BalanceSheet) : (u64, u64, u64) {
        (arg0.debt, arg0.revenue, arg0.market_coin_supply)
    }

    public fun balance_sheets(arg0: &Reserve) : &0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::WitTable<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet> {
        &arg0.balance_sheets
    }

    public(friend) fun borrow_flash_loan(arg0: &mut Reserve, arg1: u64) : FlashLoan<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD> {
        let v0 = 0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::u64::mul_div(arg1, 1, 1000);
        let v1 = v0;
        if (arg1 > 0 && arg1 % 1000 != 0) {
            v1 = v0 + 1;
        };
        FlashLoan<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>{
            loan_amount : arg1,
            fee         : v1,
        }
    }

    public fun flash_loan_fee(arg0: &FlashLoan<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>) : u64 {
        arg0.fee
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Reserve, arg1: u64) {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        v1.debt = v1.debt + arg1;
    }

    public(friend) fun handle_liquidation<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        let v2 = 0x2::balance::value<T0>(&arg1) + 0x2::balance::value<T0>(&arg2);
        let v3 = if (v1.debt >= v2) {
            v2
        } else {
            v1.debt
        };
        let v4 = v2 - v3;
        v1.debt = v1.debt - v3;
        if (v4 > 0) {
            v1.revenue = v1.revenue + v4;
        };
        0x2::balance::join<T0>(&mut arg1, arg2);
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::join<T0>(&mut arg0.underlying_balances, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        0x2::balance::split<T0>(&mut arg1, v3)
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Reserve, arg1: 0x2::coin::Coin<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>) : 0x2::balance::Balance<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD> {
        let v0 = 0x2::coin::into_balance<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(arg1);
        let v1 = 0x2::balance::value<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&v0);
        let v2 = BalanceSheets{dummy_field: false};
        let v3 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v2, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
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
        if (v5 > 0) {
            0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::join<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&mut arg0.underlying_balances, v0);
        } else {
            0x2::balance::destroy_zero<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(v0);
        };
        0x2::balance::split<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&mut v0, v4)
    }

    public(friend) fun increase_debt(arg0: &mut Reserve, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32, arg3: 0x1::fixed_point32::FixedPoint32) {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(v1.debt, arg2);
        v1.debt = v1.debt + v2;
        v1.revenue = v1.revenue + 0x1::fixed_point32::multiply_u64(v2, arg3);
    }

    public fun market_coin_supplies(arg0: &Reserve) : &0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::supply_bag::SupplyBag {
        &arg0.market_coin_supplies
    }

    public(friend) fun register_coin<T0>(arg0: &mut Reserve) {
        let v0 = MarketCoin<T0>{dummy_field: false};
        0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::supply_bag::init_supply<MarketCoin<T0>>(v0, &mut arg0.market_coin_supplies);
        0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::init_balance<T0>(&mut arg0.underlying_balances);
        let v1 = BalanceSheets{dummy_field: false};
        let v2 = BalanceSheet{
            debt               : 0,
            revenue            : 0,
            market_coin_supply : 0,
        };
        0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::add<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v1, &mut arg0.balance_sheets, 0x1::type_name::get<T0>(), v2);
    }

    public(friend) fun repay_flash_loan(arg0: &mut Reserve, arg1: 0x2::coin::Coin<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, arg2: FlashLoan<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD> {
        let FlashLoan {
            loan_amount : v0,
            fee         : v1,
        } = arg2;
        let v2 = 0x2::coin::value<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&arg1);
        assert!(v2 >= v0 + v1, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::error::flash_loan_repay_not_enough_error());
        let v3 = 0x2::coin::into_balance<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(arg1);
        0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::join<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&mut arg0.underlying_balances, v3);
        let v4 = BalanceSheets{dummy_field: false};
        let v5 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v4, &mut arg0.balance_sheets, 0x1::type_name::get<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>());
        v5.revenue = v5.revenue + v2 - v0;
        0x2::coin::from_balance<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(0x2::balance::split<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&mut v3, v0), arg3)
    }

    public(friend) fun take_borrow_fee<T0>(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BorrowFeeVaultKey{dummy_field: false};
        0x2::coin::from_balance<T0>(0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::split<T0>(0x2::dynamic_field::borrow_mut<BorrowFeeVaultKey, 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::BalanceBag>(&mut arg0.id, v0), arg1), arg2)
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        let v2 = 0x2::math::min(arg1, v1.revenue);
        v1.revenue = v1.revenue - v2;
        0x2::coin::from_balance<T0>(0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::split<T0>(&mut arg0.underlying_balances, v2), arg2)
    }

    public fun underlying_balances(arg0: &Reserve) : &0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::balance_bag::BalanceBag {
        &arg0.underlying_balances
    }

    // decompiled from Move bytecode v6
}

