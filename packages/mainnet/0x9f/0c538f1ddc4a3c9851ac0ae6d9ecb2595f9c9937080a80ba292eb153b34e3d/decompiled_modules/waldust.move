module 0x9f0c538f1ddc4a3c9851ac0ae6d9ecb2595f9c9937080a80ba292eb153b34e3d::waldust {
    struct WALDUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALDUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALDUST>(arg0, 6, b"WALDUST", b"Walrus Dust", b"First Walrus dust on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waldust_4e5602c3f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALDUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALDUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

