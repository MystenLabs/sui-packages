module 0x5e3ba9ca2281946e4bfd5711e3ba52c1f073b05f650e7f7b3f89fd26a0ccd7ee::slt {
    struct SLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLT>(arg0, 6, b"SLT", b"SUILITTT", x"41206b696477697468207269707065642070616e747320616e642073686f77206f66662074686520626f74746f6d0a496e206d7920636f756e747279206974732063616c6c6564202253494c49542220616e6420676f696e6720746f20626520225355494c4954545422", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SU_Ilit_ac36459b44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

