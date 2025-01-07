module 0x2dfcf23e4a35d27c0940632f4c3b6e67ad1c6a33f3d22d9803679f83477dca0e::smd {
    struct SMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMD>(arg0, 6, b"SMD", b"Shark Moo Deng", x"4c6574277320676f200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XNTZ_3i_DN_Qu_JV_4u2597_Gr_YJS_5gaz_FW_No4c_L_Amb_DLP_Ed_LT_3d22041e06.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

