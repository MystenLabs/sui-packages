module 0x316cf7702bc3b30213f7f13d60ab237c08694ace24b9453414104a21c80dbbb1::elotru {
    struct ELOTRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELOTRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELOTRU>(arg0, 6, b"EloTru", b"ElonTrump", b"Elon Musk & Donald Trump Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731237275562.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELOTRU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELOTRU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

