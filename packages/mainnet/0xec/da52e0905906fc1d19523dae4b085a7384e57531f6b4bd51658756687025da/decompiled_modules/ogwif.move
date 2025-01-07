module 0xecda52e0905906fc1d19523dae4b085a7384e57531f6b4bd51658756687025da::ogwif {
    struct OGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGWIF>(arg0, 6, b"Ogwif", b"2019 OG WIF", x"547765657420706f737465640a34207965617273206265666f7265206f6666696369616c200a40646f67776966636f696e0a206c61756e6368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EM_1hfr_TUEAI_7cza_ce38db7528.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

