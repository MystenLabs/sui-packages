module 0xa1febc85f3fe534be21e66d4491d686f0ec74c1c1fa055e73700da03b28fd2da::myst {
    struct MYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYST>(arg0, 6, b"MYST", b"Myst Privacy", x"456d706f776572696e67205072697661637920776974682054686520507265636973696f6e204f662041492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736129371159.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

