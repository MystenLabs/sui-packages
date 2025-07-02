module 0x912e20ca16fe441b513dc79f7e7c94ff469958b7305da6bae7c199121508b628::b_mal {
    struct B_MAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MAL>(arg0, 9, b"bMAL", b"bToken MAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

