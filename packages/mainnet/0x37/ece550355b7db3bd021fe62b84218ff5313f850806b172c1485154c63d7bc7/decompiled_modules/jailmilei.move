module 0x37ece550355b7db3bd021fe62b84218ff5313f850806b172c1485154c63d7bc7::jailmilei {
    struct JAILMILEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILMILEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILMILEI>(arg0, 6, b"JAILMILEI", b"Jail Milei Coin on SUI", b"Let's jail MILEI for the biggest rug pool on history", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jail_fab4e4c01a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILMILEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILMILEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

