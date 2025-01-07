module 0x5f701f18ccc42d926ea3eaf91b271cd17f3aed5834cf58a5b7d6a8207ba4690b::zipo {
    struct ZIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIPO>(arg0, 6, b"ZIPO", b"ZIPPO ON SUI", b"ZIPPO THE OG MULTI CHAIN MASCOT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Uvf_Hbb_QAA_8_Hxz_126f08167a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

