module 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_validation {
    fun assert_config_id(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::ProtocolConfig, arg1: u64, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::config_get_id(arg0, arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), arg3);
        assert!(arg2 == *0x1::option::borrow<0x2::object::ID>(&v0), arg3);
    }

    fun assert_config_value(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::ProtocolConfig, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::config_get_value(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), arg3);
        assert!(arg2 == *0x1::option::borrow<u64>(&v0), arg3);
    }

    public fun validate_alphalend_config<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_ALPHALEND());
        assert_config_id(&v0, 1, arg1, 118);
        assert_config_value(&v0, 0, arg2, 119);
    }

    public fun validate_alphalend_protocol<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_ALPHALEND());
        assert_config_id(&v0, 1, arg1, 118);
    }

    public fun validate_cetus_config<T0>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<0x2::sui::SUI, T0>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_CETUS());
        assert_config_id(&v0, 1, arg1, 110);
        assert_config_id(&v0, 2, arg2, 111);
        assert_config_id(&v0, 3, arg3, 112);
        assert_config_id(&v0, 4, arg4, 113);
        assert_config_id(&v0, 5, arg5, 114);
        assert_config_id(&v0, 6, arg6, 115);
        assert_config_id(&v0, 7, arg7, 116);
        assert_config_id(&v0, 8, arg8, 117);
    }

    public fun validate_cetus_core<T0>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<0x2::sui::SUI, T0>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_CETUS());
        assert_config_id(&v0, 1, arg1, 110);
        assert_config_id(&v0, 7, arg2, 116);
        assert_config_id(&v0, 8, arg3, 117);
    }

    public fun validate_navi_config<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 1, arg1, 104);
        assert_config_id(&v0, 2, arg3, 106);
        assert_config_id(&v0, 3, arg4, 107);
        assert_config_id(&v0, 4, arg5, 108);
        assert_config_value(&v0, 0, (arg2 as u64), 105);
    }

    public fun validate_navi_oracle<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 5, arg1, 109);
    }

    public fun validate_navi_pool<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 2, arg1, 106);
    }

    public fun validate_navi_reward_claim_config<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 1, arg1, 104);
        assert_config_id(&v0, 4, arg2, 108);
    }

    public fun validate_navi_reward_fund<T0, T1, T2>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_NAVI());
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()));
        let v2 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::config_get_typed_id(&v0, &v1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 125);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&v2), 124);
    }

    public fun validate_navi_storage<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_NAVI());
        assert_config_id(&v0, 1, arg1, 104);
        assert_config_value(&v0, 0, (arg2 as u64), 105);
    }

    public fun validate_scallop_claim_config<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        validate_scallop_config_with_spool<T0, T1>(arg0, arg1, arg2, arg3);
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 4, arg4, 123);
    }

    public fun validate_scallop_config<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 1, arg1, 103);
        assert_config_id(&v0, 2, arg2, 120);
    }

    public fun validate_scallop_config_with_spool<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        validate_scallop_config<T0, T1>(arg0, arg1, arg2);
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 3, arg3, 122);
    }

    public fun validate_scallop_market<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_SCALLOP());
        assert_config_id(&v0, 1, arg1, 103);
    }

    public fun validate_suilend_config<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_SUILEND());
        assert_config_id(&v0, 1, arg1, 101);
        assert_config_value(&v0, 0, arg2, 102);
    }

    public fun validate_suilend_config_with_pyth<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID) {
        validate_suilend_config<T0, T1>(arg0, arg1, arg2);
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_SUILEND());
        assert_config_id(&v0, 2, arg3, 121);
    }

    public fun validate_suilend_market<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_SUILEND());
        assert_config_id(&v0, 1, arg1, 101);
    }

    public fun validate_vault_config<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::get_protocol_config<T0, T1>(arg0, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_allocation_plan::PROTOCOL_VAULT());
        assert_config_id(&v0, 1, arg1, 126);
        assert_config_id(&v0, 2, arg2, 100);
    }

    // decompiled from Move bytecode v7
}

