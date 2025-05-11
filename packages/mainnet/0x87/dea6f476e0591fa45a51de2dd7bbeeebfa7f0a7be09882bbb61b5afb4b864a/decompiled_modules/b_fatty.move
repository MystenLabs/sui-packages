module 0x87dea6f476e0591fa45a51de2dd7bbeeebfa7f0a7be09882bbb61b5afb4b864a::b_fatty {
    struct B_FATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FATTY>(arg0, 9, b"bFATTY", b"bToken FATTY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

