module 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state {
    struct DefaultUnstakeProtocolFeeConfig has store {
        total_fee: u64,
        treasury_allocation: u64,
        dev_wallet_allocation: u64,
        crank_incentive_allocation: u64,
        referee_discount: u64,
    }

    struct AtomicUnstakeProtocolFeeConfig has store {
        max_fee: u64,
        min_fee: u64,
        treasury_allocation: u64,
        dev_wallet_allocation: u64,
        crank_incentive_allocation: u64,
        referee_discount: u64,
    }

    struct ProtocolConfig has store {
        max_validator_fee: u64,
        dev_account: address,
        default_unstake_protocol_fee: DefaultUnstakeProtocolFeeConfig,
        atomic_unstake_protocol_fee: AtomicUnstakeProtocolFeeConfig,
        atomic_unstake_sui_reserves_target_value: u64,
        min_staking_threshold: u64,
        crank_incentive_reward_per_instruction: u64,
        max_crank_incentive_reward: u64,
        reference_gas_price: u64,
        min_fields_requests_per_tx: u64,
        pool_rates_epoch_gap: u64,
        unstaking_bunch_size: u64,
    }

    struct ValidatorConfig has store {
        sui_address: address,
        operation_cap_id: 0x2::object::ID,
        fee: u64,
    }

    struct EpochWasChangedState has store {
        is_epoch_processing: bool,
        is_inactive_stakes_processed: bool,
        is_unstaking_deque_sorted: bool,
        is_total_sui_amount_updated: bool,
        is_unstaking_from_storage_processed: bool,
        is_pending_unstakes_processed: bool,
        amount_to_unstake: u64,
        reserves_before_unstake: u64,
    }

    struct StakedSuiVaultStateV1 has store, key {
        id: 0x2::object::UID,
        protocol_config: ProtocolConfig,
        validator_configs: 0x2::linked_table::LinkedTable<address, ValidatorConfig>,
        staked_sui_storage: 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::storage::Storage,
        crank_incentive_reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        atomic_unstake_sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        afsui_bin: 0x2::balance::Balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>,
        pending_unstake_records: 0x2::table_vec::TableVec<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord>,
        inactive_stakes: 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>,
        active_epoch: u64,
        epoch_was_changed_state: EpochWasChangedState,
        total_sui_amount: u64,
        total_rewards_amount: u64,
    }

    fun new(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) : StakedSuiVaultStateV1 {
        let v0 = DefaultUnstakeProtocolFeeConfig{
            total_fee                  : arg2,
            treasury_allocation        : arg3,
            dev_wallet_allocation      : arg4,
            crank_incentive_allocation : arg5,
            referee_discount           : arg6,
        };
        let v1 = AtomicUnstakeProtocolFeeConfig{
            max_fee                    : arg7,
            min_fee                    : arg8,
            treasury_allocation        : arg9,
            dev_wallet_allocation      : arg10,
            crank_incentive_allocation : arg11,
            referee_discount           : arg12,
        };
        let v2 = ProtocolConfig{
            max_validator_fee                        : 50000000000000000,
            dev_account                              : arg1,
            default_unstake_protocol_fee             : v0,
            atomic_unstake_protocol_fee              : v1,
            atomic_unstake_sui_reserves_target_value : arg13,
            min_staking_threshold                    : arg15,
            crank_incentive_reward_per_instruction   : 2000,
            max_crank_incentive_reward               : 2000000,
            reference_gas_price                      : arg14,
            min_fields_requests_per_tx               : 500,
            pool_rates_epoch_gap                     : arg16,
            unstaking_bunch_size                     : arg17,
        };
        let v3 = initialize_validator_configs(arg0, arg18);
        let v4 = EpochWasChangedState{
            is_epoch_processing                 : false,
            is_inactive_stakes_processed        : false,
            is_unstaking_deque_sorted           : false,
            is_total_sui_amount_updated         : false,
            is_unstaking_from_storage_processed : false,
            is_pending_unstakes_processed       : false,
            amount_to_unstake                   : 0,
            reserves_before_unstake             : 0,
        };
        StakedSuiVaultStateV1{
            id                          : 0x2::object::new(arg18),
            protocol_config             : v2,
            validator_configs           : v3,
            staked_sui_storage          : 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::storage::create(arg18),
            crank_incentive_reward_pool : 0x2::balance::zero<0x2::sui::SUI>(),
            sui_reserves                : 0x2::balance::zero<0x2::sui::SUI>(),
            atomic_unstake_sui_reserves : 0x2::balance::zero<0x2::sui::SUI>(),
            afsui_bin                   : 0x2::balance::zero<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(),
            pending_unstake_records     : 0x2::table_vec::empty<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord>(arg18),
            inactive_stakes             : 0x2::table_vec::empty<0x3::staking_pool::StakedSui>(arg18),
            active_epoch                : 0x2::tx_context::epoch(arg18),
            epoch_was_changed_state     : v4,
            total_sui_amount            : 0,
            total_rewards_amount        : 0,
        }
    }

    public(friend) fun authorize(arg0: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::OwnerCap, arg1: &StakedSuiVaultStateV1, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) {
        0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::authorize<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(arg2, arg0, 0x2::object::id<StakedSuiVaultStateV1>(arg1));
    }

    public(friend) fun afsui_to_sui(arg0: &StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: u64) : u64 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::afsui_to_sui(arg2, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::total_supply(arg1), total_sui_amount(arg0))
    }

    public(friend) fun afsui_to_sui_exchange_rate(arg0: &StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u128 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::afsui_to_sui_exchange_rate(0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::total_supply(arg1), total_sui_amount(arg0))
    }

    public(friend) fun sui_to_afsui(arg0: &StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: u64) : u64 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::sui_to_afsui(arg2, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::total_supply(arg1), total_sui_amount(arg0))
    }

    public(friend) fun sui_to_afsui_exchange_rate(arg0: &StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u128 {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::sui_to_afsui_exchange_rate(0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::total_supply(arg1), total_sui_amount(arg0))
    }

    public(friend) fun active_epoch(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.active_epoch
    }

    public(friend) fun add_atomic_unstake_sui_reserves(arg0: &mut StakedSuiVaultStateV1, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.atomic_unstake_sui_reserves, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun add_crank_incentives(arg0: &mut StakedSuiVaultStateV1, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.crank_incentive_reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun add_default_validator_config(arg0: &mut StakedSuiVaultStateV1, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::new_unverified_validator_operation_cap(arg1, arg2);
        let v1 = ValidatorConfig{
            sui_address      : arg1,
            operation_cap_id : 0x2::object::id<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::UnverifiedValidatorOperationCap>(&v0),
            fee              : 0,
        };
        0x2::linked_table::push_back<address, ValidatorConfig>(&mut arg0.validator_configs, arg1, v1);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::transfer_unverified_validator_operation_cap(v0, arg1);
    }

    public(friend) fun afsui_bin_value(arg0: &StakedSuiVaultStateV1) : u64 {
        0x2::balance::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg0.afsui_bin)
    }

    public(friend) fun amount_to_unstake(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.epoch_was_changed_state.amount_to_unstake
    }

    public(friend) fun atomic_unstake_crank_incentive_allocation(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.atomic_unstake_protocol_fee.crank_incentive_allocation
    }

    public(friend) fun atomic_unstake_dev_wallet_allocation(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.atomic_unstake_protocol_fee.dev_wallet_allocation
    }

    public(friend) fun atomic_unstake_referee_discount(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.atomic_unstake_protocol_fee.referee_discount
    }

    public(friend) fun atomic_unstake_sui_reserves_target_value(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.atomic_unstake_sui_reserves_target_value
    }

    public(friend) fun atomic_unstake_sui_reserves_value(arg0: &StakedSuiVaultStateV1) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.atomic_unstake_sui_reserves)
    }

    public(friend) fun atomic_unstake_treasury_allocation(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.atomic_unstake_protocol_fee.treasury_allocation
    }

    public(friend) fun borrow_pending_unstake_records(arg0: &StakedSuiVaultStateV1) : &0x2::table_vec::TableVec<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord> {
        &arg0.pending_unstake_records
    }

    public(friend) fun borrow_pending_unstake_records_mut(arg0: &mut StakedSuiVaultStateV1) : &mut 0x2::table_vec::TableVec<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord> {
        &mut arg0.pending_unstake_records
    }

    public(friend) fun borrow_validator_config(arg0: &StakedSuiVaultStateV1, arg1: address) : &ValidatorConfig {
        assert!(0x2::linked_table::contains<address, ValidatorConfig>(&arg0.validator_configs, arg1), 3);
        0x2::linked_table::borrow<address, ValidatorConfig>(&arg0.validator_configs, arg1)
    }

    public(friend) fun borrow_validator_config_mut(arg0: &mut StakedSuiVaultStateV1, arg1: address) : &mut ValidatorConfig {
        assert!(0x2::linked_table::contains<address, ValidatorConfig>(&arg0.validator_configs, arg1), 3);
        0x2::linked_table::borrow_mut<address, ValidatorConfig>(&mut arg0.validator_configs, arg1)
    }

    public(friend) fun burn_afsui(arg0: &mut StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>) : u64 {
        0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::burn(arg1, &arg0.id, arg2)
    }

    public(friend) fun burn_afsui_bin(arg0: &mut StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::burn(arg1, &arg0.id, 0x2::coin::take<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&mut arg0.afsui_bin, 0x2::balance::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg0.afsui_bin), arg2))
    }

    public(friend) fun calculate_atomic_unstake_protocol_fee(arg0: &StakedSuiVaultStateV1, arg1: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg2: &0x2::coin::Coin<0x2::sui::SUI>, arg3: address) : (u64, u64, u64) {
        let v0 = max_atomic_unstake_fee(arg0);
        let v1 = atomic_unstake_sui_reserves_target_value(arg0);
        let v2 = atomic_unstake_sui_reserves_value(arg0);
        let v3 = if (v2 >= v1) {
            min_atomic_unstake_fee(arg0)
        } else {
            v0 - ((((v0 - min_atomic_unstake_fee(arg0)) as u128) * (v2 as u128) / (v1 as u128)) as u64)
        };
        let v4 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(0x2::coin::value<0x2::sui::SUI>(arg2), v3);
        let v5 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v4, atomic_unstake_treasury_allocation(arg0));
        let v6 = v5;
        if (0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::has_referrer(arg1, arg3)) {
            v6 = v5 - 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v5, atomic_unstake_referee_discount(arg0));
        };
        (v6, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v4, atomic_unstake_dev_wallet_allocation(arg0)), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v4, atomic_unstake_crank_incentive_allocation(arg0)))
    }

    public(friend) fun calculate_default_unstake_protocol_fee(arg0: &StakedSuiVaultStateV1, arg1: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg2: &0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: u64) : (u64, u64, u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(0x2::math::min((((v0 as u128) * (arg4 as u128) / (arg5 as u128)) as u64), v0), default_unstake_total_fee(arg0));
        let v2 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v1, default_unstake_treasury_allocation(arg0));
        let v3 = v2;
        if (0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::has_referrer(arg1, arg3)) {
            v3 = v2 - 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v2, default_unstake_referee_discount(arg0));
        };
        (v3, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v1, default_unstake_dev_wallet_allocation(arg0)), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(v1, default_unstake_crank_incentive_allocation(arg0)))
    }

    public(friend) fun calculate_total_amounts_in_vault(arg0: &mut StakedSuiVaultStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut u64) : (bool, u64, u64) {
        let (v0, v1, v2) = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::storage::calculate_total_amounts(&mut arg0.staked_sui_storage, arg1, arg2, arg3, arg4);
        (v0, v1 + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserves), v2)
    }

    public(friend) fun crank_incentive_reward_per_instruction(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.crank_incentive_reward_per_instruction
    }

    public(friend) fun crank_incentive_reward_pool_value(arg0: &StakedSuiVaultStateV1) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.crank_incentive_reward_pool)
    }

    public(friend) fun create(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) : StakedSuiVaultStateV1 {
        assert!(arg2 <= 1000000000000000000, 1);
        assert!(arg3 <= 1000000000000000000, 1);
        assert!(arg4 <= 1000000000000000000, 1);
        assert!(arg5 <= 1000000000000000000, 1);
        assert!(arg3 + arg4 + arg5 == 1000000000000000000, 1);
        assert!(arg6 <= 1000000000000000000, 1);
        assert!(arg7 <= 1000000000000000000, 1);
        assert!(arg8 <= 1000000000000000000, 1);
        assert!(arg8 <= arg7, 2);
        assert!(arg9 <= 1000000000000000000, 1);
        assert!(arg10 <= 1000000000000000000, 1);
        assert!(arg11 <= 1000000000000000000, 1);
        assert!(arg9 + arg10 + arg11 == 1000000000000000000, 1);
        assert!(arg12 <= 1000000000000000000, 1);
        new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    }

    public(friend) fun dec_amount_to_unstake(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.epoch_was_changed_state.amount_to_unstake = arg0.epoch_was_changed_state.amount_to_unstake - arg1;
    }

    public(friend) fun dec_total_rewards_amount(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.total_rewards_amount = arg0.total_rewards_amount - arg1;
    }

    public(friend) fun dec_total_sui_amount(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.total_sui_amount = arg0.total_sui_amount - arg1;
    }

    public(friend) fun default_unstake_crank_incentive_allocation(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.default_unstake_protocol_fee.crank_incentive_allocation
    }

    public(friend) fun default_unstake_dev_wallet_allocation(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.default_unstake_protocol_fee.dev_wallet_allocation
    }

    public(friend) fun default_unstake_referee_discount(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.default_unstake_protocol_fee.referee_discount
    }

    public(friend) fun default_unstake_total_fee(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.default_unstake_protocol_fee.total_fee
    }

    public(friend) fun default_unstake_treasury_allocation(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.default_unstake_protocol_fee.treasury_allocation
    }

    public(friend) fun dev_account(arg0: &StakedSuiVaultStateV1) : address {
        arg0.protocol_config.dev_account
    }

    public(friend) fun has_validator_config_for(arg0: &StakedSuiVaultStateV1, arg1: address) : bool {
        0x2::linked_table::contains<address, ValidatorConfig>(&arg0.validator_configs, arg1)
    }

    public(friend) fun inactive_stakes_amount(arg0: &StakedSuiVaultStateV1) : u64 {
        0x2::table_vec::length<0x3::staking_pool::StakedSui>(&arg0.inactive_stakes)
    }

    public(friend) fun inc_active_epoch(arg0: &mut StakedSuiVaultStateV1) {
        arg0.active_epoch = arg0.active_epoch + 1;
    }

    public(friend) fun inc_total_sui_amount(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.total_sui_amount = arg0.total_sui_amount + arg1;
    }

    fun initialize_validator_configs(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x2::tx_context::TxContext) : 0x2::linked_table::LinkedTable<address, ValidatorConfig> {
        let v0 = 0x2::linked_table::new<address, ValidatorConfig>(arg1);
        let v1 = 0x3::sui_system::active_validator_addresses(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = *0x1::vector::borrow<address>(&v1, v2);
            let v4 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::new_unverified_validator_operation_cap(v3, arg1);
            let v5 = ValidatorConfig{
                sui_address      : v3,
                operation_cap_id : 0x2::object::id<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::UnverifiedValidatorOperationCap>(&v4),
                fee              : 0,
            };
            0x2::linked_table::push_back<address, ValidatorConfig>(&mut v0, v3, v5);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::transfer_unverified_validator_operation_cap(v4, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun is_epoch_processing(arg0: &StakedSuiVaultStateV1) : bool {
        arg0.epoch_was_changed_state.is_epoch_processing
    }

    public(friend) fun is_inactive_stakes_empty(arg0: &StakedSuiVaultStateV1) : bool {
        0x2::table_vec::is_empty<0x3::staking_pool::StakedSui>(&arg0.inactive_stakes)
    }

    public(friend) fun is_inactive_stakes_processed(arg0: &StakedSuiVaultStateV1) : bool {
        arg0.epoch_was_changed_state.is_inactive_stakes_processed
    }

    public(friend) fun is_pending_unstake_records_empty(arg0: &StakedSuiVaultStateV1) : bool {
        0x2::table_vec::is_empty<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord>(&arg0.pending_unstake_records)
    }

    public(friend) fun is_pending_unstakes_processed(arg0: &StakedSuiVaultStateV1) : bool {
        arg0.epoch_was_changed_state.is_pending_unstakes_processed
    }

    public(friend) fun is_total_sui_amount_updated(arg0: &StakedSuiVaultStateV1) : bool {
        arg0.epoch_was_changed_state.is_total_sui_amount_updated
    }

    public(friend) fun is_unstaking_deque_sorted(arg0: &StakedSuiVaultStateV1) : bool {
        arg0.epoch_was_changed_state.is_unstaking_deque_sorted
    }

    public(friend) fun is_unstaking_from_storage_processed(arg0: &StakedSuiVaultStateV1) : bool {
        arg0.epoch_was_changed_state.is_unstaking_from_storage_processed
    }

    public(friend) fun join_into_atomic_unstake_sui_reserves(arg0: &mut StakedSuiVaultStateV1, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.atomic_unstake_sui_reserves, arg1);
    }

    public(friend) fun join_into_sui_reserves(arg0: &mut StakedSuiVaultStateV1, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserves, arg1);
    }

    public(friend) fun max_atomic_unstake_fee(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.atomic_unstake_protocol_fee.max_fee
    }

    public(friend) fun max_crank_incentive_reward(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.max_crank_incentive_reward
    }

    public(friend) fun max_validator_fee(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.max_validator_fee
    }

    public(friend) fun min_atomic_unstake_fee(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.atomic_unstake_protocol_fee.min_fee
    }

    public(friend) fun min_fields_requests_per_tx(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.min_fields_requests_per_tx
    }

    public(friend) fun min_staking_threshold(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.min_staking_threshold
    }

    public(friend) fun mint_afsui(arg0: &mut StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::mint(arg1, &arg0.id, arg2, arg3)
    }

    public(friend) fun move_to_afsui_bin(arg0: &mut StakedSuiVaultStateV1, arg1: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>) {
        0x2::balance::join<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&mut arg0.afsui_bin, 0x2::coin::into_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg1));
    }

    public(friend) fun pending_unstake_records_amount(arg0: &StakedSuiVaultStateV1) : u64 {
        0x2::table_vec::length<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord>(&arg0.pending_unstake_records)
    }

    public(friend) fun pool_rates_epoch_gap(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.pool_rates_epoch_gap
    }

    public(friend) fun pop_inactive_stake(arg0: &mut StakedSuiVaultStateV1) : 0x3::staking_pool::StakedSui {
        0x2::table_vec::pop_back<0x3::staking_pool::StakedSui>(&mut arg0.inactive_stakes)
    }

    public(friend) fun pop_pending_unstake_record(arg0: &mut StakedSuiVaultStateV1) : 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord {
        0x2::table_vec::pop_back<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord>(&mut arg0.pending_unstake_records)
    }

    public(friend) fun push_inactive_stake(arg0: &mut StakedSuiVaultStateV1, arg1: 0x3::staking_pool::StakedSui) {
        0x2::table_vec::push_back<0x3::staking_pool::StakedSui>(&mut arg0.inactive_stakes, arg1);
    }

    public(friend) fun push_pending_unstake_record(arg0: &mut StakedSuiVaultStateV1, arg1: 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord) {
        0x2::table_vec::push_back<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::PendingUnstakeRecord>(&mut arg0.pending_unstake_records, arg1);
    }

    public(friend) fun push_staked_sui(arg0: &mut StakedSuiVaultStateV1, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::storage::push_stake(&mut arg0.staked_sui_storage, arg1, arg2);
    }

    public(friend) fun reference_gas_price(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.reference_gas_price
    }

    public(friend) fun reserves_before_unstake(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.epoch_was_changed_state.reserves_before_unstake
    }

    public(friend) fun reward_caller_with_crank_incentives(arg0: &mut StakedSuiVaultStateV1, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.crank_incentive_reward_pool, 0x2::math::min(crank_incentive_reward_pool_value(arg0), 0x2::math::min(crank_incentive_reward_per_instruction(arg0) * arg1, max_crank_incentive_reward(arg0)) * reference_gas_price(arg0))), arg3), arg2);
    }

    public(friend) fun rotate_operation_cap(arg0: &mut StakedSuiVaultStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x8e6adb40c50cf2ce81d7dd12d240fb881df715343ab61233124aadb87a9fd1fd::sui_system_utils::is_validator_active(arg1, &v0), 4);
        if (!has_validator_config_for(arg0, v0)) {
            add_default_validator_config(arg0, v0, arg2);
        } else {
            let v1 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::new_unverified_validator_operation_cap(v0, arg2);
            borrow_validator_config_mut(arg0, v0).operation_cap_id = 0x2::object::id<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::UnverifiedValidatorOperationCap>(&v1);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::transfer_unverified_validator_operation_cap(v1, v0);
        };
    }

    public(friend) fun set_amount_to_unstake(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.epoch_was_changed_state.amount_to_unstake = arg1;
    }

    public(friend) fun set_is_inactive_stakes_processed(arg0: &mut StakedSuiVaultStateV1, arg1: bool) {
        arg0.epoch_was_changed_state.is_inactive_stakes_processed = arg1;
    }

    public(friend) fun set_is_pending_unstakes_processed(arg0: &mut StakedSuiVaultStateV1, arg1: bool) {
        arg0.epoch_was_changed_state.is_pending_unstakes_processed = arg1;
    }

    public(friend) fun set_is_total_sui_amount_updated(arg0: &mut StakedSuiVaultStateV1, arg1: bool) {
        arg0.epoch_was_changed_state.is_total_sui_amount_updated = arg1;
    }

    public(friend) fun set_is_unstaking_deque_sorted(arg0: &mut StakedSuiVaultStateV1, arg1: bool) {
        arg0.epoch_was_changed_state.is_unstaking_deque_sorted = arg1;
    }

    public(friend) fun set_is_unstaking_from_storage_processed(arg0: &mut StakedSuiVaultStateV1, arg1: bool) {
        arg0.epoch_was_changed_state.is_unstaking_from_storage_processed = arg1;
    }

    public(friend) fun set_reserves_before_unstake(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.epoch_was_changed_state.reserves_before_unstake = arg1;
    }

    public(friend) fun sort_unstaking_deque(arg0: &mut StakedSuiVaultStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut u64) : bool {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::storage::sort_unstaking_deque(&mut arg0.staked_sui_storage, arg1, arg2, arg0.protocol_config.pool_rates_epoch_gap, arg3, arg4)
    }

    public(friend) fun split_from_atomic_unstake_sui_reserves(arg0: &mut StakedSuiVaultStateV1, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.atomic_unstake_sui_reserves, arg1)
    }

    public(friend) fun split_from_sui_reserves(arg0: &mut StakedSuiVaultStateV1, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserves, arg1)
    }

    public(friend) fun sui_reserves_value(arg0: &StakedSuiVaultStateV1) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserves)
    }

    public(friend) fun switch_epoch_processing(arg0: &mut StakedSuiVaultStateV1) {
        arg0.epoch_was_changed_state.is_epoch_processing = !arg0.epoch_was_changed_state.is_epoch_processing;
        arg0.epoch_was_changed_state.is_inactive_stakes_processed = false;
        arg0.epoch_was_changed_state.is_pending_unstakes_processed = false;
        arg0.epoch_was_changed_state.is_unstaking_deque_sorted = false;
        arg0.epoch_was_changed_state.is_total_sui_amount_updated = false;
        arg0.epoch_was_changed_state.is_unstaking_from_storage_processed = false;
        arg0.epoch_was_changed_state.amount_to_unstake = 0;
        arg0.epoch_was_changed_state.reserves_before_unstake = 0;
    }

    public(friend) fun take_atomic_unstake_protocol_fee(arg0: &mut StakedSuiVaultStateV1, arg1: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg2: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = calculate_atomic_unstake_protocol_fee(arg0, arg1, arg3, arg4);
        if (v0 > 0) {
            0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::deposit<0x2::sui::SUI>(arg2, 0x2::coin::split<0x2::sui::SUI>(arg3, v0, arg5));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v1, arg5), dev_account(arg0));
        };
        if (v2 > 0) {
            add_crank_incentives(arg0, 0x2::coin::split<0x2::sui::SUI>(arg3, v2, arg5));
        };
    }

    public(friend) fun take_default_unstake_protocol_fee(arg0: &mut StakedSuiVaultStateV1, arg1: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg2: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = calculate_default_unstake_protocol_fee(arg0, arg1, arg3, arg4, total_rewards_amount(arg0), total_sui_amount(arg0));
        if (v0 > 0) {
            0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::deposit<0x2::sui::SUI>(arg2, 0x2::coin::split<0x2::sui::SUI>(arg3, v0, arg5));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v1, arg5), dev_account(arg0));
        };
        if (v2 > 0) {
            add_crank_incentives(arg0, 0x2::coin::split<0x2::sui::SUI>(arg3, v2, arg5));
        };
    }

    public(friend) fun take_validator_fee(arg0: &mut 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::percentage_of(0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0), arg2);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(0x2::coin::split<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, v0, arg3), arg1);
    }

    public(friend) fun total_rewards_amount(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.total_rewards_amount
    }

    public(friend) fun total_sui_amount(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.total_sui_amount
    }

    public(friend) fun unstake_from_storage(arg0: &mut StakedSuiVaultStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::storage::unstake(&mut arg0.staked_sui_storage, arg1, arg2, arg0.protocol_config.unstaking_bunch_size, arg0.protocol_config.min_staking_threshold, arg3, arg4, arg5)
    }

    public(friend) fun unstaking_bunch_size(arg0: &StakedSuiVaultStateV1) : u64 {
        arg0.protocol_config.unstaking_bunch_size
    }

    public(friend) fun update_atomic_unstake_fee_allocations(arg0: &mut StakedSuiVaultStateV1, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= 1000000000000000000, 1);
        assert!(arg2 <= 1000000000000000000, 1);
        assert!(arg3 <= 1000000000000000000, 1);
        assert!(arg1 + arg2 + arg3 == 1000000000000000000, 1);
        arg0.protocol_config.atomic_unstake_protocol_fee.treasury_allocation = arg1;
        arg0.protocol_config.atomic_unstake_protocol_fee.dev_wallet_allocation = arg2;
        arg0.protocol_config.atomic_unstake_protocol_fee.crank_incentive_allocation = arg3;
    }

    public(friend) fun update_atomic_unstake_max_fee(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        assert!(arg1 <= 1000000000000000000, 1);
        assert!(min_atomic_unstake_fee(arg0) <= arg1, 1);
        arg0.protocol_config.atomic_unstake_protocol_fee.max_fee = arg1;
    }

    public(friend) fun update_atomic_unstake_min_fee(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        assert!(arg1 <= 1000000000000000000, 1);
        assert!(arg1 <= max_atomic_unstake_fee(arg0), 1);
        arg0.protocol_config.atomic_unstake_protocol_fee.min_fee = arg1;
    }

    public(friend) fun update_atomic_unstake_referee_discount(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        assert!(arg1 <= 1000000000000000000, 1);
        arg0.protocol_config.atomic_unstake_protocol_fee.referee_discount = arg1;
    }

    public(friend) fun update_atomic_unstake_sui_reserves_target_value(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.atomic_unstake_sui_reserves_target_value = arg1;
    }

    public(friend) fun update_crank_incentive_reward_per_instruction(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.crank_incentive_reward_per_instruction = arg1;
    }

    public(friend) fun update_default_unstake_fee_allocations(arg0: &mut StakedSuiVaultStateV1, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= 1000000000000000000, 1);
        assert!(arg2 <= 1000000000000000000, 1);
        assert!(arg3 <= 1000000000000000000, 1);
        assert!(arg1 + arg2 + arg3 == 1000000000000000000, 1);
        arg0.protocol_config.default_unstake_protocol_fee.treasury_allocation = arg1;
        arg0.protocol_config.default_unstake_protocol_fee.dev_wallet_allocation = arg2;
        arg0.protocol_config.default_unstake_protocol_fee.crank_incentive_allocation = arg3;
    }

    public(friend) fun update_default_unstake_referee_discount(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        assert!(arg1 <= 1000000000000000000, 1);
        arg0.protocol_config.default_unstake_protocol_fee.referee_discount = arg1;
    }

    public(friend) fun update_default_unstake_total_fee(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        assert!(arg1 <= 1000000000000000000, 1);
        arg0.protocol_config.default_unstake_protocol_fee.total_fee = arg1;
    }

    public(friend) fun update_dev_account(arg0: &mut StakedSuiVaultStateV1, arg1: address) {
        arg0.protocol_config.dev_account = arg1;
    }

    public(friend) fun update_max_crank_incentive_reward(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.max_crank_incentive_reward = arg1;
    }

    public(friend) fun update_min_fields_requests_per_tx(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.min_fields_requests_per_tx = arg1;
    }

    public(friend) fun update_min_staking_threshold(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.min_staking_threshold = arg1;
    }

    public(friend) fun update_pool_rates_epoch_gap(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.pool_rates_epoch_gap = arg1;
    }

    public(friend) fun update_reference_gas_price(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.reference_gas_price = arg1;
    }

    public(friend) fun update_total_rewards_amount(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.total_rewards_amount = arg1;
    }

    public(friend) fun update_total_sui_amount(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.total_sui_amount = arg1;
    }

    public(friend) fun update_unstaking_bunch_size(arg0: &mut StakedSuiVaultStateV1, arg1: u64) {
        arg0.protocol_config.unstaking_bunch_size = arg1;
    }

    public(friend) fun update_validator_fee(arg0: &0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::UnverifiedValidatorOperationCap, arg1: &mut StakedSuiVaultStateV1, arg2: u64) {
        assert!(arg2 <= max_validator_fee(arg1), 6);
        let v0 = borrow_validator_config_mut(arg1, *0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::unverified_operation_cap_address(arg0));
        assert!(v0.operation_cap_id == 0x2::object::id<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator::UnverifiedValidatorOperationCap>(arg0), 5);
        v0.fee = arg2;
    }

    public(friend) fun validator_fee(arg0: &mut StakedSuiVaultStateV1, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        if (has_validator_config_for(arg0, arg1)) {
            borrow_validator_config(arg0, arg1).fee
        } else {
            add_default_validator_config(arg0, arg1, arg2);
            0
        }
    }

    // decompiled from Move bytecode v6
}

