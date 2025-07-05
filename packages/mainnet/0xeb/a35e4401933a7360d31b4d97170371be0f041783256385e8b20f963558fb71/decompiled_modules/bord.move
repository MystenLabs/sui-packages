module 0xeba35e4401933a7360d31b4d97170371be0f041783256385e8b20f963558fb71::bord {
    struct BORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORD>(arg0, 6, b"BORD", b"Boring Day", b"Just a boring day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicv2txyj5d7ckrgihf3im2k5n264rlcj765tgb6w7g3inp6rdjzje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

