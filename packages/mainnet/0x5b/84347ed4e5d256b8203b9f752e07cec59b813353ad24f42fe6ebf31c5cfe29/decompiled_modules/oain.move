module 0x5b84347ed4e5d256b8203b9f752e07cec59b813353ad24f42fe6ebf31c5cfe29::oain {
    struct OAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OAIN>(arg0, 6, b"OAIN", b"OracleAI Nexus", b"Step into the future with OracleAI Nexus, the revolutionary AI-powered oracle designed to unveil your personal path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735998551250.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

