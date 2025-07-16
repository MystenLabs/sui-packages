module 0x480996b545acca89e1383d7fd3c298c106719ff59166827088f3848d852830ee::Squid_game {
    struct SQUID_GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID_GAME>(arg0, 9, b"SQUID", b"Squid game", b"its an octopus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/932313014241435648/cDpqFAqZ_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUID_GAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID_GAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

