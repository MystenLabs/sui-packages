module 0x22b690913707b0e78153df7fd49c6183ea657b4d7fcf5b7ee517406ffacdc112::cfai {
    struct CFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFAI>(arg0, 6, b"CFAI", b"Chicken Frog AI", b"Chicken from AI. \"he who holds will be richer than he who sold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_4ee4f90cf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

