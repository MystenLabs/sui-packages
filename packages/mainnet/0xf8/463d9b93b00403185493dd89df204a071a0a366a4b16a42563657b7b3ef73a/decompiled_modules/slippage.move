module 0xf8463d9b93b00403185493dd89df204a071a0a366a4b16a42563657b7b3ef73a::slippage {
    public fun verify<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 42);
    }

    // decompiled from Move bytecode v6
}

