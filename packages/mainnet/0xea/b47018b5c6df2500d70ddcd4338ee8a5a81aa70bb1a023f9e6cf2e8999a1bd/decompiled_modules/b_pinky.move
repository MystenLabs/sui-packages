module 0xeab47018b5c6df2500d70ddcd4338ee8a5a81aa70bb1a023f9e6cf2e8999a1bd::b_pinky {
    struct B_PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PINKY>(arg0, 9, b"bPINKY", b"bToken PINKY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

