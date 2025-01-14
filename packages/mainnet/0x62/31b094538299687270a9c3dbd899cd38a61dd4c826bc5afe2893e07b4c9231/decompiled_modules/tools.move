module 0x6231b094538299687270a9c3dbd899cd38a61dd4c826bc5afe2893e07b4c9231::tools {
    public fun finalize<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) < arg1) {
            abort 1
        };
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg2 != v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
        };
    }

    // decompiled from Move bytecode v6
}

