module 0x1c79059e2303fc915063c3602527b61d8ed610e1d3e79665024601aa8af63aa3::slippage {
    public fun check_slippage<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    public fun m_round_down(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

