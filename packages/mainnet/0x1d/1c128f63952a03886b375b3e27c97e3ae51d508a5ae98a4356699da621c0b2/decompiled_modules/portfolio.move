module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio {
    struct RewardKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Rewards has store {
        id: 0x2::object::UID,
        active_reward_types: vector<0x1::type_name::TypeName>,
    }

    struct Portfolio has store, key {
        id: 0x2::object::UID,
        active_strategy_keys: vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>,
        rewards: Rewards,
    }

    struct AssetInfo has copy, drop {
        strategy_key: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey,
        is_coin: bool,
        balance: u64,
        exists: bool,
    }

    public fun balance<T0>(arg0: &Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&arg0.id, arg1))
        } else {
            0
        }
    }

    public(friend) fun join<T0>(arg0: &mut Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: 0x2::balance::Balance<T0>) {
        if (0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1), arg2);
        } else {
            0x2::dynamic_field::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1, arg2);
            0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
    }

    public(friend) fun split<T0>(arg0: &mut Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_strategy_exists(arg0, arg1);
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1), arg2)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Portfolio {
        let v0 = Rewards{
            id                  : 0x2::object::new(arg0),
            active_reward_types : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        Portfolio{
            id                   : 0x2::object::new(arg0),
            active_strategy_keys : 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(),
            rewards              : v0,
        }
    }

    public fun active_reward_types(arg0: &Portfolio) : &vector<0x1::type_name::TypeName> {
        &arg0.rewards.active_reward_types
    }

    public fun active_strategy_keys(arg0: &Portfolio) : &vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey> {
        &arg0.active_strategy_keys
    }

    fun assert_rewards_exist<T0>(arg0: &Portfolio) {
        let v0 = RewardKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<RewardKey<T0>>(&arg0.rewards.id, v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::asset_not_found());
    }

    fun assert_strategy_exists(arg0: &Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) {
        assert!(0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::asset_not_found());
    }

    fun assert_strategy_not_exists(arg0: &Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) {
        assert!(!0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::asset_already_exists());
    }

    public(friend) fun deposit<T0>(arg0: &mut Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: 0x2::coin::Coin<T0>) {
        if (0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1, 0x2::coin::into_balance<T0>(arg2));
            0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
    }

    public(friend) fun deposit_object<T0: store + key>(arg0: &mut Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: T0) {
        assert_strategy_not_exists(arg0, arg1);
        0x2::dynamic_field::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, T0>(&mut arg0.id, arg1, arg2);
        0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
    }

    public(friend) fun deposit_rewards<T0>(arg0: &mut Portfolio, arg1: 0x2::balance::Balance<T0>) {
        let v0 = RewardKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<RewardKey<T0>>(&arg0.rewards.id, v0)) {
            let v1 = RewardKey<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<RewardKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.rewards.id, v1), arg1);
        } else {
            let v2 = RewardKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<RewardKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.rewards.id, v2, arg1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.rewards.active_reward_types, 0x1::type_name::get<RewardKey<T0>>());
        };
    }

    public(friend) fun extract_reward_balance<T0>(arg0: &mut Portfolio, arg1: u64) : 0x2::balance::Balance<T0> {
        assert_rewards_exist<T0>(arg0);
        let v0 = RewardKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<RewardKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.rewards.id, v0), arg1)
    }

    public fun get_asset_info(arg0: &Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : AssetInfo {
        if (!0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1)) {
            return AssetInfo{
                strategy_key : arg1,
                is_coin      : false,
                balance      : 0,
                exists       : false,
            }
        };
        AssetInfo{
            strategy_key : arg1,
            is_coin      : false,
            balance      : 0,
            exists       : true,
        }
    }

    public fun get_coin_balance<T0>(arg0: &Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&arg0.id, arg1))
        } else {
            0
        }
    }

    public fun has_any_rewards(arg0: &Portfolio) : bool {
        !0x1::vector::is_empty<0x1::type_name::TypeName>(&arg0.rewards.active_reward_types)
    }

    public fun has_rewards<T0>(arg0: &Portfolio) : bool {
        let v0 = RewardKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<RewardKey<T0>>(&arg0.rewards.id, v0)
    }

    public fun has_strategy(arg0: &Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1)
    }

    public fun is_coin_balance<T0>(arg0: &Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : bool {
        if (!0x2::dynamic_field::exists_<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.id, arg1)) {
            return false
        };
        true
    }

    fun remove_reward_type<T0>(arg0: &mut Portfolio) {
        let v0 = 0x1::type_name::get<RewardKey<T0>>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.rewards.active_reward_types, &v0);
        if (v1) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.rewards.active_reward_types, v2);
        };
    }

    fun remove_strategy_key(arg0: &mut Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) {
        let (v0, v1) = 0x1::vector::index_of<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategy_keys, &arg1);
        if (v0) {
            0x1::vector::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v1);
        };
    }

    public fun reward_balance<T0>(arg0: &Portfolio) : u64 {
        let v0 = RewardKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<RewardKey<T0>>(&arg0.rewards.id, v0)) {
            let v2 = RewardKey<T0>{dummy_field: false};
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<RewardKey<T0>, 0x2::balance::Balance<T0>>(&arg0.rewards.id, v2))
        } else {
            0
        }
    }

    public(friend) fun withdraw<T0>(arg0: &mut Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_strategy_exists(arg0, arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1);
        if (0x2::balance::value<T0>(v0) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1));
            remove_strategy_key(arg0, arg1);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3)
    }

    public(friend) fun withdraw_all_rewards<T0>(arg0: &mut Portfolio, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_rewards_exist<T0>(arg0);
        let v0 = RewardKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove<RewardKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.rewards.id, v0);
        remove_reward_type<T0>(arg0);
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    public(friend) fun withdraw_object<T0: store + key>(arg0: &mut Portfolio, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : T0 {
        assert_strategy_exists(arg0, arg1);
        remove_strategy_key(arg0, arg1);
        0x2::dynamic_field::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, T0>(&mut arg0.id, arg1)
    }

    public(friend) fun withdraw_rewards<T0>(arg0: &mut Portfolio, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_rewards_exist<T0>(arg0);
        let v0 = RewardKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<RewardKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.rewards.id, v0);
        if (0x2::balance::value<T0>(v1) == 0) {
            let v2 = RewardKey<T0>{dummy_field: false};
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<RewardKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.rewards.id, v2));
            remove_reward_type<T0>(arg0);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

