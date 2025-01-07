module 0x3b65ce51324b68e2ea54d1d7ac3fa98aa45f2a7329207b2f52bed34e1a2d4906::sgrok {
    struct SGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGROK>(arg0, 6, b"SGROK", b"SUI GROK", x"53756947726f6b2020697320696e7370697265642062792061206f6e6365206972726570617261626c6520726f626f742074686174207761732072657669766564207468726f75676820616476616e63656420414920616e64206d65646963616c206578706572746973650a0a68747470733a2f2f73756967726f6b2e6f6e6c696e652f0a68747470733a2f2f782e636f6d2f53756947726f6b5f5375690a68747470733a2f2f742e6d652f53756947726f6b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3603_45405f6d70.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

