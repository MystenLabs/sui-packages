module 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::pool {
    struct PoolBalanceSheet has copy, store {
        balance: u64,
        debt_amount: u64,
        accrued_amount: u64,
        pool_lp_coin_supply: u64,
    }

    struct PoolLpCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        pool_lp_coin_supplies: 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_supply_bag::CoinSupplyBag,
        pool_balances: 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::CoinBalanceBag,
        pool_balance_sheets: 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::TableKeys<0x1::type_name::TypeName, PoolBalanceSheet>,
    }

    public(friend) fun borrow_from_pool<T0>(arg0: &mut Pool, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::borrow_mut_table<0x1::type_name::TypeName, PoolBalanceSheet>(&mut arg0.pool_balance_sheets, 0x1::type_name::get<T0>());
        v0.balance = v0.balance - arg1;
        v0.debt_amount = v0.debt_amount + arg1;
        assert!(v0.balance >= v0.accrued_amount, 6000);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::debit_coin_balance<T0>(&mut arg0.pool_balances, arg1)
    }

    public(friend) fun burn_pool_lp_coin<T0>(arg0: &mut Pool, arg1: 0x2::balance::Balance<PoolLpCoin<T0>>) : 0x2::balance::Balance<T0> {
        let v0 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::borrow_mut_table<0x1::type_name::TypeName, PoolBalanceSheet>(&mut arg0.pool_balance_sheets, 0x1::type_name::get<T0>());
        let v1 = 0x2::balance::value<PoolLpCoin<T0>>(&arg1);
        let v2 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::u64::mul_div(v1, v0.balance + v0.debt_amount - v0.accrued_amount, v0.pool_lp_coin_supply);
        v0.balance = v0.balance - v2;
        v0.pool_lp_coin_supply = v0.pool_lp_coin_supply - v1;
        assert!(v0.balance >= v0.accrued_amount, 6000);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_supply_bag::sub_coin_supply<PoolLpCoin<T0>>(&mut arg0.pool_lp_coin_supplies, arg1);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::debit_coin_balance<T0>(&mut arg0.pool_balances, v2)
    }

    public(friend) fun create_pool_lp_coin<T0>(arg0: &mut Pool) {
        let v0 = PoolLpCoin<T0>{dummy_field: false};
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_supply_bag::init_coin_supply<PoolLpCoin<T0>>(v0, &mut arg0.pool_lp_coin_supplies);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::init_coin_balance<T0>(&mut arg0.pool_balances);
        let v1 = PoolBalanceSheet{
            balance             : 0,
            debt_amount         : 0,
            accrued_amount      : 0,
            pool_lp_coin_supply : 0,
        };
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::add_key_value_pair<0x1::type_name::TypeName, PoolBalanceSheet>(&mut arg0.pool_balance_sheets, 0x1::type_name::get<T0>(), v1);
    }

    public fun get_pool_balance_sheet_asset_types(arg0: &Pool) : vector<0x1::type_name::TypeName> {
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::get_keys<0x1::type_name::TypeName, PoolBalanceSheet>(&arg0.pool_balance_sheets)
    }

    public fun get_pool_balance_sheets(arg0: &Pool) : &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::TableKeys<0x1::type_name::TypeName, PoolBalanceSheet> {
        &arg0.pool_balance_sheets
    }

    public fun get_pool_balances(arg0: &Pool) : &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::CoinBalanceBag {
        &arg0.pool_balances
    }

    public fun get_pool_lp_coin_supplies(arg0: &Pool) : &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_supply_bag::CoinSupplyBag {
        &arg0.pool_lp_coin_supplies
    }

    public fun get_pool_utilization_rate(arg0: &Pool, arg1: 0x1::type_name::TypeName) : 0x1::fixed_point32::FixedPoint32 {
        let PoolBalanceSheet {
            balance             : v0,
            debt_amount         : v1,
            accrued_amount      : v2,
            pool_lp_coin_supply : _,
        } = *0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::borrow_table<0x1::type_name::TypeName, PoolBalanceSheet>(&arg0.pool_balance_sheets, arg1);
        if (v1 > 0) {
            return 0x1::fixed_point32::create_from_rational(v1, v1 + v0 - v2)
        };
        0x1::fixed_point32::create_from_rational(0, 1)
    }

    public(friend) fun increase_pool_debt_amount(arg0: &mut Pool, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32, arg3: 0x1::fixed_point32::FixedPoint32) {
        let v0 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::borrow_mut_table<0x1::type_name::TypeName, PoolBalanceSheet>(&mut arg0.pool_balance_sheets, arg1);
        v0.debt_amount = v0.debt_amount + 0x1::fixed_point32::multiply_u64(v0.debt_amount, arg2);
        v0.accrued_amount = v0.accrued_amount + 0x1::fixed_point32::multiply_u64(v0.accrued_amount, arg3);
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : Pool {
        Pool{
            id                    : 0x2::object::new(arg0),
            pool_lp_coin_supplies : 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_supply_bag::new(arg0),
            pool_balances         : 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::new(arg0),
            pool_balance_sheets   : 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::new<0x1::type_name::TypeName, PoolBalanceSheet>(arg0),
        }
    }

    public(friend) fun mint_pool_lp_coin<T0>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<PoolLpCoin<T0>> {
        let v0 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::borrow_mut_table<0x1::type_name::TypeName, PoolBalanceSheet>(&mut arg0.pool_balance_sheets, 0x1::type_name::get<T0>());
        let v1 = 0x2::balance::value<T0>(&arg1);
        let v2 = if (v0.pool_lp_coin_supply > 0) {
            0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::u64::mul_div(v1, v0.pool_lp_coin_supply, v0.balance + v0.debt_amount - v0.accrued_amount)
        } else {
            v1
        };
        assert!(v2 > 0, 6001);
        v0.balance = v0.balance + v1;
        v0.pool_lp_coin_supply = v0.pool_lp_coin_supply + v2;
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::credit_coin_balance<T0>(&mut arg0.pool_balances, arg1);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_supply_bag::add_coin_supply<PoolLpCoin<T0>>(&mut arg0.pool_lp_coin_supplies, v2)
    }

    public(friend) fun repay_pool_debt<T0>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::borrow_mut_table<0x1::type_name::TypeName, PoolBalanceSheet>(&mut arg0.pool_balance_sheets, 0x1::type_name::get<T0>());
        let v1 = 0x2::balance::value<T0>(&arg1);
        if (v0.debt_amount >= v1) {
            v0.debt_amount = v0.debt_amount - v1;
        } else {
            v0.accrued_amount = v0.accrued_amount + v1 - v0.debt_amount;
            v0.debt_amount = 0;
        };
        v0.balance = v0.balance + v1;
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::credit_coin_balance<T0>(&mut arg0.pool_balances, arg1);
    }

    public(friend) fun withdraw_accrued_amount<T0>(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::table_keys::borrow_mut_table<0x1::type_name::TypeName, PoolBalanceSheet>(&mut arg0.pool_balance_sheets, 0x1::type_name::get<T0>());
        let v1 = 0x2::math::min(v0.accrued_amount, arg1);
        v0.balance = v0.balance - v1;
        v0.accrued_amount = v0.accrued_amount - v1;
        0x2::coin::from_balance<T0>(0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::coin_balance_bag::debit_coin_balance<T0>(&mut arg0.pool_balances, v1), arg2)
    }

    // decompiled from Move bytecode v6
}

