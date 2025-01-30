module 0xa03182b56173c53a0ea7558316a160536d1968a3ab201a5e833f927d362f3328::gtaguy {
    struct GTAGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTAGUY>(arg0, 9, b"GTAGUY", b"GTA Guy", b"Just a GTA Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXTMgP7rpWXYQMmAQAGpdskHPnkSrZabarMJXqDw3qSUm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GTAGUY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTAGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTAGUY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

