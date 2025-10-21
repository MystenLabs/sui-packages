module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors {
    public fun account_does_not_exist() : u64 {
        1016
    }

    public fun all_or_nothing() : u64 {
        1043
    }

    public fun already_delisted() : u64 {
        1055
    }

    public fun already_synced() : u64 {
        1020
    }

    public fun asset_already_supported() : u64 {
        1041
    }

    public fun asset_not_supported() : u64 {
        1036
    }

    public fun asset_type_and_symbol_mismatch() : u64 {
        1047
    }

    public fun bad_debt() : u64 {
        1064
    }

    public fun can_not_be_zero() : u64 {
        1008
    }

    public fun can_not_be_zero_address() : u64 {
        1004
    }

    public fun coin_does_not_have_enough_amount() : u64 {
        1002
    }

    public fun deprecated_function() : u64 {
        1063
    }

    public fun exceeds_lifespan() : u64 {
        1046
    }

    public fun expired() : u64 {
        1027
    }

    public fun funding_rate_exceeds_max_allowed_limit() : u64 {
        1040
    }

    public fun health_check_failed(arg0: u64) : u64 {
        4000 + arg0
    }

    public fun insufficient_funds() : u64 {
        1065
    }

    public fun insufficient_margin() : u64 {
        1017
    }

    public fun insufficient_position_size() : u64 {
        1052
    }

    public fun invalid_eds() : u64 {
        1015
    }

    public fun invalid_fill_price() : u64 {
        1026
    }

    public fun invalid_funding_time() : u64 {
        1039
    }

    public fun invalid_internal_data_store() : u64 {
        1006
    }

    public fun invalid_leverage() : u64 {
        1022
    }

    public fun invalid_nonce() : u64 {
        1003
    }

    public fun invalid_operator_type() : u64 {
        1037
    }

    public fun invalid_oracle_price() : u64 {
        1019
    }

    public fun invalid_payload_type() : u64 {
        1066
    }

    public fun invalid_permission() : u64 {
        1014
    }

    public fun invalid_perpetual_config() : u64 {
        1054
    }

    public fun invalid_position_for_liquidation() : u64 {
        1049
    }

    public fun invalid_quantity() : u64 {
        1030
    }

    public fun invalid_sequence_hash() : u64 {
        1005
    }

    public fun invalid_table_type() : u64 {
        1044
    }

    public fun invalid_trade_price() : u64 {
        1029
    }

    public fun invalid_trade_start_time() : u64 {
        1062
    }

    public fun isolated_only_market() : u64 {
        1034
    }

    public fun latest_supported_contract_version() : u64 {
        1061
    }

    public fun max_allowed_oi_open() : u64 {
        1013
    }

    public fun missing_optional_param() : u64 {
        1048
    }

    public fun mtb_breached() : u64 {
        1031
    }

    public fun negative_pnl() : u64 {
        1053
    }

    public fun no_max_allowed_oi_open_for_selected_leverage() : u64 {
        1057
    }

    public fun not_bankrupt() : u64 {
        1012
    }

    public fun not_delisted() : u64 {
        1056
    }

    public fun not_liquidateable() : u64 {
        1042
    }

    public fun nothing_to_sync() : u64 {
        1032
    }

    public fun opening_both_isolated_cross_positions_not_allowed() : u64 {
        1059
    }

    public fun operator_already_set() : u64 {
        1038
    }

    public fun order_overfill() : u64 {
        1028
    }

    public fun orders_must_be_opposite() : u64 {
        1025
    }

    public fun out_of_config_value_bounds() : u64 {
        1060
    }

    public fun perpetual_already_exists() : u64 {
        1018
    }

    public fun perpetual_delisted() : u64 {
        1023
    }

    public fun perpetual_does_not_exists() : u64 {
        1009
    }

    public fun perpetuals_mismatch() : u64 {
        1021
    }

    public fun position_does_not_exist() : u64 {
        1035
    }

    public fun self_trade() : u64 {
        1058
    }

    public fun sync_already_pending() : u64 {
        1010
    }

    public fun trading_not_permitted() : u64 {
        1024
    }

    public fun transaction_replay() : u64 {
        1011
    }

    public fun trying_to_prune_non_existent_entry() : u64 {
        1045
    }

    public fun unauthorized_liquidator() : u64 {
        1050
    }

    public fun under_water() : u64 {
        1051
    }

    public fun version_mismatch() : u64 {
        1001
    }

    // decompiled from Move bytecode v6
}

