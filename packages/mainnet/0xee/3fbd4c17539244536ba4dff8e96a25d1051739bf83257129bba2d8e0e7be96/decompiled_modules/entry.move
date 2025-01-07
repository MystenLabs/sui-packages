module 0xee3fbd4c17539244536ba4dff8e96a25d1051739bf83257129bba2d8e0e7be96::entry {
    entry fun entry_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public entry fun public_entry_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

