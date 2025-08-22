module 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        active_strategy_keys: vector<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>,
    }

    struct AssetInfo has copy, drop {
        strategy_key: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey,
        is_coin: bool,
        balance: u64,
        exists: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Portfolio {
        Portfolio{
            id                   : 0x2::object::new(arg0),
            active_strategy_keys : 0x1::vector::empty<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(),
        }
    }

    public fun asset_balance<T0>(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::asset_balance<T0>(0x2::dynamic_field::borrow<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::create_asset_key<T0>())
        } else {
            0
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::new(arg3));
            0x1::vector::push_back<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
        0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::deposit<T0>(0x2::dynamic_field::borrow_mut<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1), arg2);
    }

    public(friend) fun deposit_object<T0: store + key>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::new(arg3));
            0x1::vector::push_back<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
        0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::deposit_object<T0>(0x2::dynamic_field::borrow_mut<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1), arg2);
    }

    public(friend) fun extract_reward_balance<T0>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::extract_reward_balance<T0>(0x2::dynamic_field::borrow_mut<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1), arg2)
    }

    public fun reward_balance<T0>(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : u64 {
        if (0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::reward_balance<T0>(0x2::dynamic_field::borrow<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::create_reward_key<T0>())
        } else {
            0
        }
    }

    public(friend) fun withdraw<T0>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1);
        if (!0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::has_any_entries(v0)) {
            0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::destroy(0x2::dynamic_field::remove<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1));
            remove_strategy_key(arg0, arg1);
        };
        0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::withdraw<T0>(v0, arg2, arg3)
    }

    public(friend) fun withdraw_object<T0: store + key>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : T0 {
        assert!(0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1);
        if (!0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::has_any_entries(v0)) {
            0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::destroy(0x2::dynamic_field::remove<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1));
            remove_strategy_key(arg0, arg1);
        };
        0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::withdraw_object<T0>(v0)
    }

    public fun active_strategy_keys(arg0: &Portfolio) : &vector<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey> {
        &arg0.active_strategy_keys
    }

    public(friend) fun deposit_rewards<T0>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::new(arg3));
            0x1::vector::push_back<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&mut arg0.active_strategy_keys, arg1);
        };
        0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::deposit_reward_balance<T0>(0x2::dynamic_field::borrow_mut<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1), arg2);
    }

    public fun get_asset_info<T0>(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : AssetInfo {
        let v0 = 0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1);
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

    public fun get_asset_keys(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : vector<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetKey> {
        if (0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1)) {
            *0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::active_asset_keys(0x2::dynamic_field::borrow<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&arg0.id, arg1))
        } else {
            0x1::vector::empty<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetKey>()
        }
    }

    public fun get_coin_balance<T0>(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : u64 {
        asset_balance<T0>(arg0, arg1)
    }

    public fun has_assets(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1) && 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::has_any_assets(0x2::dynamic_field::borrow<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&arg0.id, arg1))
    }

    public fun has_object<T0: store + key>(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1) && 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::has_asset_key(0x2::dynamic_field::borrow<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::create_asset_key<T0>())
    }

    public fun has_rewards<T0>(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1) && 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::reward_exists(0x2::dynamic_field::borrow<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::create_reward_key<T0>())
    }

    public fun has_strategy(arg0: &Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) : bool {
        0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1)
    }

    fun remove_strategy_key(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey) {
        let (v0, v1) = 0x1::vector::index_of<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.active_strategy_keys, &arg1);
        if (v0) {
            0x1::vector::remove<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v1);
        };
    }

    public(friend) fun withdraw_all_rewards<T0>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        let v0 = reward_balance<T0>(arg0, arg1);
        assert!(v0 > 0, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        withdraw_rewards<T0>(arg0, arg1, v0, arg2)
    }

    public(friend) fun withdraw_rewards<T0>(arg0: &mut Portfolio, arg1: 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::dynamic_field::exists_<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey>(&arg0.id, arg1), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        let v0 = 0x2::dynamic_field::borrow_mut<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1);
        if (!0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::has_any_entries(v0)) {
            0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::destroy(0x2::dynamic_field::remove<0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::strategy::StrategyKey, 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::AssetStore>(&mut arg0.id, arg1));
            remove_strategy_key(arg0, arg1);
        };
        0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store::withdraw_reward<T0>(v0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

