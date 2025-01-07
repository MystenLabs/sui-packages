module 0x54e0ae5092df1ba126380a581a095c002a71552d064d83043b785f59b7d415fe::chow {
    struct CHOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOW>(arg0, 6, b"CHOW", b"CHOW SUI", b"THERE IS NO CABAL. ONLY CHOW CHOW.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe50713c7a1487ff06a7d7a22a036ee7d1f02d5f8_4dcb5e9f32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

