module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors {
    public(friend) fun admin_max_debt_ceiling_above_cap() : u64 {
        13015
    }

    public(friend) fun admin_module_address_zero() : u64 {
        10001
    }

    public(friend) fun admin_module_invalid_config_order() : u64 {
        10010
    }

    public(friend) fun admin_module_invalid_params() : u64 {
        10006
    }

    public(friend) fun admin_module_limit_zero() : u64 {
        10005
    }

    public(friend) fun admin_module_only_auths() : u64 {
        10003
    }

    public(friend) fun admin_module_only_governance() : u64 {
        10002
    }

    public(friend) fun admin_module_only_guardians() : u64 {
        10004
    }

    public(friend) fun admin_module_revenue_collector_not_set() : u64 {
        10011
    }

    public(friend) fun admin_module_token_invalid_decimals_range() : u64 {
        10028
    }

    public(friend) fun admin_module_user_not_defined() : u64 {
        10009
    }

    public(friend) fun admin_module_user_not_paused() : u64 {
        10008
    }

    public(friend) fun admin_module_value_overflow_exchange_prices() : u64 {
        10024
    }

    public(friend) fun admin_module_value_overflow_expand_duration() : u64 {
        10021
    }

    public(friend) fun admin_module_value_overflow_expand_duration_borrow() : u64 {
        10023
    }

    public(friend) fun admin_module_value_overflow_expand_percent() : u64 {
        10020
    }

    public(friend) fun admin_module_value_overflow_expand_percent_borrow() : u64 {
        10022
    }

    public(friend) fun admin_module_value_overflow_fee() : u64 {
        10018
    }

    public(friend) fun admin_module_value_overflow_max_utilization() : u64 {
        10027
    }

    public(friend) fun admin_module_value_overflow_rate_at_util_kink() : u64 {
        10013
    }

    public(friend) fun admin_module_value_overflow_rate_at_util_kink1() : u64 {
        10015
    }

    public(friend) fun admin_module_value_overflow_rate_at_util_kink2() : u64 {
        10016
    }

    public(friend) fun admin_module_value_overflow_rate_at_util_max() : u64 {
        10014
    }

    public(friend) fun admin_module_value_overflow_rate_at_util_max_v2() : u64 {
        10017
    }

    public(friend) fun admin_module_value_overflow_rate_at_util_zero() : u64 {
        10012
    }

    public(friend) fun already_migrated() : u64 {
        13002
    }

    public(friend) fun auth_last_admin_not_removable() : u64 {
        13011
    }

    public(friend) fun auth_role_already_assigned() : u64 {
        13012
    }

    public(friend) fun auth_role_not_assigned() : u64 {
        13013
    }

    public(friend) fun auth_use_add_admin() : u64 {
        13014
    }

    public(friend) fun insufficient_vault_balance() : u64 {
        13006
    }

    public(friend) fun liquidity_calcs_borrow_rate_negative() : u64 {
        70003
    }

    public(friend) fun liquidity_calcs_exchange_price_zero() : u64 {
        70001
    }

    public(friend) fun liquidity_calcs_unsupported_rate_version() : u64 {
        70002
    }

    public(friend) fun liquidity_calcs_utilization_overflow() : u64 {
        70004
    }

    public(friend) fun operate_amounts_nearly_zero() : u64 {
        13003
    }

    public(friend) fun protocol_paused() : u64 {
        13004
    }

    public(friend) fun registry_protocol_already_authorized() : u64 {
        13009
    }

    public(friend) fun registry_protocol_not_authorized() : u64 {
        13007
    }

    public(friend) fun registry_protocol_not_found() : u64 {
        13010
    }

    public(friend) fun reserve_token_paused() : u64 {
        13008
    }

    public(friend) fun user_module_borrow_limit_reached() : u64 {
        11004
    }

    public(friend) fun user_module_max_utilization_reached() : u64 {
        11011
    }

    public(friend) fun user_module_operate_amount_insufficient() : u64 {
        11007
    }

    public(friend) fun user_module_operate_amount_too_big() : u64 {
        11016
    }

    public(friend) fun user_module_operate_amounts_zero() : u64 {
        11005
    }

    public(friend) fun user_module_receiver_not_defined() : u64 {
        11008
    }

    public(friend) fun user_module_transfer_amount_out_of_bounds() : u64 {
        11009
    }

    public(friend) fun user_module_user_not_defined() : u64 {
        11001
    }

    public(friend) fun user_module_user_paused() : u64 {
        11002
    }

    public(friend) fun user_module_value_overflow_exchange_prices() : u64 {
        11012
    }

    public(friend) fun user_module_value_overflow_total_borrow() : u64 {
        11015
    }

    public(friend) fun user_module_value_overflow_total_supply() : u64 {
        11014
    }

    public(friend) fun user_module_value_overflow_utilization() : u64 {
        11013
    }

    public(friend) fun user_module_withdrawal_limit_reached() : u64 {
        11003
    }

    public(friend) fun wrong_version() : u64 {
        13001
    }

    // decompiled from Move bytecode v7
}

