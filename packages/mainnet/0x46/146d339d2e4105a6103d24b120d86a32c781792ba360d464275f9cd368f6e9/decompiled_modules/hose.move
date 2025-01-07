module 0x46146d339d2e4105a6103d24b120d86a32c781792ba360d464275f9cd368f6e9::hose {
    struct HOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOSE>(arg0, 6, b"HOSE", b"2fast4hose", b"runing for the rank1 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6ad8b00bd2587a60da7194803790042a_5c736a1eb0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

