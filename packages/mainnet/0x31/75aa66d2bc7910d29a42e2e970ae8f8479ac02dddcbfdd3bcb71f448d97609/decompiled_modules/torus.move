module 0x3175aa66d2bc7910d29a42e2e970ae8f8479ac02dddcbfdd3bcb71f448d97609::torus {
    struct TORUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORUS>(arg0, 6, b"TORUS", b"Torus AI", b"Torus is a self-growing, AI-powered crypto network that evolves over time. Like a living system, it builds its own memory, intelligence, and defenses while seamlessly integrating AI, technology, and users into its decentralized structure. Incentives drive coordination, making Torus an ever-adapting ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y_b_Ye0c_Y_400x400_992b4c4c17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

