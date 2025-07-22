module 0x4537ee70377a84a9bd9463fd49ec7879a1206c78653024d8153e1d8dbe3e08f5::b_bcctoo {
    struct B_BCCTOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BCCTOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BCCTOO>(arg0, 9, b"bBCCTOO", b"bToken BCCTOO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BCCTOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BCCTOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

