module 0x53e57a8ed45afc2f15f386de2b2c99142dd198635db85ab1bce89bf08901d191::b_spoil {
    struct B_SPOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SPOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SPOIL>(arg0, 9, b"bSPOIL", b"bToken SPOIL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SPOIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SPOIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

