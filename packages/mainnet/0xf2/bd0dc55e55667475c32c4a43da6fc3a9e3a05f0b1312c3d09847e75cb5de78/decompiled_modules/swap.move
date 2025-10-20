module 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::swap {
    struct SwapResult has copy, drop {
        mmt: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::SwapState,
    }

    public fun test_swap(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{mmt: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, true, false, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), 100000000000)};
        0x2::event::emit<SwapResult>(v0);
        v0
    }

    // decompiled from Move bytecode v6
}

