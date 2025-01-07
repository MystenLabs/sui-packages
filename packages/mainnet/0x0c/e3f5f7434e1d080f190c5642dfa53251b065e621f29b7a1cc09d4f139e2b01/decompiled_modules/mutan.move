module 0xce3f5f7434e1d080f190c5642dfa53251b065e621f29b7a1cc09d4f139e2b01::mutan {
    struct MUTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTAN>(arg0, 6, b"MUTAN", b"MutantBoysClubSUI", b"MutantBoysClub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_38_aaedd7fc20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

