module 0x4775d73e1e5e60dcd8d40e225101e27f6be242a1aba715ea90a4dd04f956bf7d::afel {
    struct AFEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFEL>(arg0, 6, b"AFEL", b"Afel AI Agent Mascot", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/https3_A2_F2_Fmedia_3ca42d7a95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

