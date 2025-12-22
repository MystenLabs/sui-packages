module 0x5eab2e99a8fa5f8fa8f5d5ceb74c0c7a953d773dc11200a4dc4bec57ec0527e::fee_quoter {
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

    struct TokenTransferFeeConfig has copy, drop, store {
        min_fee_usd_cents: u32,
        max_fee_usd_cents: u32,
        deci_bps: u16,
        dest_gas_overhead: u32,
        dest_bytes_overhead: u32,
        is_enabled: bool,
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

    public fun create_default_test_dest_chain_config() : DestChainConfig {
        create_test_dest_chain_config(true, 10, 10000, 1000000, 100000, 10, 20, 1000, 50000, 100, 1000, b"EVM", false, 50, 50000, 500000, 1000000000000000000, 3600, 100)
    }

    public fun create_default_test_token_transfer_fee_config() : TokenTransferFeeConfig {
        create_test_token_transfer_fee_config(25, 100, 50, 25000, 32, true)
    }

    public fun create_test_dest_chain_config(arg0: bool, arg1: u16, arg2: u32, arg3: u32, arg4: u32, arg5: u8, arg6: u8, arg7: u16, arg8: u32, arg9: u16, arg10: u16, arg11: vector<u8>, arg12: bool, arg13: u16, arg14: u32, arg15: u32, arg16: u64, arg17: u32, arg18: u32) : DestChainConfig {
        DestChainConfig{
            is_enabled                            : arg0,
            max_number_of_tokens_per_msg          : arg1,
            max_data_bytes                        : arg2,
            max_per_msg_gas_limit                 : arg3,
            dest_gas_overhead                     : arg4,
            dest_gas_per_payload_byte_base        : arg5,
            dest_gas_per_payload_byte_high        : arg6,
            dest_gas_per_payload_byte_threshold   : arg7,
            dest_data_availability_overhead_gas   : arg8,
            dest_gas_per_data_availability_byte   : arg9,
            dest_data_availability_multiplier_bps : arg10,
            chain_family_selector                 : arg11,
            enforce_out_of_order                  : arg12,
            default_token_fee_usd_cents           : arg13,
            default_token_dest_gas_overhead       : arg14,
            default_tx_gas_limit                  : arg15,
            gas_multiplier_wei_per_eth            : arg16,
            gas_price_staleness_threshold         : arg17,
            network_fee_usd_cents                 : arg18,
        }
    }

    public fun create_test_token_transfer_fee_config(arg0: u32, arg1: u32, arg2: u16, arg3: u32, arg4: u32, arg5: bool) : TokenTransferFeeConfig {
        TokenTransferFeeConfig{
            min_fee_usd_cents   : arg0,
            max_fee_usd_cents   : arg1,
            deci_bps            : arg2,
            dest_gas_overhead   : arg3,
            dest_bytes_overhead : arg4,
            is_enabled          : arg5,
        }
    }

    public fun emit_dest_chain_added_event(arg0: u64, arg1: DestChainConfig) {
        let v0 = DestChainAdded{
            dest_chain_selector : arg0,
            dest_chain_config   : arg1,
        };
        0x2::event::emit<DestChainAdded>(v0);
    }

    public fun emit_dest_chain_config_updated_event(arg0: u64, arg1: DestChainConfig) {
        let v0 = DestChainConfigUpdated{
            dest_chain_selector : arg0,
            dest_chain_config   : arg1,
        };
        0x2::event::emit<DestChainConfigUpdated>(v0);
    }

    public fun emit_fee_token_added_event(arg0: address) {
        let v0 = FeeTokenAdded{fee_token: arg0};
        0x2::event::emit<FeeTokenAdded>(v0);
    }

    public fun emit_fee_token_removed_event(arg0: address) {
        let v0 = FeeTokenRemoved{fee_token: arg0};
        0x2::event::emit<FeeTokenRemoved>(v0);
    }

    public fun emit_premium_multiplier_wei_per_eth_updated_event(arg0: address, arg1: u64) {
        let v0 = PremiumMultiplierWeiPerEthUpdated{
            token                          : arg0,
            premium_multiplier_wei_per_eth : arg1,
        };
        0x2::event::emit<PremiumMultiplierWeiPerEthUpdated>(v0);
    }

    public fun emit_token_transfer_fee_config_added_event(arg0: u64, arg1: address, arg2: TokenTransferFeeConfig) {
        let v0 = TokenTransferFeeConfigAdded{
            dest_chain_selector       : arg0,
            token                     : arg1,
            token_transfer_fee_config : arg2,
        };
        0x2::event::emit<TokenTransferFeeConfigAdded>(v0);
    }

    public fun emit_token_transfer_fee_config_removed_event(arg0: u64, arg1: address) {
        let v0 = TokenTransferFeeConfigRemoved{
            dest_chain_selector : arg0,
            token               : arg1,
        };
        0x2::event::emit<TokenTransferFeeConfigRemoved>(v0);
    }

    public fun emit_usd_per_token_updated_event(arg0: address, arg1: u256, arg2: u64) {
        let v0 = UsdPerTokenUpdated{
            token         : arg0,
            usd_per_token : arg1,
            timestamp     : arg2,
        };
        0x2::event::emit<UsdPerTokenUpdated>(v0);
    }

    public fun emit_usd_per_unit_gas_updated_event(arg0: u64, arg1: u256, arg2: u64) {
        let v0 = UsdPerUnitGasUpdated{
            dest_chain_selector : arg0,
            usd_per_unit_gas    : arg1,
            timestamp           : arg2,
        };
        0x2::event::emit<UsdPerUnitGasUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

