module 0x4823d892f0fc09a9622c4557b44d9fc4c6e2f0e1b0a5f5e542b4d77decf909b4::mewtwo {
    struct MEWTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWTWO>(arg0, 6, b"MEWTWO", b"Mewtwo Pokemon Adventure", b"The first pokemon adventure game on Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiegdnvwtyuuvfjljdqmireselaiplqwxvhxxbfkpaecfxhn2mytqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWTWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEWTWO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

