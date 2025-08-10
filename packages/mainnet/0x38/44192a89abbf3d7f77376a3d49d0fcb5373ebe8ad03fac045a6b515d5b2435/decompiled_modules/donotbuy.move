module 0x3844192a89abbf3d7f77376a3d49d0fcb5373ebe8ad03fac045a6b515d5b2435::donotbuy {
    struct DONOTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONOTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONOTBUY>(arg0, 6, b"DONOTBUY", b"DontBuy", b"Buy buy hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigsj35alfjirsahlny6jropcraghpsywpnrza7ou7eso7aep6metu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONOTBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONOTBUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

