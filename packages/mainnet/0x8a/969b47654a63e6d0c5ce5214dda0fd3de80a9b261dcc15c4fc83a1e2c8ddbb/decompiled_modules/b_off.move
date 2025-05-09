module 0x8a969b47654a63e6d0c5ce5214dda0fd3de80a9b261dcc15c4fc83a1e2c8ddbb::b_off {
    struct B_OFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OFF>(arg0, 9, b"bOFF", b"bToken OFF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

