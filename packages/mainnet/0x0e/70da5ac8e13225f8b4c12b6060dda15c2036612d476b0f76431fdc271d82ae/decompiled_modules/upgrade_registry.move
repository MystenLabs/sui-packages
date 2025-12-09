module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry {
    struct VersionBlocked has copy, drop {
        module_name: 0x1::string::String,
        version: u8,
    }

    struct VersionUnblocked has copy, drop {
        module_name: 0x1::string::String,
        version: u8,
    }

    struct FunctionBlocked has copy, drop {
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        version: u8,
    }

    struct FunctionUnblocked has copy, drop {
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        version: u8,
    }

    struct UpgradeRegistry has store, key {
        id: 0x2::object::UID,
        function_restrictions: 0x2::table::Table<0x1::string::String, vector<vector<u8>>>,
    }

    struct McmsCallback has drop {
        dummy_field: bool,
    }

    public fun block_function(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 2);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<UpgradeRegistry>(arg0);
        if (!0x2::table::contains<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg2)) {
            0x2::table::add<0x1::string::String, vector<vector<u8>>>(&mut v0.function_restrictions, arg2, vector[]);
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, arg4);
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg3));
        0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<0x1::string::String, vector<vector<u8>>>(&mut v0.function_restrictions, arg2), v1);
        let v2 = FunctionBlocked{
            module_name   : arg2,
            function_name : arg3,
            version       : arg4,
        };
        0x2::event::emit<FunctionBlocked>(v2);
    }

    public fun block_version(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 2);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<UpgradeRegistry>(arg0);
        if (!0x2::table::contains<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg2)) {
            0x2::table::add<0x1::string::String, vector<vector<u8>>>(&mut v0.function_restrictions, arg2, vector[]);
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, arg3);
        0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<0x1::string::String, vector<vector<u8>>>(&mut v0.function_restrictions, arg2), v1);
        let v2 = VersionBlocked{
            module_name : arg2,
            version     : arg3,
        };
        0x2::event::emit<VersionBlocked>(v2);
    }

    public fun get_module_restrictions(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: 0x1::string::String) : vector<vector<u8>> {
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<UpgradeRegistry>(arg0);
        if (!0x2::table::contains<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg1)) {
            0x1::vector::empty<vector<u8>>()
        } else {
            *0x2::table::borrow<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg1)
        }
    }

    public fun initialize(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 2);
        assert!(!0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<UpgradeRegistry>(arg0), 3);
        let v0 = UpgradeRegistry{
            id                    : 0x2::object::new(arg2),
            function_restrictions : 0x2::table::new<0x1::string::String, vector<vector<u8>>>(arg2),
        };
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::add<UpgradeRegistry>(arg0, arg1, v0, arg2);
    }

    public fun is_function_allowed(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8) : bool {
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<UpgradeRegistry>(arg0);
        if (!0x2::table::contains<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg1)) {
            return true
        };
        let v1 = 0x2::table::borrow<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, arg3);
        let v3 = b"";
        0x1::vector::push_back<u8>(&mut v3, arg3);
        0x1::vector::append<u8>(&mut v3, 0x1::string::into_bytes(arg2));
        !0x1::vector::contains<vector<u8>>(v1, &v3) && !0x1::vector::contains<vector<u8>>(v1, &v2)
    }

    public fun mcms_block_function(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"block_function"), 4);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        block_function(arg0, v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(&mut v4), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(&mut v4), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(&mut v4), arg3);
    }

    public fun mcms_block_version(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"block_version"), 4);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        block_version(arg0, v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(&mut v4), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(&mut v4), arg3);
    }

    public fun mcms_unblock_function(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"unblock_function"), 4);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        unblock_function(arg0, v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(&mut v4), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(&mut v4), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(&mut v4), arg3);
    }

    public fun mcms_unblock_version(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = McmsCallback{dummy_field: false};
        let (v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, v0, arg2);
        assert!(v2 == 0x1::string::utf8(b"unblock_version"), 4);
        let v4 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v6, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v5, &mut v4);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v4);
        unblock_version(arg0, v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(&mut v4), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(&mut v4), arg3);
    }

    public fun unblock_function(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 2);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<UpgradeRegistry>(arg0);
        if (!0x2::table::contains<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg2)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<0x1::string::String, vector<vector<u8>>>(&mut v0.function_restrictions, arg2);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, arg4);
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(arg3));
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(v1)) {
            if (0x1::vector::borrow<vector<u8>>(v1, v3) == &v2) {
                0x1::vector::swap_remove<vector<u8>>(v1, v3);
                let v4 = FunctionUnblocked{
                    module_name   : arg2,
                    function_name : arg3,
                    version       : arg4,
                };
                0x2::event::emit<FunctionUnblocked>(v4);
                return
            };
            v3 = v3 + 1;
        };
    }

    public fun unblock_version(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 2);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<UpgradeRegistry>(arg0);
        if (!0x2::table::contains<0x1::string::String, vector<vector<u8>>>(&v0.function_restrictions, arg2)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<0x1::string::String, vector<vector<u8>>>(&mut v0.function_restrictions, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            if (*0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(v1, v2), 0) == arg3) {
                0x1::vector::swap_remove<vector<u8>>(v1, v2);
                let v3 = VersionUnblocked{
                    module_name : arg2,
                    version     : arg3,
                };
                0x2::event::emit<VersionUnblocked>(v3);
                return
            };
            v2 = v2 + 1;
        };
    }

    public fun verify_function_allowed(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8) {
        assert!(is_function_allowed(arg0, arg1, arg2, arg3), 1);
    }

    // decompiled from Move bytecode v6
}

