module 0x26320c0877dd180160e75366e06133c66eced446b04f204a2b2aa4bfde9bf1aa::royalties {
    struct RoyaltiesPool has store, key {
        id: 0x2::object::UID,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    public fun new(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : RoyaltiesPool {
        assert!(0x2::package::from_package<RoyaltiesPool>(arg0), 0);
        RoyaltiesPool{
            id           : 0x2::object::new(arg1),
            usdc_balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        }
    }

    public(friend) fun add_to_balance_usdc(arg0: &mut RoyaltiesPool, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, arg1);
    }

    public fun withdraw(arg0: &mut RoyaltiesPool, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x2::package::from_package<RoyaltiesPool>(arg1), 0);
        0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance), arg2)
    }

    // decompiled from Move bytecode v6
}

