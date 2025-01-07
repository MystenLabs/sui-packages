module 0x7c68b1584c1739c7453476c4294ed8f975f8def005ca23c2a4b194e2b9379a7d::marauder {
    struct MARAUDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARAUDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARAUDER>(arg0, 6, b"MARAUDER", b"Merry Marauder coin", b"Merry $Marauder is part of the first Christmas skin release in Fortnite, and the RAREST of the batch. It is part of the Gingerbread set which was added into Fortnite on December 14th, 2017", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_163318_215_eeddec2fa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARAUDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARAUDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

