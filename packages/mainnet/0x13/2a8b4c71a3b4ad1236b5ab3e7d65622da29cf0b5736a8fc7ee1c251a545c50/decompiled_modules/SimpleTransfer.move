module 0x132a8b4c71a3b4ad1236b5ab3e7d65622da29cf0b5736a8fc7ee1c251a545c50::SimpleTransfer {
    public entry fun transfer_object<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

