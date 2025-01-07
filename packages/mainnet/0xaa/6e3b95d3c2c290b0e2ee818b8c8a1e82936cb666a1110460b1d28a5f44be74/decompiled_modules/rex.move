module 0xaa6e3b95d3c2c290b0e2ee818b8c8a1e82936cb666a1110460b1d28a5f44be74::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"Rex", b"Suirex", b"Suivez is cute , fun loving ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730974146026.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

