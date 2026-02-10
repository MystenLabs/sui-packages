module 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        active_strategy_keys: vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Portfolio {
        Portfolio{
            id                   : 0x2::object::new(arg0),
            active_strategy_keys : 0x1::vector::empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(),
        }
    }

    public fun asset_balance<T0>(arg0: &Portfolio, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg1)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::asset_balance<T0>(0x2::dynamic_field::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&arg0.id, arg1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_asset_key<T0>())
        } else {
            0
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        if (!0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2)) {
            0x2::dynamic_field::add<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::new(arg4));
            0x1::vector::push_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg2);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit<T0>(0x2::dynamic_field::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2), arg3);
    }

    public(friend) fun deposit_object<T0: store + key>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        if (!0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2)) {
            0x2::dynamic_field::add<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::new(arg4));
            0x1::vector::push_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg2);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit_object<T0>(0x2::dynamic_field::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2), arg3);
    }

    public(friend) fun extract_reward_balance<T0>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: u64) : 0x2::balance::Balance<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        assert!(0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::asset_not_found());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::extract_reward_balance<T0>(0x2::dynamic_field::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2), arg3)
    }

    public fun reward_balance<T0>(arg0: &Portfolio, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg1)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::reward_balance<T0>(0x2::dynamic_field::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&arg0.id, arg1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_reward_key<T0>())
        } else {
            0
        }
    }

    public(friend) fun withdraw<T0>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        assert!(0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2);
        if (!0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_any_entries(v0)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::destroy(0x2::dynamic_field::remove<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2));
            remove_strategy_key(arg0, arg2);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw<T0>(v0, arg3, arg4)
    }

    public(friend) fun withdraw_object<T0: store + key>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : T0 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        assert!(0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2);
        if (!0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_any_entries(v0)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::destroy(0x2::dynamic_field::remove<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2));
            remove_strategy_key(arg0, arg2);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw_object<T0>(v0)
    }

    public fun active_strategy_keys(arg0: &Portfolio) : &vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey> {
        &arg0.active_strategy_keys
    }

    public(friend) fun deposit_rewards<T0>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        if (!0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2)) {
            0x2::dynamic_field::add<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::new(arg4));
            0x1::vector::push_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg2);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit_reward_balance<T0>(0x2::dynamic_field::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2), arg3);
    }

    public fun has_assets(arg0: &Portfolio, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg1) && 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_any_assets(0x2::dynamic_field::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&arg0.id, arg1))
    }

    public fun has_object<T0: store + key>(arg0: &Portfolio, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg1) && 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_asset_key(0x2::dynamic_field::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&arg0.id, arg1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_asset_key<T0>())
    }

    public fun has_rewards<T0>(arg0: &Portfolio, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg1) && 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::reward_exists(0x2::dynamic_field::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&arg0.id, arg1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_reward_key<T0>())
    }

    public fun has_strategy(arg0: &Portfolio, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg1)
    }

    fun remove_strategy_key(arg0: &mut Portfolio, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) {
        let (v0, v1) = 0x1::vector::index_of<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.active_strategy_keys, &arg1);
        if (v0) {
            0x1::vector::remove<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v1);
        };
    }

    public(friend) fun withdraw_all_rewards<T0>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        assert!(0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::asset_not_found());
        let v0 = reward_balance<T0>(arg0, arg2);
        assert!(v0 > 0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::asset_not_found());
        withdraw_rewards<T0>(arg0, arg1, arg2, v0, arg3)
    }

    public(friend) fun withdraw_rewards<T0>(arg0: &mut Portfolio, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        assert!(0x2::dynamic_field::exists_<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.id, arg2), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2);
        if (!0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_any_entries(v0)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::destroy(0x2::dynamic_field::remove<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore>(&mut arg0.id, arg2));
            remove_strategy_key(arg0, arg2);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw_reward<T0>(v0, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

