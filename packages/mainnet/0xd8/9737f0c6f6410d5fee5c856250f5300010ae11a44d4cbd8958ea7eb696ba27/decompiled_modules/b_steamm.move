module 0xd89737f0c6f6410d5fee5c856250f5300010ae11a44d4cbd8958ea7eb696ba27::b_steamm {
    struct B_STEAMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM>(arg0, 9, b"bSTEAMM", b"bToken STEAMM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

