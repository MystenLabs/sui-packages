module 0x9f8f099c1a4dd5b5acbc86117b84faecab6d02f1d07bbeb3119b265b521e3b22::baked {
    struct BAKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKED>(arg0, 6, b"BAKED", b"Baked Sui", b"High as a kite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13186_B2_B_58_E8_472_A_AE_45_9_EF_917_EE_8402_f8c8a4cd4b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

