module 0x3f4df3ab5c29c344b1b35b23318cd1aa8fb82e5398d50dcbc0be801930e63e6f::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 9, b"AURA", b"AURA on SUI", b"First agent using PRIME framework", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmd2BtoakzJ2PRheF9ktURPYQKXpv21EiAea9kA1U3rHyJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AURA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

