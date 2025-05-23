module 0x67ef74448e68eaf081f74d528989d1cff5c1ac33e5352515eab464b2f5f04432::b_tulalit {
    struct B_TULALIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TULALIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TULALIT>(arg0, 9, b"bTULALIT", b"bToken TULALIT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TULALIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TULALIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

