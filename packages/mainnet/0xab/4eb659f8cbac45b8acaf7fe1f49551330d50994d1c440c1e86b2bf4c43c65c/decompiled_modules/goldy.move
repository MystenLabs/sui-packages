module 0xab4eb659f8cbac45b8acaf7fe1f49551330d50994d1c440c1e86b2bf4c43c65c::goldy {
    struct GOLDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDY>(arg0, 6, b"Goldy", b"GoldyBag", b"Goldy - a fish out of the ocean to meet new friends!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfpgoldy_1e1f837855.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

