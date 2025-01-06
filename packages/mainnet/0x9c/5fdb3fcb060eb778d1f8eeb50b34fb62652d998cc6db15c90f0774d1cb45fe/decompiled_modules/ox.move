module 0x9c5fdb3fcb060eb778d1f8eeb50b34fb62652d998cc6db15c90f0774d1cb45fe::ox {
    struct OX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OX>(arg0, 6, b"OX", b"Oxomars by SuiAI", b"X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4071_7ab1fd906c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

