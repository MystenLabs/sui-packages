module 0x588fcae753d9ab4fa4ea70cf67414b2c135822a14cf2e9fcf62154c2ee647cae::zitty {
    struct ZITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZITTY>(arg0, 6, b"ZITTY", b"ZITTYS", b"Zitty Sui Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6176_a73cd34657.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

