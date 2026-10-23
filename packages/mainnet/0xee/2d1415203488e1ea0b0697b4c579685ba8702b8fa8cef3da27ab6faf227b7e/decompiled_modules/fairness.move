module 0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::fairness {
    struct SeedChain has key {
        id: 0x2::object::UID,
        terminal_hash: vector<u8>,
        length: u64,
        salt: 0x1::option::Option<vector<u8>>,
        committed_at_ms: u64,
        sealed_at_ms: u64,
    }

    struct SeedChainRegistry has store {
        active: 0x2::object::ID,
        history: vector<ChainActivation>,
    }

    struct ChainActivation has copy, drop, store {
        chain_id: 0x2::object::ID,
        activated_at_ms: u64,
    }

    struct ChainCommitted has copy, drop {
        chain_id: 0x2::object::ID,
        terminal_hash: vector<u8>,
        length: u64,
    }

    struct SaltSealed has copy, drop {
        chain_id: 0x2::object::ID,
        salt: vector<u8>,
    }

    struct ActiveChainSet has copy, drop {
        vault_id: 0x2::object::ID,
        chain_id: 0x2::object::ID,
        previous_chain_id: 0x1::option::Option<0x2::object::ID>,
        activated_at_ms: u64,
    }

    public fun active_seed_chain(arg0: &0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::ArcadeVault) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::uid(arg0);
        if (has_registry(v0)) {
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<vector<u8>, SeedChainRegistry>(v0, b"seed_chain_registry").active)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun commit_active_chain(arg0: &0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::AdminCap, arg1: &mut 0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::ArcadeVault, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::assert_admin_current(arg0);
        0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::assert_vault_current(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 100);
        assert!(arg3 > 0, 101);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = SeedChain{
            id              : 0x2::object::new(arg5),
            terminal_hash   : arg2,
            length          : arg3,
            salt            : 0x1::option::none<vector<u8>>(),
            committed_at_ms : v0,
            sealed_at_ms    : 0,
        };
        let v2 = 0x2::object::id<SeedChain>(&v1);
        let v3 = ChainCommitted{
            chain_id      : v2,
            terminal_hash : arg2,
            length        : arg3,
        };
        0x2::event::emit<ChainCommitted>(v3);
        let v4 = ChainActivation{
            chain_id        : v2,
            activated_at_ms : v0,
        };
        let v5 = 0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::uid_mut(arg1);
        let v6 = if (has_registry(v5)) {
            let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, SeedChainRegistry>(v5, b"seed_chain_registry");
            v7.active = v2;
            0x1::vector::push_back<ChainActivation>(&mut v7.history, v4);
            0x1::option::some<0x2::object::ID>(v7.active)
        } else {
            let v8 = 0x1::vector::empty<ChainActivation>();
            0x1::vector::push_back<ChainActivation>(&mut v8, v4);
            let v9 = SeedChainRegistry{
                active  : v2,
                history : v8,
            };
            0x2::dynamic_field::add<vector<u8>, SeedChainRegistry>(v5, b"seed_chain_registry", v9);
            0x1::option::none<0x2::object::ID>()
        };
        let v10 = ActiveChainSet{
            vault_id          : 0x2::object::id<0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::ArcadeVault>(arg1),
            chain_id          : v2,
            previous_chain_id : v6,
            activated_at_ms   : v0,
        };
        0x2::event::emit<ActiveChainSet>(v10);
        0x2::transfer::share_object<SeedChain>(v1);
    }

    public fun commit_chain(arg0: &0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::AdminCap, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 103
    }

    fun has_registry(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<vector<u8>, SeedChainRegistry>(arg0, b"seed_chain_registry")
    }

    entry fun seal_salt(arg0: &0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::AdminCap, arg1: &mut SeedChain, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault::assert_admin_current(arg0);
        assert!(0x1::option::is_none<vector<u8>>(&arg1.salt), 102);
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0x2::random::generate_bytes(&mut v0, 32);
        0x1::option::fill<vector<u8>>(&mut arg1.salt, v1);
        arg1.sealed_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v2 = SaltSealed{
            chain_id : 0x2::object::id<SeedChain>(arg1),
            salt     : v1,
        };
        0x2::event::emit<SaltSealed>(v2);
    }

    // decompiled from Move bytecode v7
}

