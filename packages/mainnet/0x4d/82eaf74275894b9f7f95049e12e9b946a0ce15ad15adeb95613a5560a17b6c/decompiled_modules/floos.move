module 0x4d82eaf74275894b9f7f95049e12e9b946a0ce15ad15adeb95613a5560a17b6c::floos {
    struct FLOOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOOS>(arg0, 6, b"FLOOS", b"FLOOS SUI", x"464c4f4f532069732061206d656d65636f696e2041696d696e6720746f2070726f6d6f746520417261622063756c747572652070726f7065726c792c20616e64207265647563652063756c747572616c20616e6420636f676e697469766520646966666572656e636573206265747765656e204561737465726e20616e64205765737465726e20636f6d6d756e69746965732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gu_K3_r_TB_400x400_19828a9506.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

