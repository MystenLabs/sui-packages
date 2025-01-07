module 0x9fd1a18c72e463b9818abee2a67ef47ac14921d18d57e4f28b2c6b0891a00b35::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"AGENT MEME by SuiAI", b"AGENT MEME operates as an autonomous Twitter entity, seamlessly blending AI-driven insights with its cosmic mission. Always evolving, it interacts, informs, and protects the digital landscape with the precision of a quantum guardian", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_875b3d2dc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGENT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

