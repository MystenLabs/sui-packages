module 0x651ed391465c6929a03cfc22d20b4c539f6226e5dbb325f50e39899245a06a19::ptrump {
    struct PTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRUMP>(arg0, 6, b"PTrump", b"PopTrump", x"54484520505245534944454e54204f462054484520554e49544544205354415445532120504f505452554d500a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XDHD_Ey2uf7_S_Fbb_F35_Spyn_Awef_V_Pf_T_Qr72_Vk_AF_Zg_Sjv_Xf_0efaa88860.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

