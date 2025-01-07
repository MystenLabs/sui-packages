module 0x7d96b1b1ba4667f85b7064d0ba6b97e93e390e8b19d28766b0506c9c665e46aa::w3_rng_lite {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RandomGenerator has key {
        id: 0x2::object::UID,
        trusted_signers: 0x2::table::Table<address, bool>,
    }

    struct GeneratorCreated has copy, drop {
        generator_id: address,
    }

    struct SignerAuthorization has copy, drop {
        signer_address: address,
        is_authorized: bool,
    }

    struct RandomSeedGenerated has copy, drop {
        host_seed: vector<u8>,
        user_seed: u64,
        onchain_seed: u32,
        seed_value: vector<u8>,
    }

    fun derive_signer_address(arg0: &vector<u8>) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    entry fun generate_verified_seed(arg0: &0x2::random::Random, arg1: &RandomGenerator, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(is_signer_authorized(arg1, derive_signer_address(&arg5)), 1);
        0x1::vector::append<u8>(&mut arg2, 0x1::bcs::to_bytes<address>(&v0));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg5, &arg2), 2);
        let v1 = 0x2::random::new_generator(arg0, arg6);
        let v2 = 0x2::random::generate_u32(&mut v1);
        0x1::vector::append<u8>(&mut arg2, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut arg2, 0x1::bcs::to_bytes<u32>(&v2));
        let v3 = RandomSeedGenerated{
            host_seed    : arg2,
            user_seed    : arg3,
            onchain_seed : v2,
            seed_value   : 0x2::hash::keccak256(&arg2),
        };
        0x2::event::emit<RandomSeedGenerated>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RandomGenerator{
            id              : 0x2::object::new(arg0),
            trusted_signers : 0x2::table::new<address, bool>(arg0),
        };
        let v2 = GeneratorCreated{generator_id: 0x2::object::uid_to_address(&v1.id)};
        0x2::event::emit<GeneratorCreated>(v2);
        0x2::transfer::share_object<RandomGenerator>(v1);
    }

    public fun is_signer_authorized(arg0: &RandomGenerator, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.trusted_signers, arg1) && *0x2::table::borrow<address, bool>(&arg0.trusted_signers, arg1)
    }

    public entry fun manage_trusted_signers(arg0: &AdminCap, arg1: &mut RandomGenerator, arg2: vector<address>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<bool>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x1::vector::borrow<bool>(&arg3, v0);
            if (0x2::table::contains<address, bool>(&arg1.trusted_signers, v1)) {
                if (!v2) {
                    0x2::table::remove<address, bool>(&mut arg1.trusted_signers, v1);
                } else {
                    *0x2::table::borrow_mut<address, bool>(&mut arg1.trusted_signers, v1) = v2;
                };
            } else {
                0x2::table::add<address, bool>(&mut arg1.trusted_signers, v1, v2);
            };
            let v3 = SignerAuthorization{
                signer_address : v1,
                is_authorized  : v2,
            };
            0x2::event::emit<SignerAuthorization>(v3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

