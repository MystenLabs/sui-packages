module 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool {
    struct ValidatorPool has store {
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        validator_infos: vector<ValidatorInfo>,
        total_sui_supply: u64,
        last_refresh_epoch: u64,
        total_weight: u64,
        manage: 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::Manage,
        extra_fields: 0x2::bag::Bag,
    }

    struct ValidatorInfo has store {
        staking_pool_id: 0x2::object::ID,
        validator_address: address,
        active_stake: 0x1::option::Option<0x3::staking_pool::FungibleStakedSui>,
        inactive_stake: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        exchange_rate: 0x3::staking_pool::PoolTokenExchangeRate,
        total_sui_amount: u64,
        assigned_weight: u64,
        last_refresh_epoch: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ValidatorPool {
        ValidatorPool{
            sui_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            validator_infos    : 0x1::vector::empty<ValidatorInfo>(),
            total_sui_supply   : 0,
            last_refresh_epoch : 0x2::tx_context::epoch(arg0) - 1,
            total_weight       : 0,
            manage             : 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::new(),
            extra_fields       : 0x2::bag::new(arg0),
        }
    }

    public fun active_stake(arg0: &ValidatorInfo) : &0x1::option::Option<0x3::staking_pool::FungibleStakedSui> {
        &arg0.active_stake
    }

    public(friend) fun decrease_validator_stake(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = find_validator_index_by_address(arg0, arg2);
        assert!(0x1::option::is_some<u64>(&v0), 40004);
        unstake_approx_n_sui_from_validator(arg0, arg1, 0x1::option::extract<u64>(&mut v0), arg3, arg4)
    }

    public fun exchange_rate(arg0: &ValidatorInfo) : &0x3::staking_pool::PoolTokenExchangeRate {
        &arg0.exchange_rate
    }

    public fun find_validator_index_by_address(arg0: &ValidatorPool, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos)) {
            if (0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v0).validator_address == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun get_latest_exchange_rate(arg0: &ValidatorPool, arg1: &0x2::object::ID, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::tx_context::TxContext) : 0x1::option::Option<0x3::staking_pool::PoolTokenExchangeRate> {
        let v0 = 0x3::sui_system::pool_exchange_rates(arg2, arg1);
        let v1 = 0x2::tx_context::epoch(arg3);
        while (v1 > arg0.last_refresh_epoch) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, v1)) {
                return 0x1::option::some<0x3::staking_pool::PoolTokenExchangeRate>(*0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, v1))
            };
            v1 = v1 - 1;
        };
        0x1::option::none<0x3::staking_pool::PoolTokenExchangeRate>()
    }

    fun get_or_add_validator_index_by_staking_pool_id_mut(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos)) {
            if (0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1).staking_pool_id == arg2) {
                return v1
            };
            0x1::vector::push_back<address>(&mut v0, 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1).validator_address);
            v1 = v1 + 1;
        };
        let v2 = 0x3::sui_system::validator_address_by_pool_id(arg1, &arg2);
        assert!(!0x1::vector::contains<address>(&v0, &v2), 40003);
        let v3 = 0x3::sui_system::active_validator_addresses(arg1);
        assert!(0x1::vector::contains<address>(&v3, &v2), 40001);
        let v4 = ValidatorInfo{
            staking_pool_id    : arg2,
            validator_address  : v2,
            active_stake       : 0x1::option::none<0x3::staking_pool::FungibleStakedSui>(),
            inactive_stake     : 0x1::option::none<0x3::staking_pool::StakedSui>(),
            exchange_rate      : *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(0x3::sui_system::pool_exchange_rates(arg1, &arg2), 0x2::tx_context::epoch(arg3)),
            total_sui_amount   : 0,
            assigned_weight    : 100,
            last_refresh_epoch : 0x2::tx_context::epoch(arg3),
            extra_fields       : 0x2::bag::new(arg3),
        };
        0x1::vector::push_back<ValidatorInfo>(&mut arg0.validator_infos, v4);
        v1
    }

    fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        if (0x3::staking_pool::sui_amount(arg0) == 0 || 0x3::staking_pool::pool_token_amount(arg0) == 0) {
            return arg1
        };
        (((0x3::staking_pool::sui_amount(arg0) as u128) * (arg1 as u128) / (0x3::staking_pool::pool_token_amount(arg0) as u128)) as u64)
    }

    public fun inactive_stake(arg0: &ValidatorInfo) : &0x1::option::Option<0x3::staking_pool::StakedSui> {
        &arg0.inactive_stake
    }

    public(friend) fun increase_validator_stake(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = split_up_to_n_sui_from_sui_pool(arg0, arg3);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) < 1000000000) {
            join_to_sui_pool(arg0, v0);
            return 0
        };
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), arg2, arg4);
        join_stake(arg0, arg1, v1, arg4);
        0x3::staking_pool::staked_sui_amount(&v1)
    }

    fun is_empty(arg0: &ValidatorInfo) : bool {
        if (0x1::option::is_none<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake)) {
            if (0x1::option::is_none<0x3::staking_pool::StakedSui>(&arg0.inactive_stake)) {
                if (arg0.total_sui_amount == 0) {
                    arg0.assigned_weight == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun join_fungible_staked_sui_to_validator(arg0: &mut ValidatorPool, arg1: u64, arg2: 0x3::staking_pool::FungibleStakedSui) {
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1);
        if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            0x3::staking_pool::join_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut v0.active_stake), arg2);
        } else {
            0x1::option::fill<0x3::staking_pool::FungibleStakedSui>(&mut v0.active_stake, arg2);
        };
        refresh_validator_info(arg0, arg1);
    }

    fun join_inactive_stake_to_validator(arg0: &mut ValidatorPool, arg1: u64, arg2: 0x3::staking_pool::StakedSui) {
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1);
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            0x3::staking_pool::join_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut v0.inactive_stake), arg2);
        } else {
            0x1::option::fill<0x3::staking_pool::StakedSui>(&mut v0.inactive_stake, arg2);
        };
        refresh_validator_info(arg0, arg1);
    }

    public(friend) fun join_stake(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_add_validator_index_by_staking_pool_id_mut(arg0, arg1, 0x3::staking_pool::pool_id(&arg2), arg3);
        if (0x3::staking_pool::stake_activation_epoch(&arg2) <= 0x2::tx_context::epoch(arg3)) {
            join_fungible_staked_sui_to_validator(arg0, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
        } else {
            join_inactive_stake_to_validator(arg0, v0, arg2);
        };
    }

    public(friend) fun join_to_sui_pool(arg0: &mut ValidatorPool, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.total_sui_supply = arg0.total_sui_supply + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, arg1);
    }

    public fun last_refresh_epoch(arg0: &ValidatorPool) : u64 {
        arg0.last_refresh_epoch
    }

    public(friend) fun rebalance(arg0: &mut ValidatorPool, arg1: 0x1::option::Option<0x2::vec_map::VecMap<address, u64>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = total_sui_supply(arg0);
        let v1 = 0x1::option::is_some<0x2::vec_map::VecMap<address, u64>>(&arg1);
        if (arg0.total_weight == 0 || total_sui_supply(arg0) == 0) {
            return
        };
        let v2 = if (v1) {
            0x1::option::extract<0x2::vec_map::VecMap<address, u64>>(&mut arg1)
        } else {
            0x2::vec_map::empty<address, u64>()
        };
        let v3 = v2;
        let v4 = validators(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<ValidatorInfo>(v4)) {
            let v6 = 0x1::vector::borrow<ValidatorInfo>(v4, v5);
            let v7 = validator_address(v6);
            if (!0x2::vec_map::contains<address, u64>(&v3, &v7)) {
                let v8 = if (v1) {
                    0
                } else {
                    v6.assigned_weight
                };
                0x2::vec_map::insert<address, u64>(&mut v3, v7, v8);
            };
            v5 = v5 + 1;
        };
        let (v9, v10) = 0x2::vec_map::into_keys_values<address, u64>(v3);
        let v11 = v10;
        let v12 = v9;
        let v13 = vector[];
        0x1::vector::reverse<u64>(&mut v11);
        let v14 = 0;
        while (v14 < 0x1::vector::length<u64>(&v11)) {
            0x1::vector::push_back<u64>(&mut v13, (((total_sui_supply(arg0) as u128) * (0x1::vector::pop_back<u64>(&mut v11) as u128) / (arg0.total_weight as u128)) as u64));
            v14 = v14 + 1;
        };
        0x1::vector::destroy_empty<u64>(v11);
        let v15 = &v12;
        let v16 = vector[];
        let v17 = 0;
        while (v17 < 0x1::vector::length<address>(v15)) {
            let v18 = find_validator_index_by_address(arg0, *0x1::vector::borrow<address>(v15, v17));
            let v19 = if (0x1::option::is_none<u64>(&v18)) {
                0
            } else {
                total_sui_amount(0x1::vector::borrow<ValidatorInfo>(validators(arg0), 0x1::option::extract<u64>(&mut v18)))
            };
            0x1::vector::push_back<u64>(&mut v16, v19);
            v17 = v17 + 1;
        };
        let v20 = 0;
        while (v20 < 0x1::vector::length<address>(&v12)) {
            if (*0x1::vector::borrow<u64>(&v16, v20) > *0x1::vector::borrow<u64>(&v13, v20)) {
                decrease_validator_stake(arg0, arg2, *0x1::vector::borrow<address>(&v12, v20), *0x1::vector::borrow<u64>(&v16, v20) - *0x1::vector::borrow<u64>(&v13, v20), arg3);
            };
            v20 = v20 + 1;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<address>(&v12)) {
            if (*0x1::vector::borrow<u64>(&v16, v21) < *0x1::vector::borrow<u64>(&v13, v21)) {
                increase_validator_stake(arg0, arg2, *0x1::vector::borrow<address>(&v12, v21), *0x1::vector::borrow<u64>(&v13, v21) - *0x1::vector::borrow<u64>(&v16, v21), arg3);
            };
            v21 = v21 + 1;
        };
        let v22 = 0;
        while (v22 < 0x1::vector::length<address>(&v12)) {
            let v23 = find_validator_index_by_address(arg0, *0x1::vector::borrow<address>(&v12, v22));
            if (0x1::option::is_some<u64>(&v23)) {
                0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, 0x1::option::extract<u64>(&mut v23)).assigned_weight = *0x1::vector::borrow<u64>(&v11, v22);
            };
            v22 = v22 + 1;
        };
        assert!(total_sui_supply(arg0) + 10 >= v0, 40009);
    }

    public(friend) fun refresh(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        if (total_sui_supply(arg0) == 0) {
            return false
        };
        if (arg0.last_refresh_epoch == 0x2::tx_context::epoch(arg2)) {
            stake_pending_sui(arg0, arg1, arg2);
            return false
        };
        let v0 = 0x3::sui_system::active_validator_addresses(arg1);
        let v1 = 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos);
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            if (!0x1::vector::contains<address>(&v0, &0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v2).validator_address)) {
                unstake_approx_n_sui_from_validator(arg0, arg1, v2, 10000000000000000000, arg2);
                arg0.total_weight = arg0.total_weight - 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v2).assigned_weight;
                0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v2).assigned_weight = 0;
            };
            if (is_empty(0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v2))) {
                let ValidatorInfo {
                    staking_pool_id    : _,
                    validator_address  : _,
                    active_stake       : v5,
                    inactive_stake     : v6,
                    exchange_rate      : _,
                    total_sui_amount   : _,
                    assigned_weight    : _,
                    last_refresh_epoch : _,
                    extra_fields       : v11,
                } = 0x1::vector::remove<ValidatorInfo>(&mut arg0.validator_infos, v2);
                0x1::option::destroy_none<0x3::staking_pool::FungibleStakedSui>(v5);
                0x1::option::destroy_none<0x3::staking_pool::StakedSui>(v6);
                0x2::bag::destroy_empty(v11);
            };
        };
        v1 = 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos);
        while (v1 > 0) {
            let v12 = v1 - 1;
            v1 = v12;
            let v13 = get_latest_exchange_rate(arg0, &0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v12).staking_pool_id, arg1, arg2);
            if (0x1::option::is_some<0x3::staking_pool::PoolTokenExchangeRate>(&v13)) {
                0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v12).exchange_rate = *0x1::option::borrow<0x3::staking_pool::PoolTokenExchangeRate>(&v13);
                0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v12).last_refresh_epoch = 0x2::tx_context::epoch(arg2);
            };
            refresh_validator_info(arg0, v12);
            if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v12).inactive_stake) && 0x3::staking_pool::stake_activation_epoch(0x1::option::borrow<0x3::staking_pool::StakedSui>(&0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v12).inactive_stake)) <= 0x2::tx_context::epoch(arg2)) {
                let v14 = take_all_inactive_stake(arg0, v12);
                join_fungible_staked_sui_to_validator(arg0, v12, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, v14, arg2));
            };
        };
        stake_pending_sui(arg0, arg1, arg2);
        arg0.last_refresh_epoch = 0x2::tx_context::epoch(arg2);
        true
    }

    fun refresh_validator_info(arg0: &mut ValidatorPool, arg1: u64) {
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1);
        arg0.total_sui_supply = arg0.total_sui_supply - v0.total_sui_amount;
        let v1 = 0;
        let v2 = v1;
        if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            v2 = v1 + get_sui_amount(&v0.exchange_rate, 0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)));
        };
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            v2 = v2 + 0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.inactive_stake));
        };
        v0.total_sui_amount = v2;
        arg0.total_sui_supply = arg0.total_sui_supply + v2;
    }

    public(friend) fun set_validator_weights(arg0: &mut ValidatorPool, arg1: 0x2::vec_map::VecMap<address, u64>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = 0x2::vec_map::size<address, u64>(&arg1);
        assert!(v0 <= 50, 40002);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg1, v2);
            v1 = v1 + *v4;
            v2 = v2 + 1;
        };
        assert!(v1 <= 10000, 40008);
        arg0.total_weight = v1;
        rebalance(arg0, 0x1::option::some<0x2::vec_map::VecMap<address, u64>>(arg1), arg2, arg3);
        verify_validator_weights(arg0, arg1);
    }

    fun split_from_sui_pool(arg0: &mut ValidatorPool, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        arg0.total_sui_supply = arg0.total_sui_supply - arg1;
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, arg1)
    }

    public(friend) fun split_n_sui(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)) {
            arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)
        } else {
            0
        };
        let v1 = 0x1::vector::length<ValidatorInfo>(validators(arg0));
        while (v1 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) < arg2) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = ((1 + (0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v2).assigned_weight as u128) * (v0 as u128) / (arg0.total_weight as u128)) as u64);
            unstake_approx_n_sui_from_validator(arg0, arg1, v2, v3, arg3);
        };
        v1 = 0x1::vector::length<ValidatorInfo>(validators(arg0));
        while (v1 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) < arg2) {
            let v4 = v1 - 1;
            v1 = v4;
            let v5 = ((arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)) as u64);
            unstake_approx_n_sui_from_validator(arg0, arg1, v4, v5, arg3);
        };
        let v6 = arg2;
        if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)) {
            if (arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) + 10) {
                v6 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool);
            };
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) >= v6, 40000);
        split_from_sui_pool(arg0, v6)
    }

    public(friend) fun split_up_to_n_sui_from_sui_pool(arg0: &mut ValidatorPool, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::u64::min(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool), arg1);
        split_from_sui_pool(arg0, v0)
    }

    public(friend) fun stake_pending_sui(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos);
        if (arg0.total_weight == 0) {
            return false
        };
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v0).validator_address;
            let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) / arg0.total_weight * 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v0).assigned_weight;
            increase_validator_stake(arg0, arg1, v1, v2, arg2);
        };
        true
    }

    public fun staking_pool_id(arg0: &ValidatorInfo) : 0x2::object::ID {
        arg0.staking_pool_id
    }

    public fun sui_pool(arg0: &ValidatorPool) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.sui_pool
    }

    fun take_all_active_stake(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::option::extract<0x3::staking_pool::FungibleStakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2).active_stake);
        refresh_validator_info(arg0, arg2);
        0x3::sui_system::redeem_fungible_staked_sui(arg1, v0, arg3)
    }

    fun take_all_inactive_stake(arg0: &mut ValidatorPool, arg1: u64) : 0x3::staking_pool::StakedSui {
        let v0 = 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1).inactive_stake);
        refresh_validator_info(arg0, arg1);
        v0
    }

    fun take_some_active_stake(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x3::staking_pool::split_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2).active_stake), arg3, arg4);
        refresh_validator_info(arg0, arg2);
        0x3::sui_system::redeem_fungible_staked_sui(arg1, v0, arg4)
    }

    fun take_some_inactive_stake(arg0: &mut ValidatorPool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        let v0 = 0x3::staking_pool::split(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1).inactive_stake), arg2, arg3);
        refresh_validator_info(arg0, arg1);
        v0
    }

    public fun total_sui_amount(arg0: &ValidatorInfo) : u64 {
        arg0.total_sui_amount
    }

    public fun total_sui_supply(arg0: &ValidatorPool) : u64 {
        arg0.total_sui_supply
    }

    public fun total_weight(arg0: &ValidatorPool) : u64 {
        arg0.total_weight
    }

    public(friend) fun unstake_approx_n_sui_from_active_stake(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2);
        if (0x1::option::is_none<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            return 0
        };
        let v1 = 0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake));
        let v2 = get_sui_amount(&v0.exchange_rate, v1);
        let v3 = 0x1::u64::max(arg3, 1000000000);
        let v4 = if (v2 <= v3 + 1000000000) {
            take_all_active_stake(arg0, arg1, arg2, arg4)
        } else {
            take_some_active_stake(arg0, arg1, arg2, (((((v3 as u128) * (v1 as u128) + (v2 as u128) - 1) / (v2 as u128)) as u64) as u64), arg4)
        };
        let v5 = v4;
        join_to_sui_pool(arg0, v5);
        0x2::balance::value<0x2::sui::SUI>(&v5)
    }

    public(friend) fun unstake_approx_n_sui_from_inactive_stake(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2);
        if (0x1::option::is_none<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            return 0
        };
        let v1 = 0x1::u64::max(arg3, 1000000000);
        let v2 = if (0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) <= v1 + 1000000000) {
            take_all_inactive_stake(arg0, arg2)
        } else {
            take_some_inactive_stake(arg0, arg2, v1, arg4)
        };
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v2, arg4);
        join_to_sui_pool(arg0, v3);
        0x2::balance::value<0x2::sui::SUI>(&v3)
    }

    public(friend) fun unstake_approx_n_sui_from_validator(arg0: &mut ValidatorPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = unstake_approx_n_sui_from_inactive_stake(arg0, arg1, arg2, arg3, arg4);
        let v1 = v0;
        if (arg3 > v0) {
            v1 = v0 + unstake_approx_n_sui_from_active_stake(arg0, arg1, arg2, arg3 - v0 + 100, arg4);
        };
        v1
    }

    public fun validator_address(arg0: &ValidatorInfo) : address {
        arg0.validator_address
    }

    public fun validator_stake_amounts(arg0: &ValidatorPool) : (0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>) {
        let v0 = 0x2::vec_map::empty<address, u64>();
        let v1 = 0x2::vec_map::empty<address, u64>();
        let v2 = &arg0.validator_infos;
        let v3 = 0;
        while (v3 < 0x1::vector::length<ValidatorInfo>(v2)) {
            let v4 = 0x1::vector::borrow<ValidatorInfo>(v2, v3);
            let v5 = if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v4.inactive_stake)) {
                0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v4.inactive_stake))
            } else {
                0
            };
            let v6 = if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&v4.active_stake)) {
                get_sui_amount(&v4.exchange_rate, 0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&v4.active_stake)))
            } else {
                0
            };
            0x2::vec_map::insert<address, u64>(&mut v0, v4.validator_address, v5);
            0x2::vec_map::insert<address, u64>(&mut v1, v4.validator_address, v6);
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    public fun validator_weights(arg0: &ValidatorPool) : 0x2::vec_map::VecMap<address, u64> {
        let v0 = 0x2::vec_map::empty<address, u64>();
        let v1 = &arg0.validator_infos;
        let v2 = 0;
        while (v2 < 0x1::vector::length<ValidatorInfo>(v1)) {
            let v3 = 0x1::vector::borrow<ValidatorInfo>(v1, v2);
            0x2::vec_map::insert<address, u64>(&mut v0, v3.validator_address, v3.assigned_weight);
            v2 = v2 + 1;
        };
        v0
    }

    public fun validators(arg0: &ValidatorPool) : &vector<ValidatorInfo> {
        &arg0.validator_infos
    }

    fun verify_validator_weights(arg0: &ValidatorPool, arg1: 0x2::vec_map::VecMap<address, u64>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = &arg0.validator_infos;
        let v4 = 0;
        while (v4 < 0x1::vector::length<ValidatorInfo>(v3)) {
            let v5 = 0x1::vector::borrow<ValidatorInfo>(v3, v4);
            v0 = v0 + v5.assigned_weight;
            if (0x2::vec_map::contains<address, u64>(&arg1, &v5.validator_address) && v5.assigned_weight > 0) {
                v1 = v1 + 1;
                let v6 = v5.assigned_weight;
                assert!(0x2::vec_map::get<address, u64>(&arg1, &v5.validator_address) == &v6, 40005);
            };
            v4 = v4 + 1;
        };
        let v7 = 0;
        while (v7 < 0x2::vec_map::size<address, u64>(&arg1)) {
            let (_, v9) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg1, v7);
            if (*v9 > 0) {
                v2 = v2 + 1;
            };
            v7 = v7 + 1;
        };
        assert!(v0 == arg0.total_weight, 40006);
        assert!(v1 == v2, 40007);
    }

    // decompiled from Move bytecode v6
}

