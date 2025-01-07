module 0x25dec9e06a443e03c070f694f133725a34362efb0c5fda7140ef02105cbb1de3::transfer_proxy {
    public entry fun transfer<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

