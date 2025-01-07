module 0xe28650b9809817a4579d8e52296d9d47d4bc75473a71970845389dd759a7882::goatswarm {
    struct GOATSWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATSWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATSWARM>(arg0, 6, b"GoatSwarm", b"GOAT SOL", b"$GoatSwarm moves like $Swarm, decentralized on solana and leaderless.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOATSWARM_9da18b858a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATSWARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATSWARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

