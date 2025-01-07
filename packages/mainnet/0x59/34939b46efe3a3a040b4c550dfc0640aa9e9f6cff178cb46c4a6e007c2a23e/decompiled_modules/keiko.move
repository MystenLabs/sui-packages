module 0x5934939b46efe3a3a040b4c550dfc0640aa9e9f6cff178cb46c4a6e007c2a23e::keiko {
    struct KEIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEIKO>(arg0, 6, b"Keiko", b"KEIKO", b"Keiko, the killer whale from the blockbuster movie Free Willy, was the first captive orca ever returned to the wild.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdem_JA_7_E9_VUD_Cwhd4q_Y_Fwy_Wha_V_Ub_Xque_GDG_8_Zc9dh_M783_4bb5718805.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

