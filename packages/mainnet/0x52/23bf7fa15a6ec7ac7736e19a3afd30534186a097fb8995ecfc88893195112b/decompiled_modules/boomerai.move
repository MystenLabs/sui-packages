module 0x5223bf7fa15a6ec7ac7736e19a3afd30534186a097fb8995ecfc88893195112b::boomerai {
    struct BOOMERAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOMERAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOMERAI>(arg0, 6, b"BOOMERAI", b"Boomercoin AI", b"Boomercoin AI: Old-School Wisdom, New-Age Gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/898788888_1_2_e4787c6fed.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOMERAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOMERAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

