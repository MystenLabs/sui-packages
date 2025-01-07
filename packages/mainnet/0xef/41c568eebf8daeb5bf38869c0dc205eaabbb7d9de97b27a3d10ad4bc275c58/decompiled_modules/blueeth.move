module 0xef41c568eebf8daeb5bf38869c0dc205eaabbb7d9de97b27a3d10ad4bc275c58::blueeth {
    struct BLUEETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEETH>(arg0, 6, b"Blueeth", b"100 ETH", b"Blue eth on live sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dfgdfgdf_4221bb5a33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

