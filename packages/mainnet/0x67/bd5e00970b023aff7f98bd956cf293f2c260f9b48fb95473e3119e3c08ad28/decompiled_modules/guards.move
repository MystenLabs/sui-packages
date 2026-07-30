module 0x67bd5e00970b023aff7f98bd956cf293f2c260f9b48fb95473e3119e3c08ad28::guards {
    public fun assert_maximum_repayment(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 1);
    }

    public fun assert_minimum_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

