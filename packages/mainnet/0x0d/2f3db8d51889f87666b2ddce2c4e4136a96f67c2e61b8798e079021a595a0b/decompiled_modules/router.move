module 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::router {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    struct RouterObject has key {
        id: 0x2::object::UID,
    }

    struct OnRampSet has copy, drop {
        dest_chain_selector: u64,
        on_ramp_package_id: address,
    }

    struct RouterState has key {
        id: 0x2::object::UID,
        ownable_state: 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnableState,
        on_ramp_package_ids: 0x2::vec_map::VecMap<u64, address>,
    }

    struct RouterStatePointer has store, key {
        id: 0x2::object::UID,
        router_object_id: address,
    }

    struct McmsCallback has drop {
        dummy_field: bool,
    }

    struct McmsAcceptOwnershipProof has drop {
        dummy_field: bool,
    }

    public fun accept_ownership(arg0: &mut RouterState, arg1: &mut 0x2::tx_context::TxContext) {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::accept_ownership(&mut arg0.ownable_state, arg1);
    }

    public fun accept_ownership_from_object(arg0: &mut RouterState, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::tx_context::TxContext) {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::accept_ownership_from_object(&mut arg0.ownable_state, arg1, arg2);
    }

    public fun execute_ownership_transfer(arg0: 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap, arg1: &mut RouterState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::execute_ownership_transfer(arg0, &mut arg1.ownable_state, arg2, arg3);
    }

    public fun execute_ownership_transfer_to_mcms(arg0: 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap, arg1: &mut RouterState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let v1 = McmsCallback{dummy_field: false};
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::execute_ownership_transfer_to_mcms<McmsCallback>(arg0, &mut arg1.ownable_state, arg2, arg3, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::create_publisher_wrapper<McmsCallback>(0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::borrow_publisher(&arg0), v0), v1, vector[b"router"], arg4);
    }

    public fun has_pending_transfer(arg0: &RouterState) : bool {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::has_pending_transfer(&arg0.ownable_state)
    }

    public fun mcms_accept_ownership(arg0: &mut RouterState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsAcceptOwnershipProof{dummy_field: false};
        let v1 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_accept_ownership_data<McmsAcceptOwnershipProof>(arg1, arg2, v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addr(0x2::object::id_address<RouterState>(arg0), &mut v1);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v1);
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::mcms_accept_ownership(&mut arg0.ownable_state, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address(), arg3);
    }

    public fun owner(arg0: &RouterState) : address {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::owner(&arg0.ownable_state)
    }

    public fun pending_transfer_accepted(arg0: &RouterState) : 0x1::option::Option<bool> {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::pending_transfer_accepted(&arg0.ownable_state)
    }

    public fun pending_transfer_from(arg0: &RouterState) : 0x1::option::Option<address> {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::pending_transfer_from(&arg0.ownable_state)
    }

    public fun pending_transfer_to(arg0: &RouterState) : 0x1::option::Option<address> {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::pending_transfer_to(&arg0.ownable_state)
    }

    public fun transfer_ownership(arg0: &mut RouterState, arg1: &0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::transfer_ownership(arg1, &mut arg0.ownable_state, arg2, arg3);
    }

    public fun get_dest_chains(arg0: &RouterState) : vector<u64> {
        0x2::vec_map::keys<u64, address>(&arg0.on_ramp_package_ids)
    }

    public fun get_on_ramp(arg0: &RouterState, arg1: u64) : address {
        assert!(0x2::vec_map::contains<u64, address>(&arg0.on_ramp_package_ids, &arg1), 2);
        *0x2::vec_map::get<u64, address>(&arg0.on_ramp_package_ids, &arg1)
    }

    public(friend) fun get_uid(arg0: &mut RouterObject) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun init(arg0: ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RouterObject{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::new(&mut v0.id, arg1);
        let v3 = v2;
        let v4 = RouterState{
            id                  : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"RouterState"),
            ownable_state       : v1,
            on_ramp_package_ids : 0x2::vec_map::empty<u64, address>(),
        };
        let v5 = RouterStatePointer{
            id               : 0x2::object::new(arg1),
            router_object_id : 0x2::object::id_address<RouterObject>(&v0),
        };
        let v6 = 0x1::type_name::with_original_ids<ROUTER>();
        let v7 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v6));
        0x2::transfer::share_object<RouterState>(v4);
        0x2::transfer::share_object<RouterObject>(v0);
        0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::attach_publisher(&mut v3, 0x2::package::claim<ROUTER>(arg0, arg1));
        0x2::transfer::public_transfer<0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<RouterStatePointer>(v5, 0x2::address::from_ascii_bytes(&v7));
    }

    public fun is_chain_supported(arg0: &RouterState, arg1: u64) : bool {
        0x2::vec_map::contains<u64, address>(&arg0.on_ramp_package_ids, &arg1)
    }

    public fun mcms_add_allowed_modules(arg0: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg1: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"add_allowed_modules"), 4);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addr(0x2::object::id_address<0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry>(arg0), &mut v4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = 0;
        while (v6 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v5, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v4));
            v6 = v6 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        let v7 = McmsCallback{dummy_field: false};
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::add_allowed_modules<McmsCallback>(arg0, v7, v5, arg2);
    }

    public fun mcms_execute_ownership_transfer(arg0: &mut RouterState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::DeployerState, arg3: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(arg1, v0, arg3);
        assert!(v2 == 0x1::string::utf8(b"execute_ownership_transfer"), 4);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(v1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<RouterState>(arg0));
        let v7 = &mut v4;
        validate_obj_addrs(v5, v7);
        let v8 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        let v9 = McmsCallback{dummy_field: false};
        if (0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::has_upgrade_cap(arg2, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4))) {
            let v10 = McmsCallback{dummy_field: false};
            0x2::transfer::public_transfer<0x2::package::UpgradeCap>(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::release_upgrade_cap<McmsCallback>(arg2, arg1, v10), v8);
        };
        execute_ownership_transfer(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::release_cap<McmsCallback, 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(arg1, v9), arg0, v8, arg4);
    }

    public fun mcms_register_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::DeployerState, arg3: &mut 0x2::tx_context::TxContext) {
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_deployer::register_upgrade_cap(arg2, arg1, arg0, arg3);
    }

    public fun mcms_remove_allowed_modules(arg0: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg1: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (_, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(arg0, v0, arg1);
        assert!(v2 == 0x1::string::utf8(b"remove_allowed_modules"), 4);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addr(0x2::object::id_address<0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry>(arg0), &mut v4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = 0;
        while (v6 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<vector<u8>>(&mut v5, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v4));
            v6 = v6 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        let v7 = McmsCallback{dummy_field: false};
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::remove_allowed_modules<McmsCallback>(arg0, v7, v5, arg2);
    }

    public fun mcms_set_on_ramps(arg0: &mut RouterState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"set_on_ramps"), 4);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(v1));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<RouterState>(arg0));
        let v7 = &mut v4;
        validate_obj_addrs(v5, v7);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        while (v9 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<u64>(&mut v8, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v4));
            v9 = v9 + 1;
        };
        let v10 = 0x1::vector::empty<address>();
        let v11 = 0;
        while (v11 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v4)) {
            0x1::vector::push_back<address>(&mut v10, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4));
            v11 = v11 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        set_on_ramps(v1, arg0, v8, v10);
    }

    public fun mcms_transfer_ownership(arg0: &mut RouterState, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"transfer_ownership"), 4);
        let v4 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<RouterState>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(v1));
        let v7 = &mut v4;
        validate_obj_addrs(v5, v7);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v4);
        transfer_ownership(arg0, v1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(&mut v4), arg3);
    }

    public fun set_on_ramps(arg0: &0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap, arg1: &mut RouterState, arg2: vector<u64>, arg3: vector<address>) {
        assert!(0x2::object::id<0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::OwnerCap>(arg0) == 0xd2f3db8d51889f87666b2ddce2c4e4136a96f67c2e61b8798e079021a595a0b::ownable::owner_cap_id(&arg1.ownable_state), 3);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<address>(&arg3), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            let v2 = *0x1::vector::borrow<address>(&arg3, v0);
            assert!(v2 != @0x0, 6);
            if (0x2::vec_map::contains<u64, address>(&arg1.on_ramp_package_ids, &v1)) {
                let (_, _) = 0x2::vec_map::remove<u64, address>(&mut arg1.on_ramp_package_ids, &v1);
            };
            0x2::vec_map::insert<u64, address>(&mut arg1.on_ramp_package_ids, v1, v2);
            let v5 = OnRampSet{
                dest_chain_selector : v1,
                on_ramp_package_id  : v2,
            };
            0x2::event::emit<OnRampSet>(v5);
            v0 = v0 + 1;
        };
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"Router 1.6.0")
    }

    fun validate_obj_addrs(arg0: vector<address>, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::BCSStream) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            assert!(0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_address(arg1) == *0x1::vector::borrow<address>(&arg0, v0), 5);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

