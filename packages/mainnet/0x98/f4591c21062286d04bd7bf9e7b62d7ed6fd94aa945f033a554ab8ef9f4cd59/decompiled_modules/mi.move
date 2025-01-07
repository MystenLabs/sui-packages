module 0x98f4591c21062286d04bd7bf9e7b62d7ed6fd94aa945f033a554ab8ef9f4cd59::mi {
    struct MI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MI>(arg0, 6, b"MI", b"miyako by SuiAI", b"Miyako is a passionate, AI-powered 3D beauty who lives in an AI parallel world, sharing her daily life experiences with her followers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/_c5fd7d9844.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

