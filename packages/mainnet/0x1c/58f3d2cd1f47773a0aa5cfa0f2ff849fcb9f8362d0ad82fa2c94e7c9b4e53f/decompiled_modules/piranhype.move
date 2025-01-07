module 0x1c58f3d2cd1f47773a0aa5cfa0f2ff849fcb9f8362d0ad82fa2c94e7c9b4e53f::piranhype {
    struct PIRANHYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRANHYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRANHYPE>(arg0, 6, b"PIRANHYPE", b"PIRAN HYPEEE", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e0a4a4f494e2054484520485950454545203a20687474703a2f2f742e6d652f706972616e687970656f6e7375690a616e6420636865636b2074686973206f7574203a200a68747470733a2f2f782e636f6d2f706972616e687970652f7374617475732f313836323039343236303131333437333735363f733d3436", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9655_00e774cfe5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRANHYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRANHYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

