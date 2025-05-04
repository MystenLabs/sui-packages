module 0xf6b02a67d12c00877b3bea29e3be53946fa43561dbd3c60467973622b0d19ff7::b_sbtc {
    struct B_SBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SBTC>(arg0, 9, b"bSBTC", b"bToken SBTC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

