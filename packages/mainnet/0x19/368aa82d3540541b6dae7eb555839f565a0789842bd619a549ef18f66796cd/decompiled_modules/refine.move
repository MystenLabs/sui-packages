module 0x19368aa82d3540541b6dae7eb555839f565a0789842bd619a549ef18f66796cd::refine {
    struct REFINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REFINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<REFINE>(arg0, 6, b"REFINE", b"Sui Refine by SuiAI", b"Sui Refine leverages the synergies of DeFi and AI to create an ecosystem focused on .precision, adaptability, and community-driven innovation. By refining the standards of .decentralized financial systems, it is poised to lead the next wave of intelligent blockchain .solutions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_142_1017f11648.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REFINE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFINE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

