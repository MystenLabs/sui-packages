module 0xf5260159569046df9427029f82b20959d3bc5d8dcdbadb8f2fae223c24a95241::slippage {
    public fun verify<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

