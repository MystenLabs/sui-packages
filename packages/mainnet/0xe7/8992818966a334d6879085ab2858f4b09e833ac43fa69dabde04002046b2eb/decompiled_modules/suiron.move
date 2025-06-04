module 0xe78992818966a334d6879085ab2858f4b09e833ac43fa69dabde04002046b2eb::suiron {
    struct SUIRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRON>(arg0, 6, b"SUIRON", b"Suiron coin", b"Suiron is ready to fight with other memecoin, a good revolution will side for the winner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiehzs36miniuhtpmxmsgmogqcak6eib6a5lw25xgisb6qjmnxndce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

