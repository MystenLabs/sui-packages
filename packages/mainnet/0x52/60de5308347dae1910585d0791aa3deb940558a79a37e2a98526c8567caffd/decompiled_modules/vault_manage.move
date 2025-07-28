module 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_manage {
    public fun create_reward_manager<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::reward_manager::create_reward_manager<T0>(arg1, arg2);
    }

    public fun upgrade_reward_manager<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::reward_manager::RewardManager<T0>) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::reward_manager::upgrade_reward_manager<T0>(arg1);
    }

    public fun create_operator_cap(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::OperatorCap {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::create_operator_cap(arg1)
    }

    public fun retrieve_deposit_withdraw_fee<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::retrieve_deposit_withdraw_fee<T0>(arg1, arg2)
    }

    public fun set_deposit_fee<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: u64) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::set_deposit_fee<T0>(arg1, arg2);
    }

    public fun set_locking_time_for_cancel_request<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: u64) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::set_locking_time_for_cancel_request<T0>(arg1, arg2);
    }

    public fun set_locking_time_for_withdraw<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: u64) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::set_locking_time_for_withdraw<T0>(arg1, arg2);
    }

    public fun set_loss_tolerance<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: u256) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::set_loss_tolerance<T0>(arg1, arg2);
    }

    public fun set_operator_freezed(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Operation, arg2: address, arg3: bool) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::set_operator_freezed(arg1, arg2, arg3);
    }

    public fun set_withdraw_fee<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: u64) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::set_withdraw_fee<T0>(arg1, arg2);
    }

    public fun upgrade_vault<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::upgrade_vault<T0>(arg1);
    }

    public fun add_switchboard_aggregator(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: u8, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::add_switchboard_aggregator(arg1, arg2, arg3, arg4, arg5);
    }

    public fun change_switchboard_aggregator(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::change_switchboard_aggregator(arg1, arg2, arg3, arg4);
    }

    public fun remove_switchboard_aggregator(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::OracleConfig, arg2: 0x1::ascii::String) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::remove_switchboard_aggregator(arg1, arg2);
    }

    public fun set_dex_slippage(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::OracleConfig, arg2: u256) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::set_dex_slippage(arg1, arg2);
    }

    public fun set_update_interval(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::OracleConfig, arg2: u64) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::set_update_interval(arg1, arg2);
    }

    public fun set_vault_enabled<T0>(arg0: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::AdminCap, arg1: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg2: bool) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::set_enabled<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

