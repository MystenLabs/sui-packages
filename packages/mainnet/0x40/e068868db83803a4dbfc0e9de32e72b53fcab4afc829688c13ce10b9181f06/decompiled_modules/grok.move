module 0x40e068868db83803a4dbfc0e9de32e72b53fcab4afc829688c13ce10b9181f06::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"Grok", b"Grok the slightly obese purple friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Cy51v_W7_Ys_Ny_Td2b8_ZR_Zu_H_Zr_Zquj84_Nzhb_Fr64_Q1rxk_W_320fc495be.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

