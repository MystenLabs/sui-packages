module 0x506c44c10920832ec9d8f1b2641a3258c9b55bd0f8c8b14ea5459b77eac8146c::flour {
    struct FLOUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOUR>(arg0, 6, b"FLOUR", b"Bumpy The Bag", x"537461636b20796f7572206261677320616e64206a6f696e2074686520706172747942756d707973206865726520746f207368616b652075702063727970746f2120486f6c642024464c4f55522c207269736520776974682075732c20616e64207374617274206372656174696e6720796f7572206f776e2042756d7079206d656d6573207769746820414921204c657473206d616b652074686973206c6567656e646172792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tuejrhzt4_Jg_Unfjb81w_Jbrd_Vw_G_Rtoe_V4orj6_Z7_Zv9_K4w_64b86a2a2d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

