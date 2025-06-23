module 0xc68fef0b9383fc75af6a116300ed7a332e2048fdd2aceb92cdf443bd14d96e42::monk {
    struct MONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONK>(arg0, 6, b"MONK", b"SuiMonk", b"Be a luckymonk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifonobfudjjb6lmjf27apclwymrtzd64jvsqeziiuswryrr4jpfdu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

