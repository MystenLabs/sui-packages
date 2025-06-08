module 0x6f1a4ca5c433577ce97850abd3a7e2bd371c6b65244313accfda05ca00784b3c::b_temp22 {
    struct B_TEMP22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEMP22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEMP22>(arg0, 9, b"bTEMP22", b"bToken TEMP22", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEMP22>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEMP22>>(v1);
    }

    // decompiled from Move bytecode v6
}

