module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::fee_quoter {
    struct FeeQuoterState has store, key {
        id: 0x2::object::UID,
        max_fee_juels_per_msg: u256,
        link_token: address,
        token_price_staleness_threshold: u64,
        fee_tokens: vector<address>,
        usd_per_unit_gas_by_dest_chain: 0x2::table::Table<u64, TimestampedPrice>,
        usd_per_token: 0x2::table::Table<address, TimestampedPrice>,
        dest_chain_configs: 0x2::table::Table<u64, DestChainConfig>,
        token_transfer_fee_configs: 0x2::table::Table<u64, 0x2::table::Table<address, TokenTransferFeeConfig>>,
        premium_multiplier_wei_per_eth: 0x2::table::Table<address, u64>,
    }

    struct StaticConfig has copy, drop {
        max_fee_juels_per_msg: u256,
        link_token: address,
        token_price_staleness_threshold: u64,
    }

    struct FeeQuoterCap has store, key {
        id: 0x2::object::UID,
    }

    struct DestChainConfig has copy, drop, store {
        is_enabled: bool,
        max_number_of_tokens_per_msg: u16,
        max_data_bytes: u32,
        max_per_msg_gas_limit: u32,
        dest_gas_overhead: u32,
        dest_gas_per_payload_byte_base: u8,
        dest_gas_per_payload_byte_high: u8,
        dest_gas_per_payload_byte_threshold: u16,
        dest_data_availability_overhead_gas: u32,
        dest_gas_per_data_availability_byte: u16,
        dest_data_availability_multiplier_bps: u16,
        chain_family_selector: vector<u8>,
        enforce_out_of_order: bool,
        default_token_fee_usd_cents: u16,
        default_token_dest_gas_overhead: u32,
        default_tx_gas_limit: u32,
        gas_multiplier_wei_per_eth: u64,
        gas_price_staleness_threshold: u32,
        network_fee_usd_cents: u32,
    }

    struct TokenTransferFeeConfig has copy, drop, store {
        min_fee_usd_cents: u32,
        max_fee_usd_cents: u32,
        deci_bps: u16,
        dest_gas_overhead: u32,
        dest_bytes_overhead: u32,
        is_enabled: bool,
    }

    struct TimestampedPrice has copy, drop, store {
        value: u256,
        timestamp: u64,
    }

    struct FeeTokenAdded has copy, drop {
        fee_token: address,
    }

    struct FeeTokenRemoved has copy, drop {
        fee_token: address,
    }

    struct TokenTransferFeeConfigAdded has copy, drop {
        dest_chain_selector: u64,
        token: address,
        token_transfer_fee_config: TokenTransferFeeConfig,
    }

    struct TokenTransferFeeConfigRemoved has copy, drop {
        dest_chain_selector: u64,
        token: address,
    }

    struct UsdPerTokenUpdated has copy, drop {
        token: address,
        usd_per_token: u256,
        timestamp: u64,
    }

    struct UsdPerUnitGasUpdated has copy, drop {
        dest_chain_selector: u64,
        usd_per_unit_gas: u256,
        timestamp: u64,
    }

    struct DestChainAdded has copy, drop {
        dest_chain_selector: u64,
        dest_chain_config: DestChainConfig,
    }

    struct DestChainConfigUpdated has copy, drop {
        dest_chain_selector: u64,
        dest_chain_config: DestChainConfig,
    }

    struct PremiumMultiplierWeiPerEthUpdated has copy, drop {
        token: address,
        premium_multiplier_wei_per_eth: u64,
    }

    public fun apply_dest_chain_config_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: u64, arg3: bool, arg4: u16, arg5: u32, arg6: u32, arg7: u32, arg8: u8, arg9: u8, arg10: u16, arg11: u32, arg12: u16, arg13: u16, arg14: vector<u8>, arg15: bool, arg16: u16, arg17: u32, arg18: u32, arg19: u64, arg20: u32, arg21: u32, arg22: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"apply_dest_chain_config_updates"), 1);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<FeeQuoterState>(arg0);
        assert!(arg2 != 0, 26);
        assert!(arg18 != 0 && arg18 <= arg6, 27);
        let v1 = if (arg14 == x"2812d52c") {
            true
        } else if (arg14 == x"1e10bdc4") {
            true
        } else if (arg14 == x"ac77ffec") {
            true
        } else {
            arg14 == x"c4e05953"
        };
        assert!(v1, 28);
        let v2 = DestChainConfig{
            is_enabled                            : arg3,
            max_number_of_tokens_per_msg          : arg4,
            max_data_bytes                        : arg5,
            max_per_msg_gas_limit                 : arg6,
            dest_gas_overhead                     : arg7,
            dest_gas_per_payload_byte_base        : arg8,
            dest_gas_per_payload_byte_high        : arg9,
            dest_gas_per_payload_byte_threshold   : arg10,
            dest_data_availability_overhead_gas   : arg11,
            dest_gas_per_data_availability_byte   : arg12,
            dest_data_availability_multiplier_bps : arg13,
            chain_family_selector                 : arg14,
            enforce_out_of_order                  : arg15,
            default_token_fee_usd_cents           : arg16,
            default_token_dest_gas_overhead       : arg17,
            default_tx_gas_limit                  : arg18,
            gas_multiplier_wei_per_eth            : arg19,
            gas_price_staleness_threshold         : arg20,
            network_fee_usd_cents                 : arg21,
        };
        if (0x2::table::contains<u64, DestChainConfig>(&v0.dest_chain_configs, arg2)) {
            *0x2::table::borrow_mut<u64, DestChainConfig>(&mut v0.dest_chain_configs, arg2) = v2;
            let v3 = DestChainConfigUpdated{
                dest_chain_selector : arg2,
                dest_chain_config   : v2,
            };
            0x2::event::emit<DestChainConfigUpdated>(v3);
        } else {
            0x2::table::add<u64, DestChainConfig>(&mut v0.dest_chain_configs, arg2, v2);
            let v4 = DestChainAdded{
                dest_chain_selector : arg2,
                dest_chain_config   : v2,
            };
            0x2::event::emit<DestChainAdded>(v4);
        };
    }

    public fun apply_fee_token_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<address>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"apply_fee_token_updates"), 1);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<FeeQuoterState>(arg0);
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            let (v4, v5) = 0x1::vector::index_of<address>(&v0.fee_tokens, &v3);
            if (v4) {
                0x1::vector::remove<address>(&mut v0.fee_tokens, v5);
                let v6 = FeeTokenRemoved{fee_token: v3};
                0x2::event::emit<FeeTokenRemoved>(v6);
            };
            v2 = v2 + 1;
        };
        let v7 = &arg3;
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(v7)) {
            let v9 = *0x1::vector::borrow<address>(v7, v8);
            let (v10, _) = 0x1::vector::index_of<address>(&v0.fee_tokens, &v9);
            if (!v10) {
                0x1::vector::push_back<address>(&mut v0.fee_tokens, v9);
                let v12 = FeeTokenAdded{fee_token: v9};
                0x2::event::emit<FeeTokenAdded>(v12);
            };
            v8 = v8 + 1;
        };
    }

    public fun apply_premium_multiplier_wei_per_eth_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"apply_premium_multiplier_wei_per_eth_updates"), 1);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 36);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<FeeQuoterState>(arg0);
        let v1 = &arg2;
        let v2 = &arg3;
        let v3 = 0x1::vector::length<address>(v1);
        assert!(v3 == 0x1::vector::length<u64>(v2), 13906837687626629119);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = *0x1::vector::borrow<address>(v1, v4);
            let v6 = *0x1::vector::borrow<u64>(v2, v4);
            if (0x2::table::contains<address, u64>(&v0.premium_multiplier_wei_per_eth, v5)) {
                0x2::table::remove<address, u64>(&mut v0.premium_multiplier_wei_per_eth, v5);
            };
            0x2::table::add<address, u64>(&mut v0.premium_multiplier_wei_per_eth, v5, v6);
            let v7 = PremiumMultiplierWeiPerEthUpdated{
                token                          : v5,
                premium_multiplier_wei_per_eth : v6,
            };
            0x2::event::emit<PremiumMultiplierWeiPerEthUpdated>(v7);
            v4 = v4 + 1;
        };
    }

    public fun apply_token_transfer_fee_config_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: u64, arg3: vector<address>, arg4: vector<u32>, arg5: vector<u32>, arg6: vector<u16>, arg7: vector<u32>, arg8: vector<u32>, arg9: vector<bool>, arg10: vector<address>, arg11: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"apply_token_transfer_fee_config_updates"), 1);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<FeeQuoterState>(arg0);
        if (!0x2::table::contains<u64, 0x2::table::Table<address, TokenTransferFeeConfig>>(&v0.token_transfer_fee_configs, arg2)) {
            0x2::table::add<u64, 0x2::table::Table<address, TokenTransferFeeConfig>>(&mut v0.token_transfer_fee_configs, arg2, 0x2::table::new<address, TokenTransferFeeConfig>(arg11));
        };
        let v1 = 0x2::table::borrow_mut<u64, 0x2::table::Table<address, TokenTransferFeeConfig>>(&mut v0.token_transfer_fee_configs, arg2);
        let v2 = 0x1::vector::length<address>(&arg3);
        assert!(v2 == 0x1::vector::length<u32>(&arg4), 8);
        assert!(v2 == 0x1::vector::length<u32>(&arg5), 8);
        assert!(v2 == 0x1::vector::length<u16>(&arg6), 8);
        assert!(v2 == 0x1::vector::length<u32>(&arg7), 8);
        assert!(v2 == 0x1::vector::length<u32>(&arg8), 8);
        assert!(v2 == 0x1::vector::length<bool>(&arg9), 8);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<address>(&arg3, v3);
            let v5 = TokenTransferFeeConfig{
                min_fee_usd_cents   : *0x1::vector::borrow<u32>(&arg4, v3),
                max_fee_usd_cents   : *0x1::vector::borrow<u32>(&arg5, v3),
                deci_bps            : *0x1::vector::borrow<u16>(&arg6, v3),
                dest_gas_overhead   : *0x1::vector::borrow<u32>(&arg7, v3),
                dest_bytes_overhead : *0x1::vector::borrow<u32>(&arg8, v3),
                is_enabled          : *0x1::vector::borrow<bool>(&arg9, v3),
            };
            assert!(v5.min_fee_usd_cents < v5.max_fee_usd_cents, 32);
            assert!(v5.dest_bytes_overhead >= 32, 33);
            if (0x2::table::contains<address, TokenTransferFeeConfig>(v1, v4)) {
                0x2::table::remove<address, TokenTransferFeeConfig>(v1, v4);
            };
            0x2::table::add<address, TokenTransferFeeConfig>(v1, v4, v5);
            let v6 = TokenTransferFeeConfigAdded{
                dest_chain_selector       : arg2,
                token                     : v4,
                token_transfer_fee_config : v5,
            };
            0x2::event::emit<TokenTransferFeeConfigAdded>(v6);
            v3 = v3 + 1;
        };
        let v7 = &arg10;
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(v7)) {
            let v9 = *0x1::vector::borrow<address>(v7, v8);
            if (0x2::table::contains<address, TokenTransferFeeConfig>(v1, v9)) {
                0x2::table::remove<address, TokenTransferFeeConfig>(v1, v9);
                let v10 = TokenTransferFeeConfigRemoved{
                    dest_chain_selector : arg2,
                    token               : v9,
                };
                0x2::event::emit<TokenTransferFeeConfigRemoved>(v10);
            };
            v8 = v8 + 1;
        };
    }

    fun calc_usd_value_from_token_amount(arg0: u64, arg1: u256) : u256 {
        (arg0 as u256) * arg1 / 1000000000000000000
    }

    public fun convert_token_amount(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: address, arg2: u64, arg3: address) : u64 {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"convert_token_amount"), 1);
        convert_token_amount_internal(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0), arg1, arg2, arg3)
    }

    fun convert_token_amount_internal(arg0: &FeeQuoterState, arg1: address, arg2: u64, arg3: address) : u64 {
        let v0 = get_validated_token_price(arg0, arg1);
        let v1 = get_validated_token_price(arg0, arg3);
        let v2 = (arg2 as u256) * v0.value / v1.value;
        assert!(v2 <= 18446744073709551615, 29);
        (v2 as u64)
    }

    fun decode_generic_extra_args(arg0: &DestChainConfig, arg1: vector<u8>) : (u256, bool) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        if (v0 == 0) {
            ((arg0.default_tx_gas_limit as u256), false)
        } else {
            assert!(v0 >= 4, 21);
            assert!(slice<u8>(&arg1, 0, 4) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::generic_extra_args_v2_tag(), 20);
            decode_generic_extra_args_v2(slice<u8>(&arg1, 4, v0 - 4))
        }
    }

    fun decode_generic_extra_args_v2(arg0: vector<u8>) : (u256, bool) {
        let v0 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(arg0);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v0);
        (0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u256(&mut v0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_bool(&mut v0))
    }

    fun decode_sui_extra_args(arg0: vector<u8>) : (u64, bool, vector<u8>, vector<vector<u8>>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(slice<u8>(&arg0, 0, 4) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::sui_extra_args_v1_tag(), 20);
        assert!(v0 >= 4, 21);
        decode_sui_extra_args_v1(slice<u8>(&arg0, 4, v0 - 4))
    }

    fun decode_sui_extra_args_v1(arg0: vector<u8>) : (u64, bool, vector<u8>, vector<vector<u8>>) {
        let v0 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(arg0);
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v0));
            v2 = v2 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v0);
        (0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_bool(&mut v0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v0), v1)
    }

    fun decode_svm_extra_args(arg0: vector<u8>) : (u32, u64, bool, vector<u8>, vector<vector<u8>>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(slice<u8>(&arg0, 0, 4) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::svm_extra_args_v1_tag(), 20);
        assert!(v0 >= 4, 21);
        decode_svm_extra_args_v1(slice<u8>(&arg0, 4, v0 - 4))
    }

    fun decode_svm_extra_args_v1(arg0: vector<u8>) : (u32, u64, bool, vector<u8>, vector<vector<u8>>) {
        let v0 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(arg0);
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v0));
            v2 = v2 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v0);
        (0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_bool(&mut v0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v0), v1)
    }

    public fun destroy_fee_quoter_cap(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: FeeQuoterCap) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        let FeeQuoterCap { id: v0 } = arg2;
        0x2::object::delete(v0);
    }

    fun get_data_availability_cost(arg0: &DestChainConfig, arg1: u256, arg2: u64, arg3: u64, arg4: u32) : u256 {
        (((480 + arg2 + arg3 * 288 + (arg4 as u64)) as u256) * (arg0.dest_gas_per_data_availability_byte as u256) + (arg0.dest_data_availability_overhead_gas as u256)) * arg1 * (arg0.dest_data_availability_multiplier_bps as u256) * 100000000000000
    }

    public fun get_dest_chain_config(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: u64) : DestChainConfig {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_dest_chain_config"), 1);
        *get_dest_chain_config_internal(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0), arg1)
    }

    public fun get_dest_chain_config_fields(arg0: DestChainConfig) : (bool, u16, u32, u32, u32, u8, u8, u16, u32, u16, u16, vector<u8>, bool, u16, u32, u32, u64, u32, u32) {
        (arg0.is_enabled, arg0.max_number_of_tokens_per_msg, arg0.max_data_bytes, arg0.max_per_msg_gas_limit, arg0.dest_gas_overhead, arg0.dest_gas_per_payload_byte_base, arg0.dest_gas_per_payload_byte_high, arg0.dest_gas_per_payload_byte_threshold, arg0.dest_data_availability_overhead_gas, arg0.dest_gas_per_data_availability_byte, arg0.dest_data_availability_multiplier_bps, arg0.chain_family_selector, arg0.enforce_out_of_order, arg0.default_token_fee_usd_cents, arg0.default_token_dest_gas_overhead, arg0.default_tx_gas_limit, arg0.gas_multiplier_wei_per_eth, arg0.gas_price_staleness_threshold, arg0.network_fee_usd_cents)
    }

    fun get_dest_chain_config_internal(arg0: &FeeQuoterState, arg1: u64) : &DestChainConfig {
        assert!(0x2::table::contains<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1), 3);
        0x2::table::borrow<u64, DestChainConfig>(&arg0.dest_chain_configs, arg1)
    }

    public fun get_dest_chain_gas_price(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: u64) : TimestampedPrice {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_dest_chain_gas_price"), 1);
        get_dest_chain_gas_price_internal(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0), arg1)
    }

    fun get_dest_chain_gas_price_internal(arg0: &FeeQuoterState, arg1: u64) : TimestampedPrice {
        assert!(0x2::table::contains<u64, TimestampedPrice>(&arg0.usd_per_unit_gas_by_dest_chain, arg1), 3);
        *0x2::table::borrow<u64, TimestampedPrice>(&arg0.usd_per_unit_gas_by_dest_chain, arg1)
    }

    public fun get_fee_tokens(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : vector<address> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_fee_tokens"), 1);
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0).fee_tokens
    }

    public fun get_premium_multiplier_wei_per_eth(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: address) : u64 {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_premium_multiplier_wei_per_eth"), 1);
        get_premium_multiplier_wei_per_eth_internal(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0), arg1)
    }

    fun get_premium_multiplier_wei_per_eth_internal(arg0: &FeeQuoterState, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.premium_multiplier_wei_per_eth, arg1), 4);
        *0x2::table::borrow<address, u64>(&arg0.premium_multiplier_wei_per_eth, arg1)
    }

    public fun get_static_config(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : StaticConfig {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_static_config"), 1);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0);
        StaticConfig{
            max_fee_juels_per_msg           : v0.max_fee_juels_per_msg,
            link_token                      : v0.link_token,
            token_price_staleness_threshold : v0.token_price_staleness_threshold,
        }
    }

    public fun get_static_config_fields(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : (u256, address, u64) {
        let v0 = get_static_config(arg0);
        (v0.max_fee_juels_per_msg, v0.link_token, v0.token_price_staleness_threshold)
    }

    public fun get_timestamped_price_fields(arg0: TimestampedPrice) : (u256, u64) {
        (arg0.value, arg0.timestamp)
    }

    public fun get_token_and_gas_prices(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0x2::clock::Clock, arg2: address, arg3: u64) : (u256, u256) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_token_and_gas_prices"), 1);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0);
        let v1 = get_dest_chain_config_internal(v0, arg3);
        assert!(v1.is_enabled, 5);
        let v2 = get_token_price_internal(v0, arg2);
        (v2.value, get_validated_gas_price_internal(v0, arg1, v1, arg3))
    }

    public fun get_token_price(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: address) : TimestampedPrice {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_token_price"), 1);
        get_token_price_internal(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0), arg1)
    }

    fun get_token_price_internal(arg0: &FeeQuoterState, arg1: address) : TimestampedPrice {
        assert!(0x2::table::contains<address, TimestampedPrice>(&arg0.usd_per_token, arg1), 4);
        *0x2::table::borrow<address, TimestampedPrice>(&arg0.usd_per_token, arg1)
    }

    public fun get_token_prices(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: vector<address>) : vector<TimestampedPrice> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_token_prices"), 1);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0);
        let v1 = &arg1;
        let v2 = 0x1::vector::empty<TimestampedPrice>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(v1)) {
            0x1::vector::push_back<TimestampedPrice>(&mut v2, get_token_price_internal(v0, *0x1::vector::borrow<address>(v1, v3)));
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_token_receiver(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_token_receiver"), 1);
        let v0 = get_dest_chain_config_internal(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0), arg1).chain_family_selector;
        if (v0 == x"2812d52c" || v0 == x"ac77ffec") {
            arg3
        } else if (v0 == x"c4e05953") {
            let (_, _, v4, _) = decode_sui_extra_args(arg2);
            v4
        } else {
            assert!(v0 == x"1e10bdc4", 11);
            let (_, _, _, v9, _) = decode_svm_extra_args(arg2);
            v9
        }
    }

    fun get_token_transfer_cost(arg0: &FeeQuoterState, arg1: &DestChainConfig, arg2: u64, arg3: address, arg4: TimestampedPrice, arg5: vector<address>, arg6: vector<u64>) : (u256, u32, u32) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6), 36);
        let v3 = &arg5;
        let v4 = &arg6;
        let v5 = 0x1::vector::length<address>(v3);
        assert!(v5 == 0x1::vector::length<u64>(v4), 13906838911692308479);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = *0x1::vector::borrow<address>(v3, v6);
            let v8 = get_token_transfer_fee_config_internal(arg0, arg2, v7);
            if (!v8.is_enabled) {
                v0 = v0 + (arg1.default_token_fee_usd_cents as u256) * 10000000000000000;
                v1 = v1 + arg1.default_token_dest_gas_overhead;
                v2 = v2 + 32;
            } else {
                let v9 = 0;
                if (v8.deci_bps > 0) {
                    let v10 = if (v7 == arg3) {
                        arg4
                    } else {
                        get_token_price_internal(arg0, v7)
                    };
                    let v11 = v10;
                    v9 = calc_usd_value_from_token_amount(*0x1::vector::borrow<u64>(v4, v6), v11.value) * (v8.deci_bps as u256) / 100000;
                };
                v1 = v1 + v8.dest_gas_overhead;
                v2 = v2 + v8.dest_bytes_overhead;
                let v12 = (v8.min_fee_usd_cents as u256) * 10000000000000000;
                let v13 = (v8.max_fee_usd_cents as u256) * 10000000000000000;
                let v14 = if (v9 < v12) {
                    v12
                } else if (v9 > v13) {
                    v13
                } else {
                    v9
                };
                v0 = v0 + v14;
            };
            v6 = v6 + 1;
        };
        (v0, v1, v2)
    }

    public fun get_token_transfer_fee_config(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: u64, arg2: address) : TokenTransferFeeConfig {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_token_transfer_fee_config"), 1);
        get_token_transfer_fee_config_internal(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0), arg1, arg2)
    }

    public fun get_token_transfer_fee_config_fields(arg0: TokenTransferFeeConfig) : (u32, u32, u16, u32, u32, bool) {
        (arg0.min_fee_usd_cents, arg0.max_fee_usd_cents, arg0.deci_bps, arg0.dest_gas_overhead, arg0.dest_bytes_overhead, arg0.is_enabled)
    }

    fun get_token_transfer_fee_config_internal(arg0: &FeeQuoterState, arg1: u64, arg2: address) : TokenTransferFeeConfig {
        let v0 = TokenTransferFeeConfig{
            min_fee_usd_cents   : 0,
            max_fee_usd_cents   : 0,
            deci_bps            : 0,
            dest_gas_overhead   : 0,
            dest_bytes_overhead : 0,
            is_enabled          : false,
        };
        if (!0x2::table::contains<u64, 0x2::table::Table<address, TokenTransferFeeConfig>>(&arg0.token_transfer_fee_configs, arg1)) {
            v0
        } else {
            let v2 = 0x2::table::borrow<u64, 0x2::table::Table<address, TokenTransferFeeConfig>>(&arg0.token_transfer_fee_configs, arg1);
            if (!0x2::table::contains<address, TokenTransferFeeConfig>(v2, arg2)) {
                v0
            } else {
                *0x2::table::borrow<address, TokenTransferFeeConfig>(v2, arg2)
            }
        }
    }

    public fun get_validated_fee(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<address>, arg6: vector<u64>, arg7: address, arg8: vector<u8>) : u64 {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"get_validated_fee"), 1);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6), 36);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0);
        let v1 = get_dest_chain_config_internal(v0, arg2);
        assert!(v1.is_enabled, 5);
        assert!(0x1::vector::contains<address>(&v0.fee_tokens, &arg7), 9);
        let v2 = v1.chain_family_selector;
        let v3 = 0x1::vector::length<u8>(&arg4);
        let v4 = 0x1::vector::length<address>(&arg5);
        validate_message(v1, v3, v4);
        let v5 = if (v2 == x"2812d52c" || v2 == x"ac77ffec") {
            resolve_generic_gas_limit(v1, arg8)
        } else if (v2 == x"c4e05953") {
            resolve_sui_gas_limit(v1, arg8)
        } else {
            assert!(v2 == x"1e10bdc4", 11);
            resolve_svm_gas_limit(v1, v0, arg2, arg8, arg3, v3, v4, arg5)
        };
        validate_dest_family_address(v2, arg3, v5);
        let v6 = get_token_price_internal(v0, arg7);
        assert!(v6.value > 0, 10);
        let v7 = get_validated_gas_price_internal(v0, arg1, v1, arg2);
        let (v8, v9, v10) = if (v4 > 0) {
            get_token_transfer_cost(v0, v1, arg2, arg7, v6, arg5, arg6)
        } else {
            ((v1.network_fee_usd_cents as u256) * 10000000000000000, 0, 0)
        };
        let v11 = if (v1.dest_data_availability_multiplier_bps > 0) {
            get_data_availability_cost(v1, v7 >> 112 & 5192296858534827628530496329220095, v3, v4, v10)
        } else {
            0
        };
        let v12 = (v3 as u256) + (v10 as u256);
        let v13 = v12 * (v1.dest_gas_per_payload_byte_base as u256);
        if (v12 > (v1.dest_gas_per_payload_byte_threshold as u256)) {
            v13 = (v1.dest_gas_per_payload_byte_base as u256) * (v1.dest_gas_per_payload_byte_threshold as u256) + (v12 - (v1.dest_gas_per_payload_byte_threshold as u256)) * (v1.dest_gas_per_payload_byte_high as u256);
        };
        let v14 = (((v1.dest_gas_overhead as u256) + (v9 as u256) + v13 + v5) * (v7 & 5192296858534827628530496329220095) * (v1.gas_multiplier_wei_per_eth as u256) + v8 * (get_premium_multiplier_wei_per_eth_internal(v0, arg7) as u256) + v11) / v6.value;
        assert!(v14 <= 18446744073709551615, 17);
        (v14 as u64)
    }

    fun get_validated_gas_price_internal(arg0: &FeeQuoterState, arg1: &0x2::clock::Clock, arg2: &DestChainConfig, arg3: u64) : u256 {
        let v0 = get_dest_chain_gas_price_internal(arg0, arg3);
        if (arg2.gas_price_staleness_threshold > 0) {
            assert!(0x2::clock::timestamp_ms(arg1) / 1000 - v0.timestamp <= (arg2.gas_price_staleness_threshold as u64), 12);
        };
        v0.value
    }

    fun get_validated_token_price(arg0: &FeeQuoterState, arg1: address) : TimestampedPrice {
        let v0 = get_token_price_internal(arg0, arg1);
        assert!(v0.value > 0 && v0.timestamp > 0, 4);
        v0
    }

    public fun initialize(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: u256, arg3: address, arg4: u64, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        assert!(!0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<FeeQuoterState>(arg0), 1);
        let v0 = FeeQuoterState{
            id                              : 0x2::object::new(arg6),
            max_fee_juels_per_msg           : arg2,
            link_token                      : arg3,
            token_price_staleness_threshold : arg4,
            fee_tokens                      : arg5,
            usd_per_unit_gas_by_dest_chain  : 0x2::table::new<u64, TimestampedPrice>(arg6),
            usd_per_token                   : 0x2::table::new<address, TimestampedPrice>(arg6),
            dest_chain_configs              : 0x2::table::new<u64, DestChainConfig>(arg6),
            token_transfer_fee_configs      : 0x2::table::new<u64, 0x2::table::Table<address, TokenTransferFeeConfig>>(arg6),
            premium_multiplier_wei_per_eth  : 0x2::table::new<address, u64>(arg6),
        };
        let v1 = new_fee_quoter_cap(arg0, arg1, arg6);
        0x2::transfer::public_transfer<FeeQuoterCap>(v1, 0x2::tx_context::sender(arg6));
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::add<FeeQuoterState>(arg0, arg1, v0, arg6);
    }

    public fun mcms_apply_dest_chain_config_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"apply_dest_chain_config_updates"), 38);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        apply_dest_chain_config_updates(arg0, v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_bool(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u16(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u16(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u16(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u16(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_bool(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u16(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3), arg3);
    }

    public fun mcms_apply_fee_token_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"apply_fee_token_updates"), 38);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<address>();
        let v9 = 0;
        while (v9 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v9 = v9 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        apply_fee_token_updates(arg0, v0, v6, v8, arg3);
    }

    public fun mcms_apply_premium_multiplier_wei_per_eth_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"apply_premium_multiplier_wei_per_eth_updates"), 38);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        while (v9 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u64>(&mut v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v3));
            v9 = v9 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        apply_premium_multiplier_wei_per_eth_updates(arg0, v0, v6, v8, arg3);
    }

    public fun mcms_apply_token_transfer_fee_config_updates(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"apply_token_transfer_fee_config_updates"), 38);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u32>();
        let v9 = 0;
        while (v9 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u32>(&mut v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3));
            v9 = v9 + 1;
        };
        let v10 = 0x1::vector::empty<u32>();
        let v11 = 0;
        while (v11 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u32>(&mut v10, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3));
            v11 = v11 + 1;
        };
        let v12 = 0x1::vector::empty<u16>();
        let v13 = 0;
        while (v13 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u16>(&mut v12, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u16(&mut v3));
            v13 = v13 + 1;
        };
        let v14 = 0x1::vector::empty<u32>();
        let v15 = 0;
        while (v15 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u32>(&mut v14, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<u32>();
        let v17 = 0;
        while (v17 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u32>(&mut v16, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u32(&mut v3));
            v17 = v17 + 1;
        };
        let v18 = 0x1::vector::empty<bool>();
        let v19 = 0;
        while (v19 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<bool>(&mut v18, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_bool(&mut v3));
            v19 = v19 + 1;
        };
        let v20 = 0x1::vector::empty<address>();
        let v21 = 0;
        while (v21 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v20, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v21 = v21 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        apply_token_transfer_fee_config_updates(arg0, v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v3), v6, v8, v10, v12, v14, v16, v18, v20, arg3);
    }

    public fun mcms_update_prices_with_owner_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: &0x2::clock::Clock, arg3: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg3);
        assert!(v1 == 0x1::string::utf8(b"update_prices_with_owner_cap"), 38);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x2::clock::Clock>(arg2));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u256>();
        let v9 = 0;
        while (v9 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u256>(&mut v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u256(&mut v3));
            v9 = v9 + 1;
        };
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0;
        while (v11 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u64>(&mut v10, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v3));
            v11 = v11 + 1;
        };
        let v12 = 0x1::vector::empty<u256>();
        let v13 = 0;
        while (v13 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u256>(&mut v12, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u256(&mut v3));
            v13 = v13 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        update_prices_with_owner_cap(arg0, v0, arg2, v6, v8, v10, v12, arg4);
    }

    public fun new_fee_quoter_cap(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : FeeQuoterCap {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"new_fee_quoter_cap"), 1);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        FeeQuoterCap{id: 0x2::object::new(arg2)}
    }

    fun process_chain_family_selector(arg0: &DestChainConfig, arg1: bool, arg2: vector<u8>) : (vector<u8>, bool) {
        let v0 = arg0.chain_family_selector;
        if (v0 == x"2812d52c" || v0 == x"ac77ffec") {
            let (v3, v4) = decode_generic_extra_args(arg0, arg2);
            (0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::encode_generic_extra_args_v2(v3, v4), v4)
        } else {
            let v5 = if (v0 == x"c4e05953") {
                let (v6, v7, v8, _) = decode_sui_extra_args(arg2);
                let v10 = v8;
                if (arg1) {
                    assert!(0x1::vector::length<u8>(&v10) == 32, 22);
                    assert!(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(v10) > 0, 22);
                };
                assert!(!arg0.enforce_out_of_order || v7, 19);
                assert!(v6 <= (arg0.max_per_msg_gas_limit as u64), 18);
                v7
            } else {
                assert!(v0 == x"1e10bdc4", 11);
                let (v11, _, v13, v14, _) = decode_svm_extra_args(arg2);
                let v16 = v14;
                if (arg1) {
                    assert!(0x1::vector::length<u8>(&v16) == 32, 22);
                    assert!(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(v16) > 0, 22);
                };
                assert!(!arg0.enforce_out_of_order || v13, 19);
                assert!(v11 <= arg0.max_per_msg_gas_limit, 23);
                v13
            };
            (arg2, v5)
        }
    }

    public fun process_message_args(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: u64, arg2: address, arg3: u64, arg4: vector<u8>, arg5: vector<address>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>) : (u256, bool, vector<u8>, vector<vector<u8>>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"process_message_args"), 1);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<vector<u8>>(&arg6), 36);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<vector<u8>>(&arg7), 36);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<FeeQuoterState>(arg0);
        let v1 = if (arg2 == v0.link_token) {
            arg3
        } else {
            convert_token_amount_internal(v0, arg2, arg3, v0.link_token)
        };
        let v2 = (v1 as u256) * 10000000000;
        assert!(v2 <= v0.max_fee_juels_per_msg, 24);
        let v3 = get_dest_chain_config_internal(v0, arg1);
        let (v4, v5) = process_chain_family_selector(v3, !0x1::vector::is_empty<vector<u8>>(&arg6), arg4);
        (v2, v5, v4, process_pool_return_data(v0, v3, arg1, arg5, arg6, arg7))
    }

    fun process_pool_return_data(arg0: &FeeQuoterState, arg1: &DestChainConfig, arg2: u64, arg3: vector<address>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>) : vector<vector<u8>> {
        let v0 = 0x1::vector::length<vector<u8>>(&arg4);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg5), 36);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 36);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg5, v2));
            let v4 = get_token_transfer_fee_config_internal(arg0, arg2, *0x1::vector::borrow<address>(&arg3, v2));
            if (v3 > (32 as u64)) {
                assert!(v3 <= (v4.dest_bytes_overhead as u64), 25);
            };
            validate_dest_family_address(arg1.chain_family_selector, *0x1::vector::borrow<vector<u8>>(&arg4, v2), 1);
            let v5 = if (v4.is_enabled) {
                v4.dest_gas_overhead
            } else {
                arg1.default_token_dest_gas_overhead
            };
            let v6 = v5;
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::bcs::to_bytes<u32>(&v6));
            v2 = v2 + 1;
        };
        v1
    }

    fun resolve_generic_gas_limit(arg0: &DestChainConfig, arg1: vector<u8>) : u256 {
        let (v0, v1) = decode_generic_extra_args(arg0, arg1);
        assert!(v0 <= (arg0.max_per_msg_gas_limit as u256), 18);
        assert!(!arg0.enforce_out_of_order || v1, 19);
        v0
    }

    fun resolve_sui_gas_limit(arg0: &DestChainConfig, arg1: vector<u8>) : u256 {
        let (v0, v1, _, _) = decode_sui_extra_args(arg1);
        assert!(v0 <= (arg0.max_per_msg_gas_limit as u64), 18);
        assert!(!arg0.enforce_out_of_order || v1, 19);
        (v0 as u256)
    }

    fun resolve_svm_gas_limit(arg0: &DestChainConfig, arg1: &FeeQuoterState, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<address>) : u256 {
        assert!(0x1::vector::length<u8>(&arg3) > 0, 21);
        let (v0, v1, v2, v3, v4) = decode_svm_extra_args(arg3);
        let v5 = v4;
        let v6 = v3;
        assert!(!arg0.enforce_out_of_order || v2, 19);
        assert!(v0 <= arg0.max_per_msg_gas_limit, 23);
        let v7 = 0x1::vector::length<vector<u8>>(&v5);
        let v8 = arg5;
        assert!(0x1::vector::length<u8>(&arg4) == 32, 34);
        if (0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(arg4) == 0) {
            assert!(v7 == 0, 30);
        } else {
            v8 = arg5 + (v7 + 2) * 32;
        };
        let v9 = 0;
        while (v9 < v7) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&v5, v9)) == 32, 35);
            v9 = v9 + 1;
        };
        if (arg6 > 0) {
            assert!(0x1::vector::length<u8>(&v6) == 32 && 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(v6) != 0, 22);
        };
        assert!(v7 <= 64, 30);
        assert!(v1 >> (v7 as u8) == 0, 31);
        v8 = v8 + arg6 * 300;
        let v10 = 0;
        while (v10 < arg6) {
            let v11 = get_token_transfer_fee_config_internal(arg1, arg2, *0x1::vector::borrow<address>(&arg7, v10));
            let v12 = v11.dest_bytes_overhead;
            if (v12 > 0) {
                v8 = v8 + (v12 as u64);
            } else {
                v8 = v8 + (32 as u64);
            };
            v10 = v10 + 1;
        };
        assert!(v8 <= (arg0.max_data_bytes as u64), 13);
        (v0 as u256)
    }

    fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg1 + arg2 <= 0x1::vector::length<T0>(arg0), 2);
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg1 + arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"FeeQuoter 1.6.0")
    }

    public fun update_prices(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &FeeQuoterCap, arg2: &0x2::clock::Clock, arg3: vector<address>, arg4: vector<u256>, arg5: vector<u64>, arg6: vector<u256>, arg7: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"update_prices"), 1);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u256>(&arg4), 6);
        assert!(0x1::vector::length<u64>(&arg5) == 0x1::vector::length<u256>(&arg6), 7);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<FeeQuoterState>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = &arg3;
        let v3 = &arg4;
        let v4 = 0x1::vector::length<address>(v2);
        assert!(v4 == 0x1::vector::length<u256>(v3), 13906836884467744767);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = 0x1::vector::borrow<address>(v2, v5);
            let v7 = 0x1::vector::borrow<u256>(v3, v5);
            let v8 = TimestampedPrice{
                value     : *v7,
                timestamp : v1,
            };
            if (0x2::table::contains<address, TimestampedPrice>(&v0.usd_per_token, *v6)) {
                0x2::table::remove<address, TimestampedPrice>(&mut v0.usd_per_token, *v6);
            };
            0x2::table::add<address, TimestampedPrice>(&mut v0.usd_per_token, *v6, v8);
            let v9 = UsdPerTokenUpdated{
                token         : *v6,
                usd_per_token : *v7,
                timestamp     : v1,
            };
            0x2::event::emit<UsdPerTokenUpdated>(v9);
            v5 = v5 + 1;
        };
        let v10 = &arg5;
        let v11 = &arg6;
        let v12 = 0x1::vector::length<u64>(v10);
        assert!(v12 == 0x1::vector::length<u256>(v11), 13906836961777156095);
        let v13 = 0;
        while (v13 < v12) {
            let v14 = 0x1::vector::borrow<u64>(v10, v13);
            let v15 = 0x1::vector::borrow<u256>(v11, v13);
            let v16 = TimestampedPrice{
                value     : *v15,
                timestamp : v1,
            };
            if (0x2::table::contains<u64, TimestampedPrice>(&v0.usd_per_unit_gas_by_dest_chain, *v14)) {
                0x2::table::remove<u64, TimestampedPrice>(&mut v0.usd_per_unit_gas_by_dest_chain, *v14);
            };
            0x2::table::add<u64, TimestampedPrice>(&mut v0.usd_per_unit_gas_by_dest_chain, *v14, v16);
            let v17 = UsdPerUnitGasUpdated{
                dest_chain_selector : *v14,
                usd_per_unit_gas    : *v15,
                timestamp           : v1,
            };
            0x2::event::emit<UsdPerUnitGasUpdated>(v17);
            v13 = v13 + 1;
        };
    }

    public fun update_prices_with_owner_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &0x2::clock::Clock, arg3: vector<address>, arg4: vector<u256>, arg5: vector<u64>, arg6: vector<u256>, arg7: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"fee_quoter"), 0x1::string::utf8(b"update_prices_with_owner_cap"), 1);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 37);
        let v0 = new_fee_quoter_cap(arg0, arg1, arg7);
        update_prices(arg0, &v0, arg2, arg3, arg4, arg5, arg6, arg7);
        destroy_fee_quoter_cap(arg0, arg1, v0);
    }

    fun validate_32byte_address(arg0: vector<u8>, arg1: u256) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 16);
        assert!(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(arg0) >= arg1, 16);
    }

    fun validate_dest_family_address(arg0: vector<u8>, arg1: vector<u8>, arg2: u256) {
        if (arg0 == x"2812d52c") {
            validate_evm_address(arg1);
        } else if (arg0 == x"1e10bdc4") {
            let v0 = 0;
            if (arg2 > 0) {
                v0 = 1;
            };
            validate_32byte_address(arg1, v0);
        } else if (arg0 == x"ac77ffec" || arg0 == x"c4e05953") {
            validate_32byte_address(arg1, 11);
        };
    }

    fun validate_evm_address(arg0: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 16);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(arg0);
        assert!(v0 >= 1024, 15);
        assert!(v0 <= 1461501637330902918203684832716283019655932542975, 15);
    }

    fun validate_message(arg0: &DestChainConfig, arg1: u64, arg2: u64) {
        assert!(arg1 <= (arg0.max_data_bytes as u64), 13);
        assert!(arg2 <= (arg0.max_number_of_tokens_per_msg as u64), 14);
    }

    // decompiled from Move bytecode v6
}

