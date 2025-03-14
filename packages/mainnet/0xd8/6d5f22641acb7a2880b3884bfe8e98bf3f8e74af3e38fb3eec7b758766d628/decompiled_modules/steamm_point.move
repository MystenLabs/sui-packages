module 0xd86d5f22641acb7a2880b3884bfe8e98bf3f8e74af3e38fb3eec7b758766d628::steamm_point {
    struct STEAMM_POINT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STEAMM_POINT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STEAMM_POINT>>(0x2::coin::mint<STEAMM_POINT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STEAMM_POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_POINT>(arg0, 6, b"POINT", b"STEAMM Points", b"STEAMM Points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM%20Points.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STEAMM_POINT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_POINT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

