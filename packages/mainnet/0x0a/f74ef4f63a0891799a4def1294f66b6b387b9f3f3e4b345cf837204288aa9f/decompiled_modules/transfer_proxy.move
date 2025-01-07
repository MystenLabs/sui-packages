module 0xaf74ef4f63a0891799a4def1294f66b6b387b9f3f3e4b345cf837204288aa9f::transfer_proxy {
    fun transfer<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

