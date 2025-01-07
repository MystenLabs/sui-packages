module 0xf762e571300d8d58fd53e8aae2070e03c0a94f6c26421ef48d87aed2628159d7::vai {
    struct VAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAI>(arg0, 6, b"VAI", b"VapeAi ", b"Where Clouds Meet Code.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733052031808.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

