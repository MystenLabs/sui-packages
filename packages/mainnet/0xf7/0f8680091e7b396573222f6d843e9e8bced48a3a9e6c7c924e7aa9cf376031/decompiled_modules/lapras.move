module 0xf70f8680091e7b396573222f6d843e9e8bced48a3a9e6c7c924e7aa9cf376031::lapras {
    struct LAPRAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAPRAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAPRAS>(arg0, 6, b"Lapras", b"Lapras Sui", b"Lapras is a Water ice type Pokemon introduced in Generation I Kanto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiec5wuu4gq3egop36xtjiarvcspgivoy4je2kxt7buxq6thnla5ie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAPRAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAPRAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

