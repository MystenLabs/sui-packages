module 0x4ce49f19678080e124db725aa10df6125037dad97dee9cd1ed9a83a11e61136b::toto {
    struct TOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTO>(arg0, 6, b"TOTO", b"TOTODILE", b"Totodile is the most lovely pet in pokeverse, and $TOTO is bringin a good luck in all of his holders. We love $TOTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731910237920.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

