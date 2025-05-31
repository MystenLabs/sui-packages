module 0xe3fd04bb78db5b915f0fc79446d61529216fa1b5c840c8c8b965cc34e9ee5a41::raffle {
    struct RaffleCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTOwnerRegistry has key {
        id: 0x2::object::UID,
        owners: vector<address>,
        finalized: bool,
    }

    struct RaffleResult has key {
        id: 0x2::object::UID,
        winners: vector<address>,
        timestamp: u64,
        raffle_id: u64,
    }

    struct RegistryInitialized has copy, drop {
        registry_id: 0x2::object::ID,
        owner_count: u64,
    }

    struct RegistryFinalized has copy, drop {
        registry_id: 0x2::object::ID,
        owner_count: u64,
    }

    struct RaffleCompleted has copy, drop {
        result_id: 0x2::object::ID,
        winners: vector<address>,
        timestamp: u64,
        raffle_id: u64,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        let v2 = 0x1::bcs::to_bytes<address>(&arg0);
        while (v1 < 0x1::vector::length<u8>(&v2)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v2, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun derive_random_index(arg0: &vector<u8>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1::hash::sha3_256(*arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 8 && v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = if (v2 == 0) {
                1
            } else if (v2 == 1) {
                256
            } else if (v2 == 2) {
                65536
            } else if (v2 == 3) {
                16777216
            } else if (v2 == 4) {
                4294967296
            } else if (v2 == 5) {
                1099511627776
            } else if (v2 == 6) {
                281474976710656
            } else {
                72057594037927936
            };
            v1 = v1 + (*0x1::vector::borrow<u8>(&v0, v2) as u64) * v3;
            v2 = v2 + 1;
        };
        v1 % arg1
    }

    public entry fun finalize_owner_registry(arg0: &RaffleCap, arg1: &mut NFTOwnerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.finalized, 0);
        arg1.finalized = true;
        let v0 = RegistryFinalized{
            registry_id : 0x2::object::id<NFTOwnerRegistry>(arg1),
            owner_count : 0x1::vector::length<address>(&arg1.owners),
        };
        0x2::event::emit<RegistryFinalized>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleCap{id: 0x2::object::new(arg0)};
        let v1 = NFTOwnerRegistry{
            id        : 0x2::object::new(arg0),
            owners    : 0x1::vector::empty<address>(),
            finalized : false,
        };
        let v2 = RegistryInitialized{
            registry_id : 0x2::object::id<NFTOwnerRegistry>(&v1),
            owner_count : 0,
        };
        0x2::event::emit<RegistryInitialized>(v2);
        0x2::transfer::transfer<RaffleCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<NFTOwnerRegistry>(v1);
    }

    public entry fun initialize_owner_registry(arg0: &RaffleCap, arg1: &mut NFTOwnerRegistry, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.finalized, 0);
        arg1.owners = arg2;
        let v0 = RegistryInitialized{
            registry_id : 0x2::object::id<NFTOwnerRegistry>(arg1),
            owner_count : 0x1::vector::length<address>(&arg1.owners),
        };
        0x2::event::emit<RegistryInitialized>(v0);
    }

    public entry fun run_raffle(arg0: &RaffleCap, arg1: &NFTOwnerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.finalized, 1);
        assert!(0x1::vector::length<address>(&arg1.owners) >= arg2, 2);
        let v0 = RaffleResult{
            id        : 0x2::object::new(arg3),
            winners   : select_random_winners(*0x2::tx_context::digest(arg3), &arg1.owners, arg2),
            timestamp : 0x2::tx_context::epoch(arg3),
            raffle_id : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        let v1 = RaffleCompleted{
            result_id : 0x2::object::id<RaffleResult>(&v0),
            winners   : v0.winners,
            timestamp : v0.timestamp,
            raffle_id : v0.raffle_id,
        };
        0x2::event::emit<RaffleCompleted>(v1);
        0x2::transfer::share_object<RaffleResult>(v0);
    }

    fun select_random_winners(arg0: vector<u8>, arg1: &vector<address>, arg2: u64) : vector<address> {
        assert!(0x1::vector::length<address>(arg1) >= arg2, 2);
        let v0 = *arg1;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < arg2 && 0x1::vector::length<address>(&v0) > 0) {
            let v3 = 0x1::vector::swap_remove<address>(&mut v0, derive_random_index(&arg0, 0x1::vector::length<address>(&v0)));
            0x1::vector::push_back<address>(&mut v1, v3);
            v2 = v2 + 1;
            0x1::vector::append<u8>(&mut arg0, address_to_bytes(v3));
        };
        v1
    }

    // decompiled from Move bytecode v6
}

