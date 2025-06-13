module 0x49cf300909497632a71e11ec7e56153a02cef1fb5cc4d3e4b4c5842dc508a9f5::b_onebts {
    struct B_ONEBTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ONEBTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ONEBTS>(arg0, 9, b"bONEBTS", b"bToken ONEBTS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ONEBTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ONEBTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

