module 0x2147c48dc62e119d87a3e8ad6dbbb8a930ca9a5e81420e762b0597c37bffffaa::gfd {
    struct GFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFD>(arg0, 6, b"GFD", b"dfgdfgdf", b"sdfdsdfsdfsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr3vmvte3fso3em65fsfra2fvzl4a7x3boabz63uluh3tgyhb6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GFD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

