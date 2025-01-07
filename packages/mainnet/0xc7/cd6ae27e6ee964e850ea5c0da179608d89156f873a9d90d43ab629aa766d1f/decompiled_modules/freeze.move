module 0xc7cd6ae27e6ee964e850ea5c0da179608d89156f873a9d90d43ab629aa766d1f::freeze {
    public entry fun freeze_object<T0>(arg0: 0x2::coin::TreasuryCap<T0>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

