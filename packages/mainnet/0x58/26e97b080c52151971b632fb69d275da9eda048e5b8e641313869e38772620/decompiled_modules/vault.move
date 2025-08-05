module 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::vault {
    struct CreateVaultCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct RewardKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct RewardValue<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
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

    public fun burn<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = v0 * 0x2::coin::total_supply<T1>(&arg0.treasury_cap) / 0x2::balance::value<T0>(&arg0.funds);
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg2);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v1), arg3);
        let v3 = &mut v2;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(v3, 0x2::coin::value<T0>(v3) * arg0.fee_bps / 10000, arg3)));
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::events::emit_burned_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, v1, v1 - 0x2::coin::value<T0>(&v2));
        v2
    }

    public fun mint<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        let v2 = if (v1 == 0) {
            v0
        } else {
            v0 * 0x2::balance::value<T0>(&arg0.funds) / v1
        };
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::events::emit_minted_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, v2);
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, v2, arg3)
    }

    public fun total_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.treasury_cap)
    }

    public fun new<T0, T1>(arg0: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg1: CreateVaultCap<T1>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::AuthorityCap<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::ADMIN>) {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_is_whitelisted(arg0, &v0);
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_valid_fee_bps(arg0, arg3);
        let (v1, v2) = unwrap<T1>(arg1);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::coin::total_supply<T1>(&v4) == 0, 1);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 0x2::coin::get_decimals<T1>(&v3), 2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1>>(v3);
        let v5 = Vault<T0, T1>{
            id                      : 0x2::object::new(arg5),
            treasury_cap            : v4,
            funds                   : 0x2::balance::zero<T0>(),
            fees                    : 0x2::balance::zero<T0>(),
            fee_bps                 : arg3,
            creator                 : 0x2::tx_context::sender(arg5),
            created_at_timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            active_assistant        : 0x2::object::id_from_address(@0x0),
        };
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::events::emit_created_vault_event<T0, T1>(0x2::object::uid_to_inner(&v5.id), 0x2::tx_context::sender(arg5));
        (v5, 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::create_vault_admin_cap(0x2::object::uid_to_inner(&v5.id), arg5))
    }

    public fun add_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg2: 0x2::coin::Coin<T0>) {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg1);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
    }

    fun default<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardValue<T0> {
        RewardValue<T0>{
            id      : 0x2::object::new(arg1),
            vault   : arg0,
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public fun deposit_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg1);
        let v0 = from(0x1::type_name::get<T2>());
        if (!0x2::dynamic_object_field::exists_<RewardKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::add<RewardKey, RewardValue<T2>>(&mut arg0.id, v0, default<T2>(0x2::object::uid_to_inner(&arg0.id), arg3));
        };
        0x2::balance::join<T2>(&mut 0x2::dynamic_object_field::borrow_mut<RewardKey, RewardValue<T2>>(&mut arg0.id, v0).balance, 0x2::coin::into_balance<T2>(arg2));
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::events::emit_deposited_reward_event<T2>(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<T2>(&arg2));
    }

    fun from(arg0: 0x1::type_name::TypeName) : RewardKey {
        RewardKey{pos0: arg0}
    }

    public fun set_fee_bps<T0, T1, T2>(arg0: &mut Vault<T1, T2>, arg1: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::AuthorityCap<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>, arg2: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg3: u64) {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::for<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::is_admin(v0) || 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::AuthorityCap<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>>(arg1)), 0);
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_valid_fee_bps(arg2, arg3);
        arg0.fee_bps = arg3;
    }

    public fun to_create_vault_cap<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &mut 0x2::tx_context::TxContext) : CreateVaultCap<T0> {
        let v0 = CreateVaultCap<T0>{id: 0x2::object::new(arg2)};
        0x2::dynamic_object_field::add<u64, 0x2::coin::TreasuryCap<T0>>(&mut v0.id, 0, arg0);
        0x2::dynamic_object_field::add<u64, 0x2::coin::CoinMetadata<T0>>(&mut v0.id, 1, arg1);
        v0
    }

    fun unwrap<T0>(arg0: CreateVaultCap<T0>) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        let CreateVaultCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        (0x2::dynamic_object_field::remove<u64, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0), 0x2::dynamic_object_field::remove<u64, 0x2::coin::CoinMetadata<T0>>(&mut arg0.id, 1))
    }

    public fun update_coin_metadata<T0>(arg0: &mut CreateVaultCap<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<vector<u8>>) {
        let v0 = 0x2::dynamic_object_field::remove<u64, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0);
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, 0x2::coin::CoinMetadata<T0>>(&mut arg0.id, 1);
        0x2::coin::update_symbol<T0>(&v0, v1, 0x1::ascii::string(arg1));
        0x2::coin::update_name<T0>(&v0, v1, 0x1::string::utf8(arg2));
        0x2::coin::update_description<T0>(&v0, v1, 0x1::string::utf8(arg3));
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            0x2::coin::update_icon_url<T0>(&v0, v1, 0x1::ascii::string(0x1::option::destroy_some<vector<u8>>(arg4)));
        } else {
            0x1::option::destroy_none<vector<u8>>(arg4);
        };
        0x2::dynamic_object_field::add<u64, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0, v0);
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T1, T2>, arg1: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::AuthorityCap<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>, arg2: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::for<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::is_admin(v0) || 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::AuthorityCap<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>>(arg1)), 0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fees, 0x2::balance::value<T1>(&arg0.fees)), arg3)
    }

    public fun withdraw_reward<T0, T1, T2, T3>(arg0: &mut Vault<T1, T2>, arg1: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::AuthorityCap<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>, arg2: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::for<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::is_admin(v0) || 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::AuthorityCap<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::VAULT, T0>>(arg1)), 0);
        let v1 = from(0x1::type_name::get<T3>());
        if (!0x2::dynamic_object_field::exists_<RewardKey>(&arg0.id, v1)) {
            let v2 = default<T3>(0x2::object::uid_to_inner(&arg0.id), arg3);
            0x2::dynamic_object_field::add<RewardKey, RewardValue<T3>>(&mut arg0.id, v1, v2);
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<RewardKey, RewardValue<T3>>(&mut arg0.id, v1);
        let v4 = 0x2::balance::value<T3>(&v3.balance);
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::events::emit_withdrew_reward_event<T3>(0x2::object::uid_to_inner(&arg0.id), v4);
        0x2::coin::from_balance<T3>(0x2::balance::split<T3>(&mut v3.balance, v4), arg3)
    }

    // decompiled from Move bytecode v6
}

