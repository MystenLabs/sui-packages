module 0xddda3b22c55b3bb534546ab6c0130e351ef23ce5b811498dbfa07497b166d8f6::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"Moo", b"MooMaid", b"A cow that had sex with a mermaid? That's udderly ridiculous! Let's call it a Moo-Maid, a creature that's half bovine, half aquatic, and 100% absurd. Imagine the dairy products  sea-salted milk, anyone?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moo_Maid_PFP_ba1b519466.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

