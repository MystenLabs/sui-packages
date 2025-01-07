module 0xa6bfb3754f59cbc62bbc5888a0e7de38a6969d78d163f422c08632837a201616::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"Fluffy", b" Welcome to Fluffys Iceberg! Fluffy the Penguin has waddled onto the Sui blockchain, bringing cool vibes and frosty fun. Join our cozy, fun-loving community and be part of the Fluffy fam!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_26_23_30_35_ada96cb86b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

