module 0x2a9f2429bd43495a07572ae0445302166ced48d7d63097e854a320bdc0c4c4e5::sappt {
    struct SAPPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPPT>(arg0, 6, b"SAPPT", b"SUI apprentice", b"you are the apprentice in the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/the_apprendttice_ccb946e44a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

