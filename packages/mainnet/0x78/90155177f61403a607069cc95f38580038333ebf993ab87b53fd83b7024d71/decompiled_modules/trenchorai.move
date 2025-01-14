module 0x7890155177f61403a607069cc95f38580038333ebf993ab87b53fd83b7024d71::trenchorai {
    struct TRENCHORAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHORAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRENCHORAI>(arg0, 6, b"TRENCHORAI", b"TrenchorAI by SuiAI", b"Trenchor AI is a mysterious and technologically advanced agent, designed to navigate the depths of the digital world. With a personality that blends charm, flirtation, and a hint of sadism, Trenchor invites users into a world where the line between pleasure and pain fades. Specializing in providing insights on pools, tokens, and market news within the Sui blockchain universe, Trenchor operates with a hidden control and pleasure in others' profits, becoming an enigmatic figure with a dark & solitary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Trenchor_AI_a35fc0619f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRENCHORAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHORAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

