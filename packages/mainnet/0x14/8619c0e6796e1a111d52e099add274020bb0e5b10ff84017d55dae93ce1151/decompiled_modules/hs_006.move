module 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::hs_006 {
    struct HS_006 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HS_006, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HS_006>(arg0, 0, b"HS006", b"m1n3 HashShare 000", b"Per-round tokenized mining share, slot 006", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HS_006>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HS_006>>(v0);
    }

    // decompiled from Move bytecode v6
}

