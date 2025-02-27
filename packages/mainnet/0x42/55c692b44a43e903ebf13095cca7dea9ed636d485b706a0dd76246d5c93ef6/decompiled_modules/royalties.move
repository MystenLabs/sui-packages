module 0x4255c692b44a43e903ebf13095cca7dea9ed636d485b706a0dd76246d5c93ef6::royalties {
    struct RoyaltiesAdminCap has key {
        id: 0x2::object::UID,
    }

    struct RoyaltiesPool has store, key {
        id: 0x2::object::UID,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    public fun new(arg0: &RoyaltiesAdminCap, arg1: &mut 0x2::tx_context::TxContext) : RoyaltiesPool {
        RoyaltiesPool{
            id           : 0x2::object::new(arg1),
            usdc_balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        }
    }

    public(friend) fun add_to_balance_usdc(arg0: &mut RoyaltiesPool, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltiesAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RoyaltiesAdminCap>(v0);
    }

    public fun withdraw(arg0: &mut RoyaltiesPool, arg1: &RoyaltiesAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance), arg2)
    }

    // decompiled from Move bytecode v6
}

