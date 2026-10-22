module 0x46c875d5b8175a2abac2d2a533063807fcdfe268d5d94eac0bde0f9ac4eb848d::k {
    public fun k<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        own(arg2);
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 1);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun c(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        k<0x2::sui::SUI>(arg0, arg1, arg2);
    }

    public fun d(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        k<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2);
    }

    public fun e(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg0 >= arg1 && arg0 <= arg2, 2);
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun r<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg1);
        0x2::balance::redeem_funds<T0>(arg0)
    }

    public fun s(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg1);
        0x2::balance::redeem_funds<0x2::sui::SUI>(arg0)
    }

    public fun u(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        own(arg1);
        0x2::balance::redeem_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0)
    }

    // decompiled from Move bytecode v7
}

