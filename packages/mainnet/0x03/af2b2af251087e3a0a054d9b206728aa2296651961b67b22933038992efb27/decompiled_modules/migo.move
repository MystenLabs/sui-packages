module 0x3af2b2af251087e3a0a054d9b206728aa2296651961b67b22933038992efb27::migo {
    struct MIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGO>(arg0, 6, b"Migo", b"Amigos", x"546865206d656d6520636f696e2074686174277320736f206c6169642d6261636b2c20697427732070726163746963616c6c7920686f72697a6f6e74616c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731088014655.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

