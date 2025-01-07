module 0x97d2a76efce8e7cdf55b781bd3d23382237fb1d095f9b9cad0bf1fd5f7176b62::suilend_point_2 {
    struct SUILEND_POINT_2 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILEND_POINT_2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILEND_POINT_2>>(0x2::coin::mint<SUILEND_POINT_2>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUILEND_POINT_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEND_POINT_2>(arg0, 6, b"POINT2", b"Suilend Points 2", b"Suilend Points Season 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/suilend_points_2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEND_POINT_2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEND_POINT_2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

