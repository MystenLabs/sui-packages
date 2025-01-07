module 0x3353aa242a86982dc2a263b589020b15c36a240c01d802df686796337feb8faf::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 6, b"Mumu", b"Mumu on sui", b"Mumu hates bubu but keeps on getting his pants pulled", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ECAB_6474_2_E45_445_D_AEA_1_77_A06_AAC_0208_1bfb73937a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

