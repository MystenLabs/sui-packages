module 0x22faf0f671a6ed5035a3d9e70a06d532e05106187057e14fc6667854360ec50a::swap {
    struct SwapResult has copy, drop {
        mmt_balance_sui: u64,
        mmt_balance_usdc: u64,
    }

    public fun test_swap(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : SwapResult {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, true, true, 100000000000, 0, arg2, arg1, arg3);
        let v3 = v1;
        let v4 = v0;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v2, v4, v3, arg1, arg3);
        let v5 = SwapResult{
            mmt_balance_sui  : 0x2::balance::value<0x2::sui::SUI>(&v4),
            mmt_balance_usdc : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3),
        };
        0x2::event::emit<SwapResult>(v5);
        v5
    }

    // decompiled from Move bytecode v6
}

