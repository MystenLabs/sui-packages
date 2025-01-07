module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool {
    struct Scale has drop {
        dummy_field: bool,
    }

    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store {
        vault_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        vault_balance: 0x2::balance::Balance<T1>,
        profit_balance: 0x2::balance::Balance<T1>,
        insurance_balance: 0x2::balance::Balance<T1>,
        spread_profit: 0x2::balance::Balance<T1>,
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 501);
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.vault_balance, v0);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.vault_supply, 0x2::balance::value<T1>(&v0)), arg2)
    }

    public fun create_pool<T0: drop, T1>(arg0: T0, arg1: &0x2::coin::Coin<T1>) : Pool<T0, T1> {
        let v0 = LSP<T0, T1>{dummy_field: false};
        Pool<T0, T1>{
            vault_supply      : 0x2::balance::create_supply<LSP<T0, T1>>(v0),
            vault_balance     : 0x2::balance::zero<T1>(),
            profit_balance    : 0x2::balance::zero<T1>(),
            insurance_balance : 0x2::balance::zero<T1>(),
            spread_profit     : 0x2::balance::zero<T1>(),
        }
    }

    public fun create_pool_<T0>(arg0: &0x2::coin::Coin<T0>) : Pool<Scale, T0> {
        let v0 = Scale{dummy_field: false};
        create_pool<Scale, T0>(v0, arg0)
    }

    public fun get_insurance_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.insurance_balance)
    }

    public fun get_profit_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.profit_balance)
    }

    public fun get_spread_profit<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.spread_profit)
    }

    public fun get_vault_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.vault_balance)
    }

    public fun get_vault_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<LSP<T0, T1>>(&arg0.vault_supply)
    }

    public(friend) fun join_insurance_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.insurance_balance, arg1);
    }

    public(friend) fun join_profit_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.vault_supply);
        let v1 = 0x2::balance::join<T1>(&mut arg0.vault_balance, arg1);
        if (v1 > v0) {
            0x2::balance::join<T1>(&mut arg0.profit_balance, 0x2::balance::split<T1>(&mut arg0.vault_balance, v1 - v0));
        };
    }

    public(friend) fun join_spread_profit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.spread_profit, arg1);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<LSP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::balance::value<LSP<T0, T1>>(&arg1);
        assert!(v0 > 0, 501);
        0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg0.vault_supply, arg1);
        0x2::coin::take<T1>(&mut arg0.vault_balance, v0, arg2)
    }

    public(friend) fun split_insurance_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.insurance_balance, arg1)
    }

    public(friend) fun split_profit_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T1>(&mut arg0.profit_balance);
        if (v0 >= arg1) {
            return 0x2::balance::split<T1>(&mut arg0.profit_balance, arg1)
        };
        let v1 = 0x2::balance::split<T1>(&mut arg0.profit_balance, v0);
        0x2::balance::join<T1>(&mut v1, 0x2::balance::split<T1>(&mut arg0.vault_balance, arg1 - 0x2::balance::value<T1>(&v1)));
        v1
    }

    public(friend) fun split_spread_profit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.spread_profit, arg1)
    }

    // decompiled from Move bytecode v6
}

