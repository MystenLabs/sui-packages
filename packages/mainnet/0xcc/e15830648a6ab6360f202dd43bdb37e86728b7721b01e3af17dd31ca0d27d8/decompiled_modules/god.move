module 0xcce15830648a6ab6360f202dd43bdb37e86728b7721b01e3af17dd31ca0d27d8::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"God", b"God AI", x"476f642068617320617272697665642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcf56ca6g8p_XBQ_Zaq_Uvko3_JT_9gq_Y_Ac_WBG_7_P2_RZ_Pxji_Dwh_547b23ac1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

