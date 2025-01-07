module 0xd4ef1e788a6d791852ec508b96f7799c63ab86328e78fc850a7ffb6183ca6a02::odom {
    struct ODOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODOM>(arg0, 6, b"ODOM", b"operation dick on mars", b"the $ODOM movement and help Richard Dickie Musk teach his cocky, arrogant half brother whos the best of the Musks once and for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241230_191649_955_b0479e399d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

