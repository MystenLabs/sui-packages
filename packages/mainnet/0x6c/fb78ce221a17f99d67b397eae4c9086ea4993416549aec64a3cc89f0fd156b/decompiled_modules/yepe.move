module 0x6cfb78ce221a17f99d67b397eae4c9086ea4993416549aec64a3cc89f0fd156b::yepe {
    struct YEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEPE>(arg0, 9, b"YEPE", b"YEPE On Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmT83gJ7x7gzLr3unHTSpG8YQnJrs8TfXyX2fp1CQXmJJ1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

