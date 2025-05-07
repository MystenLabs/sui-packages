module 0x7f59d1ea93d74836c5114f80fb092378781ee2e75bac8ac949de4bb2e9fd986b::b__cone {
    struct B__CONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B__CONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B__CONE>(arg0, 9, b"b$CONE", b"bToken $CONE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B__CONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B__CONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

