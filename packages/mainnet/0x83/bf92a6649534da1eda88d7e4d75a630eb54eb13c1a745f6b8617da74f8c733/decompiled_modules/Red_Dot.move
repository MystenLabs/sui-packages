module 0x83bf92a6649534da1eda88d7e4d75a630eb54eb13c1a745f6b8617da74f8c733::Red_Dot {
    struct RED_DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED_DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED_DOT>(arg0, 9, b"REDOT", b"Red Dot", b"red dot is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/03d1c8c4-65c4-4c4f-885f-c34690c66ac0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RED_DOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED_DOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

