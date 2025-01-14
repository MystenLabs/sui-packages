module 0x3bdfeb801cd4e87db3d66ba3b69449e0bf7ccd6fef8eb4890063c1739ec0a2c1::gobai {
    struct GOBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBAI>(arg0, 6, b"GOBAI", b"GoblinAI", b"Accelerated by the sacred tree's energy, goblin intelligence and power surged, unleashing worldwide destruction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PFPFIXXXXXXX_4ab5e2bce7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

