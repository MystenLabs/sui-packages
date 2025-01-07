module 0x29fe8d09aead494149e1d39152819c62d90587e1cb50fe6ea66d30a769b519a::ghall {
    struct GHALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHALL>(arg0, 6, b"GHALL", x"47686f73742048616c6c6f7765656e20f09f8e83", b"Ghost Halloween $GHAL coming to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730980294548.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

