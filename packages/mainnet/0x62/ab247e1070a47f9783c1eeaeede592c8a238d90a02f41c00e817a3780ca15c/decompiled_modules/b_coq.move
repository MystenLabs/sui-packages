module 0x62ab247e1070a47f9783c1eeaeede592c8a238d90a02f41c00e817a3780ca15c::b_coq {
    struct B_COQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_COQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_COQ>(arg0, 9, b"bCOQ", b"bToken COQ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_COQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_COQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

