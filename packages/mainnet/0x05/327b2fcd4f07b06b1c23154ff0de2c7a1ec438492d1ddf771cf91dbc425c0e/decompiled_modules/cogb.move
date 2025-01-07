module 0x5327b2fcd4f07b06b1c23154ff0de2c7a1ec438492d1ddf771cf91dbc425c0e::cogb {
    struct COGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: COGB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COGB>(arg0, 6, b"COGB", b"CogniBot", b"It is an AI Agent that provides its users with high-level cognitive abilities and can learn and adapt according to user behavior. It has the capacity to optimize both the analytical power of AI and the user experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/f1abf4dd_231f_4ce2_a2aa_f128708fd1d6_778916610c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COGB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COGB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

