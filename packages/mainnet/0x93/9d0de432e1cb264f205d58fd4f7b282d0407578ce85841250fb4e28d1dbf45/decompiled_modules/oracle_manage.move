module 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_manage {
    public fun set_enable_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: bool) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_enable_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_historical_price_ttl_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u64) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_historical_price_ttl_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_max_duration_within_thresholds_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u64) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_max_duration_within_thresholds_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_max_timestamp_diff_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u64) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_max_timestamp_diff_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_maximum_allowed_span_percentage_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u64) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_maximum_allowed_span_percentage_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_maximum_effective_price_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u256) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_maximum_effective_price_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_minimum_effective_price_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u256) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_minimum_effective_price_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_pause(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: bool) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_pause(arg1, arg2);
    }

    public fun set_price_diff_threshold1_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u64) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_price_diff_threshold1_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_price_diff_threshold2_to_price_feed(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u64) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_price_diff_threshold2_to_price_feed(arg1, arg2, arg3);
    }

    public fun set_primary_oracle_provider(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::OracleProvider) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_primary_oracle_provider(arg1, arg2, arg3);
    }

    public fun set_secondary_oracle_provider(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::OracleProvider) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_secondary_oracle_provider(arg1, arg2, arg3);
    }

    public fun version_migrate(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::PriceOracle) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_migrate(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::oracle_version_migrate(arg0, arg2);
    }

    public fun create_config(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::new_config(arg1);
    }

    public fun create_price_feed<T0>(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: u256, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::new_price_feed<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun create_pyth_oracle_provider_config(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: vector<u8>, arg4: bool) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::new_oracle_provider_config(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::pyth_provider(), arg3, arg4);
    }

    public fun create_supra_oracle_provider_config(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: u32, arg4: bool) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::new_oracle_provider_config(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::supra_provider(), 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::adaptor_supra::pair_id_to_vector(arg3), arg4);
    }

    public fun disable_pyth_oracle_provider(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_oracle_provider_config_enable(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::pyth_provider(), false);
    }

    public fun disable_supra_oracle_provider(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_oracle_provider_config_enable(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::supra_provider(), false);
    }

    public fun enable_pyth_oracle_provider(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_oracle_provider_config_enable(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::pyth_provider(), true);
    }

    public fun enable_supra_oracle_provider(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_oracle_provider_config_enable(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::supra_provider(), true);
    }

    public fun set_pyth_price_oracle_provider_pair_id(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: vector<u8>) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_oracle_provider_config_pair_id(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::pyth_provider(), arg3);
    }

    public fun set_supra_price_source_pair_id(arg0: &0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle::OracleAdminCap, arg1: &mut 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::OracleConfig, arg2: address, arg3: vector<u8>) {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::version_verification(arg1);
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::config::set_oracle_provider_config_pair_id(arg1, arg2, 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_provider::supra_provider(), arg3);
    }

    // decompiled from Move bytecode v6
}

