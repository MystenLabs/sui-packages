module 0x7c1d4059a3d24e05b3ac64523c39823e26431356730320ee8d4a3a32efefbfe9::bsds {
    struct BSDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSDS>(arg0, 6, b"BSDS", b"BROKENSUIDOAS", b"SMOOTH LAUNCH EVERRRRR, HAHAHAHAH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_B47594_C_4757_43_E7_9_C3_C_F4294_FA_22_A83_69af663e60.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

