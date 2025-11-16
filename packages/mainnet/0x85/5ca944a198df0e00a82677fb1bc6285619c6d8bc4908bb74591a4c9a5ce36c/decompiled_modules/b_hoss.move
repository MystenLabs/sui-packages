module 0x855ca944a198df0e00a82677fb1bc6285619c6d8bc4908bb74591a4c9a5ce36c::b_hoss {
    struct B_HOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HOSS>(arg0, 9, b"bHoss", b"bToken Hoss", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

