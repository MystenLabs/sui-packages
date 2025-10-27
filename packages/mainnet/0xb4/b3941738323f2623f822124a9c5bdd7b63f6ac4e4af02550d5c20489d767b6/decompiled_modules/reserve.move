module 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::reserve {
    struct BalanceSheets has drop {
        dummy_field: bool,
    }

    struct BalanceSheet has copy, store {
        cash: u64,
        debt: u64,
        revenue: u64,
        market_coin_supply: u64,
    }

    struct FlashLoanFees has drop {
        dummy_field: bool,
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
        market_coin_supplies: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::supply_bag::SupplyBag,
        underlying_balances: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag,
        balance_sheets: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>,
        flash_loan_fees: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<FlashLoanFees, 0x1::type_name::TypeName, u64>,
    }

    struct MarketCoinPriceTableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BorrowFeeVaultKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Reserve {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = FlashLoanFees{dummy_field: false};
        Reserve{
            id                   : 0x2::object::new(arg0),
            market_coin_supplies : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::supply_bag::new(arg0),
            underlying_balances  : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::new(arg0),
            balance_sheets       : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::new<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, true, arg0),
            flash_loan_fees      : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::new<FlashLoanFees, 0x1::type_name::TypeName, u64>(v1, true, arg0),
        }
    }

    public(friend) fun add_borrow_fee<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BorrowFeeVaultKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<BorrowFeeVaultKey, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag>(&arg0.id, v0)) {
            0x2::dynamic_field::add<BorrowFeeVaultKey, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag>(&mut arg0.id, v0, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::new(arg2));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<BorrowFeeVaultKey, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag>(&mut arg0.id, v0);
        if (!0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::contains<T0>(v1)) {
            0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::init_balance<T0>(v1);
        };
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(v1, arg1);
    }

    public fun asset_types(arg0: &Reserve) : vector<0x1::type_name::TypeName> {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(&arg0.balance_sheets)
    }

    public fun balance_sheet(arg0: &BalanceSheet) : (u64, u64, u64, u64) {
        (arg0.cash, arg0.debt, arg0.revenue, arg0.market_coin_supply)
    }

    public fun balance_sheets(arg0: &Reserve) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet> {
        &arg0.balance_sheets
    }

    public(friend) fun borrow_flash_loan<T0>(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan<T0>) {
        let (v0, v1) = borrow_flash_loan_internal<T0>(arg0, arg1, 0, 1);
        (0x2::coin::from_balance<T0>(v0, arg2), v1)
    }

    fun borrow_flash_loan_internal<T0>(arg0: &mut Reserve, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, FlashLoan<T0>) {
        let v0 = *0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<FlashLoanFees, 0x1::type_name::TypeName, u64>(&arg0.flash_loan_fees, 0x1::type_name::get<T0>());
        let v1 = if (v0 > 0) {
            arg1 * v0 / 10000 + 1
        } else {
            0
        };
        let v2 = if (arg2 > 0 && arg3 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v1, arg2, arg3)
        } else {
            0
        };
        let v3 = FlashLoan<T0>{
            loan_amount : arg1,
            fee         : v1 - v2,
        };
        (0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::split<T0>(&mut arg0.underlying_balances, arg1), v3)
    }

    public fun flash_loan_fee<T0>(arg0: &FlashLoan<T0>) : u64 {
        arg0.fee
    }

    public fun flash_loan_loan_amount<T0>(arg0: &FlashLoan<T0>) : u64 {
        arg0.loan_amount
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Reserve, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        assert!(v1.cash >= arg1, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::reserve_not_enough_error());
        v1.cash = v1.cash - arg1;
        v1.debt = v1.debt + arg1;
        assert!(v1.cash >= v1.revenue, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::pool_liquidity_not_enough_error());
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::split<T0>(&mut arg0.underlying_balances, arg1)
    }

    public(friend) fun handle_liquidation<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>) {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        v1.cash = v1.cash + 0x2::balance::value<T0>(&arg1) + 0x2::balance::value<T0>(&arg2);
        v1.revenue = v1.revenue + 0x2::balance::value<T0>(&arg2);
        v1.debt = v1.debt - 0x2::balance::value<T0>(&arg1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(&mut arg0.underlying_balances, arg1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(&mut arg0.underlying_balances, arg2);
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = BalanceSheets{dummy_field: false};
        let v2 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v1, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        if (v2.debt >= v0) {
            v2.debt = v2.debt - v0;
        } else {
            v2.revenue = v2.revenue + v0 - v2.debt;
            v2.debt = 0;
        };
        v2.cash = v2.cash + v0;
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(&mut arg0.underlying_balances, arg1);
    }

    public(friend) fun increase_debt(arg0: &mut Reserve, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32, arg3: 0x1::fixed_point32::FixedPoint32) {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(v1.debt, arg2);
        v1.debt = v1.debt + v2;
        v1.revenue = v1.revenue + 0x1::fixed_point32::multiply_u64(v2, arg3);
    }

    public(friend) fun init_market_coin_price_table(arg0: &mut Reserve, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketCoinPriceTableKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<MarketCoinPriceTableKey, 0x2::table::Table<0x1::type_name::TypeName, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>>(&arg0.id, v0)) {
            return
        };
        let v1 = MarketCoinPriceTableKey{dummy_field: false};
        0x2::dynamic_field::add<MarketCoinPriceTableKey, 0x2::table::Table<0x1::type_name::TypeName, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>>(&mut arg0.id, v1, 0x2::table::new<0x1::type_name::TypeName, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>(arg1));
    }

    public fun market_coin_supplies(arg0: &Reserve) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::supply_bag::SupplyBag {
        &arg0.market_coin_supplies
    }

    public(friend) fun mint_market_coin<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<MarketCoin<T0>> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = update_and_get_market_coin_price(arg0, 0x1::type_name::get<T0>());
        let v2 = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::floor(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::div(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(v0), v1));
        assert!(v2 > 0, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::mint_market_coin_too_small_error());
        let v3 = BalanceSheets{dummy_field: false};
        let v4 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v3, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        v4.cash = v4.cash + v0;
        v4.market_coin_supply = v4.market_coin_supply + v2;
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(&mut arg0.underlying_balances, arg1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::supply_bag::increase_supply<MarketCoin<T0>>(&mut arg0.market_coin_supplies, v2)
    }

    public(friend) fun redeem_underlying_coin<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<MarketCoin<T0>>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<MarketCoin<T0>>(&arg1);
        let v1 = update_and_get_market_coin_price(arg0, 0x1::type_name::get<T0>());
        let v2 = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::floor(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::mul(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(v0), v1));
        assert!(v2 > 0, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::redeem_market_coin_too_small_error());
        let v3 = BalanceSheets{dummy_field: false};
        let v4 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v3, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        assert!(v4.cash >= v2, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::reserve_not_enough_error());
        v4.cash = v4.cash - v2;
        v4.market_coin_supply = v4.market_coin_supply - v0;
        assert!(v4.cash >= v4.revenue, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::pool_liquidity_not_enough_error());
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::supply_bag::decrease_supply<MarketCoin<T0>>(&mut arg0.market_coin_supplies, arg1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::split<T0>(&mut arg0.underlying_balances, v2)
    }

    public(friend) fun register_coin<T0>(arg0: &mut Reserve) {
        let v0 = MarketCoin<T0>{dummy_field: false};
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::supply_bag::init_supply<MarketCoin<T0>>(v0, &mut arg0.market_coin_supplies);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::init_balance<T0>(&mut arg0.underlying_balances);
        let v1 = BalanceSheets{dummy_field: false};
        let v2 = BalanceSheet{
            cash               : 0,
            debt               : 0,
            revenue            : 0,
            market_coin_supply : 0,
        };
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::add<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v1, &mut arg0.balance_sheets, 0x1::type_name::get<T0>(), v2);
        let v3 = FlashLoanFees{dummy_field: false};
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::add<FlashLoanFees, 0x1::type_name::TypeName, u64>(v3, &mut arg0.flash_loan_fees, 0x1::type_name::get<T0>(), 0);
    }

    public(friend) fun repay_flash_loan<T0>(arg0: &mut Reserve, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoan<T0>) {
        let FlashLoan {
            loan_amount : v0,
            fee         : v1,
        } = arg2;
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v0 + v1, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::flash_loan_repay_not_enough_error());
        let v3 = v2 - v0;
        let v4 = BalanceSheets{dummy_field: false};
        let v5 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v4, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        v5.cash = v5.cash + v3;
        v5.revenue = v5.revenue + v3;
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(&mut arg0.underlying_balances, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun set_flash_loan_fee<T0>(arg0: &mut Reserve, arg1: u64) {
        let v0 = FlashLoanFees{dummy_field: false};
        *0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<FlashLoanFees, 0x1::type_name::TypeName, u64>(v0, &mut arg0.flash_loan_fees, 0x1::type_name::get<T0>()) = arg1;
    }

    public(friend) fun take_borrow_fee<T0>(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BorrowFeeVaultKey{dummy_field: false};
        0x2::coin::from_balance<T0>(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::split<T0>(0x2::dynamic_field::borrow_mut<BorrowFeeVaultKey, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag>(&mut arg0.id, v0), arg1), arg2)
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceSheets{dummy_field: false};
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v0, &mut arg0.balance_sheets, 0x1::type_name::get<T0>());
        let v2 = 0x2::math::min(arg1, v1.revenue);
        v1.revenue = v1.revenue - v2;
        v1.cash = v1.cash - v2;
        0x2::coin::from_balance<T0>(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::split<T0>(&mut arg0.underlying_balances, v2), arg2)
    }

    public fun underlying_balances(arg0: &Reserve) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag {
        &arg0.underlying_balances
    }

    fun update_and_get_market_coin_price(arg0: &mut Reserve, arg1: 0x1::type_name::TypeName) : 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal {
        let v0 = MarketCoinPriceTableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<MarketCoinPriceTableKey, 0x2::table::Table<0x1::type_name::TypeName, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>>(&mut arg0.id, v0);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>(v1, arg1) == false) {
            0x2::table::add<0x1::type_name::TypeName, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>(v1, arg1, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(1));
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>(v1, arg1);
        let v3 = BalanceSheets{dummy_field: false};
        let v4 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(v3, &mut arg0.balance_sheets, arg1);
        let v5 = if (v4.market_coin_supply > 0) {
            let v6 = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::div(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(v4.cash + v4.debt - v4.revenue), 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(v4.market_coin_supply));
            assert!(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::ge(v6, *v2), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::market_coin_price_cannot_decrease_error());
            v6
        } else {
            0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(1)
        };
        *v2 = v5;
        v5
    }

    public fun util_rate(arg0: &Reserve, arg1: 0x1::type_name::TypeName) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<BalanceSheets, 0x1::type_name::TypeName, BalanceSheet>(&arg0.balance_sheets, arg1);
        if (v0.debt > 0) {
            0x1::fixed_point32::create_from_rational(v0.debt, v0.debt + v0.cash - v0.revenue)
        } else {
            0x1::fixed_point32::create_from_rational(0, 1)
        }
    }

    // decompiled from Move bytecode v6
}

