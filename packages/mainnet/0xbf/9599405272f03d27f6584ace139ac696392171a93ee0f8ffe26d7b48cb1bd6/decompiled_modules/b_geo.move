module 0xbf9599405272f03d27f6584ace139ac696392171a93ee0f8ffe26d7b48cb1bd6::b_geo {
    struct B_GEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GEO>(arg0, 9, b"bGEO", b"bToken GEO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

