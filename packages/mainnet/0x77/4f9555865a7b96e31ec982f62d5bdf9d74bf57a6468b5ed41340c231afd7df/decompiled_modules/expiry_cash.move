module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::expiry_cash {
    struct ExpiryCash has store {
        cash_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        inventory_impact_reserve: u64,
    }

    public(friend) fun balance(arg0: &ExpiryCash) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.cash_balance)
    }

    public(friend) fun assert_backing(arg0: &ExpiryCash, arg1: u64) {
        assert!(balance(arg0) >= required_cash(arg0, arg1), 0);
    }

    public(friend) fun credit_inventory_impact_reserve(arg0: &mut ExpiryCash, arg1: u64) {
        arg0.inventory_impact_reserve = arg0.inventory_impact_reserve + arg1;
    }

    public(friend) fun free_cash(arg0: &ExpiryCash) : u64 {
        0x1::u64::saturating_sub(balance(arg0), arg0.inventory_impact_reserve)
    }

    public(friend) fun inventory_impact_reserve(arg0: &ExpiryCash) : u64 {
        arg0.inventory_impact_reserve
    }

    public(friend) fun new() : ExpiryCash {
        ExpiryCash{
            cash_balance             : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            inventory_impact_reserve : 0,
        }
    }

    public(friend) fun pay_authorized(arg0: &mut ExpiryCash, arg1: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(balance(arg0) >= arg1, 0);
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.cash_balance, arg1)
    }

    public(friend) fun pay_inventory_impact_rebate(arg0: &mut ExpiryCash, arg1: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg1 <= arg0.inventory_impact_reserve, 1);
        arg0.inventory_impact_reserve = arg0.inventory_impact_reserve - arg1;
        pay_authorized(arg0, arg1)
    }

    public(friend) fun receive(arg0: &mut ExpiryCash, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.cash_balance, arg1);
    }

    public(friend) fun release_inventory_impact_reserve(arg0: &mut ExpiryCash) {
        arg0.inventory_impact_reserve = 0;
    }

    public(friend) fun release_surplus(arg0: &mut ExpiryCash, arg1: u64, arg2: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        if (arg1 == 0) {
            return 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        assert!(balance(arg0) >= required_cash(arg0, arg2) + arg1, 0);
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.cash_balance, arg1)
    }

    public(friend) fun required_cash(arg0: &ExpiryCash, arg1: u64) : u64 {
        arg1 + arg0.inventory_impact_reserve
    }

    // decompiled from Move bytecode v7
}

