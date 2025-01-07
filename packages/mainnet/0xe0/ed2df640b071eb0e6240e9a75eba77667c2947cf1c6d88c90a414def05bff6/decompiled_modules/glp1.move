module 0xe0ed2df640b071eb0e6240e9a75eba77667c2947cf1c6d88c90a414def05bff6::glp1 {
    struct GLP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLP1>(arg0, 6, b"GLP1", b"GLP-1", b"GLP-1 is a hormone your body produces. GLP-1 supports a healthier, learner you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5072_4d198b7502.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLP1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLP1>>(v1);
    }

    // decompiled from Move bytecode v6
}

