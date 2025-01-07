module 0x2a094736a1d4e08e71069a65eb5ef9fb6da2f5f0d76679947f8f4499b13af8d0::suilend_point {
    struct SUILEND_POINT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILEND_POINT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILEND_POINT>>(0x2::coin::mint<SUILEND_POINT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUILEND_POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEND_POINT>(arg0, 6, b"POINT", b"Suilend Points", b"Suilend Points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/suilend_points.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEND_POINT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEND_POINT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

