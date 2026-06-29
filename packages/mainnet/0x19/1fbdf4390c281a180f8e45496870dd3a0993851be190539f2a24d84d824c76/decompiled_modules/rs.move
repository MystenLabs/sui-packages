module 0x191fbdf4390c281a180f8e45496870dd3a0993851be190539f2a24d84d824c76::rs {
    public fun swp<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

