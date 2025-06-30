module 0x4accae0efe5be08fa427e396670763c86bc71b392f1da28e87a5c077a991c31c::frogget {
    struct FROGGET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGET>(arg0, 6, b"FROGGET", b"Frogget Sui", b"Froget is strong frog on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicsev33s234pd7k7t33nknrbp4cuz3an6ofkly5ch4rx34ivqukxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGGET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

