module 0x11ff5dd25c6baf02e2d31275eb4f7e701e0aac3b08283b9a8f52c62bc70938ae::inner {
    struct SolanaPubkey has copy, drop, store {
        pos0: vector<u8>,
    }

    struct EvmAddress has copy, drop, store {
        pos0: vector<u8>,
    }

    struct Links has store {
        solana: 0x2::vec_set::VecSet<SolanaPubkey>,
        evm: 0x2::vec_set::VecSet<EvmAddress>,
    }

    struct StateV1 has store, key {
        id: 0x2::object::UID,
        solana_to_sui: 0x2::table::Table<SolanaPubkey, address>,
        evm_to_sui: 0x2::table::Table<EvmAddress, address>,
        links: 0x2::table::Table<address, Links>,
        aliases: 0x2::table::Table<address, 0x2::vec_set::VecSet<address>>,
        alias_to_primary: 0x2::table::Table<address, address>,
    }

    fun address_to_hex(arg0: address) : vector<u8> {
        let v0 = b"0123456789abcdef";
        let v1 = 0x2::address::to_bytes(arg0);
        let v2 = &v1;
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v2)) {
            let v5 = 0x1::vector::borrow<u8>(v2, v4);
            let v6 = 0x1::vector::empty<u8>();
            let v7 = &mut v6;
            0x1::vector::push_back<u8>(v7, *0x1::vector::borrow<u8>(&v0, ((*v5 >> 4) as u64)));
            0x1::vector::push_back<u8>(v7, *0x1::vector::borrow<u8>(&v0, ((*v5 & 15) as u64)));
            0x1::vector::push_back<vector<u8>>(&mut v3, v6);
            v4 = v4 + 1;
        };
        0x1::vector::flatten<u8>(v3)
    }

    fun alias_link_message(arg0: address, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"Link alias ");
        0x1::vector::push_back<vector<u8>>(v1, address_to_hex(arg1));
        0x1::vector::push_back<vector<u8>>(v1, b" to primary Sui address: ");
        0x1::vector::push_back<vector<u8>>(v1, address_to_hex(arg0));
        0x1::vector::flatten<u8>(v0)
    }

    fun assert_valid_alias_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u8) {
        if (arg3 == 0) {
            assert!(0x1::vector::length<u8>(arg0) == 64, 22);
            assert!(0x2::ed25519::ed25519_verify(arg0, arg1, arg2), 19);
        } else {
            assert!(arg3 == 1, 20);
            assert!(0x1::vector::length<u8>(arg0) == 64, 22);
            let v0 = 0x2::hash::blake2b256(arg2);
            assert!(0x2::ecdsa_k1::secp256k1_verify(arg0, arg1, &v0, 1), 19);
        };
    }

    fun derive_sui_address(arg0: &vector<u8>, arg1: u8) : address {
        if (arg1 == 0) {
            assert!(0x1::vector::length<u8>(arg0) == 32, 21);
            let v1 = x"00";
            0x1::vector::append<u8>(&mut v1, *arg0);
            0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
        } else {
            assert!(arg1 == 1, 20);
            assert!(0x1::vector::length<u8>(arg0) == 33, 21);
            let v2 = x"01";
            0x1::vector::append<u8>(&mut v2, *arg0);
            0x2::address::from_bytes(0x2::hash::blake2b256(&v2))
        }
    }

    fun ecrecover_keccak(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(arg0, arg1, 0)
    }

    fun eip191_message(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, x"19457468657265756d205369676e6564204d6573736167653a0a");
        0x1::vector::push_back<vector<u8>>(v1, 0x1::string::into_bytes(0x1::u64::to_string(0x1::vector::length<u8>(&arg0))));
        0x1::vector::push_back<vector<u8>>(v1, arg0);
        0x1::vector::flatten<u8>(v0)
    }

    fun ensure_alias(arg0: &mut StateV1, arg1: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(&arg0.aliases, 0x2::tx_context::sender(arg1))) {
            0x2::table::add<address, 0x2::vec_set::VecSet<address>>(&mut arg0.aliases, 0x2::tx_context::sender(arg1), 0x2::vec_set::empty<address>());
        };
    }

    fun ensure_links(arg0: &mut StateV1, arg1: address) {
        if (0x2::table::contains<address, Links>(&arg0.links, arg1)) {
            return
        };
        let v0 = Links{
            solana : 0x2::vec_set::empty<SolanaPubkey>(),
            evm    : 0x2::vec_set::empty<EvmAddress>(),
        };
        0x2::table::add<address, Links>(&mut arg0.links, arg1, v0);
    }

    fun evm_address(arg0: vector<u8>) : EvmAddress {
        assert!(0x1::vector::length<u8>(&arg0) == 20, 8);
        EvmAddress{pos0: arg0}
    }

    public(friend) fun get_aliases(arg0: &StateV1, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(&arg0.aliases, arg1)) {
            return vector[]
        };
        let v0 = 0x2::vec_set::keys<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(&arg0.aliases, arg1));
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v0)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun get_evm_for_sui(arg0: &StateV1, arg1: address) : vector<vector<u8>> {
        if (!0x2::table::contains<address, Links>(&arg0.links, arg1)) {
            return vector[]
        };
        let v0 = 0x2::vec_set::keys<EvmAddress>(&0x2::table::borrow<address, Links>(&arg0.links, arg1).evm);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<EvmAddress>(v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::vector::borrow<EvmAddress>(v0, v2).pos0);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun get_primary(arg0: &StateV1, arg1: address) : address {
        if (0x2::table::contains<address, address>(&arg0.alias_to_primary, arg1)) {
            *0x2::table::borrow<address, address>(&arg0.alias_to_primary, arg1)
        } else {
            arg1
        }
    }

    public(friend) fun get_solana_for_sui(arg0: &StateV1, arg1: address) : vector<vector<u8>> {
        if (!0x2::table::contains<address, Links>(&arg0.links, arg1)) {
            return vector[]
        };
        let v0 = 0x2::vec_set::keys<SolanaPubkey>(&0x2::table::borrow<address, Links>(&arg0.links, arg1).solana);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<SolanaPubkey>(v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::vector::borrow<SolanaPubkey>(v0, v2).pos0);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun get_sui_for_evm(arg0: &StateV1, arg1: vector<u8>) : 0x1::option::Option<address> {
        let v0 = &arg0.evm_to_sui;
        let v1 = evm_address(arg1);
        if (0x2::table::contains<EvmAddress, address>(v0, v1)) {
            0x1::option::some<address>(*0x2::table::borrow<EvmAddress, address>(v0, v1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun get_sui_for_solana(arg0: &StateV1, arg1: vector<u8>) : 0x1::option::Option<address> {
        let v0 = &arg0.solana_to_sui;
        let v1 = solana_pubkey(arg1);
        if (0x2::table::contains<SolanaPubkey, address>(v0, v1)) {
            0x1::option::some<address>(*0x2::table::borrow<SolanaPubkey, address>(v0, v1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun link_alias(arg0: &mut StateV1, arg1: vector<u8>, arg2: u8, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 == 0 || arg2 == 1, 20);
        let v1 = derive_sui_address(&arg1, arg2);
        let v2 = alias_link_message(v0, v1);
        assert_valid_alias_signature(&arg3, &arg1, &v2, arg2);
        assert!(v0 != v1, 17);
        assert!(!0x2::table::contains<address, address>(&arg0.alias_to_primary, v1), 18);
        ensure_alias(arg0, arg4);
        assert!(0x2::vec_set::length<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(&arg0.aliases, v0)) < 20, 15);
        assert!(!0x2::vec_set::contains<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(&arg0.aliases, v0), &v1), 14);
        0x2::vec_set::insert<address>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<address>>(&mut arg0.aliases, v0), v1);
        0x2::table::add<address, address>(&mut arg0.alias_to_primary, v1, v0);
        0x11ff5dd25c6baf02e2d31275eb4f7e701e0aac3b08283b9a8f52c62bc70938ae::events::emit_alias_linked(v0, v1);
    }

    public(friend) fun link_evm(arg0: &mut StateV1, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = evm_address(arg1);
        assert!(!0x2::table::contains<EvmAddress, address>(&arg0.evm_to_sui, v1), 3);
        ensure_links(arg0, v0);
        assert!(0x2::vec_set::length<EvmAddress>(&0x2::table::borrow<address, Links>(&arg0.links, v0).evm) < 20, 10);
        assert!(0x1::vector::length<u8>(&arg2) == 65, 5);
        let v2 = eip191_message(link_message(v0, b"EVM"));
        let v3 = normalize_evm_signature(arg2);
        let v4 = ecrecover_keccak(&v3, &v2);
        assert!(pubkey_to_evm_address(0x2::ecdsa_k1::decompress_pubkey(&v4)) == v1, 1);
        0x2::table::add<EvmAddress, address>(&mut arg0.evm_to_sui, v1, v0);
        0x2::vec_set::insert<EvmAddress>(&mut 0x2::table::borrow_mut<address, Links>(&mut arg0.links, v0).evm, v1);
        0x11ff5dd25c6baf02e2d31275eb4f7e701e0aac3b08283b9a8f52c62bc70938ae::events::emit_evm_linked(v0, arg1);
    }

    fun link_message(arg0: address, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"Link ");
        0x1::vector::push_back<vector<u8>>(v1, arg1);
        0x1::vector::push_back<vector<u8>>(v1, b" to Sui: ");
        0x1::vector::push_back<vector<u8>>(v1, address_to_hex(arg0));
        0x1::vector::flatten<u8>(v0)
    }

    public(friend) fun link_solana(arg0: &mut StateV1, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = solana_pubkey(arg1);
        assert!(!0x2::table::contains<SolanaPubkey, address>(&arg0.solana_to_sui, v1), 2);
        ensure_links(arg0, v0);
        assert!(0x2::vec_set::length<SolanaPubkey>(&0x2::table::borrow<address, Links>(&arg0.links, v0).solana) < 20, 9);
        let v2 = link_message(v0, b"Solana");
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &v2), 0);
        0x2::table::add<SolanaPubkey, address>(&mut arg0.solana_to_sui, v1, v0);
        0x2::vec_set::insert<SolanaPubkey>(&mut 0x2::table::borrow_mut<address, Links>(&mut arg0.links, v0).solana, v1);
        0x11ff5dd25c6baf02e2d31275eb4f7e701e0aac3b08283b9a8f52c62bc70938ae::events::emit_solana_linked(v0, arg1);
    }

    public(friend) fun new_state_v1(arg0: &mut 0x2::tx_context::TxContext) : StateV1 {
        StateV1{
            id               : 0x2::object::new(arg0),
            solana_to_sui    : 0x2::table::new<SolanaPubkey, address>(arg0),
            evm_to_sui       : 0x2::table::new<EvmAddress, address>(arg0),
            links            : 0x2::table::new<address, Links>(arg0),
            aliases          : 0x2::table::new<address, 0x2::vec_set::VecSet<address>>(arg0),
            alias_to_primary : 0x2::table::new<address, address>(arg0),
        }
    }

    fun normalize_evm_signature(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0, 64);
        if (*v0 >= 27) {
            *v0 = *v0 - 27;
        };
        assert!(*v0 <= 1, 13);
        arg0
    }

    fun pubkey_to_evm_address(arg0: vector<u8>) : EvmAddress {
        let v0 = 0x1::vector::skip<u8>(arg0, 1);
        evm_address(0x1::vector::skip<u8>(0x2::hash::keccak256(&v0), 12))
    }

    fun solana_pubkey(arg0: vector<u8>) : SolanaPubkey {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 4);
        SolanaPubkey{pos0: arg0}
    }

    public(friend) fun unlink_alias(arg0: &mut StateV1, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(&arg0.aliases, v0) && 0x2::vec_set::contains<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(&arg0.aliases, v0), &arg1), 16);
        0x2::vec_set::remove<address>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<address>>(&mut arg0.aliases, v0), &arg1);
        0x2::table::remove<address, address>(&mut arg0.alias_to_primary, arg1);
        0x11ff5dd25c6baf02e2d31275eb4f7e701e0aac3b08283b9a8f52c62bc70938ae::events::emit_alias_unlinked(v0, arg1);
    }

    public(friend) fun unlink_evm(arg0: &mut StateV1, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = evm_address(arg1);
        assert!(0x2::table::contains<EvmAddress, address>(&arg0.evm_to_sui, v1) && *0x2::table::borrow<EvmAddress, address>(&arg0.evm_to_sui, v1) == v0, 12);
        0x2::table::remove<EvmAddress, address>(&mut arg0.evm_to_sui, v1);
        0x2::vec_set::remove<EvmAddress>(&mut 0x2::table::borrow_mut<address, Links>(&mut arg0.links, v0).evm, &v1);
        0x11ff5dd25c6baf02e2d31275eb4f7e701e0aac3b08283b9a8f52c62bc70938ae::events::emit_evm_unlinked(v0, arg1);
    }

    public(friend) fun unlink_solana(arg0: &mut StateV1, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = solana_pubkey(arg1);
        assert!(0x2::table::contains<SolanaPubkey, address>(&arg0.solana_to_sui, v1) && *0x2::table::borrow<SolanaPubkey, address>(&arg0.solana_to_sui, v1) == v0, 11);
        0x2::table::remove<SolanaPubkey, address>(&mut arg0.solana_to_sui, v1);
        0x2::vec_set::remove<SolanaPubkey>(&mut 0x2::table::borrow_mut<address, Links>(&mut arg0.links, v0).solana, &v1);
        0x11ff5dd25c6baf02e2d31275eb4f7e701e0aac3b08283b9a8f52c62bc70938ae::events::emit_solana_unlinked(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

