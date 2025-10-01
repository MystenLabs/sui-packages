module 0xb89b1ecad07db1de30448b9a6706b2f805aaead6b85f441ff7336ac431806b66::swarm_network_token {
    struct SWARM_NETWORK_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM_NETWORK_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM_NETWORK_TOKEN>(arg0, 9, b"TRUTH", b"0x0a48f85a3905cfa49a652bdb074d9e9fabad27892d54afaa5c9e0adeb7ac3cdf::swarm_network_token::SWARM_NETWORK_TOKEN", b"AI AGENT SWARMS OWNED AND OPERATED BY YOU.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://truth-logo.swarmnetwork.ai/")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWARM_NETWORK_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SWARM_NETWORK_TOKEN>>(0x2::coin::mint<SWARM_NETWORK_TOKEN>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SWARM_NETWORK_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

