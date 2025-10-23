module 0xa4be6d557995cef069ca0c924cda835d0dac9da839a7fa7d3b42d609dc3e86bb::b_maya {
    struct B_MAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MAYA>(arg0, 9, b"bMAYA", b"bToken MAYA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MAYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

