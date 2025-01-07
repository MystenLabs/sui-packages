module 0x8ae12f5683c266abc4df15657f1388b45bc6ce5685c5ef4a2c57e39bc669a190::suirb {
    struct SUIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRB>(arg0, 6, b"SUIRB", b"SUIRB SUI", b"Suirb Sui Play Game And Chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6778_329616e818.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

