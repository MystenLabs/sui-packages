module 0xb7a29e6e73c07484deba5e51aa80abd4998aff15e98b95c3b08401ab3afc362::deeznuts {
    struct DEEZNUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEZNUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEZNUTS>(arg0, 6, b"DeezNuts", b"AllDeezNuts - The nuts from the AllFather", b"Dont buy this shit, its just the nuts from AllFather", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicsuluplv6hw3jl7rfma25cg6aydqhwkbw6kgb2j6u3fndpf2nwza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEZNUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEEZNUTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

