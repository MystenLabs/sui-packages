module 0x8faabeeaa490ffb3c5ec3033f90ffcc480f4c10704cd736f18352f7dc3fc5d93::zitty {
    struct ZITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZITTY>(arg0, 6, b"ZITTY", b"ZITTY ON SUI", b"Zitty ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6176_6a24b017b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

