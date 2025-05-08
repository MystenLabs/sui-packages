module 0x705611f9716f3e0021c08255c5147b351a75db10f2e1761f25f4c882d00591c8::b_antt {
    struct B_ANTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ANTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ANTT>(arg0, 9, b"bANTT", b"bToken ANTT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ANTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ANTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

