module 0xc34c6e356a01cc6c2cb8c6aa1e87c0c8cb2969bbbb88c93db91552dfa6d06c8c::laolong1994 {
    struct LAOLONG1994 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAOLONG1994, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAOLONG1994>(arg0, 8, b"LAOLONG1994", b"LAOLONG1994", b"this is laolong1994", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAOLONG1994>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LAOLONG1994>>(v0);
    }

    // decompiled from Move bytecode v6
}

