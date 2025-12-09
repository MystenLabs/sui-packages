module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object {
    struct CCIPObject has key {
        id: 0x2::object::UID,
    }

    struct CCIPObjectRef has store, key {
        id: 0x2::object::UID,
        package_ids: vector<address>,
        ownable_state: 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnableState,
    }

    struct CCIPObjectRefPointer has store, key {
        id: 0x2::object::UID,
        ccip_object_id: address,
    }

    struct STATE_OBJECT has drop {
        dummy_field: bool,
    }

    struct McmsCallback has drop {
        dummy_field: bool,
    }

    struct McmsAcceptOwnershipProof has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0: store + key>(arg0: &CCIPObjectRef) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, T0>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun borrow_mut<T0: store + key>(arg0: &mut CCIPObjectRef) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, T0>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun remove<T0: store + key>(arg0: &mut CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &0x2::tx_context::TxContext) : T0 {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::owner_cap_id(&arg0.ownable_state), 4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::remove<0x1::type_name::TypeName, T0>(&mut arg0.id, v0)
    }

    public(friend) fun add<T0: store + key>(arg0: &mut CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::owner_cap_id(&arg0.ownable_state), 4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 1);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, T0>(&mut arg0.id, v0, arg2);
    }

    public fun accept_ownership(arg0: &mut CCIPObjectRef, arg1: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::accept_ownership(&mut arg0.ownable_state, arg1);
    }

    public fun accept_ownership_from_object(arg0: &mut CCIPObjectRef, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::accept_ownership_from_object(&mut arg0.ownable_state, arg1, arg2);
    }

    public fun execute_ownership_transfer(arg0: &mut CCIPObjectRef, arg1: 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::execute_ownership_transfer(arg1, &mut arg0.ownable_state, arg2, arg3);
    }

    public fun execute_ownership_transfer_to_mcms(arg0: &mut CCIPObjectRef, arg1: 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let v1 = McmsCallback{dummy_field: false};
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::execute_ownership_transfer_to_mcms<McmsCallback>(arg1, &mut arg0.ownable_state, arg2, arg3, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::create_publisher_wrapper<McmsCallback>(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::borrow_publisher(&arg1), v0), v1, vector[b"fee_quoter", b"rmn_remote", b"state_object", b"token_admin_registry"], arg4);
    }

    public fun has_pending_transfer(arg0: &CCIPObjectRef) : bool {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::has_pending_transfer(&arg0.ownable_state)
    }

    public fun mcms_accept_ownership(arg0: &mut CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsAcceptOwnershipProof{dummy_field: false};
        let v1 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_accept_ownership_data<McmsAcceptOwnershipProof>(arg1, arg2, v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<CCIPObjectRef>(arg0), &mut v1);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v1);
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::mcms_accept_ownership(&mut arg0.ownable_state, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), arg3);
    }

    public fun owner(arg0: &CCIPObjectRef) : address {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::owner(&arg0.ownable_state)
    }

    public fun owner_cap_id(arg0: &CCIPObjectRef) : 0x2::object::ID {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::owner_cap_id(&arg0.ownable_state)
    }

    public fun pending_transfer_accepted(arg0: &CCIPObjectRef) : 0x1::option::Option<bool> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::pending_transfer_accepted(&arg0.ownable_state)
    }

    public fun pending_transfer_from(arg0: &CCIPObjectRef) : 0x1::option::Option<address> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::pending_transfer_from(&arg0.ownable_state)
    }

    public fun pending_transfer_to(arg0: &CCIPObjectRef) : 0x1::option::Option<address> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::pending_transfer_to(&arg0.ownable_state)
    }

    public fun transfer_ownership(arg0: &mut CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::transfer_ownership(arg1, &mut arg0.ownable_state, arg2, arg3);
    }

    public fun add_package_id(arg0: &mut CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: address) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::owner_cap_id(&arg0.ownable_state), 4);
        0x1::vector::push_back<address>(&mut arg0.package_ids, arg2);
    }

    public(friend) fun contains<T0>(arg0: &CCIPObjectRef) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    fun init(arg0: STATE_OBJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CCIPObject{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::new(&mut v0.id, arg1);
        let v3 = v2;
        let v4 = CCIPObjectRef{
            id            : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"CCIPObjectRef"),
            package_ids   : vector[],
            ownable_state : v1,
        };
        let v5 = CCIPObjectRefPointer{
            id             : 0x2::object::new(arg1),
            ccip_object_id : 0x2::object::id_address<CCIPObject>(&v0),
        };
        let v6 = 0x1::type_name::with_original_ids<STATE_OBJECT>();
        let v7 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v6));
        let v8 = 0x2::address::from_ascii_bytes(&v7);
        0x1::vector::push_back<address>(&mut v4.package_ids, v8);
        0x2::transfer::share_object<CCIPObjectRef>(v4);
        0x2::transfer::share_object<CCIPObject>(v0);
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::attach_publisher(&mut v3, 0x2::package::claim<STATE_OBJECT>(arg0, arg1));
        0x2::transfer::public_transfer<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<CCIPObjectRefPointer>(v5, v8);
    }

    public fun mcms_add_allowed_modules(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg1: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"add_allowed_modules"), 3);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry>(arg0), &mut v4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = 0;
        while (v6 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v5, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v4));
            v6 = v6 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        let v7 = McmsCallback{dummy_field: false};
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::add_allowed_modules<McmsCallback>(arg0, v7, v5, arg2);
    }

    public fun mcms_add_package_id(arg0: &mut CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"add_package_id"), 3);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        add_package_id(arg0, v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v4));
    }

    public(friend) fun mcms_callback() : McmsCallback {
        McmsCallback{dummy_field: false}
    }

    public fun mcms_execute_ownership_transfer(arg0: &mut CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::DeployerState, arg3: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"execute_ownership_transfer"), 3);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        let v7 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        let v8 = McmsCallback{dummy_field: false};
        if (0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::has_upgrade_cap(arg2, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v4))) {
            let v9 = McmsCallback{dummy_field: false};
            0x2::transfer::public_transfer<0x2::package::UpgradeCap>(0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::release_upgrade_cap<McmsCallback>(arg2, arg1, v9), v7);
        };
        execute_ownership_transfer(arg0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::release_cap<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v8), v7, arg4);
    }

    public fun mcms_register_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::DeployerState, arg3: &mut 0x2::tx_context::TxContext) {
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::register_upgrade_cap(arg2, arg1, arg0, arg3);
    }

    public fun mcms_remove_allowed_modules(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg1: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"remove_allowed_modules"), 3);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry>(arg0), &mut v4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = 0;
        while (v6 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v5, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v4));
            v6 = v6 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        let v7 = McmsCallback{dummy_field: false};
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::remove_allowed_modules<McmsCallback>(arg0, v7, v5, arg2);
    }

    public fun mcms_remove_package_id(arg0: &mut CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"remove_package_id"), 3);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        remove_package_id(arg0, v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v4));
    }

    public fun mcms_transfer_ownership(arg0: &mut CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"transfer_ownership"), 3);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        transfer_ownership(arg0, v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v4), arg3);
    }

    public fun remove_package_id(arg0: &mut CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: address) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::owner_cap_id(&arg0.ownable_state), 4);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.package_ids, &arg2);
        assert!(v0, 5);
        0x1::vector::remove<address>(&mut arg0.package_ids, v1);
    }

    // decompiled from Move bytecode v6
}

