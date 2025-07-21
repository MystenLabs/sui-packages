module 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::verifier_registry {
    struct VerifierSet has copy, drop {
        config_digest: vector<u8>,
        verifier_id: 0x2::object::ID,
    }

    struct VerifierInitialized has copy, drop {
        verifier_id: 0x2::object::ID,
    }

    struct VerifierUnset has copy, drop {
        config_digest: vector<u8>,
        verifier_id: 0x2::object::ID,
    }

    struct OwnershipTransferRequested has copy, drop {
        from: address,
        to: address,
    }

    struct OwnershipTransferred has copy, drop {
        from: address,
        to: address,
    }

    struct VerifierRegistryStorage has key {
        id: 0x2::object::UID,
        owner_address: address,
        pending_owner_address: address,
        verifiers_by_config: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        initialized_verifiers: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public fun accept_ownership(arg0: &mut VerifierRegistryStorage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pending_owner_address == 0x2::tx_context::sender(arg1), 7);
        arg0.owner_address = arg0.pending_owner_address;
        arg0.pending_owner_address = @0x0;
        let v0 = OwnershipTransferred{
            from : arg0.owner_address,
            to   : arg0.owner_address,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    fun assert_is_owner(arg0: &VerifierRegistryStorage, arg1: address) {
        assert!(arg0.owner_address == arg1, 5);
    }

    fun assert_only_initialized_verifier(arg0: &VerifierRegistryStorage, arg1: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.initialized_verifiers, arg1), 1);
    }

    fun assert_valid_config_digest(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 6);
    }

    public fun get_owner(arg0: &VerifierRegistryStorage) : address {
        arg0.owner_address
    }

    public fun get_verifier(arg0: &VerifierRegistryStorage, arg1: vector<u8>) : 0x2::object::ID {
        assert!(0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.verifiers_by_config, arg1), 4);
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.verifiers_by_config, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VerifierRegistryStorage{
            id                    : 0x2::object::new(arg0),
            owner_address         : 0x2::tx_context::sender(arg0),
            pending_owner_address : @0x0,
            verifiers_by_config   : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
            initialized_verifiers : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<VerifierRegistryStorage>(v0);
    }

    public fun initialize_verifier(arg0: &mut VerifierRegistryStorage, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.initialized_verifiers, arg1), 9);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.initialized_verifiers, arg1, true);
        let v0 = VerifierInitialized{verifier_id: arg1};
        0x2::event::emit<VerifierInitialized>(v0);
    }

    public fun set_verifier(arg0: &mut VerifierRegistryStorage, arg1: 0x2::object::ID, arg2: vector<u8>) {
        assert_only_initialized_verifier(arg0, arg1);
        assert_valid_config_digest(&arg2);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.verifiers_by_config, arg2), 3);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.verifiers_by_config, arg2, arg1);
        let v0 = VerifierSet{
            config_digest : arg2,
            verifier_id   : arg1,
        };
        0x2::event::emit<VerifierSet>(v0);
    }

    public fun transfer_ownership(arg0: &mut VerifierRegistryStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg0.owner_address != arg1, 8);
        arg0.pending_owner_address = arg1;
        let v0 = OwnershipTransferRequested{
            from : arg0.owner_address,
            to   : arg1,
        };
        0x2::event::emit<OwnershipTransferRequested>(v0);
    }

    public fun type_and_version() : vector<u8> {
        b"VerifierRegistry v2.0.0"
    }

    public fun unset_verifier(arg0: &mut VerifierRegistryStorage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.verifiers_by_config, arg1), 4);
        let v0 = VerifierUnset{
            config_digest : arg1,
            verifier_id   : 0x2::table::remove<vector<u8>, 0x2::object::ID>(&mut arg0.verifiers_by_config, arg1),
        };
        0x2::event::emit<VerifierUnset>(v0);
    }

    // decompiled from Move bytecode v6
}

