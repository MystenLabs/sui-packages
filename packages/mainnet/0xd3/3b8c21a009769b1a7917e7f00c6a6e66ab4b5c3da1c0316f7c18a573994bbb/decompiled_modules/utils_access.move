module 0xd33b8c21a009769b1a7917e7f00c6a6e66ab4b5c3da1c0316f7c18a573994bbb::utils_access {
    public fun assert_owner(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x381fa7b8c35ef12b989638c01e3d46ab9839736fdc13bff0bff5b4505a907c80, 1);
    }

    public fun assert_pool<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>) {
    }

    // decompiled from Move bytecode v6
}

