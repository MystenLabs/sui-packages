module 0xdaf4fe869b3691c1c0a69175677ec4329db9202b1ac184fcfdd0b13af3011f47::freezer {
    entry fun freeze_metadata<T0: store + key>(arg0: 0x2::coin::CoinMetadata<T0>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

