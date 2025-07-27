module 0x655b2c03b52fe3ee157b44e538943bb5af38e7188502c7cc056a2d742ca08923::b_blze {
    struct B_BLZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BLZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BLZE>(arg0, 9, b"bBLZE", b"bToken BLZE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BLZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BLZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

