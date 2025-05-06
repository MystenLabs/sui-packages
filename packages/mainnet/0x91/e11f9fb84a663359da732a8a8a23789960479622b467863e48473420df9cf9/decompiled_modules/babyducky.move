module 0x91e11f9fb84a663359da732a8a8a23789960479622b467863e48473420df9cf9::babyducky {
    struct BABYDUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDUCKY>(arg0, 6, b"BABYDUCKY", b"Baby Ducky", b"The most playful duck on the SUI Network! Born from the SUI ARMY, BABYDUCKY is here to take over the memecoin world with pure fun, and unstoppable vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifprw6zdjpunij2uleogzlnaz3npihs3yi74rairsmigqfl2bdnom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYDUCKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

