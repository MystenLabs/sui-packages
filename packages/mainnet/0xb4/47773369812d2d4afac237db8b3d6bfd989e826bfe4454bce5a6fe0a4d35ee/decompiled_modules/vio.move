module 0xb447773369812d2d4afac237db8b3d6bfd989e826bfe4454bce5a6fe0a4d35ee::vio {
    struct VIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VIO>(arg0, 6, b"VIO", b"VioAI by SuiAI", b"personality, memories & real-time comms for agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2141_d3e0340f02.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

