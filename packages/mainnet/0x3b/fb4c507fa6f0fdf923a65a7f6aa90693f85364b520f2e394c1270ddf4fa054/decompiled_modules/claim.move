module 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::claim {
    public fun claim_reward<T0, T1>(arg0: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg1: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::StakeReceiptWithPoints, arg2: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg3: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg2);
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::claim_reward<T0, T1>(arg0, arg1, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

