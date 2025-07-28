module 0xa48f85a3905cfa49a652bdb074d9e9fabad27892d54afaa5c9e0adeb7ac3cdf::swarm_network_token {
    struct SWARM_NETWORK_TOKEN has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun make_immutable(arg0: 0x2::package::UpgradeCap) {
        0x2::package::make_immutable(arg0);
    }

    fun init(arg0: SWARM_NETWORK_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM_NETWORK_TOKEN>(arg0, 8, b"TRUTH", b"Swarm Network", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://truth-logo.swarmnetwork.ai/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWARM_NETWORK_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM_NETWORK_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWARM_NETWORK_TOKEN>, arg1: MintCap, arg2: &mut 0x2::tx_context::TxContext) {
        let MintCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        0x2::coin::mint_and_transfer<SWARM_NETWORK_TOKEN>(arg0, 1000000000000000000, @0x1fdbbe2907f00af879ecfb9e3696391a1025b785ed17d8c7ade9ea67185412d, arg2);
    }

    // decompiled from Move bytecode v6
}

