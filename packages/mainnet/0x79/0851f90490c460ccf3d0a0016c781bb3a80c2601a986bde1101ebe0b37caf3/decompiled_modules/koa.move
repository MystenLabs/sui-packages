module 0x790851f90490c460ccf3d0a0016c781bb3a80c2601a986bde1101ebe0b37caf3::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOA>(arg0, 6, b"KOA", b"KOALA SUI", b"I'm $KOA!I'm Pepe's bestie for real!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2a1rz5_Gs_E_Eeu12_YJ_Ncdm_Dg_JX_4_MQV_Sk_R7z7ci5qs_TP_1jc_805df66413.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

