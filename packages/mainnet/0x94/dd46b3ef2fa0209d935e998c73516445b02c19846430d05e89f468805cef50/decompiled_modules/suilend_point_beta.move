module 0x94dd46b3ef2fa0209d935e998c73516445b02c19846430d05e89f468805cef50::suilend_point_beta {
    struct SUILEND_POINT_BETA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILEND_POINT_BETA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILEND_POINT_BETA>>(0x2::coin::mint<SUILEND_POINT_BETA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUILEND_POINT_BETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEND_POINT_BETA>(arg0, 6, b"POINT", b"Suilend Points", b"Suilend Points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/suilend_points.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILEND_POINT_BETA>>(0x2::coin::mint<SUILEND_POINT_BETA>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEND_POINT_BETA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEND_POINT_BETA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

