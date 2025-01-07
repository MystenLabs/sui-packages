module 0xd1663e71a1264228fdb17cad8b6ed80c8f4b33da532e8d040427f005551a4ff8::miko {
    struct MIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKO>(arg0, 6, b"MIKO", b"SUIKO", b"memecoin_girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/miko_logo_AV_Lp_D7_Pj_Z_Gc7v_JBD_688f6d295a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

