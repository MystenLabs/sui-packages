module 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        active_strategy_keys: vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>,
    }

    struct AssetInfo has copy, drop {
        strategy_key: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey,
        is_coin: bool,
        balance: u64,
        exists: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Portfolio {
        Portfolio{
            id                   : 0x2::object::new(arg0),
            active_strategy_keys : 0x1::vector::empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(),
        }
    }

    public fun asset_balance<T0>(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::asset_balance<T0>(0x2::dynamic_field::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::create_asset_key<T0>())
        } else {
            0
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::new(arg3));
            0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::deposit<T0>(0x2::dynamic_field::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1), arg2);
    }

    public(friend) fun deposit_object<T0: store + key>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::new(arg3));
            0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::deposit_object<T0>(0x2::dynamic_field::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1), arg2);
    }

    public(friend) fun extract_reward_balance<T0>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::asset_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::extract_reward_balance<T0>(0x2::dynamic_field::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1), arg2)
    }

    public fun reward_balance<T0>(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::reward_balance<T0>(0x2::dynamic_field::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::create_reward_key<T0>())
        } else {
            0
        }
    }

    public(friend) fun withdraw<T0>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1);
        if (!0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::has_any_entries(v0)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::destroy(0x2::dynamic_field::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1));
            remove_strategy_key(arg0, arg1);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::withdraw<T0>(v0, arg2, arg3)
    }

    public(friend) fun withdraw_object<T0: store + key>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : T0 {
        assert!(0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1);
        if (!0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::has_any_entries(v0)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::destroy(0x2::dynamic_field::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1));
            remove_strategy_key(arg0, arg1);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::withdraw_object<T0>(v0)
    }

    public fun active_strategy_keys(arg0: &Portfolio) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey> {
        &arg0.active_strategy_keys
    }

    public(friend) fun deposit_rewards<T0>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::new(arg3));
            0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::deposit_reward_balance<T0>(0x2::dynamic_field::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1), arg2);
    }

    public fun get_asset_info<T0>(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : AssetInfo {
        let v0 = 0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1);
        let v1 = if (v0) {
            asset_balance<T0>(arg0, arg1)
        } else {
            0
        };
        AssetInfo{
            strategy_key : arg1,
            is_coin      : true,
            balance      : v1,
            exists       : v0,
        }
    }

    public fun get_asset_keys(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetKey> {
        if (0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1)) {
            *0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::active_asset_keys(0x2::dynamic_field::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&arg0.id, arg1))
        } else {
            0x1::vector::empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetKey>()
        }
    }

    public fun get_coin_balance<T0>(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : u64 {
        asset_balance<T0>(arg0, arg1)
    }

    public fun has_assets(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1) && 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::has_any_assets(0x2::dynamic_field::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&arg0.id, arg1))
    }

    public fun has_object<T0: store + key>(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1) && 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::has_asset_key(0x2::dynamic_field::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::create_asset_key<T0>())
    }

    public fun has_rewards<T0>(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1) && 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::reward_exists(0x2::dynamic_field::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::create_reward_key<T0>())
    }

    public fun has_strategy(arg0: &Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1)
    }

    fun remove_strategy_key(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey) {
        let (v0, v1) = 0x1::vector::index_of<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.active_strategy_keys, &arg1);
        if (v0) {
            0x1::vector::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v1);
        };
    }

    public(friend) fun withdraw_all_rewards<T0>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::asset_not_found());
        let v0 = reward_balance<T0>(arg0, arg1);
        assert!(v0 > 0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::asset_not_found());
        withdraw_rewards<T0>(arg0, arg1, v0, arg2)
    }

    public(friend) fun withdraw_rewards<T0>(arg0: &mut Portfolio, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::dynamic_field::exists_<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.id, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1);
        if (!0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::has_any_entries(v0)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::destroy(0x2::dynamic_field::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetStore>(&mut arg0.id, arg1));
            remove_strategy_key(arg0, arg1);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::withdraw_reward<T0>(v0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

