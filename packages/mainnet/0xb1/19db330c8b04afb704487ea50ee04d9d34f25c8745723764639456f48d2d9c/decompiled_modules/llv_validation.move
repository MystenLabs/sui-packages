module 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_validation {
    public(friend) fun validate_all_for_sync(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: u8) {
        validate_vault_config<0x2::sui::SUI>(arg0, arg1);
        validate_cetus_core(arg0, arg2, arg3, arg4);
        validate_suilend_market<0x2::sui::SUI>(arg0, arg5);
        validate_scallop_config<0x2::sui::SUI>(arg0, arg6);
        validate_navi_storage<0x2::sui::SUI>(arg0, arg7, arg8);
    }

    public(friend) fun validate_all_protocols(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: u64, arg12: 0x2::object::ID, arg13: 0x2::object::ID, arg14: u8, arg15: 0x2::object::ID, arg16: 0x2::object::ID, arg17: 0x2::object::ID) {
        validate_vault_config<0x2::sui::SUI>(arg0, arg1);
        validate_cetus_config(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        validate_suilend_config<0x2::sui::SUI>(arg0, arg10, arg11);
        validate_scallop_config<0x2::sui::SUI>(arg0, arg12);
        validate_navi_config<0x2::sui::SUI>(arg0, arg13, arg14, arg15, arg16, arg17);
    }

    public(friend) fun validate_cetus_config(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<0x2::sui::SUI>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 110);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 110);
        let v2 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 111);
        assert!(arg2 == *0x1::option::borrow<0x2::object::ID>(&v2), 111);
        let v3 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v3), 112);
        assert!(arg3 == *0x1::option::borrow<0x2::object::ID>(&v3), 112);
        let v4 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v4), 113);
        assert!(arg4 == *0x1::option::borrow<0x2::object::ID>(&v4), 113);
        let v5 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 5);
        assert!(0x1::option::is_some<0x2::object::ID>(&v5), 114);
        assert!(arg5 == *0x1::option::borrow<0x2::object::ID>(&v5), 114);
        let v6 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 6);
        assert!(0x1::option::is_some<0x2::object::ID>(&v6), 115);
        assert!(arg6 == *0x1::option::borrow<0x2::object::ID>(&v6), 115);
        let v7 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 7);
        assert!(0x1::option::is_some<0x2::object::ID>(&v7), 116);
        assert!(arg7 == *0x1::option::borrow<0x2::object::ID>(&v7), 116);
        let v8 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 8);
        assert!(0x1::option::is_some<0x2::object::ID>(&v8), 117);
        assert!(arg8 == *0x1::option::borrow<0x2::object::ID>(&v8), 117);
    }

    public(friend) fun validate_cetus_core(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<0x2::sui::SUI>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 110);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 110);
        let v2 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 7);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 116);
        assert!(arg2 == *0x1::option::borrow<0x2::object::ID>(&v2), 116);
        let v3 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 8);
        assert!(0x1::option::is_some<0x2::object::ID>(&v3), 117);
        assert!(arg3 == *0x1::option::borrow<0x2::object::ID>(&v3), 117);
    }

    public(friend) fun validate_l1_l3_for_sync<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u8) {
        validate_vault_config<T0>(arg0, arg1);
        validate_suilend_market<T0>(arg0, arg2);
        validate_scallop_config<T0>(arg0, arg3);
        validate_navi_storage<T0>(arg0, arg4, arg5);
    }

    public(friend) fun validate_l1_l3_protocols<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u8, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID) {
        validate_vault_config<T0>(arg0, arg1);
        validate_suilend_config<T0>(arg0, arg2, arg3);
        validate_scallop_config<T0>(arg0, arg4);
        validate_navi_config<T0>(arg0, arg5, arg6, arg7, arg8, arg9);
    }

    public(friend) fun validate_navi_config<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<T0>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_NAVI());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 104);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 104);
        let v2 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 106);
        assert!(arg3 == *0x1::option::borrow<0x2::object::ID>(&v2), 106);
        let v3 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v3), 107);
        assert!(arg4 == *0x1::option::borrow<0x2::object::ID>(&v3), 107);
        let v4 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v4), 108);
        assert!(arg5 == *0x1::option::borrow<0x2::object::ID>(&v4), 108);
        let v5 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_value(&v0, 0);
        assert!(0x1::option::is_some<u64>(&v5), 105);
        assert!((arg2 as u64) == *0x1::option::borrow<u64>(&v5), 105);
    }

    public(friend) fun validate_navi_oracle<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<T0>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_NAVI());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 5);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 109);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 109);
    }

    public(friend) fun validate_navi_storage<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<T0>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_NAVI());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 104);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 104);
        let v2 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_value(&v0, 0);
        assert!(0x1::option::is_some<u64>(&v2), 105);
        assert!((arg2 as u64) == *0x1::option::borrow<u64>(&v2), 105);
    }

    public(friend) fun validate_scallop_config<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<T0>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_SCALLOP());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 103);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 103);
    }

    public(friend) fun validate_suilend_config<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<T0>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_SUILEND());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 101);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 101);
        let v2 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_value(&v0, 0);
        assert!(0x1::option::is_some<u64>(&v2), 102);
        assert!(arg2 == *0x1::option::borrow<u64>(&v2), 102);
    }

    public(friend) fun validate_suilend_market<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<T0>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_SUILEND());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 101);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 101);
    }

    public(friend) fun validate_vault_config<T0>(arg0: &0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID) {
        let v0 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::get_protocol_config<T0>(arg0, 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_allocation_plan::PROTOCOL_VAULT());
        let v1 = 0xb119db330c8b04afb704487ea50ee04d9d34f25c8745723764639456f48d2d9c::llv_pool::config_get_id(&v0, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 100);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v1), 100);
    }

    // decompiled from Move bytecode v6
}

