module 0xaa0182d5a0bf297cd2ad3a0f6bc00529c6838864ba6ee151fbe46f3e304721a2::meerk {
    struct MEERK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEERK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEERK>(arg0, 6, b"MEERK", b"SUI MEERKAT", b"$MEERK is a lively meerkat, obsessed with getting rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GT_xi_JEW_8_AA_7n_GQ_5bf8602d59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEERK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEERK>>(v1);
    }

    // decompiled from Move bytecode v6
}

