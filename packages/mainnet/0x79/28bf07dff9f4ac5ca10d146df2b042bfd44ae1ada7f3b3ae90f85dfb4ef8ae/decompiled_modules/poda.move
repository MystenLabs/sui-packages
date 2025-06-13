module 0x7928bf07dff9f4ac5ca10d146df2b042bfd44ae1ada7f3b3ae90f85dfb4ef8ae::poda {
    struct PODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PODA>(arg0, 6, b"PODA", b"PokeDailySui", b"live across Kanto on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidqf5vwf6nkbnxovpdrg366dkps3lfygtyuk3g4oo2ovvw2z3mngq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PODA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

