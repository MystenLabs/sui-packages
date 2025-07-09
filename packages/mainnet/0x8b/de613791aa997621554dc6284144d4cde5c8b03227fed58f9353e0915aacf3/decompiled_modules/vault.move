module 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::vault {
    struct RewardKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        funds: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        creator: address,
        created_at_timestamp_ms: u64,
        active_assistant: 0x2::object::ID,
    }

    public fun burn<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = v0 * 0x2::coin::total_supply<T1>(&arg0.treasury_cap) / 0x2::balance::value<T0>(&arg0.funds);
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg2);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v0), arg3);
        let v3 = &mut v2;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(v3, 0x2::coin::value<T0>(v3) * arg0.fee_bps / 10000, arg3)));
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::events::emit_burned_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, v1, v1 - 0x2::coin::value<T0>(&v2));
        v2
    }

    public fun mint<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        let v2 = if (v1 == 0) {
            v0
        } else {
            v0 * 0x2::balance::value<T0>(&arg0.funds) / v1
        };
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::events::emit_minted_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, v2);
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, v2, arg3)
    }

    public fun total_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.treasury_cap)
    }

    public fun new<T0, T1>(arg0: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg1: 0x2::coin::TreasuryCap<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::AuthorityCap<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::ADMIN>) {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_is_whitelisted(arg0, &v0);
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_valid_fee_bps(arg0, arg2);
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 1);
        let v1 = Vault<T0, T1>{
            id                      : 0x2::object::new(arg4),
            treasury_cap            : arg1,
            funds                   : 0x2::balance::zero<T0>(),
            fees                    : 0x2::balance::zero<T0>(),
            fee_bps                 : arg2,
            creator                 : 0x2::tx_context::sender(arg4),
            created_at_timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            active_assistant        : 0x2::object::id_from_address(@0x0),
        };
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::events::emit_created_vault_event<T0, T1>(0x2::object::uid_to_inner(&v1.id), 0x2::tx_context::sender(arg4));
        (v1, 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::create_vault_admin_cap(0x2::object::uid_to_inner(&v1.id), arg4))
    }

    public fun add_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg2: 0x2::coin::Coin<T0>) {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg1);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun deposit_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg1);
        let v0 = from(0x1::type_name::get<T2>());
        if (!0x2::dynamic_object_field::exists_<RewardKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::add<RewardKey, 0x2::coin::Coin<T2>>(&mut arg0.id, v0, 0x2::coin::zero<T2>(arg3));
        };
        0x2::coin::join<T2>(0x2::dynamic_object_field::borrow_mut<RewardKey, 0x2::coin::Coin<T2>>(&mut arg0.id, v0), arg2);
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::events::emit_deposited_reward_event<T2>(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<T2>(&arg2));
    }

    fun from(arg0: 0x1::type_name::TypeName) : RewardKey {
        RewardKey{pos0: arg0}
    }

    public fun set_fee_bps<T0, T1, T2>(arg0: &mut Vault<T1, T2>, arg1: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::AuthorityCap<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>, arg2: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg3: u64) {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::for<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::is_admin(v0) || 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::AuthorityCap<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>>(arg1)), 0);
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_valid_fee_bps(arg2, arg3);
        arg0.fee_bps = arg3;
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T1, T2>, arg1: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::AuthorityCap<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>, arg2: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::for<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::is_admin(v0) || 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::AuthorityCap<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>>(arg1)), 0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fees, 0x2::balance::value<T1>(&arg0.fees)), arg3)
    }

    public fun withdraw_reward<T0, T1, T2, T3>(arg0: &mut Vault<T1, T2>, arg1: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::AuthorityCap<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>, arg2: &0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::for<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::is_admin(v0) || 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::AuthorityCap<0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::VAULT, T0>>(arg1)), 0);
        let v1 = from(0x1::type_name::get<T3>());
        if (!0x2::dynamic_object_field::exists_<RewardKey>(&arg0.id, v1)) {
            0x2::dynamic_object_field::add<RewardKey, 0x2::coin::Coin<T3>>(&mut arg0.id, v1, 0x2::coin::zero<T3>(arg3));
        };
        let v2 = 0x2::dynamic_object_field::borrow_mut<RewardKey, 0x2::coin::Coin<T3>>(&mut arg0.id, v1);
        let v3 = 0x2::coin::value<T3>(v2);
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::events::emit_withdrew_reward_event<T3>(0x2::object::uid_to_inner(&arg0.id), v3);
        0x2::coin::split<T3>(v2, v3, arg3)
    }

    // decompiled from Move bytecode v6
}

