module 0x96787cef8a89da1fa1af5c10b253107c9c9e8b27094688b58e1cf349f6b75824::imn {
    struct IMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IMN>(arg0, 6, b"IMN", b"imnotsure by SuiAI", b"test mint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2567_11_15_19_50_03_0ea8f7ac31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

