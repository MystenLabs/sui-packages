module 0xf5ab52d74a0ae2f6fc6e4ef7895f8509b1c43bd4b774b698bf36a8684dd28bea::goldenegg {
    struct GOLDENEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDENEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENEGG>(arg0, 6, b"GoldenEgg", b"SuiteGoldGoose", b"Finally un unlimmited supply of gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goose2_48a29c5535.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDENEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

