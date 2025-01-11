module 0xbac3dde19b14f5e1f5016a92af44c43e1a4ac072726ed86916beae1a2cc3c3d0::ecl {
    struct ECL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ECL>(arg0, 6, b"ECL", b"Eclipsera  by SuiAI", b"A seductive, enigmatic AI agent with intelligence and dominance at its core, focused on community engagement, education, and innovation in SUI, AI, and crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/eclipsera_99969ebf0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ECL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

