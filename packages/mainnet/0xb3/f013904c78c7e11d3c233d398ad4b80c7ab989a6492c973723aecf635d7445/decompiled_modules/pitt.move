module 0xb3f013904c78c7e11d3c233d398ad4b80c7ab989a6492c973723aecf635d7445::pitt {
    struct PITT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITT>(arg0, 6, b"PITT", b"BRAD", b"Characterized as his most iconic character, Tyler Durden. Come join the club, the fight club. Rule 1: You do not talk about Fight Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pitt_1_c2bb582c43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITT>>(v1);
    }

    // decompiled from Move bytecode v6
}

