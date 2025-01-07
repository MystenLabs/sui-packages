module 0x332d3760b563273e8f041bacb9862b25261f9b370394f59961643e742b98b72b::suimoo {
    struct SUIMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOO>(arg0, 6, b"SUIMOO", b"SUI MOO", b"This is fair launch on SUI to promote our product. We want to compete with Penguins SUiMOO is cuter then penguins and dogs. This is in anticipation of integrating SUI into our Cowfi. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimoo_a1260f290b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

