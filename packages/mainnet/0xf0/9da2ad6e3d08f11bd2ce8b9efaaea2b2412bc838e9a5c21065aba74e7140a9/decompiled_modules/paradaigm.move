module 0xf09da2ad6e3d08f11bd2ce8b9efaaea2b2412bc838e9a5c21065aba74e7140a9::paradaigm {
    struct PARADAIGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARADAIGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARADAIGM>(arg0, 6, b"PARADAIGM", b"ParadAIgm", b"We invest in advanced AI memeology. We aim to provide our turbo autist LPs the best possible returns by divining the best possible coins from our AI waifus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pzh_JDK_832d_Gkvh_Ey_A_Sy_Km_Jy_J_Kai_D1ha5d_Piyunri_Jp_Bn_e547817ff9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARADAIGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARADAIGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

