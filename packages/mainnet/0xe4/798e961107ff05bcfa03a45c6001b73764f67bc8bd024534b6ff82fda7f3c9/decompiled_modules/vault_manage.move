module 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_manage {
    public fun create_reward_manager<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::create_reward_manager<T0>(arg1, arg2);
    }

    public fun upgrade_reward_manager<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::RewardManager<T0>) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::upgrade_reward_manager<T0>(arg1);
    }

    public fun create_operator_cap(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::OperatorCap {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::create_operator_cap(arg1)
    }

    public fun retrieve_deposit_withdraw_fee<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::retrieve_deposit_withdraw_fee<T0>(arg1, arg2)
    }

    public fun set_deposit_fee<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: u64) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::set_deposit_fee<T0>(arg1, arg2);
    }

    public fun set_locking_time_for_cancel_request<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: u64) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::set_locking_time_for_cancel_request<T0>(arg1, arg2);
    }

    public fun set_locking_time_for_withdraw<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: u64) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::set_locking_time_for_withdraw<T0>(arg1, arg2);
    }

    public fun set_loss_tolerance<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: u256) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::set_loss_tolerance<T0>(arg1, arg2);
    }

    public fun set_operator_freezed(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Operation, arg2: address, arg3: bool) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::set_operator_freezed(arg1, arg2, arg3);
    }

    public fun set_withdraw_fee<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: u64) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::set_withdraw_fee<T0>(arg1, arg2);
    }

    public fun upgrade_vault<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::upgrade_vault<T0>(arg1);
    }

    public fun add_switchboard_aggregator(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: u8, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::add_switchboard_aggregator(arg1, arg2, arg3, arg4, arg5);
    }

    public fun change_switchboard_aggregator(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::change_switchboard_aggregator(arg1, arg2, arg3, arg4);
    }

    public fun remove_switchboard_aggregator(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::OracleConfig, arg2: 0x1::ascii::String) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::remove_switchboard_aggregator(arg1, arg2);
    }

    public fun set_dex_slippage(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::OracleConfig, arg2: u256) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::set_dex_slippage(arg1, arg2);
    }

    public fun set_update_interval(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::OracleConfig, arg2: u64) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_oracle::set_update_interval(arg1, arg2);
    }

    public fun set_vault_enabled<T0>(arg0: &0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::AdminCap, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg2: bool) {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::set_enabled<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

