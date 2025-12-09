module 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        package_caps: 0x2::bag::Bag,
        registered_proof_types: 0x2::table::Table<0x1::ascii::String, 0x1::type_name::TypeName>,
        proof_type_to_package: 0x2::table::Table<0x1::type_name::TypeName, 0x1::ascii::String>,
        allowed_modules: 0x2::table::Table<0x1::ascii::String, vector<vector<u8>>>,
        batch_execution: 0x2::table::Table<vector<u8>, BatchExecutionState>,
        completed_batches: 0x2::table::Table<vector<u8>, bool>,
    }

    struct PublisherWrapper<phantom T0: drop> {
        package_address: 0x1::ascii::String,
    }

    struct BatchExecutionState has store {
        total_callbacks: u64,
        next_expected_sequence: u64,
    }

    struct ExecutingCallbackParams {
        target: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        data: vector<u8>,
        batch_id: vector<u8>,
        sequence_number: u64,
        total_in_batch: u64,
    }

    struct EntrypointRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        account_address: 0x1::ascii::String,
        allowed_modules: vector<vector<u8>>,
        proof_type: 0x1::type_name::TypeName,
    }

    struct ModulesAdded has copy, drop {
        registry_id: 0x2::object::ID,
        package_address: 0x1::ascii::String,
        module_names: vector<vector<u8>>,
    }

    struct ModulesRemoved has copy, drop {
        registry_id: 0x2::object::ID,
        package_address: 0x1::ascii::String,
        module_names: vector<vector<u8>>,
    }

    struct MCMS_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun add_allowed_modules<T0: drop>(arg0: &mut Registry, arg1: T0, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(0x2::table::contains<0x1::ascii::String, vector<vector<u8>>>(&arg0.allowed_modules, v1), 7);
        assert!(v0 == *0x2::table::borrow<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_proof_types, v1), 6);
        let v2 = 0x2::table::borrow_mut<0x1::ascii::String, vector<vector<u8>>>(&mut arg0.allowed_modules, v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg2, v3);
            assert!(!0x1::vector::contains<vector<u8>>(v2, &v4), 9);
            0x1::vector::push_back<vector<u8>>(v2, v4);
            v3 = v3 + 1;
        };
        let v5 = ModulesAdded{
            registry_id     : 0x2::object::id<Registry>(arg0),
            package_address : v1,
            module_names    : arg2,
        };
        0x2::event::emit<ModulesAdded>(v5);
    }

    public(friend) fun borrow_owner_cap<T0: store + key>(arg0: &Registry) : &T0 {
        0x2::bag::borrow<0x1::ascii::String, T0>(&arg0.package_caps, get_multisig_address_ascii())
    }

    public(friend) fun create_executing_callback_params(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64) : ExecutingCallbackParams {
        ExecutingCallbackParams{
            target          : arg0,
            module_name     : arg1,
            function_name   : arg2,
            data            : arg3,
            batch_id        : arg4,
            sequence_number : arg5,
            total_in_batch  : arg6,
        }
    }

    public fun create_publisher_wrapper<T0: drop>(arg0: &0x2::package::Publisher, arg1: T0) : PublisherWrapper<T0> {
        assert!(0x2::package::from_module<T0>(arg0), 14);
        PublisherWrapper<T0>{package_address: *0x2::package::published_package(arg0)}
    }

    public fun data(arg0: &ExecutingCallbackParams) : vector<u8> {
        arg0.data
    }

    fun enforce_execution_order(arg0: &mut Registry, arg1: vector<u8>, arg2: u64, arg3: u64) {
        if (!0x2::table::contains<vector<u8>, BatchExecutionState>(&arg0.batch_execution, arg1)) {
            let v0 = BatchExecutionState{
                total_callbacks        : arg3,
                next_expected_sequence : 0,
            };
            0x2::table::add<vector<u8>, BatchExecutionState>(&mut arg0.batch_execution, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<vector<u8>, BatchExecutionState>(&mut arg0.batch_execution, arg1);
        assert!(arg2 == v1.next_expected_sequence, 5);
        v1.next_expected_sequence = v1.next_expected_sequence + 1;
        if (v1.next_expected_sequence == v1.total_callbacks) {
            0x2::table::add<vector<u8>, bool>(&mut arg0.completed_batches, arg1, true);
            let BatchExecutionState {
                total_callbacks        : _,
                next_expected_sequence : _,
            } = 0x2::table::remove<vector<u8>, BatchExecutionState>(&mut arg0.batch_execution, arg1);
        };
    }

    public fun function_name(arg0: &ExecutingCallbackParams) : 0x1::string::String {
        arg0.function_name
    }

    public fun get_accept_ownership_data<T0: drop>(arg0: &mut Registry, arg1: ExecutingCallbackParams, arg2: T0) : vector<u8> {
        let ExecutingCallbackParams {
            target          : v0,
            module_name     : v1,
            function_name   : v2,
            data            : v3,
            batch_id        : v4,
            sequence_number : v5,
            total_in_batch  : v6,
        } = arg1;
        let v7 = v2;
        enforce_execution_order(arg0, v4, v5, v6);
        let v8 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::address::to_ascii_string(v0) == 0x1::type_name::address_string(&v8), 3);
        assert!(0x1::string::from_ascii(0x1::type_name::module_string(&v8)) == v1, 13);
        let v9 = b"accept_ownership";
        assert!(0x1::string::as_bytes(&v7) == &v9, 11);
        assert!(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::params::get_struct_name(&v8) == b"McmsAcceptOwnershipProof", 12);
        v3
    }

    public fun get_allowed_modules(arg0: &Registry, arg1: 0x1::ascii::String) : vector<vector<u8>> {
        assert!(0x2::table::contains<0x1::ascii::String, vector<vector<u8>>>(&arg0.allowed_modules, arg1), 7);
        *0x2::table::borrow<0x1::ascii::String, vector<vector<u8>>>(&arg0.allowed_modules, arg1)
    }

    public(friend) fun get_callback_params_from_mcms(arg0: &mut Registry, arg1: ExecutingCallbackParams) : (address, 0x1::string::String, 0x1::string::String, vector<u8>) {
        let ExecutingCallbackParams {
            target          : v0,
            module_name     : v1,
            function_name   : v2,
            data            : v3,
            batch_id        : v4,
            sequence_number : v5,
            total_in_batch  : v6,
        } = arg1;
        enforce_execution_order(arg0, v4, v5, v6);
        (v0, v1, v2, v3)
    }

    public fun get_callback_params_with_caps<T0: drop, T1: store + key>(arg0: &mut Registry, arg1: T0, arg2: ExecutingCallbackParams) : (&mut T1, 0x1::string::String, vector<u8>) {
        let ExecutingCallbackParams {
            target          : v0,
            module_name     : v1,
            function_name   : v2,
            data            : v3,
            batch_id        : v4,
            sequence_number : v5,
            total_in_batch  : v6,
        } = arg2;
        let v7 = v1;
        enforce_execution_order(arg0, v4, v5, v6);
        let v8 = 0x1::type_name::with_original_ids<T0>();
        let v9 = 0x1::type_name::address_string(&v8);
        assert!(v8 == get_registered_proof_type(arg0, v9), 6);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1::ascii::String>(&arg0.proof_type_to_package, v8), 15);
        assert!(0x2::address::to_ascii_string(v0) == v9, 3);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.package_caps, v9), 2);
        assert!(0x2::table::contains<0x1::ascii::String, vector<vector<u8>>>(&arg0.allowed_modules, v9), 7);
        assert!(0x1::vector::contains<vector<u8>>(0x2::table::borrow<0x1::ascii::String, vector<vector<u8>>>(&arg0.allowed_modules, v9), 0x1::string::as_bytes(&v7)), 8);
        (0x2::bag::borrow_mut<0x1::ascii::String, T1>(&mut arg0.package_caps, v9), v2, v3)
    }

    public fun get_multisig_address() : address {
        let v0 = 0x1::ascii::into_bytes(get_multisig_address_ascii());
        0x2::address::from_ascii_bytes(&v0)
    }

    public fun get_multisig_address_ascii() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<MCMS_REGISTRY>();
        0x1::type_name::address_string(&v0)
    }

    public fun get_next_expected_sequence(arg0: &Registry, arg1: vector<u8>) : u64 {
        if (!0x2::table::contains<vector<u8>, BatchExecutionState>(&arg0.batch_execution, arg1)) {
            return 0
        };
        0x2::table::borrow<vector<u8>, BatchExecutionState>(&arg0.batch_execution, arg1).next_expected_sequence
    }

    public(friend) fun get_registered_proof_type(arg0: &Registry, arg1: 0x1::ascii::String) : 0x1::type_name::TypeName {
        assert!(0x2::table::contains<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_proof_types, arg1), 7);
        *0x2::table::borrow<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_proof_types, arg1)
    }

    fun init(arg0: MCMS_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                     : 0x2::object::new(arg1),
            package_caps           : 0x2::bag::new(arg1),
            registered_proof_types : 0x2::table::new<0x1::ascii::String, 0x1::type_name::TypeName>(arg1),
            proof_type_to_package  : 0x2::table::new<0x1::type_name::TypeName, 0x1::ascii::String>(arg1),
            allowed_modules        : 0x2::table::new<0x1::ascii::String, vector<vector<u8>>>(arg1),
            batch_execution        : 0x2::table::new<vector<u8>, BatchExecutionState>(arg1),
            completed_batches      : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_batch_completed(arg0: &Registry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.completed_batches, arg1)
    }

    public fun is_package_registered(arg0: &Registry, arg1: 0x1::ascii::String) : bool {
        0x2::bag::contains<0x1::ascii::String>(&arg0.package_caps, arg1)
    }

    public fun module_name(arg0: &ExecutingCallbackParams) : 0x1::string::String {
        arg0.module_name
    }

    public fun register_entrypoint<T0: drop, T1: store + key>(arg0: &mut Registry, arg1: PublisherWrapper<T0>, arg2: T0, arg3: T1, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        let PublisherWrapper { package_address: v0 } = arg1;
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::type_name::address_string(&v2) == v0, 16);
        assert!(!0x2::bag::contains<0x1::ascii::String>(&arg0.package_caps, v0), 1);
        0x2::bag::add<0x1::ascii::String, T1>(&mut arg0.package_caps, v0, arg3);
        0x2::table::add<0x1::ascii::String, 0x1::type_name::TypeName>(&mut arg0.registered_proof_types, v0, v1);
        0x2::table::add<0x1::type_name::TypeName, 0x1::ascii::String>(&mut arg0.proof_type_to_package, v1, v0);
        0x2::table::add<0x1::ascii::String, vector<vector<u8>>>(&mut arg0.allowed_modules, v0, arg4);
        let v3 = EntrypointRegistered{
            registry_id     : 0x2::object::id<Registry>(arg0),
            account_address : v0,
            allowed_modules : arg4,
            proof_type      : v1,
        };
        0x2::event::emit<EntrypointRegistered>(v3);
    }

    public fun release_cap<T0: drop, T1: store + key>(arg0: &mut Registry, arg1: T0) : T1 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.package_caps, v1), 2);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1::ascii::String>(&arg0.proof_type_to_package, v0), 15);
        assert!(0x2::table::contains<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_proof_types, v1), 7);
        assert!(v0 == 0x2::table::remove<0x1::ascii::String, 0x1::type_name::TypeName>(&mut arg0.registered_proof_types, v1), 6);
        0x2::table::remove<0x1::type_name::TypeName, 0x1::ascii::String>(&mut arg0.proof_type_to_package, v0);
        0x2::table::remove<0x1::ascii::String, vector<vector<u8>>>(&mut arg0.allowed_modules, v1);
        0x2::bag::remove<0x1::ascii::String, T1>(&mut arg0.package_caps, v1)
    }

    public fun remove_allowed_modules<T0: drop>(arg0: &mut Registry, arg1: T0, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(0x2::table::contains<0x1::ascii::String, vector<vector<u8>>>(&arg0.allowed_modules, v1), 7);
        assert!(v0 == *0x2::table::borrow<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_proof_types, v1), 6);
        let v2 = 0x2::table::borrow_mut<0x1::ascii::String, vector<vector<u8>>>(&mut arg0.allowed_modules, v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let (v4, v5) = 0x1::vector::index_of<vector<u8>>(v2, 0x1::vector::borrow<vector<u8>>(&arg2, v3));
            assert!(v4, 10);
            0x1::vector::remove<vector<u8>>(v2, v5);
            v3 = v3 + 1;
        };
        let v6 = ModulesRemoved{
            registry_id     : 0x2::object::id<Registry>(arg0),
            package_address : v1,
            module_names    : arg2,
        };
        0x2::event::emit<ModulesRemoved>(v6);
    }

    public fun target(arg0: &ExecutingCallbackParams) : address {
        arg0.target
    }

    // decompiled from Move bytecode v6
}

