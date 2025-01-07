module 0x48347e346aa758ac4f7fe7118226398de752e5acd8a5714518e79c34ba4df482::gb {
    struct GB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GB>(arg0, 6, b"GB", b"Goofball", b"Goofball the farmer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wnya_R6_Un_FC_Gsp49_Sosv_Jeg_Awva_B7o_Q_Lt_Z7_Avw_Gghvhbn_5dcb924228.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GB>>(v1);
    }

    // decompiled from Move bytecode v6
}

