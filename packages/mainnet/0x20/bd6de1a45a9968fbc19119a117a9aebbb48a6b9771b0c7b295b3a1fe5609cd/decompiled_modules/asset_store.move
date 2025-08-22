module 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::asset_store {
    struct AssetKey has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
    }

    struct RewardKey has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
    }

    struct AssetStore has store, key {
        id: 0x2::object::UID,
        active_asset_keys: vector<AssetKey>,
        active_reward_keys: vector<RewardKey>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AssetStore {
        AssetStore{
            id                 : 0x2::object::new(arg0),
            active_asset_keys  : 0x1::vector::empty<AssetKey>(),
            active_reward_keys : 0x1::vector::empty<RewardKey>(),
        }
    }

    public(friend) fun active_asset_keys(arg0: &AssetStore) : &vector<AssetKey> {
        &arg0.active_asset_keys
    }

    public(friend) fun active_reward_keys(arg0: &AssetStore) : &vector<RewardKey> {
        &arg0.active_reward_keys
    }

    public(friend) fun asset_balance<T0>(arg0: &AssetStore, arg1: AssetKey) : u64 {
        if (0x2::dynamic_field::exists_<AssetKey>(&arg0.id, arg1)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<AssetKey, 0x2::balance::Balance<T0>>(&arg0.id, arg1))
        } else {
            0
        }
    }

    public(friend) fun asset_type(arg0: &AssetKey) : &0x1::type_name::TypeName {
        &arg0.asset_type
    }

    public(friend) fun create_asset_key<T0>() : AssetKey {
        AssetKey{asset_type: 0x1::type_name::get<T0>()}
    }

    public(friend) fun create_reward_key<T0>() : RewardKey {
        RewardKey{reward_type: 0x1::type_name::get<T0>()}
    }

    public(friend) fun deposit<T0>(arg0: &mut AssetStore, arg1: 0x2::coin::Coin<T0>) {
        let v0 = create_asset_key<T0>();
        if (0x2::dynamic_field::exists_<AssetKey>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<AssetKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<AssetKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
            0x1::vector::push_back<AssetKey>(&mut arg0.active_asset_keys, v0);
        };
    }

    public(friend) fun deposit_object<T0: store + key>(arg0: &mut AssetStore, arg1: T0) {
        let v0 = create_asset_key<T0>();
        assert!(!0x2::dynamic_field::exists_<AssetKey>(&arg0.id, v0), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_already_exists());
        0x2::dynamic_field::add<AssetKey, T0>(&mut arg0.id, v0, arg1);
        0x1::vector::push_back<AssetKey>(&mut arg0.active_asset_keys, v0);
    }

    public(friend) fun deposit_reward_balance<T0>(arg0: &mut AssetStore, arg1: 0x2::balance::Balance<T0>) {
        let v0 = create_reward_key<T0>();
        if (0x2::dynamic_field::exists_<RewardKey>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<RewardKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<RewardKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
            0x1::vector::push_back<RewardKey>(&mut arg0.active_reward_keys, v0);
        };
    }

    public(friend) fun destroy(arg0: AssetStore) {
        let AssetStore {
            id                 : v0,
            active_asset_keys  : v1,
            active_reward_keys : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        while (!0x1::vector::is_empty<AssetKey>(&v4)) {
            0x1::vector::pop_back<AssetKey>(&mut v4);
        };
        0x1::vector::destroy_empty<AssetKey>(v4);
        while (!0x1::vector::is_empty<RewardKey>(&v3)) {
            0x1::vector::pop_back<RewardKey>(&mut v3);
        };
        0x1::vector::destroy_empty<RewardKey>(v3);
        0x2::object::delete(v0);
    }

    public(friend) fun extract_reward_balance<T0>(arg0: &mut AssetStore, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = create_reward_key<T0>();
        assert!(0x2::dynamic_field::exists_<RewardKey>(&arg0.id, v0), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<RewardKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1)
    }

    public(friend) fun has_any_assets(arg0: &AssetStore) : bool {
        !0x1::vector::is_empty<AssetKey>(&arg0.active_asset_keys)
    }

    public(friend) fun has_any_entries(arg0: &AssetStore) : bool {
        has_any_assets(arg0) || has_any_rewards(arg0)
    }

    public(friend) fun has_any_rewards(arg0: &AssetStore) : bool {
        !0x1::vector::is_empty<RewardKey>(&arg0.active_reward_keys)
    }

    public(friend) fun has_asset_key(arg0: &AssetStore, arg1: AssetKey) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AssetKey>(&arg0.active_asset_keys)) {
            if (*0x1::vector::borrow<AssetKey>(&arg0.active_asset_keys, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun matches_asset_type<T0>(arg0: &AssetKey) : bool {
        arg0.asset_type == 0x1::type_name::get<T0>()
    }

    fun remove_asset_key(arg0: &mut AssetStore, arg1: AssetKey) {
        let (v0, v1) = 0x1::vector::index_of<AssetKey>(&arg0.active_asset_keys, &arg1);
        if (v0) {
            0x1::vector::remove<AssetKey>(&mut arg0.active_asset_keys, v1);
        };
    }

    fun remove_reward_key(arg0: &mut AssetStore, arg1: RewardKey) {
        let (v0, v1) = 0x1::vector::index_of<RewardKey>(&arg0.active_reward_keys, &arg1);
        if (v0) {
            0x1::vector::remove<RewardKey>(&mut arg0.active_reward_keys, v1);
        };
    }

    public(friend) fun reward_balance<T0>(arg0: &AssetStore, arg1: RewardKey) : u64 {
        if (0x2::dynamic_field::exists_<RewardKey>(&arg0.id, arg1)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<RewardKey, 0x2::balance::Balance<T0>>(&arg0.id, arg1))
        } else {
            0
        }
    }

    public(friend) fun reward_exists(arg0: &AssetStore, arg1: RewardKey) : bool {
        0x2::dynamic_field::exists_<RewardKey>(&arg0.id, arg1)
    }

    public(friend) fun withdraw<T0>(arg0: &mut AssetStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = create_asset_key<T0>();
        assert!(0x2::dynamic_field::exists_<AssetKey>(&arg0.id, v0), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        let v1 = 0x2::dynamic_field::borrow_mut<AssetKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<AssetKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0));
            remove_asset_key(arg0, v0);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    public(friend) fun withdraw_object<T0: store + key>(arg0: &mut AssetStore) : T0 {
        let v0 = create_asset_key<T0>();
        assert!(0x2::dynamic_field::exists_<AssetKey>(&arg0.id, v0), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        remove_asset_key(arg0, v0);
        0x2::dynamic_field::remove<AssetKey, T0>(&mut arg0.id, v0)
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut AssetStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = create_reward_key<T0>();
        assert!(0x2::dynamic_field::exists_<RewardKey>(&arg0.id, v0), 0x20bd6de1a45a9968fbc19119a117a9aebbb48a6b9771b0c7b295b3a1fe5609cd::errors::asset_not_found());
        let v1 = 0x2::dynamic_field::borrow_mut<RewardKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<RewardKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0));
            remove_reward_key(arg0, v0);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

