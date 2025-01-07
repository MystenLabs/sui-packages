module 0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::storage {
    struct Storage has store {
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        validator_infos: vector<ValidatorInfo>,
        total_sui_supply: u64,
        last_refresh_epoch: u64,
        total_weight: u64,
        validator_addresses_and_weights: 0x2::vec_map::VecMap<address, u64>,
        version: 0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::version::Version,
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
        extra_fields: 0x2::bag::Bag,
    }

    struct DecreaseValidatorStakeEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        staking_pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct IncreaseValidatorStakeEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        staking_pool_id: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Storage {
        Storage{
            sui_pool                        : 0x2::balance::zero<0x2::sui::SUI>(),
            validator_infos                 : 0x1::vector::empty<ValidatorInfo>(),
            total_sui_supply                : 0,
            last_refresh_epoch              : 0x2::tx_context::epoch(arg0) - 1,
            total_weight                    : 0,
            validator_addresses_and_weights : 0x2::vec_map::empty<address, u64>(),
            version                         : 0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::version::new(1),
            extra_fields                    : 0x2::bag::new(arg0),
        }
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

    public(friend) fun active_stake(arg0: &ValidatorInfo) : &0x1::option::Option<0x3::staking_pool::FungibleStakedSui> {
        &arg0.active_stake
    }

    public(friend) fun decrease_validator_stake<T0>(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = find_validator_index_by_address(arg0, arg2);
        assert!(v0 < 0x1::vector::length<ValidatorInfo>(validators(arg0)), 4);
        let v1 = unstake_approx_n_sui_from_validator(arg0, arg1, v0, arg3, arg4);
        let v2 = DecreaseValidatorStakeEvent{
            typename        : 0x1::type_name::get<T0>(),
            staking_pool_id : staking_pool_id(0x1::vector::borrow<ValidatorInfo>(validators(arg0), v0)),
            amount          : v1,
        };
        0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::events::emit_event<DecreaseValidatorStakeEvent>(v2);
        v1
    }

    public(friend) fun exchange_rate(arg0: &ValidatorInfo) : &0x3::staking_pool::PoolTokenExchangeRate {
        &arg0.exchange_rate
    }

    public(friend) fun find_validator_index_by_address(arg0: &Storage, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos)) {
            if (0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v0).validator_address == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun get_latest_exchange_rate(arg0: &Storage, arg1: &0x2::object::ID, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::tx_context::TxContext) : 0x1::option::Option<0x3::staking_pool::PoolTokenExchangeRate> {
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

    fun get_or_add_validator_index_by_staking_pool_id_mut(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : u64 {
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
        assert!(!0x1::vector::contains<address>(&v0, &v2), 3);
        let v3 = 0x3::sui_system::active_validator_addresses(arg1);
        assert!(0x1::vector::contains<address>(&v3, &v2), 1);
        let v4 = ValidatorInfo{
            staking_pool_id   : arg2,
            validator_address : v2,
            active_stake      : 0x1::option::none<0x3::staking_pool::FungibleStakedSui>(),
            inactive_stake    : 0x1::option::none<0x3::staking_pool::StakedSui>(),
            exchange_rate     : *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(0x3::sui_system::pool_exchange_rates(arg1, &arg2), 0x2::tx_context::epoch(arg3)),
            total_sui_amount  : 0,
            assigned_weight   : 100,
            extra_fields      : 0x2::bag::new(arg3),
        };
        0x1::vector::push_back<ValidatorInfo>(&mut arg0.validator_infos, v4);
        assert!(0x1::vector::length<ValidatorInfo>(&arg0.validator_infos) <= 50, 2);
        v1
    }

    fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        if (0x3::staking_pool::sui_amount(arg0) == 0 || 0x3::staking_pool::pool_token_amount(arg0) == 0) {
            return arg1
        };
        (((0x3::staking_pool::sui_amount(arg0) as u128) * (arg1 as u128) / (0x3::staking_pool::pool_token_amount(arg0) as u128)) as u64)
    }

    public(friend) fun inactive_stake(arg0: &ValidatorInfo) : &0x1::option::Option<0x3::staking_pool::StakedSui> {
        &arg0.inactive_stake
    }

    public(friend) fun increase_validator_stake<T0>(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = split_up_to_n_sui_from_sui_pool(arg0, arg3);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) < 1000000000) {
            join_to_sui_pool(arg0, v0);
            return 0
        };
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), arg2, arg4);
        let v2 = IncreaseValidatorStakeEvent{
            typename        : 0x1::type_name::get<T0>(),
            staking_pool_id : 0x3::staking_pool::pool_id(&v1),
            amount          : 0x3::staking_pool::staked_sui_amount(&v1),
        };
        0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::events::emit_event<IncreaseValidatorStakeEvent>(v2);
        join_stake(arg0, arg1, v1, arg4);
        0x3::staking_pool::staked_sui_amount(&v1)
    }

    public(friend) fun join_fungible_stake(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x3::staking_pool::FungibleStakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_add_validator_index_by_staking_pool_id_mut(arg0, arg1, 0x3::staking_pool::fungible_staked_sui_pool_id(&arg2), arg3);
        join_fungible_staked_sui_to_validator(arg0, v0, arg2);
    }

    fun join_fungible_staked_sui_to_validator(arg0: &mut Storage, arg1: u64, arg2: 0x3::staking_pool::FungibleStakedSui) {
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1);
        if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            0x3::staking_pool::join_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut v0.active_stake), arg2);
        } else {
            0x1::option::fill<0x3::staking_pool::FungibleStakedSui>(&mut v0.active_stake, arg2);
        };
        refresh_validator_info(arg0, arg1);
    }

    fun join_inactive_stake_to_validator(arg0: &mut Storage, arg1: u64, arg2: 0x3::staking_pool::StakedSui) {
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1);
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            0x3::staking_pool::join_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut v0.inactive_stake), arg2);
        } else {
            0x1::option::fill<0x3::staking_pool::StakedSui>(&mut v0.inactive_stake, arg2);
        };
        refresh_validator_info(arg0, arg1);
    }

    public(friend) fun join_stake(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_add_validator_index_by_staking_pool_id_mut(arg0, arg1, 0x3::staking_pool::pool_id(&arg2), arg3);
        if (0x3::staking_pool::stake_activation_epoch(&arg2) <= 0x2::tx_context::epoch(arg3)) {
            join_fungible_staked_sui_to_validator(arg0, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
        } else {
            join_inactive_stake_to_validator(arg0, v0, arg2);
        };
    }

    public(friend) fun join_to_sui_pool(arg0: &mut Storage, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.total_sui_supply = arg0.total_sui_supply + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, arg1);
    }

    public(friend) fun last_refresh_epoch(arg0: &Storage) : u64 {
        arg0.last_refresh_epoch
    }

    public(friend) fun rebalance<T0>(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.total_weight == 0 || total_sui_supply(arg0) == 0) {
            return
        };
        let v0 = arg0.validator_addresses_and_weights;
        arg0.validator_addresses_and_weights = 0x2::vec_map::empty<address, u64>();
        let v1 = validators(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<ValidatorInfo>(v1)) {
            let v3 = validator_address(0x1::vector::borrow<ValidatorInfo>(v1, v2));
            if (!0x2::vec_map::contains<address, u64>(&v0, &v3)) {
                0x2::vec_map::insert<address, u64>(&mut v0, v3, 0);
            };
            v2 = v2 + 1;
        };
        let (v4, v5) = 0x2::vec_map::into_keys_values<address, u64>(v0);
        let v6 = v5;
        let v7 = v4;
        let v8 = vector[];
        0x1::vector::reverse<u64>(&mut v6);
        while (0x1::vector::length<u64>(&v6) != 0) {
            0x1::vector::push_back<u64>(&mut v8, (((total_sui_supply(arg0) as u128) * (0x1::vector::pop_back<u64>(&mut v6) as u128) / (arg0.total_weight as u128)) as u64));
        };
        0x1::vector::destroy_empty<u64>(v6);
        let v9 = &v7;
        let v10 = vector[];
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(v9)) {
            let v12 = find_validator_index_by_address(arg0, *0x1::vector::borrow<address>(v9, v11));
            let v13 = if (v12 >= 0x1::vector::length<ValidatorInfo>(validators(arg0))) {
                0
            } else {
                total_sui_amount(0x1::vector::borrow<ValidatorInfo>(validators(arg0), v12))
            };
            0x1::vector::push_back<u64>(&mut v10, v13);
            v11 = v11 + 1;
        };
        let v14 = 0;
        while (v14 < 0x1::vector::length<address>(&v7)) {
            if (*0x1::vector::borrow<u64>(&v10, v14) > *0x1::vector::borrow<u64>(&v8, v14)) {
                decrease_validator_stake<T0>(arg0, arg1, *0x1::vector::borrow<address>(&v7, v14), *0x1::vector::borrow<u64>(&v10, v14) - *0x1::vector::borrow<u64>(&v8, v14), arg2);
            };
            v14 = v14 + 1;
        };
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(&v7)) {
            if (*0x1::vector::borrow<u64>(&v10, v15) < *0x1::vector::borrow<u64>(&v8, v15)) {
                increase_validator_stake<T0>(arg0, arg1, *0x1::vector::borrow<address>(&v7, v15), *0x1::vector::borrow<u64>(&v8, v15) - *0x1::vector::borrow<u64>(&v10, v15), arg2);
            };
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos);
        while (v16 > 0) {
            v16 = v16 - 1;
            let v17 = 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v16).validator_address;
            let (v18, v19) = 0x1::vector::index_of<address>(&v7, &v17);
            if (v18 == true) {
                0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v16).assigned_weight = *0x1::vector::borrow<u64>(&v6, v19);
            };
        };
        arg0.last_refresh_epoch = 0x2::tx_context::epoch(arg2);
    }

    public(friend) fun refresh<T0>(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (total_sui_supply(arg0) == 0) {
            return false
        };
        if (arg0.last_refresh_epoch == 0x2::tx_context::epoch(arg2)) {
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
            };
            if (is_empty(0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v2))) {
                let ValidatorInfo {
                    staking_pool_id   : _,
                    validator_address : _,
                    active_stake      : v5,
                    inactive_stake    : v6,
                    exchange_rate     : _,
                    total_sui_amount  : _,
                    assigned_weight   : _,
                    extra_fields      : v10,
                } = 0x1::vector::remove<ValidatorInfo>(&mut arg0.validator_infos, v2);
                0x1::option::destroy_none<0x3::staking_pool::FungibleStakedSui>(v5);
                0x1::option::destroy_none<0x3::staking_pool::StakedSui>(v6);
                0x2::bag::destroy_empty(v10);
            };
        };
        v1 = 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos);
        while (v1 > 0) {
            let v11 = v1 - 1;
            v1 = v11;
            let v12 = get_latest_exchange_rate(arg0, &0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v11).staking_pool_id, arg1, arg2);
            if (0x1::option::is_some<0x3::staking_pool::PoolTokenExchangeRate>(&v12)) {
                0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v11).exchange_rate = *0x1::option::borrow<0x3::staking_pool::PoolTokenExchangeRate>(&v12);
            };
            refresh_validator_info(arg0, v11);
            if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v11).inactive_stake)) {
                let v13 = take_from_inactive_stake(arg0, v11);
                if (0x3::staking_pool::stake_activation_epoch(&v13) <= 0x2::tx_context::epoch(arg2)) {
                    join_fungible_staked_sui_to_validator(arg0, v11, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, v13, arg2));
                    continue
                };
                join_inactive_stake_to_validator(arg0, v11, v13);
            };
        };
        if (!0x2::vec_map::is_empty<address, u64>(&arg0.validator_addresses_and_weights)) {
            rebalance<T0>(arg0, arg1, arg2);
        } else {
            stake_pending_sui<T0>(arg0, arg1, arg2);
        };
        true
    }

    fun refresh_validator_info(arg0: &mut Storage, arg1: u64) {
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

    public(friend) fun set_validator_addresses_and_weights(arg0: &mut Storage, arg1: 0x2::vec_map::VecMap<address, u64>) {
        0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::version::assert_version_and_upgrade(&mut arg0.version, 1);
        arg0.validator_addresses_and_weights = arg1;
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<address, u64>(&arg0.validator_addresses_and_weights);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.validator_addresses_and_weights, v2);
            v0 = v0 + *v4;
            v2 = v2 + 1;
        };
        arg0.total_weight = v0;
    }

    fun split_from_active_stake(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x3::staking_pool::split_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2).active_stake), arg3, arg4);
        refresh_validator_info(arg0, arg2);
        0x3::sui_system::redeem_fungible_staked_sui(arg1, v0, arg4)
    }

    fun split_from_inactive_stake(arg0: &mut Storage, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        let v0 = 0x3::staking_pool::split(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1).inactive_stake), arg2, arg3);
        refresh_validator_info(arg0, arg1);
        v0
    }

    fun split_from_sui_pool(arg0: &mut Storage, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        arg0.total_sui_supply = arg0.total_sui_supply - arg1;
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, arg1)
    }

    public(friend) fun split_n_sui(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)) {
            arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)
        } else {
            0
        };
        let v1 = (arg0.total_weight as u128);
        let v2 = 0x1::vector::length<ValidatorInfo>(validators(arg0));
        while (v2 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) < arg2) {
            v2 = v2 - 1;
            let v3 = ((((0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v2).assigned_weight as u128) * (v0 as u128) + v1 - 1) / v1) as u64);
            unstake_approx_n_sui_from_validator(arg0, arg1, v2, v3, arg3);
        };
        let v4 = arg2;
        if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool)) {
            if (arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) + 10) {
                v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool);
            };
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) >= v4, 0);
        split_from_sui_pool(arg0, v4)
    }

    public(friend) fun split_up_to_n_sui_from_sui_pool(arg0: &mut Storage, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::u64::min(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool), arg1);
        split_from_sui_pool(arg0, v0)
    }

    public(friend) fun stake_pending_sui<T0>(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v0).validator_address;
            let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) / arg0.total_weight * 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v0).assigned_weight;
            increase_validator_stake<T0>(arg0, arg1, v1, v2, arg2);
        };
        arg0.last_refresh_epoch = 0x2::tx_context::epoch(arg2);
        true
    }

    public(friend) fun staking_pool_id(arg0: &ValidatorInfo) : 0x2::object::ID {
        arg0.staking_pool_id
    }

    public(friend) fun sui_pool(arg0: &Storage) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.sui_pool
    }

    fun take_active_stake(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::option::extract<0x3::staking_pool::FungibleStakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2).active_stake);
        refresh_validator_info(arg0, arg2);
        0x3::sui_system::redeem_fungible_staked_sui(arg1, v0, arg3)
    }

    fun take_from_inactive_stake(arg0: &mut Storage, arg1: u64) : 0x3::staking_pool::StakedSui {
        let v0 = 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1).inactive_stake);
        refresh_validator_info(arg0, arg1);
        v0
    }

    public(friend) fun total_sui_amount(arg0: &ValidatorInfo) : u64 {
        arg0.total_sui_amount
    }

    public(friend) fun total_sui_supply(arg0: &Storage) : u64 {
        arg0.total_sui_supply
    }

    public(friend) fun unstake_approx_n_sui_from_active_stake(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2);
        if (0x1::option::is_none<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            return 0
        };
        let v1 = 0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake));
        let v2 = get_sui_amount(&v0.exchange_rate, v1);
        let v3 = if (v2 <= arg3) {
            take_active_stake(arg0, arg1, arg2, arg4)
        } else {
            split_from_active_stake(arg0, arg1, arg2, (((((arg3 as u128) * (v1 as u128) + (v2 as u128) - 1) / (v2 as u128)) as u64) as u64), arg4)
        };
        let v4 = v3;
        join_to_sui_pool(arg0, v4);
        0x2::balance::value<0x2::sui::SUI>(&v4)
    }

    public(friend) fun unstake_approx_n_sui_from_inactive_stake(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg2);
        if (0x1::option::is_none<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            return 0
        };
        let v1 = 0x1::u64::max(arg3, 1000000000);
        let v2 = if (0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) < v1 + 1000000000) {
            take_from_inactive_stake(arg0, arg2)
        } else {
            split_from_inactive_stake(arg0, arg2, v1, arg4)
        };
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v2, arg4);
        join_to_sui_pool(arg0, v3);
        0x2::balance::value<0x2::sui::SUI>(&v3)
    }

    public(friend) fun unstake_approx_n_sui_from_validator(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = unstake_approx_n_sui_from_inactive_stake(arg0, arg1, arg2, arg3, arg4);
        let v1 = v0;
        if (arg3 > v0) {
            v1 = v0 + unstake_approx_n_sui_from_active_stake(arg0, arg1, arg2, arg3 - v0, arg4);
        };
        v1
    }

    public(friend) fun validator_address(arg0: &ValidatorInfo) : address {
        arg0.validator_address
    }

    public(friend) fun validators(arg0: &Storage) : &vector<ValidatorInfo> {
        &arg0.validator_infos
    }

    // decompiled from Move bytecode v6
}

