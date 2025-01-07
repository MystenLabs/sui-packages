module 0xe04fd5987beee5ef0f0d3b39aa57b44bb9ac61df23c0608ed5db3008f0358f9::blep {
    struct BLEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEP>(arg0, 6, b"BLEP", b"BLEP SUI", x"546865726573204e6f205375627374697475746520666f722024626c65702e204865732061204c6974746c6520576569726420596561202e2042757420486573204261736564204173662e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6662_b587c8b242.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

