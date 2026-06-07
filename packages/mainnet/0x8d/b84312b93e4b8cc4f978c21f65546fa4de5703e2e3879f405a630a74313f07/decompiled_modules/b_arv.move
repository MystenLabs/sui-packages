module 0x8db84312b93e4b8cc4f978c21f65546fa4de5703e2e3879f405a630a74313f07::b_arv {
    struct B_ARV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ARV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ARV>(arg0, 9, b"bARV", b"bToken ARV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ARV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ARV>>(v1);
    }

    // decompiled from Move bytecode v6
}

