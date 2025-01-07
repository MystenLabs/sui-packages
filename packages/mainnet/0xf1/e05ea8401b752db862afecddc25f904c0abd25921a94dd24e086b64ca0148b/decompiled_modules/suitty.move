module 0xf1e05ea8401b752db862afecddc25f904c0abd25921a94dd24e086b64ca0148b::suitty {
    struct SUITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTY>(arg0, 6, b"SUITTY", b"SUITTY'S", x"5768657265206368616f73206d656574732063727970746f20696e20612066757a7a792c20626c7565207061636b616765210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HC_Ij_Uss_O_400x400_f49327063d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

