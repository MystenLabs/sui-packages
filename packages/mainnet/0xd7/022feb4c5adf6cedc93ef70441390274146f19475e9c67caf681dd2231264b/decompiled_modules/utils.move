module 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::utils {
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

