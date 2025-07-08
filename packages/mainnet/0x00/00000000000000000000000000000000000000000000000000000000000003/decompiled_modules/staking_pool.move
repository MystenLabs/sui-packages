module 0x3::staking_pool {
    struct StakingPool has store, key {
        id: 0x2::object::UID,
        activation_epoch: 0x1::option::Option<u64>,
        deactivation_epoch: 0x1::option::Option<u64>,
        sui_balance: u64,
        rewards_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_token_balance: u64,
        exchange_rates: 0x2::table::Table<u64, PoolTokenExchangeRate>,
        pending_stake: u64,
        pending_total_sui_withdraw: u64,
        pending_pool_token_withdraw: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct PoolTokenExchangeRate has copy, drop, store {
        sui_amount: u64,
        pool_token_amount: u64,
    }

    struct StakedSui has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        stake_activation_epoch: u64,
        principal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct FungibleStakedSui has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        value: u64,
    }

    struct FungibleStakedSuiData has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        principal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct FungibleStakedSuiDataKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : StakingPool {
        StakingPool{
            id                          : 0x2::object::new(arg0),
            activation_epoch            : 0x1::option::none<u64>(),
            deactivation_epoch          : 0x1::option::none<u64>(),
            sui_balance                 : 0,
            rewards_pool                : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_token_balance          : 0,
            exchange_rates              : 0x2::table::new<u64, PoolTokenExchangeRate>(arg0),
            pending_stake               : 0,
            pending_total_sui_withdraw  : 0,
            pending_pool_token_withdraw : 0,
            extra_fields                : 0x2::bag::new(arg0),
        }
    }

    public fun split(arg0: &mut StakedSui, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : StakedSui {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.principal);
        assert!(arg1 <= v0, 3);
        assert!(v0 - arg1 >= 1000000000, 18);
        assert!(arg1 >= 1000000000, 18);
        StakedSui{
            id                     : 0x2::object::new(arg2),
            pool_id                : arg0.pool_id,
            stake_activation_epoch : arg0.stake_activation_epoch,
            principal              : 0x2::balance::split<0x2::sui::SUI>(&mut arg0.principal, arg1),
        }
    }

    public(friend) fun activate_staking_pool(arg0: &mut StakingPool, arg1: u64) {
        0x2::table::add<u64, PoolTokenExchangeRate>(&mut arg0.exchange_rates, arg1, initial_exchange_rate());
        assert!(is_preactive(arg0), 14);
        assert!(!is_inactive(arg0), 16);
        0x1::option::fill<u64>(&mut arg0.activation_epoch, arg1);
    }

    public(friend) fun activation_epoch(arg0: &StakingPool) : 0x1::option::Option<u64> {
        arg0.activation_epoch
    }

    fun calculate_fungible_staked_sui_withdraw_amount(arg0: PoolTokenExchangeRate, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = get_sui_amount(&arg0, arg3);
        let v1 = 0x1::u64::min(arg2, v0);
        let v2 = (((arg1 as u128) * (v1 as u128) / (arg3 as u128)) as u64);
        let v3 = (((arg1 as u128) * ((v0 - v1) as u128) / (arg3 as u128)) as u64);
        assert!(v2 + v3 <= get_sui_amount(&arg0, arg1), 20);
        (v2, v3)
    }

    fun check_balance_invariants(arg0: &StakingPool, arg1: u64) {
        let v0 = pool_token_exchange_rate_at_epoch(arg0, arg1);
        assert!(get_token_amount(&v0, arg0.sui_balance) == arg0.pool_token_balance, 9);
    }

    public(friend) fun convert_to_fungible_staked_sui(arg0: &mut StakingPool, arg1: StakedSui, arg2: &mut 0x2::tx_context::TxContext) : FungibleStakedSui {
        let StakedSui {
            id                     : v0,
            pool_id                : v1,
            stake_activation_epoch : v2,
            principal              : v3,
        } = arg1;
        let v4 = v3;
        assert!(v1 == 0x2::object::id<StakingPool>(arg0), 1);
        assert!(0x2::tx_context::epoch(arg2) >= v2, 19);
        assert!(!is_preactive(arg0) && !is_inactive(arg0), 15);
        0x2::object::delete(v0);
        let v5 = pool_token_exchange_rate_at_epoch(arg0, v2);
        let v6 = get_token_amount(&v5, 0x2::balance::value<0x2::sui::SUI>(&v4));
        let v7 = FungibleStakedSuiDataKey{dummy_field: false};
        if (!0x2::bag::contains<FungibleStakedSuiDataKey>(&arg0.extra_fields, v7)) {
            let v8 = FungibleStakedSuiData{
                id           : 0x2::object::new(arg2),
                total_supply : v6,
                principal    : v4,
            };
            0x2::bag::add<FungibleStakedSuiDataKey, FungibleStakedSuiData>(&mut arg0.extra_fields, v7, v8);
        } else {
            let v9 = 0x2::bag::borrow_mut<FungibleStakedSuiDataKey, FungibleStakedSuiData>(&mut arg0.extra_fields, v7);
            v9.total_supply = v9.total_supply + v6;
            0x2::balance::join<0x2::sui::SUI>(&mut v9.principal, v4);
        };
        FungibleStakedSui{
            id      : 0x2::object::new(arg2),
            pool_id : v1,
            value   : v6,
        }
    }

    public(friend) fun deactivate_staking_pool(arg0: &mut StakingPool, arg1: u64) {
        assert!(!is_inactive(arg0), 11);
        arg0.deactivation_epoch = 0x1::option::some<u64>(arg1);
    }

    public(friend) fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.sui_balance = arg0.sui_balance + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.rewards_pool, arg1);
    }

    public(friend) fun exchange_rates(arg0: &StakingPool) : &0x2::table::Table<u64, PoolTokenExchangeRate> {
        &arg0.exchange_rates
    }

    public fun fungible_staked_sui_pool_id(arg0: &FungibleStakedSui) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun fungible_staked_sui_value(arg0: &FungibleStakedSui) : u64 {
        arg0.value
    }

    fun get_sui_amount(arg0: &PoolTokenExchangeRate, arg1: u64) : u64 {
        if (arg0.sui_amount == 0 || arg0.pool_token_amount == 0) {
            return arg1
        };
        (((arg0.sui_amount as u128) * (arg1 as u128) / (arg0.pool_token_amount as u128)) as u64)
    }

    fun get_token_amount(arg0: &PoolTokenExchangeRate, arg1: u64) : u64 {
        if (arg0.sui_amount == 0 || arg0.pool_token_amount == 0) {
            return arg1
        };
        (((arg0.pool_token_amount as u128) * (arg1 as u128) / (arg0.sui_amount as u128)) as u64)
    }

    fun initial_exchange_rate() : PoolTokenExchangeRate {
        PoolTokenExchangeRate{
            sui_amount        : 0,
            pool_token_amount : 0,
        }
    }

    public fun is_equal_staking_metadata(arg0: &StakedSui, arg1: &StakedSui) : bool {
        arg0.pool_id == arg1.pool_id && arg0.stake_activation_epoch == arg1.stake_activation_epoch
    }

    public fun is_inactive(arg0: &StakingPool) : bool {
        0x1::option::is_some<u64>(&arg0.deactivation_epoch)
    }

    public fun is_preactive(arg0: &StakingPool) : bool {
        0x1::option::is_none<u64>(&arg0.activation_epoch)
    }

    fun is_preactive_at_epoch(arg0: &StakingPool, arg1: u64) : bool {
        is_preactive(arg0) || *0x1::option::borrow<u64>(&arg0.activation_epoch) > arg1
    }

    public fun join_fungible_staked_sui(arg0: &mut FungibleStakedSui, arg1: FungibleStakedSui) {
        let FungibleStakedSui {
            id      : v0,
            pool_id : v1,
            value   : v2,
        } = arg1;
        assert!(arg0.pool_id == v1, 1);
        0x2::object::delete(v0);
        arg0.value = arg0.value + v2;
    }

    public entry fun join_staked_sui(arg0: &mut StakedSui, arg1: StakedSui) {
        assert!(is_equal_staking_metadata(arg0, &arg1), 12);
        let StakedSui {
            id                     : v0,
            pool_id                : _,
            stake_activation_epoch : _,
            principal              : v3,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.principal, v3);
    }

    public fun pending_stake_amount(arg0: &StakingPool) : u64 {
        arg0.pending_stake
    }

    public fun pending_stake_withdraw_amount(arg0: &StakingPool) : u64 {
        arg0.pending_total_sui_withdraw
    }

    public fun pool_id(arg0: &StakedSui) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_token_amount(arg0: &PoolTokenExchangeRate) : u64 {
        arg0.pool_token_amount
    }

    public fun pool_token_exchange_rate_at_epoch(arg0: &StakingPool, arg1: u64) : PoolTokenExchangeRate {
        if (is_preactive_at_epoch(arg0, arg1)) {
            return initial_exchange_rate()
        };
        let v0 = 0x1::u64::min(0x1::option::get_with_default<u64>(&arg0.deactivation_epoch, arg1), arg1);
        while (v0 >= *0x1::option::borrow<u64>(&arg0.activation_epoch)) {
            if (0x2::table::contains<u64, PoolTokenExchangeRate>(&arg0.exchange_rates, v0)) {
                return *0x2::table::borrow<u64, PoolTokenExchangeRate>(&arg0.exchange_rates, v0)
            };
            v0 = v0 - 1;
        };
        initial_exchange_rate()
    }

    public(friend) fun process_pending_stake(arg0: &mut StakingPool) {
        let v0 = PoolTokenExchangeRate{
            sui_amount        : arg0.sui_balance,
            pool_token_amount : arg0.pool_token_balance,
        };
        arg0.sui_balance = arg0.sui_balance + arg0.pending_stake;
        arg0.pool_token_balance = get_token_amount(&v0, arg0.sui_balance);
        arg0.pending_stake = 0;
    }

    fun process_pending_stake_withdraw(arg0: &mut StakingPool) {
        arg0.sui_balance = arg0.sui_balance - arg0.pending_total_sui_withdraw;
        arg0.pool_token_balance = arg0.pool_token_balance - arg0.pending_pool_token_withdraw;
        arg0.pending_total_sui_withdraw = 0;
        arg0.pending_pool_token_withdraw = 0;
    }

    public(friend) fun process_pending_stakes_and_withdraws(arg0: &mut StakingPool, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg1) + 1;
        process_pending_stake_withdraw(arg0);
        process_pending_stake(arg0);
        let v1 = PoolTokenExchangeRate{
            sui_amount        : arg0.sui_balance,
            pool_token_amount : arg0.pool_token_balance,
        };
        0x2::table::add<u64, PoolTokenExchangeRate>(&mut arg0.exchange_rates, v0, v1);
        check_balance_invariants(arg0, v0);
    }

    public(friend) fun redeem_fungible_staked_sui(arg0: &mut StakingPool, arg1: FungibleStakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let FungibleStakedSui {
            id      : v0,
            pool_id : v1,
            value   : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<StakingPool>(arg0), 1);
        0x2::object::delete(v0);
        let v3 = FungibleStakedSuiDataKey{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<FungibleStakedSuiDataKey, FungibleStakedSuiData>(&mut arg0.extra_fields, v3);
        let (v5, v6) = calculate_fungible_staked_sui_withdraw_amount(pool_token_exchange_rate_at_epoch(arg0, 0x2::tx_context::epoch(arg2)), v2, 0x2::balance::value<0x2::sui::SUI>(&v4.principal), v4.total_supply);
        v4.total_supply = v4.total_supply - v2;
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut v4.principal, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.rewards_pool, v6));
        arg0.pending_total_sui_withdraw = arg0.pending_total_sui_withdraw + 0x2::balance::value<0x2::sui::SUI>(&v7);
        arg0.pending_pool_token_withdraw = arg0.pending_pool_token_withdraw + v2;
        v7
    }

    public(friend) fun request_add_stake(arg0: &mut StakingPool, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : StakedSui {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        assert!(!is_inactive(arg0), 10);
        assert!(v0 > 0, 17);
        arg0.pending_stake = arg0.pending_stake + v0;
        StakedSui{
            id                     : 0x2::object::new(arg3),
            pool_id                : 0x2::object::id<StakingPool>(arg0),
            stake_activation_epoch : arg2,
            principal              : arg1,
        }
    }

    public(friend) fun request_withdraw_stake(arg0: &mut StakingPool, arg1: StakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (arg1.stake_activation_epoch > 0x2::tx_context::epoch(arg2) && !is_preactive(arg0)) {
            let v0 = unwrap_staked_sui(arg1);
            arg0.pending_stake = arg0.pending_stake - 0x2::balance::value<0x2::sui::SUI>(&v0);
            return v0
        };
        let (v1, v2) = withdraw_from_principal(arg0, arg1);
        let v3 = v2;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = withdraw_rewards(arg0, v4, v1, 0x2::tx_context::epoch(arg2));
        arg0.pending_total_sui_withdraw = arg0.pending_total_sui_withdraw + v4 + 0x2::balance::value<0x2::sui::SUI>(&v5);
        arg0.pending_pool_token_withdraw = arg0.pending_pool_token_withdraw + v1;
        if (is_inactive(arg0) || is_preactive(arg0)) {
            process_pending_stake_withdraw(arg0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v3, v5);
        v3
    }

    public fun split_fungible_staked_sui(arg0: &mut FungibleStakedSui, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FungibleStakedSui {
        assert!(arg1 <= arg0.value, 0);
        arg0.value = arg0.value - arg1;
        FungibleStakedSui{
            id      : 0x2::object::new(arg2),
            pool_id : arg0.pool_id,
            value   : arg1,
        }
    }

    public entry fun split_staked_sui(arg0: &mut StakedSui, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = split(arg0, arg1, arg2);
        0x2::transfer::transfer<StakedSui>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun stake_activation_epoch(arg0: &StakedSui) : u64 {
        arg0.stake_activation_epoch
    }

    public fun staked_sui_amount(arg0: &StakedSui) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.principal)
    }

    public fun sui_amount(arg0: &PoolTokenExchangeRate) : u64 {
        arg0.sui_amount
    }

    public fun sui_balance(arg0: &StakingPool) : u64 {
        arg0.sui_balance
    }

    fun unwrap_staked_sui(arg0: StakedSui) : 0x2::balance::Balance<0x2::sui::SUI> {
        let StakedSui {
            id                     : v0,
            pool_id                : _,
            stake_activation_epoch : _,
            principal              : v3,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    public(friend) fun withdraw_from_principal(arg0: &StakingPool, arg1: StakedSui) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool>(arg0), 1);
        let v0 = pool_token_exchange_rate_at_epoch(arg0, arg1.stake_activation_epoch);
        let v1 = unwrap_staked_sui(arg1);
        (get_token_amount(&v0, 0x2::balance::value<0x2::sui::SUI>(&v1)), v1)
    }

    fun withdraw_rewards(arg0: &mut StakingPool, arg1: u64, arg2: u64, arg3: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = pool_token_exchange_rate_at_epoch(arg0, arg3);
        let v1 = get_sui_amount(&v0, arg2);
        let v2 = if (v1 >= arg1) {
            v1 - arg1
        } else {
            0
        };
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.rewards_pool, 0x1::u64::min(v2, 0x2::balance::value<0x2::sui::SUI>(&arg0.rewards_pool)))
    }

    // decompiled from Move bytecode v6
}

