module 0x8980aae0839e642fd72a428ceb1b17b2053592f4f079b3f20b68443edaa30437::eviliq {
    struct EVILIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVILIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EVILIQ>(arg0, 6, b"EVILIQ", b"Evil", b"@suilaunchcoin $EVILIQ + Evil Liquor https://t.co/1eT4O5dIYg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/eviliq-y3oglu.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVILIQ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVILIQ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

