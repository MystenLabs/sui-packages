module 0x83f7eb15fb94850c6169fef332fa6cbdcc7ddb609d84c7c0ae1eb303f1e88bb2::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0xac928205d73d8a9de7d8aba63d9df263abd429855f71a7a9cc02d732102d985a::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0xac928205d73d8a9de7d8aba63d9df263abd429855f71a7a9cc02d732102d985a::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0xac928205d73d8a9de7d8aba63d9df263abd429855f71a7a9cc02d732102d985a::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

