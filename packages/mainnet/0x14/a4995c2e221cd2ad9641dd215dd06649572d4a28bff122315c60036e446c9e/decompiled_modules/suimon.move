module 0x14a4995c2e221cd2ad9641dd215dd06649572d4a28bff122315c60036e446c9e::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"SUIMON", b"SUIMON ON SUI", b"SUIMONS is an exciting card game inspired by elemental creatures, where players can capture, train, and battle their own SUIMONS. Each SUIMONS belongs to one of the four fundamental elements: Fire, Grass, Water, and Air. Choose your favorite type and create strategies to defeat your opponents in epic battles. Additionally, SUIMONS has its own ecosystem on the blockchain. We are launching an exclusive token on ape.store, which will allow players to access special content, participate in events, and contribute to the growth of the community. Join the adventure and prove who is the best SUIMONS trainer!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Apemons_2_72ea1e5dd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

