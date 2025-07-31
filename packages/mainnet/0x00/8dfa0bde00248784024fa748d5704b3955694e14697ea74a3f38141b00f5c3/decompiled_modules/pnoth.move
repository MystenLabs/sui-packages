module 0x8dfa0bde00248784024fa748d5704b3955694e14697ea74a3f38141b00f5c3::pnoth {
    struct PNOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNOTH>(arg0, 6, b"Pnoth", b"ProbNothing", b"Just pure community vibe . No telegram no website . It's nothing . Will I rug you or send it to the moon? Enjoy trading !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidjgma6igpv6wwt7nvsc3pzakje53fdttwkvhcji7t75xtrbdt6yq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PNOTH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

