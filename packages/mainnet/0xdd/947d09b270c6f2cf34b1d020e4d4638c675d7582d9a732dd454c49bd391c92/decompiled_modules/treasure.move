module 0xdd947d09b270c6f2cf34b1d020e4d4638c675d7582d9a732dd454c49bd391c92::treasure {
    struct TREASURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREASURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURE>(arg0, 6, b"TREASURE", b"Treasure of Sui", b"Hidden deep in Suis waters. Only for true explorers. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chest_d36673ebaa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREASURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREASURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

