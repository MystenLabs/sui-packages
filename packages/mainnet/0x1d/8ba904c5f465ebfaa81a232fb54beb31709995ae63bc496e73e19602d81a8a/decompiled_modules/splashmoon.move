module 0x1d8ba904c5f465ebfaa81a232fb54beb31709995ae63bc496e73e19602d81a8a::splashmoon {
    struct SPLASHMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHMOON>(arg0, 6, b"SPLASHMOON", b"Splash moon", b"Move to splash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidrxdommnfsztsbqneca4yy6m5hxxns5gyzpxlkl3riaxcbqwgham")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLASHMOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

