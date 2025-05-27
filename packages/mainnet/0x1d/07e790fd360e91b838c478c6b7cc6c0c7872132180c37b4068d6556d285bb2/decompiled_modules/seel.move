module 0x1d07e790fd360e91b838c478c6b7cc6c0c7872132180c37b4068d6556d285bb2::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"Seel SUI", b"Seel is the cutest seal on sui, Born from a passion for both cute marine creatures and blockchain technology, SEEL emerged as the undisputed cutest seal-themed token in the SUI ecosystem. Inspired by beloved pocket monsters and the playful spirit of the crypto community, we're building more than just a token  we're creating an entire experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bkgj_L_Zz_Q_400x400_cefc9fcfb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

