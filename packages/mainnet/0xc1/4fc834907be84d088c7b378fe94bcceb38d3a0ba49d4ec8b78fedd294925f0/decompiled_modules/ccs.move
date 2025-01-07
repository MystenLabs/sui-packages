module 0xc14fc834907be84d088c7b378fe94bcceb38d3a0ba49d4ec8b78fedd294925f0::ccs {
    struct CCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCS>(arg0, 6, b"CCS", b"Charlie Sui", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Progetto_senza_titolo_4_cmc_1_915c9521da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

