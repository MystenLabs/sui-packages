module 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils {
    public fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    // decompiled from Move bytecode v6
}

