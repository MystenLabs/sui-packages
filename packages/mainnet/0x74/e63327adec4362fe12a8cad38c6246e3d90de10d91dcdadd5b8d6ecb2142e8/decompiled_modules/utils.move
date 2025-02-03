module 0x74e63327adec4362fe12a8cad38c6246e3d90de10d91dcdadd5b8d6ecb2142e8::utils {
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

