module 0x159cf056af7d14e0f6ea4fb9963124051076ad865749ab8d10878b49eb441822::nonnonnoncoin {
    struct NONNONNONCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONNONNONCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742463830613.png"));
        let (v1, v2) = 0x2::coin::create_currency<NONNONNONCOIN>(arg0, 6, b"NONNONNON_COIN", b"NONNONNON_COIN", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONNONNONCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONNONNONCOIN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<NONNONNONCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NONNONNONCOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

