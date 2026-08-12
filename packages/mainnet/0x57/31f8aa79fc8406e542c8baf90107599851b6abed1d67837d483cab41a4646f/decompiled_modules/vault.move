module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault {
    struct WindDownStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FinalAssetsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WindDownRewardKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct WindDownState has store {
        lifecycle: u8,
    }

    struct Vault<phantom T0, phantom T1, phantom T2, T3: store> has store, key {
        id: 0x2::object::UID,
        config: 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::Config<T0, T1, T2>,
        protocol_config: T3,
        extra_info: 0x2::bag::Bag,
    }

    public(friend) fun new<T0, T1, T2, T3: store>(arg0: 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::Config<T0, T1, T2>, arg1: T3, arg2: &mut 0x2::tx_context::TxContext) : Vault<T0, T1, T2, T3> {
        Vault<T0, T1, T2, T3>{
            id              : 0x2::object::new(arg2),
            config          : arg0,
            protocol_config : arg1,
            extra_info      : 0x2::bag::new(arg2),
        }
    }

    public(friend) fun config<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) : &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::Config<T0, T1, T2> {
        &arg0.config
    }

    public(friend) fun assert_active<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) {
        assert!(lifecycle<T0, T1, T2, T3>(arg0) == 0, 100);
    }

    public(friend) fun assert_finalized<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) {
        assert!(lifecycle<T0, T1, T2, T3>(arg0) == 2, 102);
    }

    public(friend) fun assert_reward_collection_state<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) {
        let v0 = lifecycle<T0, T1, T2, T3>(arg0);
        assert!(v0 == 1 || v0 == 2, 104);
    }

    public(friend) fun assert_unwinding<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) {
        assert!(lifecycle<T0, T1, T2, T3>(arg0) == 1, 101);
    }

    public(friend) fun begin_wind_down<T0: store, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>) {
        assert_active<T0, T1, T2, T3>(arg0);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::set_deposits_enabled<T0, T1, T2>(&mut arg0.config, false);
        let v0 = WindDownStateKey{dummy_field: false};
        let v1 = WindDownState{lifecycle: 1};
        0x2::dynamic_field::add<WindDownStateKey, WindDownState>(&mut arg0.id, v0, v1);
        let v2 = FinalAssetsKey{dummy_field: false};
        0x2::dynamic_field::add<FinalAssetsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::balance::zero<T0>());
    }

    public(friend) fun config_mut<T0, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::Config<T0, T1, T2> {
        &mut arg0.config
    }

    public fun final_assets<T0: store, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        let v0 = FinalAssetsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FinalAssetsKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = FinalAssetsKey{dummy_field: false};
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<FinalAssetsKey, 0x2::balance::Balance<T0>>(&arg0.id, v1))
    }

    public(friend) fun finalize_wind_down<T0: store, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>) {
        assert_unwinding<T0, T1, T2, T3>(arg0);
        let v0 = FinalAssetsKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FinalAssetsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::take_all_fees<T0, T1, T2>(&mut arg0.config));
        let v1 = WindDownStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<WindDownStateKey, WindDownState>(&mut arg0.id, v1).lifecycle = 2;
    }

    public(friend) fun join_final_assets<T0: store, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T0>) {
        assert_unwinding<T0, T1, T2, T3>(arg0);
        let v0 = FinalAssetsKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FinalAssetsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
    }

    public(friend) fun join_settled_reward<T0: store, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T0>) {
        assert_finalized<T0, T1, T2, T3>(arg0);
        let v0 = FinalAssetsKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FinalAssetsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
    }

    public fun lifecycle<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) : u8 {
        let v0 = WindDownStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<WindDownStateKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = WindDownStateKey{dummy_field: false};
        0x2::dynamic_field::borrow<WindDownStateKey, WindDownState>(&arg0.id, v1).lifecycle
    }

    fun proportional_share(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == arg2) {
            arg0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    public(friend) fun protocol_config<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) : &T3 {
        &arg0.protocol_config
    }

    public(friend) fun protocol_config_mut<T0, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut T3 {
        &mut arg0.protocol_config
    }

    public(friend) fun store_wind_down_reward<T0, T1, T2, T3: store, T4: store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T4>) {
        assert_reward_collection_state<T0, T1, T2, T3>(arg0);
        assert!(0x2::balance::value<T4>(&arg1) > 0, 105);
        let v0 = WindDownRewardKey<T4>{dummy_field: false};
        if (0x2::dynamic_field::exists_<WindDownRewardKey<T4>>(&arg0.id, v0)) {
            0x2::balance::join<T4>(0x2::dynamic_field::borrow_mut<WindDownRewardKey<T4>, 0x2::balance::Balance<T4>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<WindDownRewardKey<T4>, 0x2::balance::Balance<T4>>(&mut arg0.id, v0, arg1);
        };
    }

    public fun stored_wind_down_reward<T0, T1, T2, T3: store, T4: store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        let v0 = WindDownRewardKey<T4>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<WindDownRewardKey<T4>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T4>(0x2::dynamic_field::borrow<WindDownRewardKey<T4>, 0x2::balance::Balance<T4>>(&arg0.id, v0))
    }

    public(friend) fun take_finalized_share<T0: store, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::coin::Coin<T2>, arg2: u64) : (0x2::balance::Balance<T0>, u64) {
        assert_finalized<T0, T1, T2, T3>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::total_vt_supply<T0, T1, T2>(&arg0.config);
        assert!(v0 > 0 && v0 <= v1, 103);
        let v2 = proportional_share(final_assets<T0, T1, T2, T3>(arg0), v0, v1);
        assert!(v2 >= arg2, 103);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::burn_vt<T0, T1, T2>(&mut arg0.config, arg1);
        let v3 = FinalAssetsKey{dummy_field: false};
        (0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<FinalAssetsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v3), v2), v0)
    }

    public(friend) fun take_wind_down_reward<T0, T1, T2, T3: store, T4: store>(arg0: &mut Vault<T0, T1, T2, T3>) : 0x2::balance::Balance<T4> {
        assert_finalized<T0, T1, T2, T3>(arg0);
        let v0 = WindDownRewardKey<T4>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<WindDownRewardKey<T4>>(&arg0.id, v0), 106);
        0x2::dynamic_field::remove<WindDownRewardKey<T4>, 0x2::balance::Balance<T4>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v7
}

