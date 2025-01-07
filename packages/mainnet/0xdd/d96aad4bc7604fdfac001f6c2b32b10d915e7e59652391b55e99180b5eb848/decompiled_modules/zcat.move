module 0xddd96aad4bc7604fdfac001f6c2b32b10d915e7e59652391b55e99180b5eb848::zcat {
    struct ZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZCAT>(arg0, 9, b"ZCAT", b"ZOE CAT", b"ZOE THE CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b407994c-e93c-42bd-a4e7-42f5c9ab8ee9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

