module 0x5f296e63e2adbe4b3e8a1737a53a41f963e2266f3e39007f9024b46fbd75632d::nepe {
    struct NEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPE>(arg0, 6, b"NEPE", b"First Nepe on Sui", b"First Nepe on Sui: https://nepesui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_14_33451b4a97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

