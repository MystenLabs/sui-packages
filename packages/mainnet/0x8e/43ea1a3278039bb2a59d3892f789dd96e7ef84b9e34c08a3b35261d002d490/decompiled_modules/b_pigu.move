module 0x8e43ea1a3278039bb2a59d3892f789dd96e7ef84b9e34c08a3b35261d002d490::b_pigu {
    struct B_PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PIGU>(arg0, 9, b"bPIGU", b"bToken PIGU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PIGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

