module 0x67a1a1598d89394921ebfff584eaa55da5a73569fb2067c1ad0e0356038f95ea::caps {
    struct CAPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPS>(arg0, 6, b"CAPS", b"Nuka-Cola Bottlecaps", b"Just some Nuka-Cola bottle caps to trade. Community token. No tg, no twitter. The tokens yours, Ive marked your map with some settlements that need your help. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2664_3ba153ff76.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

