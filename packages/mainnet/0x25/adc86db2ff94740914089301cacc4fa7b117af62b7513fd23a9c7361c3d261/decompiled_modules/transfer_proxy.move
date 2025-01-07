module 0x25adc86db2ff94740914089301cacc4fa7b117af62b7513fd23a9c7361c3d261::transfer_proxy {
    public entry fun transferTreasuryCap<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

