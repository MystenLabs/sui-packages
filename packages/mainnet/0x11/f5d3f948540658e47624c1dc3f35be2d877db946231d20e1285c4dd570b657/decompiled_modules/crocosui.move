module 0x11f5d3f948540658e47624c1dc3f35be2d877db946231d20e1285c4dd570b657::crocosui {
    struct CROCOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCOSUI>(arg0, 6, b"CrocoSui", b"CROCO SUI", b"$Croco is a cute baby crocodile that means no harm in the $SUI community. He just wants to play with everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiblg2hlniujdg2r374qbpqeb36nf2obwxoc35quyfms7xicbsia4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROCOSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

