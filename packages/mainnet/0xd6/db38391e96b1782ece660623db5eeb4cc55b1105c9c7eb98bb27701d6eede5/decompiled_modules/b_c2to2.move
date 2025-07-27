module 0xd6db38391e96b1782ece660623db5eeb4cc55b1105c9c7eb98bb27701d6eede5::b_c2to2 {
    struct B_C2TO2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_C2TO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_C2TO2>(arg0, 9, b"bC2TO2", b"bToken C2TO2", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_C2TO2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_C2TO2>>(v1);
    }

    // decompiled from Move bytecode v6
}

