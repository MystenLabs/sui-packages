module 0x201e82a977b415eb93bb59ab845438ea250c2b4d5597c75788fe4624e42f4a0a::solazy {
    struct SOLAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLAZY>(arg0, 6, b"SOLAZY", b"SOLAZY SUI", x"534f4c415a59205355492028534f4c415a59290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcux1yq_Dnj4_AU_8p3_KR_Tw9b62_Jr42_E4_Z_Qj8fxhm9_NS_1_QAR_75c3f08f58.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

