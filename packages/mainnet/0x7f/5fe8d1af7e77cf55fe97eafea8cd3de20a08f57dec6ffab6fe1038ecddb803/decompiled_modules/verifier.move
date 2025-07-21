module 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::verifier {
    struct ConfigSet has copy, drop {
        config_digest: vector<u8>,
        signing_keys: vector<vector<u8>>,
        f: u8,
    }

    struct ConfigUpdated has copy, drop {
        config_digest: vector<u8>,
        prev_signing_keys: vector<vector<u8>>,
        new_signing_keys: vector<vector<u8>>,
        f: u8,
    }

    struct ConfigDeactivated has copy, drop {
        config_digest: vector<u8>,
    }

    struct ConfigActivated has copy, drop {
        config_digest: vector<u8>,
    }

    struct OwnershipTransferRequested has copy, drop {
        from: address,
        to: address,
    }

    struct OwnershipTransferred has copy, drop {
        from: address,
        to: address,
    }

    struct ReportVerified has copy, drop {
        feed_id: vector<u8>,
        sender: address,
    }

    struct Config has store {
        latest_config_block_number: u64,
        is_active: bool,
        signing_keys: 0x2::table::Table<vector<u8>, u8>,
        f: u8,
    }

    struct VerifierStorage has key {
        id: 0x2::object::UID,
        owner_address: address,
        pending_owner_address: address,
        configs: 0x2::table::Table<vector<u8>, Config>,
        registry_storage_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun accept_ownership(arg0: &mut VerifierStorage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pending_owner_address == 0x2::tx_context::sender(arg1), 10);
        arg0.owner_address = arg0.pending_owner_address;
        arg0.pending_owner_address = @0x0;
        let v0 = OwnershipTransferred{
            from : arg0.owner_address,
            to   : arg0.owner_address,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    public fun activate_config(arg0: &mut VerifierStorage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x2::table::contains<vector<u8>, Config>(&arg0.configs, arg1), 5);
        0x2::table::borrow_mut<vector<u8>, Config>(&mut arg0.configs, arg1).is_active = true;
        let v0 = ConfigActivated{config_digest: arg1};
        0x2::event::emit<ConfigActivated>(v0);
    }

    fun assert_is_owner(arg0: &VerifierStorage, arg1: address) {
        assert!(arg0.owner_address == arg1, 11);
    }

    fun assert_valid_config(arg0: &vector<vector<u8>>, arg1: u8) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(arg1 > 0, 1);
        assert!(v0 <= 31, 2);
        assert!(v0 > 3 * (arg1 as u64), 3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            assert_valid_public_key(0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
    }

    fun assert_valid_config_digest(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 18);
    }

    fun assert_valid_public_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 20, 7);
        let v0 = x"0000000000000000000000000000000000000000";
        assert!(arg0 != &v0, 6);
    }

    fun assert_valid_report_data(arg0: &Config, arg1: &0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::SignedReport) {
        assert!(arg0.is_active, 13);
        let v0 = 0x1::vector::length<vector<u8>>(0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_rs(arg1));
        assert!(v0 == ((arg0.f + 1) as u64), 14);
        assert!(v0 == 0x1::vector::length<vector<u8>>(0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_ss(arg1)), 15);
    }

    fun assert_valid_signatures(arg0: &Config, arg1: &0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::SignedReport) {
        let v0 = get_signed_report(arg1);
        let v1 = 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_ss(arg1);
        let v2 = 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_rs(arg1);
        let v3 = 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_raw_vs(arg1);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(v2)) {
            let v6 = *0x1::vector::borrow<u8>(v3, v5);
            let v7 = if (v6 >= 27) {
                v6 - 27
            } else {
                v6
            };
            let v8 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v8, *0x1::vector::borrow<vector<u8>>(v2, v5));
            0x1::vector::append<u8>(&mut v8, *0x1::vector::borrow<vector<u8>>(v1, v5));
            0x1::vector::push_back<u8>(&mut v8, v7);
            let v9 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v8, &v0, 0);
            assert!(!0x1::vector::is_empty<u8>(&v9), 16);
            let v10 = 0x2::ecdsa_k1::decompress_pubkey(&v9);
            let v11 = slice<u8>(&v10, 1, 65);
            let v12 = 0x2::hash::keccak256(&v11);
            let v13 = slice<u8>(&v12, 12, 32);
            assert!(0x2::table::contains<vector<u8>, u8>(&arg0.signing_keys, v13), 17);
            v4 = v4 + (1 << 8 * *0x2::table::borrow<vector<u8>, u8>(&arg0.signing_keys, v13));
            v5 = v5 + 1;
        };
        assert!(v4 & 1773775876797123091660094745843871137458179912157484130506396813846708481 == v4, 14);
    }

    public fun deactivate_config(arg0: &mut VerifierStorage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x2::table::contains<vector<u8>, Config>(&arg0.configs, arg1), 5);
        0x2::table::borrow_mut<vector<u8>, Config>(&mut arg0.configs, arg1).is_active = false;
        let v0 = ConfigDeactivated{config_digest: arg1};
        0x2::event::emit<ConfigDeactivated>(v0);
    }

    public fun get_owner(arg0: &VerifierStorage) : address {
        arg0.owner_address
    }

    fun get_signed_report(arg0: &0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::SignedReport) : vector<u8> {
        let v0 = 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_report_context(arg0);
        let v1 = 0x2::hash::keccak256(0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_report_data(arg0));
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v0)) {
            0x1::vector::append<u8>(&mut v1, *0x1::vector::borrow<vector<u8>>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VerifierStorage{
            id                    : 0x2::object::new(arg0),
            owner_address         : 0x2::tx_context::sender(arg0),
            pending_owner_address : @0x0,
            configs               : 0x2::table::new<vector<u8>, Config>(arg0),
            registry_storage_id   : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<VerifierStorage>(v0);
    }

    public fun latest_config_block_number(arg0: &VerifierStorage, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, Config>(&arg0.configs, arg1), 5);
        0x2::table::borrow<vector<u8>, Config>(&arg0.configs, arg1).latest_config_block_number
    }

    public fun set_config(arg0: &mut VerifierStorage, arg1: &mut 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::verifier_registry::VerifierRegistryStorage, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        set_config_internal(arg0, arg2, arg3, arg4, arg5, arg6);
        0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::verifier_registry::set_verifier(arg1, 0x2::object::id<VerifierStorage>(arg0), arg3);
        let v0 = ConfigSet{
            config_digest : arg3,
            signing_keys  : arg4,
            f             : arg5,
        };
        0x2::event::emit<ConfigSet>(v0);
    }

    fun set_config_internal(arg0: &mut VerifierStorage, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg5));
        assert_valid_config(&arg3, arg4);
        assert_valid_config_digest(&arg2);
        assert!(!0x2::table::contains<vector<u8>, Config>(&arg0.configs, arg2), 4);
        let v0 = Config{
            latest_config_block_number : 0x2::clock::timestamp_ms(arg1),
            is_active                  : true,
            signing_keys               : 0x2::table::new<vector<u8>, u8>(arg5),
            f                          : arg4,
        };
        0x2::table::add<vector<u8>, Config>(&mut arg0.configs, arg2, v0);
        let v1 = 0x2::table::borrow_mut<vector<u8>, Config>(&mut arg0.configs, arg2);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg3, v3);
            assert!(!0x2::table::contains<vector<u8>, u8>(&v1.signing_keys, v4), 8);
            0x2::table::add<vector<u8>, u8>(&mut v1.signing_keys, v4, v2);
            v2 = v2 + 1;
            v3 = v3 + 1;
        };
    }

    fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun transfer_ownership(arg0: &mut VerifierStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg0.owner_address != arg1, 12);
        arg0.pending_owner_address = arg1;
        let v0 = OwnershipTransferRequested{
            from : arg0.owner_address,
            to   : arg1,
        };
        0x2::event::emit<OwnershipTransferRequested>(v0);
    }

    public fun type_and_version() : vector<u8> {
        b"Verifier v1.0.0"
    }

    public fun update_config(arg0: &mut VerifierStorage, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, Config>(&arg0.configs, arg2), 5);
        let Config {
            latest_config_block_number : _,
            is_active                  : _,
            signing_keys               : v2,
            f                          : _,
        } = 0x2::table::remove<vector<u8>, Config>(&mut arg0.configs, arg2);
        let v4 = v2;
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x2::table::length<vector<u8>, u8>(&v4), 9);
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v6 = *0x1::vector::borrow<vector<u8>>(&arg3, v5);
            assert!(0x2::table::contains<vector<u8>, u8>(&v4, v6), 9);
            0x2::table::remove<vector<u8>, u8>(&mut v4, v6);
            v5 = v5 + 1;
        };
        0x2::table::destroy_empty<vector<u8>, u8>(v4);
        set_config_internal(arg0, arg1, arg2, arg4, arg5, arg6);
        let v7 = ConfigUpdated{
            config_digest     : arg2,
            prev_signing_keys : arg3,
            new_signing_keys  : arg4,
            f                 : arg5,
        };
        0x2::event::emit<ConfigUpdated>(v7);
    }

    public fun verify(arg0: &VerifierStorage, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::parse_signed_report(&arg1);
        let v1 = *0x1::vector::borrow<vector<u8>>(0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_report_context(&v0), 0);
        assert!(0x2::table::contains<vector<u8>, Config>(&arg0.configs, v1), 5);
        let v2 = 0x2::table::borrow<vector<u8>, Config>(&arg0.configs, v1);
        assert_valid_report_data(v2, &v0);
        assert_valid_signatures(v2, &v0);
        let v3 = *0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm::get_report_data(&v0);
        let v4 = ReportVerified{
            feed_id : slice<u8>(&v3, 0, 32),
            sender  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ReportVerified>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

