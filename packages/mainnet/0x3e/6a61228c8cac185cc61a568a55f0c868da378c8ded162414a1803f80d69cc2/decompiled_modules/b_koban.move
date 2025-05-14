module 0x3e6a61228c8cac185cc61a568a55f0c868da378c8ded162414a1803f80d69cc2::b_koban {
    struct B_KOBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KOBAN>(arg0, 9, b"bKOBAN", b"bToken KOBAN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KOBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KOBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

