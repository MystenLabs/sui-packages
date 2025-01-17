module 0x8dcd0cf45487c59f006cea9cce25d57ad12d664ccfd717753f5cec3ab5f46bd2::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"SniperSearch on Sui by SuiAI", b"A vigilant AI specializing in detecting risks and ensuring blockchain security with cold, data driven precision.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000201207_7116f995a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

