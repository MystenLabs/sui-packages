module 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage {
    struct Storage has store {
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        validator_infos: vector<ValidatorInfo>,
        total_sui_supply: u64,
        last_refresh_epoch: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct ValidatorInfo has store {
        staking_pool_id: 0x2::object::ID,
        validator_address: address,
        active_stake: 0x1::option::Option<0x3::staking_pool::FungibleStakedSui>,
        inactive_stake: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        exchange_rate: 0x3::staking_pool::PoolTokenExchangeRate,
        total_sui_amount: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Storage {
        Storage{
            sui_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            validator_infos    : 0x1::vector::empty<ValidatorInfo>(),
            total_sui_supply   : 0,
            last_refresh_epoch : 0x2::tx_context::epoch(arg0),
            extra_fields       : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun active_stake(arg0: &ValidatorInfo) : &0x1::option::Option<0x3::staking_pool::FungibleStakedSui> {
        &arg0.active_stake
    }

    public(friend) fun change_validator_priority(arg0: &mut Storage, arg1: u64, arg2: u64) {
        if (arg1 == arg2) {
            return
        };
        0x1::vector::insert<ValidatorInfo>(&mut arg0.validator_infos, 0x1::vector::remove<ValidatorInfo>(&mut arg0.validator_infos, arg1), arg2);
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

    fun is_empty(arg0: &ValidatorInfo) : bool {
        if (0x1::option::is_none<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake)) {
            if (0x1::option::is_none<0x3::staking_pool::StakedSui>(&arg0.inactive_stake)) {
                arg0.total_sui_amount == 0
            } else {
                false
            }
        } else {
            false
        }
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

    public(friend) fun refresh(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (arg0.last_refresh_epoch == 0x2::tx_context::epoch(arg2)) {
            return false
        };
        let v0 = 0x3::sui_system::active_validator_addresses(arg1);
        let v1 = 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos);
        while (v1 > 0) {
            v1 = v1 - 1;
            if (!0x1::vector::contains<address>(&v0, &0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1).validator_address)) {
                unstake_approx_n_sui_from_validator(arg0, arg1, v1, 10000000000000000000, arg2);
            };
            if (is_empty(0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1))) {
                let ValidatorInfo {
                    staking_pool_id   : _,
                    validator_address : _,
                    active_stake      : v4,
                    inactive_stake    : v5,
                    exchange_rate     : _,
                    total_sui_amount  : _,
                    extra_fields      : v8,
                } = 0x1::vector::remove<ValidatorInfo>(&mut arg0.validator_infos, v1);
                0x1::option::destroy_none<0x3::staking_pool::FungibleStakedSui>(v4);
                0x1::option::destroy_none<0x3::staking_pool::StakedSui>(v5);
                0x2::bag::destroy_empty(v8);
                continue
            };
            let v9 = get_latest_exchange_rate(arg0, &0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1).staking_pool_id, arg1, arg2);
            if (0x1::option::is_some<0x3::staking_pool::PoolTokenExchangeRate>(&v9)) {
                0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v1).exchange_rate = *0x1::option::borrow<0x3::staking_pool::PoolTokenExchangeRate>(&v9);
            };
            refresh_validator_info(arg0, v1);
            if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1).inactive_stake)) {
                let v10 = take_from_inactive_stake(arg0, v1);
                join_fungible_staked_sui_to_validator(arg0, v1, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, v10, arg2));
            };
        };
        arg0.last_refresh_epoch = 0x2::tx_context::epoch(arg2);
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
        let v0 = 0x1::vector::length<ValidatorInfo>(validators(arg0));
        while (v0 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) < arg2) {
            v0 = v0 - 1;
            let v1 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool);
            unstake_approx_n_sui_from_inactive_stake(arg0, arg1, v0, v1, arg3);
        };
        let v2 = 0x1::vector::length<ValidatorInfo>(validators(arg0));
        while (v2 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) < arg2) {
            v2 = v2 - 1;
            let v3 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool);
            unstake_approx_n_sui_from_active_stake(arg0, arg1, v2, v3, arg3);
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) >= arg2, 0);
        split_from_sui_pool(arg0, arg2)
    }

    public(friend) fun split_up_to_n_sui_from_sui_pool(arg0: &mut Storage, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::u64::min(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool), arg1);
        split_from_sui_pool(arg0, v0)
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

