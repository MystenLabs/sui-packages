module 0x3::sui_system {
    struct SuiSystemState has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun active_validator_addresses(arg0: &mut SuiSystemState) : vector<address> {
        0x3::sui_system_state_inner::active_validator_addresses(load_system_state_mut(arg0))
    }

    fun advance_epoch(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut SuiSystemState, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg10) == @0x0, 0);
        0x3::sui_system_state_inner::advance_epoch(load_system_state_mut(arg2), arg3, arg4, arg0, arg1, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun convert_to_fungible_staked_sui(arg0: &mut SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::FungibleStakedSui {
        0x3::sui_system_state_inner::convert_to_fungible_staked_sui(load_system_state_mut(arg0), arg1, arg2)
    }

    public(friend) fun create(arg0: 0x2::object::UID, arg1: vector<0x3::validator::Validator>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: 0x3::sui_system_state_inner::SystemParameters, arg6: 0x3::stake_subsidy::StakeSubsidy, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::sui_system_state_inner::genesis_system_state_version();
        let v1 = SuiSystemState{
            id      : arg0,
            version : v0,
        };
        0x2::dynamic_field::add<u64, 0x3::sui_system_state_inner::SuiSystemStateInner>(&mut v1.id, v0, 0x3::sui_system_state_inner::create(arg1, arg2, arg3, arg4, arg5, arg6, arg7));
        0x2::transfer::share_object<SuiSystemState>(v1);
    }

    fun load_inner_maybe_upgrade(arg0: &mut SuiSystemState) : &mut 0x3::sui_system_state_inner::SuiSystemStateInnerV2 {
        if (arg0.version == 1) {
            arg0.version = 2;
            0x2::dynamic_field::add<u64, 0x3::sui_system_state_inner::SuiSystemStateInnerV2>(&mut arg0.id, arg0.version, 0x3::sui_system_state_inner::v1_to_v2(0x2::dynamic_field::remove<u64, 0x3::sui_system_state_inner::SuiSystemStateInner>(&mut arg0.id, arg0.version)));
        };
        let v0 = 0x2::dynamic_field::borrow_mut<u64, 0x3::sui_system_state_inner::SuiSystemStateInnerV2>(&mut arg0.id, arg0.version);
        assert!(0x3::sui_system_state_inner::system_state_version(v0) == arg0.version, 1);
        v0
    }

    fun load_system_state(arg0: &mut SuiSystemState) : &0x3::sui_system_state_inner::SuiSystemStateInnerV2 {
        load_inner_maybe_upgrade(arg0)
    }

    fun load_system_state_mut(arg0: &mut SuiSystemState) : &mut 0x3::sui_system_state_inner::SuiSystemStateInnerV2 {
        load_inner_maybe_upgrade(arg0)
    }

    public fun pool_exchange_rates(arg0: &mut SuiSystemState, arg1: &0x2::object::ID) : &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate> {
        0x3::sui_system_state_inner::pool_exchange_rates(load_system_state_mut(arg0), arg1)
    }

    public fun redeem_fungible_staked_sui(arg0: &mut SuiSystemState, arg1: 0x3::staking_pool::FungibleStakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x3::sui_system_state_inner::redeem_fungible_staked_sui(load_system_state_mut(arg0), arg1, arg2)
    }

    public entry fun report_validator(arg0: &mut SuiSystemState, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: address) {
        0x3::sui_system_state_inner::report_validator(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun request_add_stake(arg0: &mut SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = request_add_stake_non_entry(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun request_add_stake_mul_coin(arg0: &mut SuiSystemState, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(0x3::sui_system_state_inner::request_add_stake_mul_coin(load_system_state_mut(arg0), arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_add_stake_non_entry(arg0: &mut SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        0x3::sui_system_state_inner::request_add_stake(load_system_state_mut(arg0), arg1, arg2, arg3)
    }

    public entry fun request_add_validator(arg0: &mut SuiSystemState, arg1: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::request_add_validator(load_system_state_mut(arg0), arg1);
    }

    public entry fun request_add_validator_candidate(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::request_add_validator_candidate(load_system_state_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun request_remove_validator(arg0: &mut SuiSystemState, arg1: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::request_remove_validator(load_system_state_mut(arg0), arg1);
    }

    public entry fun request_remove_validator_candidate(arg0: &mut SuiSystemState, arg1: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::request_remove_validator_candidate(load_system_state_mut(arg0), arg1);
    }

    public entry fun request_set_commission_rate(arg0: &mut SuiSystemState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::request_set_commission_rate(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun request_set_gas_price(arg0: &mut SuiSystemState, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: u64) {
        0x3::sui_system_state_inner::request_set_gas_price(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun request_withdraw_stake(arg0: &mut SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = request_withdraw_stake_non_entry(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun request_withdraw_stake_non_entry(arg0: &mut SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x3::sui_system_state_inner::request_withdraw_stake(load_system_state_mut(arg0), arg1, arg2)
    }

    public entry fun rotate_operation_cap(arg0: &mut SuiSystemState, arg1: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::rotate_operation_cap(load_system_state_mut(arg0), arg1);
    }

    public entry fun set_candidate_validator_commission_rate(arg0: &mut SuiSystemState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::set_candidate_validator_commission_rate(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun set_candidate_validator_gas_price(arg0: &mut SuiSystemState, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: u64) {
        0x3::sui_system_state_inner::set_candidate_validator_gas_price(load_system_state_mut(arg0), arg1, arg2);
    }

    fun store_execution_time_estimates(arg0: &mut SuiSystemState, arg1: vector<u8>) {
        0x3::sui_system_state_inner::store_execution_time_estimates(load_system_state_mut(arg0), arg1);
    }

    public entry fun undo_report_validator(arg0: &mut SuiSystemState, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: address) {
        0x3::sui_system_state_inner::undo_report_validator(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_candidate_validator_network_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_candidate_validator_network_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_candidate_validator_network_pubkey(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_candidate_validator_network_pubkey(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_candidate_validator_p2p_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_candidate_validator_p2p_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_candidate_validator_primary_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_candidate_validator_primary_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_candidate_validator_protocol_pubkey(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_candidate_validator_protocol_pubkey(load_system_state_mut(arg0), arg1, arg2, arg3);
    }

    public entry fun update_candidate_validator_worker_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_candidate_validator_worker_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_candidate_validator_worker_pubkey(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_candidate_validator_worker_pubkey(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_description(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_description(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_image_url(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_image_url(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_name(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_name(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_next_epoch_network_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_next_epoch_network_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_next_epoch_network_pubkey(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_next_epoch_network_pubkey(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_next_epoch_p2p_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_next_epoch_p2p_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_next_epoch_primary_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_next_epoch_primary_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_next_epoch_protocol_pubkey(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_next_epoch_protocol_pubkey(load_system_state_mut(arg0), arg1, arg2, arg3);
    }

    public entry fun update_validator_next_epoch_worker_address(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_next_epoch_worker_address(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_next_epoch_worker_pubkey(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_next_epoch_worker_pubkey(load_system_state_mut(arg0), arg1, arg2);
    }

    public entry fun update_validator_project_url(arg0: &mut SuiSystemState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::sui_system_state_inner::update_validator_project_url(load_system_state_mut(arg0), arg1, arg2);
    }

    public fun validator_address_by_pool_id(arg0: &mut SuiSystemState, arg1: &0x2::object::ID) : address {
        0x3::sui_system_state_inner::validator_address_by_pool_id(load_system_state_mut(arg0), arg1)
    }

    fun validator_voting_powers(arg0: &mut SuiSystemState) : 0x2::vec_map::VecMap<address, u64> {
        0x3::sui_system_state_inner::active_validator_voting_powers(load_system_state(arg0))
    }

    // decompiled from Move bytecode v6
}

