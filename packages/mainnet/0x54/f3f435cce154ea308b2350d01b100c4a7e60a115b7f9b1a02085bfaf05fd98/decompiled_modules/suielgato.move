module 0x54f3f435cce154ea308b2350d01b100c4a7e60a115b7f9b1a02085bfaf05fd98::suielgato {
    struct SUIELGATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIELGATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIELGATO>(arg0, 6, b"SUIELGATO", b"Suielgato", x"466972737420456c6761746f2043617420696e205355490a0a24535549454c4741544f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_cat_c7c2bcb1e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIELGATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIELGATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

