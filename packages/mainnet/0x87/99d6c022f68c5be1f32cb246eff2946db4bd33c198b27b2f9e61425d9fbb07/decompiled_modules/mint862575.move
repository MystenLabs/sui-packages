module 0x8799d6c022f68c5be1f32cb246eff2946db4bd33c198b27b2f9e61425d9fbb07::mint862575 {
    struct MINT862575 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINT862575, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINT862575>(arg0, 9, b"MINT862575", b"Mintable Token 1759892862575", b"Token for mint testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINT862575>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINT862575>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

