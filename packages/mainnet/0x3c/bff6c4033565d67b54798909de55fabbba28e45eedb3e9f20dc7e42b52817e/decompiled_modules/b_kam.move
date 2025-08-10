module 0x3cbff6c4033565d67b54798909de55fabbba28e45eedb3e9f20dc7e42b52817e::b_kam {
    struct B_KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KAM>(arg0, 9, b"bKAM", b"bToken KAM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

