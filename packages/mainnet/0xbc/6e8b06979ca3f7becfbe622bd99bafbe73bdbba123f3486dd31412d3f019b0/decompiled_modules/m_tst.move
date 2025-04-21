module 0xbc6e8b06979ca3f7becfbe622bd99bafbe73bdbba123f3486dd31412d3f019b0::m_tst {
    struct M_TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_TST>(arg0, 9, b"mTST", b"MITEST", b"MiTEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/image.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_TST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_TST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

