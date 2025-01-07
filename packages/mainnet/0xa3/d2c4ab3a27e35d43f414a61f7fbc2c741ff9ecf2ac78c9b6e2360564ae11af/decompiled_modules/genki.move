module 0xa3d2c4ab3a27e35d43f414a61f7fbc2c741ff9ecf2ac78c9b6e2360564ae11af::genki {
    struct GENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENKI>(arg0, 6, b"Genki", b"Genki sui", b"Genki brother of Pochita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2730_03e9a713c0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

