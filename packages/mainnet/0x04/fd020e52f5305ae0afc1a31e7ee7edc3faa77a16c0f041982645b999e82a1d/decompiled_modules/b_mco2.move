module 0x4fd020e52f5305ae0afc1a31e7ee7edc3faa77a16c0f041982645b999e82a1d::b_mco2 {
    struct B_MCO2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MCO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MCO2>(arg0, 9, b"bMCO2", b"bToken MCO2", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MCO2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MCO2>>(v1);
    }

    // decompiled from Move bytecode v6
}

