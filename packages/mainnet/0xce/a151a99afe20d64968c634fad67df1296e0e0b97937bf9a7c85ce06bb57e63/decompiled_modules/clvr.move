module 0xcea151a99afe20d64968c634fad67df1296e0e0b97937bf9a7c85ce06bb57e63::clvr {
    struct CLVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLVR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CLVR>(arg0, 6, b"CLVR", b"Lucky Clover by SuiAI", b"Lucky clover brings good luck to its owner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250108_194001_9199fd7ab2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLVR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLVR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

