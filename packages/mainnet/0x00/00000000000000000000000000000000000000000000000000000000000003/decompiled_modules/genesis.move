module 0x3::genesis {
    struct GenesisValidatorMetadata has copy, drop {
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
        project_url: vector<u8>,
        sui_address: address,
        gas_price: u64,
        commission_rate: u64,
        protocol_public_key: vector<u8>,
        proof_of_possession: vector<u8>,
        network_public_key: vector<u8>,
        worker_public_key: vector<u8>,
        network_address: vector<u8>,
        p2p_address: vector<u8>,
        primary_address: vector<u8>,
        worker_address: vector<u8>,
    }

    struct GenesisChainParameters has copy, drop {
        protocol_version: u64,
        chain_start_timestamp_ms: u64,
        epoch_duration_ms: u64,
        stake_subsidy_start_epoch: u64,
        stake_subsidy_initial_distribution_amount: u64,
        stake_subsidy_period_length: u64,
        stake_subsidy_decrease_rate: u16,
        max_validator_count: u64,
        min_validator_joining_stake: u64,
        validator_low_stake_threshold: u64,
        validator_very_low_stake_threshold: u64,
        validator_low_stake_grace_period: u64,
    }

    struct TokenDistributionSchedule {
        stake_subsidy_fund_mist: u64,
        allocations: vector<TokenAllocation>,
    }

    struct TokenAllocation {
        recipient_address: address,
        amount_mist: u64,
        staked_with_validator: 0x1::option::Option<address>,
    }

    fun allocate_tokens(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: vector<TokenAllocation>, arg2: &mut vector<0x3::validator::Validator>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenAllocation>(&arg1)) {
            let TokenAllocation {
                recipient_address     : v1,
                amount_mist           : v2,
                staked_with_validator : v3,
            } = 0x1::vector::pop_back<TokenAllocation>(&mut arg1);
            let v4 = v3;
            if (0x1::option::is_some<address>(&v4)) {
                0x3::validator::request_add_stake_at_genesis(0x3::validator_set::get_validator_mut(arg2, 0x1::option::destroy_some<address>(v4)), 0x2::balance::split<0x2::sui::SUI>(&mut arg0, v2), v1, arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0, v2), arg3), v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<TokenAllocation>(arg1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
    }

    fun create(arg0: 0x2::object::UID, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: GenesisChainParameters, arg3: vector<GenesisValidatorMetadata>, arg4: TokenDistributionSchedule, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg5) == 0, 0);
        let v0 = 0x1::vector::empty<0x3::validator::Validator>();
        0x1::vector::reverse<GenesisValidatorMetadata>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<GenesisValidatorMetadata>(&arg3)) {
            let GenesisValidatorMetadata {
                name                : v2,
                description         : v3,
                image_url           : v4,
                project_url         : v5,
                sui_address         : v6,
                gas_price           : v7,
                commission_rate     : v8,
                protocol_public_key : v9,
                proof_of_possession : v10,
                network_public_key  : v11,
                worker_public_key   : v12,
                network_address     : v13,
                p2p_address         : v14,
                primary_address     : v15,
                worker_address      : v16,
            } = 0x1::vector::pop_back<GenesisValidatorMetadata>(&mut arg3);
            let v17 = 0x3::validator::new(v6, v9, v11, v12, v10, v2, v3, v4, v5, v13, v14, v15, v16, v7, v8, arg5);
            assert!(!0x3::validator_set::is_duplicate_validator(&v0, &v17), 1);
            0x1::vector::push_back<0x3::validator::Validator>(&mut v0, v17);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<GenesisValidatorMetadata>(arg3);
        let TokenDistributionSchedule {
            stake_subsidy_fund_mist : v18,
            allocations             : v19,
        } = arg4;
        let v20 = &mut v0;
        allocate_tokens(arg1, v19, v20, arg5);
        let v21 = &mut v0;
        let v22 = 0;
        while (v22 < 0x1::vector::length<0x3::validator::Validator>(v21)) {
            0x3::validator::activate(0x1::vector::borrow_mut<0x3::validator::Validator>(v21, v22), 0);
            v22 = v22 + 1;
        };
        0x3::sui_system::create(arg0, v0, 0x2::balance::zero<0x2::sui::SUI>(), arg2.protocol_version, arg2.chain_start_timestamp_ms, 0x3::sui_system_state_inner::create_system_parameters(arg2.epoch_duration_ms, arg2.stake_subsidy_start_epoch, arg2.max_validator_count, arg2.min_validator_joining_stake, arg2.validator_low_stake_threshold, arg2.validator_very_low_stake_threshold, arg2.validator_low_stake_grace_period, arg5), 0x3::stake_subsidy::create(0x2::balance::split<0x2::sui::SUI>(&mut arg1, v18), arg2.stake_subsidy_initial_distribution_amount, arg2.stake_subsidy_period_length, arg2.stake_subsidy_decrease_rate, arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

