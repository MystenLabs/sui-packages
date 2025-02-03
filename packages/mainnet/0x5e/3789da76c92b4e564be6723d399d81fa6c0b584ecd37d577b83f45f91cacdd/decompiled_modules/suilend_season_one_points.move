module 0x9d5c964fda4247e0e191c5856bcdb7c96d19800c82d2a4a6e52740a64bc44625::suilend_season_one_points {
    struct SUILEND_SEASON_ONE_POINTS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILEND_SEASON_ONE_POINTS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILEND_SEASON_ONE_POINTS>>(0x2::coin::mint<SUILEND_SEASON_ONE_POINTS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUILEND_SEASON_ONE_POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEND_SEASON_ONE_POINTS>(arg0, 6, b"SOP", b"Season One Points", b"Suilend Season One Points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/suilend_points.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEND_SEASON_ONE_POINTS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEND_SEASON_ONE_POINTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

