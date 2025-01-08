module 0x5a3ccf01052272e4f60a67ccc3911cc8113b072f692b76a484042b67e2c5835d::ailien {
    struct AILIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AILIEN>(arg0, 6, b"AILIEN", b"Ailien by SuiAI", b"Ailien is a Sui-friendly extraterrestrial moon resident-based cosmic token that bridges the gap between the Moon and Earth by connecting with Earthlings through an AI agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000001470_ceb0fe67ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AILIEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILIEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

