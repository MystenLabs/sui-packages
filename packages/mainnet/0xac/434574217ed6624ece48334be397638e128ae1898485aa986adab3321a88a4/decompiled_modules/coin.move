module 0xac434574217ed6624ece48334be397638e128ae1898485aa986adab3321a88a4::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    struct CoinCreated has copy, drop {
        treasury_id: address,
        metadata_id: address,
        creator: address,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 6, b"SYMBOL", b"NAME", b"DESCRIPTION", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::mint_and_transfer<COIN>(&mut v3, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, 0x2::tx_context::sender(arg1));
        let v4 = CoinCreated{
            treasury_id : 0x2::object::id_address<0x2::coin::TreasuryCap<COIN>>(&v3),
            metadata_id : 0x2::object::id_address<0x2::coin::CoinMetadata<COIN>>(&v2),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CoinCreated>(v4);
    }

    // decompiled from Move bytecode v6
}

