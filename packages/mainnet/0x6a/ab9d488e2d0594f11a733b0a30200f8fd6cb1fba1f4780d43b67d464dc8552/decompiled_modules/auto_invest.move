module 0x6aab9d488e2d0594f11a733b0a30200f8fd6cb1fba1f4780d43b67d464dc8552::auto_invest {
    struct Investment has store, key {
        id: 0x2::object::UID,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        from: address,
        initial_usdc: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun buy(arg0: &mut Config, arg1: &mut Investment, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance_usdc), arg2)
    }

    public fun cancel_investment(arg0: &mut Investment, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.from == 0x2::tx_context::sender(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance_sui), arg1), arg0.from);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance_usdc), arg1), arg0.from);
    }

    public fun create_investment(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v1 = Investment{
            id           : 0x2::object::new(arg1),
            balance_sui  : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_usdc : v0,
            from         : 0x2::tx_context::sender(arg1),
            initial_usdc : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0),
        };
        0x2::transfer::share_object<Investment>(v1);
    }

    public fun fill_buy(arg0: &mut Config, arg1: &mut Investment, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun fill_sell(arg0: &mut Config, arg1: &mut Investment, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance_usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun sell(arg0: &mut Config, arg1: &mut Investment, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance_sui), arg2)
    }

    // decompiled from Move bytecode v6
}

