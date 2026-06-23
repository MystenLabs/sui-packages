module 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::hs_003 {
    struct HS_003 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HS_003, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HS_003>(arg0, 0, b"HS003", b"m1n3 HashShare 000", b"Per-round tokenized mining share, slot 003", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HS_003>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HS_003>>(v0);
    }

    // decompiled from Move bytecode v6
}

