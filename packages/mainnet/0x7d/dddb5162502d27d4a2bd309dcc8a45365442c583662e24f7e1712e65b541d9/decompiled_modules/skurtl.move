module 0x7ddddb5162502d27d4a2bd309dcc8a45365442c583662e24f7e1712e65b541d9::skurtl {
    struct SKURTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURTL>(arg0, 6, b"SKURTL", b"Skurtl", b"SKURTL - A cute and badass turtle shredding its way through SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JM_9_GP_Yjh_400x400_1_a60fdc9a52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

