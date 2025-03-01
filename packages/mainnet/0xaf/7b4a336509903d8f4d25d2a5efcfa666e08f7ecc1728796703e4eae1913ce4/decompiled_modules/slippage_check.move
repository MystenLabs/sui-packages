module 0xaf7b4a336509903d8f4d25d2a5efcfa666e08f7ecc1728796703e4eae1913ce4::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

