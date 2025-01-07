module 0x9843a373a1c43bc06368d3746f2182cc30a5f2a7b7fde4a677eb974f7d392cff::transfer_proxy {
    public entry fun transfer<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

