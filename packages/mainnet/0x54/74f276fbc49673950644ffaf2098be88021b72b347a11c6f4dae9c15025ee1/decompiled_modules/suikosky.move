module 0x5474f276fbc49673950644ffaf2098be88021b72b347a11c6f4dae9c15025ee1::suikosky {
    struct SUIKOSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOSKY>(arg0, 6, b"SUIKOSKY", b"SUIKOSKY SUI", b"BOOOO! augh aughrr!! The ultimate blue degen, standing awkwardly in the shadows of the Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikosky_7a42d7a545.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

