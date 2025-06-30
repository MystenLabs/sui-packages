module 0xec5a4380f36559a8368bddb6ad2f4f998ba4f0c158438893ff48fe33fa8f1006::frogget {
    struct FROGGET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGET>(arg0, 6, b"FROGGET", b"Frogget Sui", b"Frogget on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiehyhuhsxxaiglnibs437jqaqqiawwglxfgcnicnxhl4d4fa4cjge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGGET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

