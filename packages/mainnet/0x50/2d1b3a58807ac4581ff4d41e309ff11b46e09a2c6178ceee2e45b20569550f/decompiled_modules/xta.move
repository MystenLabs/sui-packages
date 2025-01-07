module 0x502d1b3a58807ac4581ff4d41e309ff11b46e09a2c6178ceee2e45b20569550f::xta {
    struct XTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTA>(arg0, 6, b"XTA", b"XTACY69", x"787461637920666f72206120626574746572206c6966650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_Jap5_S6_Zgg_Tm3ux_M_Mc9j_FUV_1k8_78053db3cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

