module 0x85d887a521aac5cb12d9d17ea0e1358788d51cc598d2daf906a64ccb87c1ce7::posh {
    struct POSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSH>(arg0, 6, b"POSH", b"Catty Posh", b"Catty Posh Elegant or fashionable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigraecfpdab763zynses4gkkjthfipvunmbtpf3n3ibrdk7bok5q4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POSH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

