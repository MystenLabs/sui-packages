module 0x6cf2e85cd0e6d99660546f603032900df3fbc2bc29838266e466de84c44567ee::usdp {
    struct USDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDP>(arg0, 6, b"USDP", b"USDPSUI", b"USFUSFPUSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_D731406_ECAB_4_A46_A8_C8_EDC_035_AB_6_A6_E_94fa1756a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

