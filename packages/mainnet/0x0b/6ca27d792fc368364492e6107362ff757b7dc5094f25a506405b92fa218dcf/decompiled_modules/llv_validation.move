module 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation {
    fun assert_config_id(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::ProtocolConfig, arg1: u64, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::config_get_id(arg0, arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), arg3);
        assert!(arg2 == *0x1::option::borrow<0x2::object::ID>(&v0), arg3);
    }

    fun assert_config_value(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::ProtocolConfig, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::config_get_value(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), arg3);
        assert!(arg2 == *0x1::option::borrow<u64>(&v0), arg3);
    }

    public fun validate_all_for_sync<T0>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: u8, arg10: 0x2::object::ID, arg11: u64) {
        validate_vault_config<0x2::sui::SUI, T0>(arg0, arg1);
        validate_cetus_core<T0>(arg0, arg2, arg3, arg4);
        validate_suilend_market<0x2::sui::SUI, T0>(arg0, arg5);
        validate_scallop_market<0x2::sui::SUI, T0>(arg0, arg6);
        validate_navi_storage<0x2::sui::SUI, T0>(arg0, arg7, arg9);
        validate_navi_pool<0x2::sui::SUI, T0>(arg0, arg8);
        validate_alphalend_config<0x2::sui::SUI, T0>(arg0, arg10, arg11);
    }

    public fun validate_all_protocols<T0>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: u64, arg12: 0x2::object::ID, arg13: 0x2::object::ID, arg14: u8, arg15: 0x2::object::ID, arg16: 0x2::object::ID, arg17: 0x2::object::ID, arg18: 0x2::object::ID, arg19: u64) {
        validate_vault_config<0x2::sui::SUI, T0>(arg0, arg1);
        validate_cetus_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        validate_suilend_config<0x2::sui::SUI, T0>(arg0, arg10, arg11);
        validate_scallop_market<0x2::sui::SUI, T0>(arg0, arg12);
        validate_navi_config<0x2::sui::SUI, T0>(arg0, arg13, arg14, arg15, arg16, arg17);
        validate_alphalend_config<0x2::sui::SUI, T0>(arg0, arg18, arg19);
    }

    public fun validate_alphalend_config<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND());
        assert_config_id(&v0, 1, arg1, 118);
        assert_config_value(&v0, 0, arg2, 119);
    }

    public fun validate_cetus_config<T0>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<0x2::sui::SUI, T0>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS());
        assert_config_id(&v0, 1, arg1, 110);
        assert_config_id(&v0, 2, arg2, 111);
        assert_config_id(&v0, 3, arg3, 112);
        assert_config_id(&v0, 4, arg4, 113);
        assert_config_id(&v0, 5, arg5, 114);
        assert_config_id(&v0, 6, arg6, 115);
        assert_config_id(&v0, 7, arg7, 116);
        assert_config_id(&v0, 8, arg8, 117);
    }

    public fun validate_cetus_core<T0>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<0x2::sui::SUI, T0>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS());
        assert_config_id(&v0, 1, arg1, 110);
        assert_config_id(&v0, 7, arg2, 116);
        assert_config_id(&v0, 8, arg3, 117);
    }

    public fun validate_l1_l3_for_sync<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u8, arg7: 0x2::object::ID, arg8: u64) {
        validate_vault_config<T0, T1>(arg0, arg1);
        validate_suilend_market<T0, T1>(arg0, arg2);
        validate_scallop_market<T0, T1>(arg0, arg3);
        validate_navi_storage<T0, T1>(arg0, arg4, arg6);
        validate_navi_pool<T0, T1>(arg0, arg5);
        validate_alphalend_config<T0, T1>(arg0, arg7, arg8);
    }

    public fun validate_l1_l3_protocols<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u8, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: u64) {
        validate_vault_config<T0, T1>(arg0, arg1);
        validate_suilend_config<T0, T1>(arg0, arg2, arg3);
        validate_scallop_market<T0, T1>(arg0, arg4);
        validate_navi_config<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg9);
        validate_alphalend_config<T0, T1>(arg0, arg10, arg11);
    }

    public fun validate_navi_config<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 1, arg1, 104);
        assert_config_id(&v0, 2, arg3, 106);
        assert_config_id(&v0, 3, arg4, 107);
        assert_config_id(&v0, 4, arg5, 108);
        assert_config_value(&v0, 0, (arg2 as u64), 105);
    }

    public fun validate_navi_oracle<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 5, arg1, 109);
    }

    public fun validate_navi_pool<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 2, arg1, 106);
    }

    public fun validate_navi_reward_claim_config<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 1, arg1, 104);
        assert_config_id(&v0, 4, arg2, 108);
    }

    public fun validate_navi_storage<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 1, arg1, 104);
        assert_config_value(&v0, 0, (arg2 as u64), 105);
    }

    public fun validate_scallop_claim_config<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        validate_scallop_config_with_spool<T0, T1>(arg0, arg1, arg2, arg3);
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 4, arg4, 123);
    }

    public fun validate_scallop_config<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 1, arg1, 103);
        assert_config_id(&v0, 2, arg2, 120);
    }

    public fun validate_scallop_config_with_spool<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        validate_scallop_config<T0, T1>(arg0, arg1, arg2);
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 3, arg3, 122);
    }

    public fun validate_scallop_market<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 1, arg1, 103);
    }

    public fun validate_suilend_config<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND());
        assert_config_id(&v0, 1, arg1, 101);
        assert_config_value(&v0, 0, arg2, 102);
    }

    public fun validate_suilend_config_with_pyth<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID) {
        validate_suilend_config<T0, T1>(arg0, arg1, arg2);
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND());
        assert_config_id(&v0, 2, arg3, 121);
    }

    public fun validate_suilend_market<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND());
        assert_config_id(&v0, 1, arg1, 101);
    }

    public fun validate_vault_config<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_VAULT());
        assert_config_id(&v0, 2, arg1, 100);
    }

    // decompiled from Move bytecode v7
}

