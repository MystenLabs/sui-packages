module 0x7f30526b39b25f641c97250668622dcaf627af0779b61279c29913dd991f478d::swarm_network_token {
    struct SWARM_NETWORK_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM_NETWORK_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM_NETWORK_TOKEN>(arg0, 9, b"TRUTH", b"Swarm Network", b"AI AGENT SWARMS OWNED AND OPERATED BY YOU.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://truth-logo.swarmnetwork.ai/")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWARM_NETWORK_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SWARM_NETWORK_TOKEN>>(0x2::coin::mint<SWARM_NETWORK_TOKEN>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SWARM_NETWORK_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

