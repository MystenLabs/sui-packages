module 0xdf92cc7ef3c00e3fb61f0cdf264239cbd9daa6a4af5ce6290e5b8447b8b7ec1a::didi {
    struct DIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDI>(arg0, 6, b"DIDI", b"Didi", x"4b65657020617761792066726f6d206d696e6f72730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdmjjq_Gi_Tkqx_Ur_Acw_EQV_1z_YCF_Zyq8ge_Zb_Tz25j_Mn_EH_Vda_8a8d235759.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

