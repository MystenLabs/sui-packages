module 0x21d974b50d2b8dabf127e1f3269a4d70a021eafc96125ed6ac00c8660a22bca8::b_text {
    struct B_TEXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEXT>(arg0, 9, b"bTEXT", b"bToken TEXT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

