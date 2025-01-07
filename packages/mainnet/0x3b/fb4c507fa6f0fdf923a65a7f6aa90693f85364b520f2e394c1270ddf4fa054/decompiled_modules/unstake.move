module 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::unstake {
    public fun unstake<T0>(arg0: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg1: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::StakeReceiptWithPoints, arg2: u64, arg3: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg4: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg3);
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::unstake<T0>(arg0, arg1, arg2, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

