module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_otc_entry {
    struct OtcConfig has drop, store {
        round: u64,
        size: u64,
        price: u64,
        fee_bp: u64,
        expiration_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    entry fun add_otc_config(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_authority(arg0, arg8);
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(v0, 0x1::string::utf8(b"otc_configs"))) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<address, 0x2::table::Table<u64, OtcConfig>>>(v0, 0x1::string::utf8(b"otc_configs"), 0x2::table::new<address, 0x2::table::Table<u64, OtcConfig>>(arg8));
        };
        let v12 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x2::table::Table<u64, OtcConfig>>>(v0, 0x1::string::utf8(b"otc_configs"));
        if (!0x2::table::contains<address, 0x2::table::Table<u64, OtcConfig>>(v12, arg1)) {
            0x2::table::add<address, 0x2::table::Table<u64, OtcConfig>>(v12, arg1, 0x2::table::new<u64, OtcConfig>(arg8));
        };
        let v13 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, OtcConfig>>(v12, arg1);
        if (0x2::table::contains<u64, OtcConfig>(v13, arg2)) {
            0x2::table::remove<u64, OtcConfig>(v13, arg2);
        };
        let v14 = OtcConfig{
            round            : arg3,
            size             : arg4,
            price            : arg5,
            fee_bp           : arg6,
            expiration_ts_ms : arg7,
            u64_padding      : vector[],
        };
        0x2::table::add<u64, OtcConfig>(v13, arg2, v14);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_add_otc_config_event(arg1, arg2, arg3, arg4, arg5, arg8);
    }

    fun expired(arg0: u64) : u64 {
        abort arg0
    }

    public(friend) fun get_user_otc_configs(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: address, arg2: vector<u64>) : vector<vector<u8>> {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(v0, 0x1::string::utf8(b"otc_configs"))) {
            return vector[]
        };
        let v12 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x2::table::Table<u64, OtcConfig>>>(v0, 0x1::string::utf8(b"otc_configs"));
        if (!0x2::table::contains<address, 0x2::table::Table<u64, OtcConfig>>(v12, arg1)) {
            return vector[]
        };
        let v13 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, OtcConfig>>(v12, arg1);
        let v14 = vector[];
        0x1::vector::reverse<u64>(&mut arg2);
        let v15 = 0;
        while (v15 < 0x1::vector::length<u64>(&arg2)) {
            let v16 = 0x1::vector::pop_back<u64>(&mut arg2);
            if (0x2::table::contains<u64, OtcConfig>(v13, v16)) {
                let v17 = 0x1::bcs::to_bytes<u64>(&v16);
                0x1::vector::append<u8>(&mut v17, 0x1::bcs::to_bytes<OtcConfig>(0x2::table::borrow<u64, OtcConfig>(v13, v16)));
                0x1::vector::push_back<vector<u8>>(&mut v14, v17);
            };
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        v14
    }

    fun invalid_index(arg0: u64) : u64 {
        abort arg0
    }

    fun invalid_user(arg0: u64) : u64 {
        abort arg0
    }

    public fun otc<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg1);
        let (v0, _, _, _, v4, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x2::tx_context::sender(arg4);
        let v13 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x2::table::Table<u64, OtcConfig>>>(v0, 0x1::string::utf8(b"otc_configs"));
        assert!(0x2::table::contains<address, 0x2::table::Table<u64, OtcConfig>>(v13, v12), invalid_user(arg1));
        let v14 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, OtcConfig>>(v13, v12);
        assert!(0x2::table::contains<u64, OtcConfig>(v14, arg1), invalid_index(arg1));
        let v15 = 0x2::table::remove<u64, OtcConfig>(v14, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) <= v15.expiration_ts_ms, expired(arg1));
        let v16 = (((v15.price as u128) * (v15.size as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_size_decimal(v4, arg1)) as u128) * (v15.fee_bp as u128) / 10000) as u64);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::otc_<T0, T1>(arg0, arg1, 0x1::option::some<u64>(v15.round), v15.price, v15.size, arg2, 0x2::balance::split<T1>(&mut arg2, v16), 0x2::balance::zero<T1>(), 0x2::balance::zero<T1>(), 0x2::balance::zero<T1>(), arg3, arg4);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_otc_event(arg0, arg1, v15.price, v15.size, 0x2::balance::value<T1>(&arg2), v16, 0, 0, 0, arg4);
    }

    entry fun remove_otc_config(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_authority(arg0, arg3);
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        0x2::table::remove<u64, OtcConfig>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, OtcConfig>>(0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x2::table::Table<u64, OtcConfig>>>(v0, 0x1::string::utf8(b"otc_configs")), arg1), arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_remove_otc_config_event(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

