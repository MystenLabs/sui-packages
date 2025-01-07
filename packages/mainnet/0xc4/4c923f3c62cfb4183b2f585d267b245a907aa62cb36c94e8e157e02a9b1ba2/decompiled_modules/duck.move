module 0xc44c923f3c62cfb4183b2f585d267b245a907aa62cb36c94e8e157e02a9b1ba2::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"Sui Duck", x"4d65657420537569204455434b2c204475636b20697320666c79696e67206869676820616e6420717561636b696e67206c6f756421205468697320746f6b656e206973206c656164696e672074686520666c6f636b20776974682069747320756e69717565207669626520616e6420636f6d6d756e69747920706f7765722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_52_1_8e55c7ce3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

