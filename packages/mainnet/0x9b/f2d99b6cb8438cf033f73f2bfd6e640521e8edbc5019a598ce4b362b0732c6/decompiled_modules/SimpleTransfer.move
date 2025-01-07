module 0x9bf2d99b6cb8438cf033f73f2bfd6e640521e8edbc5019a598ce4b362b0732c6::SimpleTransfer {
    public entry fun transfer_object<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

