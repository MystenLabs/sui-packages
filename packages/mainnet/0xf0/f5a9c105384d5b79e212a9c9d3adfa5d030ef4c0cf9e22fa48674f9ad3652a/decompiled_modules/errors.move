module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors {
    public(friend) fun vault_admin_address_zero_not_allowed() : u64 {
        6066
    }

    public(friend) fun vault_admin_last_admin_not_removable() : u64 {
        6076
    }

    public(friend) fun vault_admin_only_authority() : u64 {
        6073
    }

    public(friend) fun vault_admin_only_auths() : u64 {
        6065
    }

    public(friend) fun vault_admin_role_already_assigned() : u64 {
        6074
    }

    public(friend) fun vault_admin_role_not_assigned() : u64 {
        6075
    }

    public(friend) fun vault_admin_value_above_limit() : u64 {
        6064
    }

    public(friend) fun vault_already_migrated() : u64 {
        7001
    }

    public(friend) fun vault_branch_debt_too_low() : u64 {
        6022
    }

    public(friend) fun vault_branch_not_found() : u64 {
        6032
    }

    public(friend) fun vault_cap_holder_mismatch() : u64 {
        7003
    }

    public(friend) fun vault_caps_not_installed() : u64 {
        7002
    }

    public(friend) fun vault_excess_collateral_withdrawal() : u64 {
        6017
    }

    public(friend) fun vault_excess_debt_payback() : u64 {
        6018
    }

    public(friend) fun vault_excess_slippage_liquidation() : u64 {
        6013
    }

    public(friend) fun vault_invalid_decimals() : u64 {
        6008
    }

    public(friend) fun vault_invalid_liquidation() : u64 {
        6027
    }

    public(friend) fun vault_invalid_liquidation_amt() : u64 {
        6020
    }

    public(friend) fun vault_invalid_liquidity_program() : u64 {
        6044
    }

    public(friend) fun vault_invalid_operate_amount() : u64 {
        6009
    }

    public(friend) fun vault_invalid_oracle() : u64 {
        6042
    }

    public(friend) fun vault_invalid_oracle_price() : u64 {
        6031
    }

    public(friend) fun vault_invalid_payback_or_deposit() : u64 {
        6026
    }

    public(friend) fun vault_invalid_position_authority() : u64 {
        6045
    }

    public(friend) fun vault_invalid_position_mint() : u64 {
        6001
    }

    public(friend) fun vault_invalid_vault_id() : u64 {
        6036
    }

    public(friend) fun vault_liquidation_reverts() : u64 {
        6030
    }

    public(friend) fun vault_liquidity_exchange_price_unexpected() : u64 {
        6024
    }

    public(friend) fun vault_no_caps_supplied() : u64 {
        7006
    }

    public(friend) fun vault_not_rebalancer() : u64 {
        6014
    }

    public(friend) fun vault_nothing_to_rebalance() : u64 {
        6028
    }

    public(friend) fun vault_position_above_cf() : u64 {
        6011
    }

    public(friend) fun vault_position_above_liquidation_threshold() : u64 {
        6063
    }

    public(friend) fun vault_position_not_empty() : u64 {
        6039
    }

    public(friend) fun vault_state_already_initialized() : u64 {
        7004
    }

    public(friend) fun vault_tick_debt_too_low() : u64 {
        6023
    }

    public(friend) fun vault_tick_has_debt_index_mismatch() : u64 {
        6077
    }

    public(friend) fun vault_tick_has_debt_out_of_range() : u64 {
        6058
    }

    public(friend) fun vault_tick_id_liquidation_mismatch() : u64 {
        6002
    }

    public(friend) fun vault_tick_is_empty() : u64 {
        6010
    }

    public(friend) fun vault_tick_not_found() : u64 {
        6033
    }

    public(friend) fun vault_token_not_initialized() : u64 {
        6015
    }

    public(friend) fun vault_top_tick_does_not_exist() : u64 {
        6012
    }

    public(friend) fun vault_user_collateral_debt_exceed() : u64 {
        6016
    }

    public(friend) fun vault_user_debt_too_low() : u64 {
        6025
    }

    public(friend) fun vault_withdraw_more_than_operate_limit() : u64 {
        6019
    }

    public(friend) fun vault_wrong_version() : u64 {
        7000
    }

    // decompiled from Move bytecode v7
}

