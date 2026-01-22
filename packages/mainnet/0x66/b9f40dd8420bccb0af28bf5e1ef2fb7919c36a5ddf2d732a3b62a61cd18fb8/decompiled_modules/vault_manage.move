module 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_manage {
    struct ParametersSetByManager has copy, drop {
        vault_id: address,
        manager_cap_id: address,
        deposit_fee: u64,
        withdraw_fee: u64,
        loss_tolerance: u256,
        locking_time_for_withdraw: u64,
        locking_time_for_cancel_request: u64,
    }

    public fun add_curator_cap(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::CuratorConfig, arg2: address) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::add_curator_cap(arg1, arg2);
    }

    public fun init_curator_config(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::init_curator_config(arg1);
    }

    public fun remove_curator_cap(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::CuratorConfig, arg2: address) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::remove_curator_cap(arg1, arg2);
    }

    public fun remove_curator_cap_paired_with_position(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::CuratorConfig, arg2: address, arg3: address) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::remove_curator_cap_paired_with_position(arg1, arg2, arg3);
    }

    public fun set_curator_cap_paired_with_position(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::CuratorConfig, arg2: address, arg3: address) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::set_curator_cap_paired_with_position(arg1, arg2, arg3);
    }

    public fun set_value_submission_min_interval(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::CuratorConfig, arg2: u64) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::set_value_submission_min_interval(arg1, arg2);
    }

    public fun upgrade_curator_config(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::CuratorConfig) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::curator_position::upgrade_curator_config(arg1);
    }

    public fun create_manager_cap(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::manager_cap::ManagerCap {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::manager_cap::create_manager_cap(arg1)
    }

    public fun add_dynamic_field_to_vault<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::receipt_cancellation::add_dynamic_field_to_vault<T0>(arg1, arg2);
    }

    public fun create_reward_manager<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::reward_manager::create_reward_manager<T0>(arg1, arg2);
    }

    public fun upgrade_reward_manager<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::reward_manager::RewardManager<T0>) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::reward_manager::upgrade_reward_manager<T0>(arg1);
    }

    public fun add_dynamic_field_to_operation(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Operation, arg2: &mut 0x2::tx_context::TxContext) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::add_dynamic_field_to_operation(arg1, arg2);
    }

    public fun create_operator_cap(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::OperatorCap {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::create_operator_cap(arg1)
    }

    public fun remove_single_vault_operator(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Operation, arg2: address, arg3: address) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::remove_single_vault_operator(arg1, arg2, arg3);
    }

    public fun retrieve_deposit_withdraw_fee<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::retrieve_deposit_withdraw_fee<T0>(arg1, arg2)
    }

    public fun set_deposit_fee<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u64) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_deposit_fee<T0>(arg1, arg2);
    }

    public fun set_locking_time_for_cancel_request<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u64) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_locking_time_for_cancel_request<T0>(arg1, arg2);
    }

    public fun set_locking_time_for_withdraw<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u64) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_locking_time_for_withdraw<T0>(arg1, arg2);
    }

    public fun set_loss_tolerance<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u256) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_loss_tolerance<T0>(arg1, arg2);
    }

    public fun set_operator_freezed(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Operation, arg2: address, arg3: bool) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_operator_freezed(arg1, arg2, arg3);
    }

    public fun set_single_vault_operator(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Operation, arg2: address, arg3: address) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_single_vault_operator(arg1, arg2, arg3);
    }

    public fun set_withdraw_fee<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u64) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_withdraw_fee<T0>(arg1, arg2);
    }

    public fun upgrade_vault<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::upgrade_vault<T0>(arg1);
    }

    public fun add_switchboard_aggregator(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: u8, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::add_switchboard_aggregator(arg1, arg2, arg3, arg4, arg5);
    }

    public fun change_switchboard_aggregator(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::change_switchboard_aggregator(arg1, arg2, arg3, arg4);
    }

    public fun remove_switchboard_aggregator(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::OracleConfig, arg2: 0x1::ascii::String) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::remove_switchboard_aggregator(arg1, arg2);
    }

    public fun reset_loss_tolerance<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: &0x2::tx_context::TxContext) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::try_reset_tolerance<T0>(arg1, true, arg2);
    }

    public fun retrieve_deposit_withdraw_fee_by_operator<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Operation, arg1: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::OperatorCap, arg2: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg3: u64) : 0x2::balance::Balance<T0> {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::assert_operator_not_freezed(arg0, arg1);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::assert_single_vault_operator_paired(arg0, 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::vault_id<T0>(arg2), arg1);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::retrieve_deposit_withdraw_fee<T0>(arg2, arg3)
    }

    public fun retrieve_deposit_withdraw_fee_operator<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::OperatorCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::retrieve_deposit_withdraw_fee<T0>(arg1, 0)
    }

    public fun set_dex_slippage(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::OracleConfig, arg2: u256) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::set_dex_slippage(arg1, arg2);
    }

    public fun set_parameters_by_manager<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::manager_cap::ManagerCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: u64, arg3: u64, arg4: u256, arg5: u64, arg6: u64) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_deposit_fee<T0>(arg1, arg2);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_withdraw_fee<T0>(arg1, arg3);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_loss_tolerance<T0>(arg1, arg4);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_locking_time_for_withdraw<T0>(arg1, arg5);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_locking_time_for_cancel_request<T0>(arg1, arg6);
        let v0 = ParametersSetByManager{
            vault_id                        : 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::vault_id<T0>(arg1),
            manager_cap_id                  : 0x2::object::id_address<0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::manager_cap::ManagerCap>(arg0),
            deposit_fee                     : arg2,
            withdraw_fee                    : arg3,
            loss_tolerance                  : arg4,
            locking_time_for_withdraw       : arg5,
            locking_time_for_cancel_request : arg6,
        };
        0x2::event::emit<ParametersSetByManager>(v0);
    }

    public fun set_update_interval(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::OracleConfig, arg2: u64) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::set_update_interval(arg1, arg2);
    }

    public fun set_vault_enabled<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg2: bool) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_enabled<T0>(arg1, arg2);
    }

    public fun set_vault_enabled_by_operator<T0>(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Operation, arg1: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::OperatorCap, arg2: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::Vault<T0>, arg3: bool) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::assert_operator_not_freezed(arg0, arg1);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::assert_single_vault_operator_paired(arg0, 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::vault_id<T0>(arg2), arg1);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::assert_not_during_operation<T0>(arg2);
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::set_enabled<T0>(arg2, arg3);
    }

    public fun upgrade_oracle_config(arg0: &0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault::AdminCap, arg1: &mut 0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::OracleConfig) {
        0x9817be432fe15732729b66953e8e845339300f9d4a0fff6f110272e90b772996::vault_oracle::upgrade_oracle_config(arg1);
    }

    // decompiled from Move bytecode v6
}

