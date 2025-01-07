module 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::stake {
    public fun increase_stake<T0>(arg0: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::StakeReceiptWithPoints, arg3: &0x2::clock::Clock, arg4: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg5: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg4);
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::increase_stake<T0>(arg0, arg1, arg2, arg5, arg3, arg6);
    }

    public fun stake<T0>(arg0: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg4: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::StakeReceiptWithPoints {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg3);
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::stake<T0>(arg0, arg1, arg2, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

