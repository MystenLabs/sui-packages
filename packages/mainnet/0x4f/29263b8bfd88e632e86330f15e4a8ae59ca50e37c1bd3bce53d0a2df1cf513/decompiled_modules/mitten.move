module 0x4f29263b8bfd88e632e86330f15e4a8ae59ca50e37c1bd3bce53d0a2df1cf513::mitten {
    struct MITTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITTEN>(arg0, 6, b"MITTEN", b"Mitten", b"Welcome to MITTENS Telegrams Cat on SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_200128_dbee22c21c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITTEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MITTEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

