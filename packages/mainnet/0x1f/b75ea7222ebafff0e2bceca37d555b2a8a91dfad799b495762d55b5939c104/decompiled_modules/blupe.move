module 0x1fb75ea7222ebafff0e2bceca37d555b2a8a91dfad799b495762d55b5939c104::blupe {
    struct BLUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPE>(arg0, 6, b"BLUPE", b"BLUE PEPE", x"426c75652070657065206973206b696e67206974732074696d6520666f722061206e6577206572612e0a0a546865207265616c2050657065206f6e207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0294_c0ea9d6864.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

