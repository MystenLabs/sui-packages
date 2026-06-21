module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hs_005 {
    struct HS_005 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HS_005, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HS_005>(arg0, 0, b"HS005", b"m1n3 HashShare 000", b"Per-round tokenized mining share, slot 005", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HS_005>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HS_005>>(v0);
    }

    // decompiled from Move bytecode v7
}

