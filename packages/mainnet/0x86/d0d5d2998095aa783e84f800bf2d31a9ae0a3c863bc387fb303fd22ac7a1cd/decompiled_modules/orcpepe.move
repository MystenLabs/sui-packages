module 0x86d0d5d2998095aa783e84f800bf2d31a9ae0a3c863bc387fb303fd22ac7a1cd::orcpepe {
    struct ORCPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCPEPE>(arg0, 6, b"ORCPEPE", b"ORCPEPE GANG ON SUI", x"5468652077696c6465737420667573696f6e206f6e20537569210a0a244f52435045504520636f6d62696e65732074686520627275746520737472656e677468206f6620616e206f72632077697468207468652068756d6f72206f6620506570652c206372656174696e67206120626f6c642c206d656d652d706f776572656420746f6b656e206f6e2074686520537569206e6574776f726b2e2047657420726561647920666f72206570696320626174746c657320616e6420656e646c657373206672696374696f6e732077696620244f52435045504521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cbvxcnxn_d3d461ab4c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

