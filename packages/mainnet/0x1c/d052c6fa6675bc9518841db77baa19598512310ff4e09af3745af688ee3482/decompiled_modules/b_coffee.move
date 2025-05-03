module 0x1cd052c6fa6675bc9518841db77baa19598512310ff4e09af3745af688ee3482::b_coffee {
    struct B_COFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_COFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_COFFEE>(arg0, 9, b"bCOFFEE", b"bToken COFFEE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_COFFEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_COFFEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

