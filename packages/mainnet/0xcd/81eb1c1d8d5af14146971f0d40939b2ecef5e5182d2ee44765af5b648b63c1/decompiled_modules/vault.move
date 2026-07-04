module 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault {
    struct VaultParams has store {
        lock_period: u64,
        owner_fee_rate: u256,
        force_withdraw_delay: u64,
        min_pause_vault_for_force_withdraw_frequency_ms: u64,
        collateral_storage_id: u32,
        collateral_source_id: u16,
        collateral_pfs_tolerance: u64,
        max_force_withdraw_mr_tolerance: u256,
        min_force_withdraw_position_usd: u256,
        min_owner_lock_usd: u256,
        scaling_factor: u256,
        max_markets_in_vault: u64,
        max_pending_orders_per_position: u64,
        max_total_deposited_collateral: u64,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        lp_supply: 0x2::balance::Supply<T0>,
        ch_ids: vector<0x2::object::ID>,
        paused: 0x1::option::Option<u64>,
        last_paused_timestamp_ms: u64,
        vault_params: VaultParams,
    }

    struct UserLpCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        lp_balance: 0x2::balance::Balance<T0>,
        start_timestamp_ms: u64,
        provided_value_usd: u256,
    }

    struct DepositSession<phantom T0, phantom T1> {
        vault: Vault<T0, T1>,
        account: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>,
        sender: address,
        timestamp_ms: u64,
        collateral_price: u256,
        ch_ids: vector<0x2::object::ID>,
        vault_balance_value: u256,
        provided_balance: 0x2::balance::Balance<T1>,
    }

    struct WithdrawRequest<phantom T0> has store {
        user_lp_coin: UserLpCoin<T0>,
        request_timestamp_ms: u64,
        min_expected_balance_out: u64,
    }

    struct WithdrawSession<phantom T0, phantom T1> {
        vault: Vault<T0, T1>,
        account: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>,
        sender: address,
        collateral_price: u256,
        ch_ids: vector<0x2::object::ID>,
        user_lp_coin: UserLpCoin<T0>,
        vault_balance_value: u256,
        accumulated_slippage: u256,
        accumulated_withdraw_dust: u256,
        can_force_process: bool,
        min_expected_balance_out: u64,
    }

    public(friend) fun id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::coin_registry::CoinRegistry, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg7: u64, arg8: u256, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::option::Option<0x1::ascii::String>, arg14: 0x1::option::Option<0x1::ascii::String>, arg15: 0x1::option::Option<0x1::ascii::String>, arg16: 0x1::option::Option<vector<0x1::ascii::String>>, arg17: 0x1::option::Option<vector<0x1::ascii::String>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::non_zero_total_supply());
        assert!(0x2::coin::get_decimals<T0>(arg4) == 0x2::coin::get_decimals<T1>(arg5), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_decimals());
        assert_vault_creation_parameters_are_valid(arg1, arg7, arg8, arg9);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::collateral_pfs_tolerance(arg1);
        let (v1, v2, v3) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::collateral_info<T1>(arg0);
        assert!(v1 == 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::storage_id(arg6), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::wrong_collateral_oracle());
        assert_minimum_owner_locked_liquidity_with_oracle(arg1, arg6, v2, v0, arg18, 0x2::coin::value<T1>(&arg10), v3);
        let v4 = VaultParams{
            lock_period                                     : arg7,
            owner_fee_rate                                  : arg8,
            force_withdraw_delay                            : arg9,
            min_pause_vault_for_force_withdraw_frequency_ms : 1800000,
            collateral_storage_id                           : v1,
            collateral_source_id                            : v2,
            collateral_pfs_tolerance                        : v0,
            max_force_withdraw_mr_tolerance                 : 5000000000000000,
            min_force_withdraw_position_usd                 : 5000000000000000000,
            min_owner_lock_usd                              : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::min_owner_lock_usd(arg1),
            scaling_factor                                  : v3,
            max_markets_in_vault                            : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_markets_in_vault(arg1),
            max_pending_orders_per_position                 : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_pending_orders_per_position(arg1),
            max_total_deposited_collateral                  : 18446744073709551615,
        };
        let v5 = Vault<T0, T1>{
            id                       : 0x2::object::new(arg19),
            version                  : 2,
            lp_supply                : 0x2::coin::treasury_into_supply<T0>(arg2),
            ch_ids                   : 0x1::vector::empty<0x2::object::ID>(),
            paused                   : 0x1::option::none<u64>(),
            last_paused_timestamp_ms : 0,
            vault_params             : v4,
        };
        let v6 = 0x2::tx_context::sender(arg19);
        let v7 = id<T0, T1>(&v5);
        let v8 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_vault_admin_cap<T0>(&mut v5.id);
        let v9 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(&v8);
        let v10 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_vault_treasury_cap<T0>(&mut v5.id, arg19);
        let v11 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>>(&v10);
        let (v12, v13, v14) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::create_account<T1>(arg0, arg19);
        let v15 = v14;
        let v16 = v12;
        let v17 = 0x2::coin::value<T1>(&arg10);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::deposit_collateral<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut v16, &v15, arg0, arg10);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::consume_policy_and_share_account<T1>(v16, v13);
        0x2::dynamic_object_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::AccountCapKey, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(&mut v5.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::account_cap_key(), v15);
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&mut v5.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::owner_fees_key(), 0x2::balance::zero<T1>());
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveAssistantCapsKey, vector<0x2::object::ID>>(&mut v5.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_assistant_caps_key(), 0x1::vector::empty<0x2::object::ID>());
        let v18 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v18, v11);
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey, vector<0x2::object::ID>>(&mut v5.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key(), v18);
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::OwnerLockedLpCoinKey, 0x2::balance::Balance<T0>>(&mut v5.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::owner_user_lp_coin_key(), 0x2::balance::increase_supply<T0>(&mut v5.lp_supply, v17));
        let v19 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::new<T0>(&mut v5.id, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v20 = 0x2::object::id<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>>(&v19);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::register_vault(arg1, v7, v9, v20, 0x2::clock::timestamp_ms(arg18));
        0x2::coin_registry::migrate_legacy_metadata<T0>(arg3, arg4, arg19);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_created_vault_event(v7, v20, v9, v1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())), 0x2::coin::get_decimals<T0>(arg4), v17, v6, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T1>(&v16), arg7);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_create_vault_treasury_cap(v7, v11);
        0x2::transfer::public_transfer<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(v8, v6);
        0x2::transfer::public_transfer<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>>(v10, v6);
        0x2::transfer::share_object<Vault<T0, T1>>(v5);
        0x2::transfer::public_share_object<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>>(v19);
    }

    public(friend) fun assert_package_version<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version <= 2, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_version());
    }

    public(friend) fun max_markets_in_vault<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.max_markets_in_vault
    }

    public(friend) fun max_pending_orders_per_position<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.max_pending_orders_per_position
    }

    public(friend) fun account_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN> {
        0x2::dynamic_object_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::AccountCapKey, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::account_cap_key())
    }

    public(friend) fun account_cap_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN> {
        0x2::dynamic_object_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::AccountCapKey, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::account_cap_key())
    }

    public(friend) fun active_assistants<T0, T1>(arg0: &Vault<T0, T1>) : &vector<0x2::object::ID> {
        0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveAssistantCapsKey, vector<0x2::object::ID>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_assistant_caps_key())
    }

    public(friend) fun active_treasuries<T0, T1>(arg0: &Vault<T0, T1>) : &vector<0x2::object::ID> {
        0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey, vector<0x2::object::ID>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key())
    }

    public(friend) fun add_yield<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: 0x2::coin::Coin<T1>) {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::deposit_collateral<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg1, account_cap<T0, T1>(arg0), arg2, arg3);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_add_yield_event(id<T0, T1>(arg0), 0x2::coin::value<T1>(&arg3));
    }

    public(friend) fun admin_pause_vault<T0, T1>(arg0: &mut Vault<T0, T1>) {
        assert_package_version<T0, T1>(arg0);
        arg0.paused = 0x1::option::some<u64>(18446744073709551615);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_admin_pause_vault(id<T0, T1>(arg0));
    }

    public(friend) fun admin_pause_vault_for_force_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: &0x2::clock::Clock, arg3: address) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert_package_version<T0, T1>(arg0);
        assert_withdraw_request_exists<T0, T1>(arg0, arg3);
        assert!(0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(arg3)).request_timestamp_ms + arg0.vault_params.force_withdraw_delay <= 0x2::clock::timestamp_ms(arg2), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::force_withdraw_delay_not_passed());
        let v0 = &arg0.paused;
        let v1 = 0x1::option::is_some<u64>(v0) && *0x1::option::borrow<u64>(v0) == 18446744073709551615;
        if (!v1) {
            arg0.paused = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2) + 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::force_withdraw_pause_ms(arg1));
        };
    }

    public(friend) fun admin_set_max_markets_in_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        arg0.vault_params.max_markets_in_vault = arg1;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_max_markets_updated(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun admin_unpause_vault<T0, T1>(arg0: &mut Vault<T0, T1>) {
        assert_package_version<T0, T1>(arg0);
        arg0.paused = 0x1::option::none<u64>();
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_admin_unpause_vault(id<T0, T1>(arg0));
    }

    public(friend) fun assert_account_has_vault_authority<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>) {
        assert!(0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(account_cap<T0, T1>(arg0)) == 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>>(arg1), 13835352041498738691);
    }

    fun assert_base_price_feed_storage_is_correct(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg1: u32) {
        assert!(arg1 == 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::storage_id(arg0), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::wrong_base_oracle());
    }

    fun assert_collateral_price_feed_storage_is_correct(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg1: u32) {
        assert!(arg1 == 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::storage_id(arg0), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::wrong_collateral_oracle());
    }

    fun assert_deposit_cap_not_exceeded<T0, T1>(arg0: &Vault<T0, T1>, arg1: u256, arg2: u256) {
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg1, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg0.vault_params.max_total_deposited_collateral, arg0.vault_params.scaling_factor), arg2)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::exceeding_max_total_deposited_collateral());
    }

    public(friend) fun assert_deposit_session_package_version<T0, T1>(arg0: &DepositSession<T0, T1>) {
        assert_package_version<T0, T1>(&arg0.vault);
    }

    fun assert_minimum_owner_locked_liquidity_with_oracle(arg0: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u256) {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg5, arg6), get_price(arg1, arg4, arg2, arg3));
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::min_owner_lock_usd(arg0)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::owner_locked_amount_not_enough());
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_owner_lock_usd(arg0)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::owner_locked_amount_too_big());
    }

    fun assert_minimum_user_deposit<T0, T1>(arg0: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &Vault<T0, T1>, arg2: u256, arg3: u64) {
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg3, arg1.vault_params.scaling_factor), arg2), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::min_deposit_usd(arg0)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::user_deposit_amount_not_enough());
    }

    public(friend) fun assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>) {
        assert!(has_authority<T0, T1, T2>(arg0, arg1), 13835070832809869313);
    }

    fun assert_vault_creation_parameters_are_valid(arg0: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: u64, arg2: u256, arg3: u64) {
        assert!(arg1 <= 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_lock_period(arg0), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_lock_period());
        assert!(arg3 <= 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_force_withdraw_delay(arg0), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_force_withdraw_delay());
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg2, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_owner_fee_rate(arg0)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_owner_fee_rate());
    }

    public(friend) fun assert_vault_is_not_admin_paused<T0, T1>(arg0: &Vault<T0, T1>) {
        let v0 = arg0.paused;
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(0x1::option::destroy_some<u64>(v0) != 18446744073709551615, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::vault_temporarily_paused());
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
    }

    public(friend) fun assert_vault_is_not_paused<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = arg0.paused;
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(0x1::option::destroy_some<u64>(v0) <= 0x2::clock::timestamp_ms(arg1), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::vault_temporarily_paused());
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
    }

    public(friend) fun assert_vault_treasury_cap_is_valid<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>) {
        assert!(has_treasury_authority<T0, T1>(arg0, arg1), 13835070862874640385);
    }

    fun assert_withdraw_request_does_not_already_exist<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(!0x2::dynamic_field::exists<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(arg1)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_request_already_exists());
    }

    fun assert_withdraw_request_exists<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(0x2::dynamic_field::exists<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(arg1)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_request_does_not_exist());
    }

    public(friend) fun assert_withdraw_session_cap_has_authority<T0, T1, T2>(arg0: &WithdrawSession<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>) {
        assert_vault_authority_cap_is_valid<T0, T1, T2>(&arg0.vault, arg1);
    }

    public(friend) fun assert_withdraw_session_package_version<T0, T1>(arg0: &WithdrawSession<T0, T1>) {
        assert_package_version<T0, T1>(&arg0.vault);
    }

    public(friend) fun ch_ids<T0, T1>(arg0: &Vault<T0, T1>) : vector<0x2::object::ID> {
        arg0.ch_ids
    }

    public(friend) fun ch_ids_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut vector<0x2::object::ID> {
        &mut arg0.ch_ids
    }

    public(friend) fun clip_force_withdraw_delay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_force_withdraw_delay(arg1);
        if (arg0.vault_params.force_withdraw_delay <= v0) {
            return
        };
        arg0.vault_params.force_withdraw_delay = v0;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_force_withdraw_delay(id<T0, T1>(arg0), v0);
    }

    public(friend) fun clip_lock_period<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_lock_period(arg1);
        if (arg0.vault_params.lock_period <= v0) {
            return
        };
        arg0.vault_params.lock_period = v0;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_lock_period(id<T0, T1>(arg0), v0);
    }

    public(friend) fun clip_max_markets_in_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_markets_in_vault(arg1);
        if (arg0.vault_params.max_markets_in_vault <= v0) {
            return
        };
        arg0.vault_params.max_markets_in_vault = v0;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_max_markets_updated(id<T0, T1>(arg0), v0);
    }

    public(friend) fun clip_max_pending_orders_per_position<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_pending_orders_per_position(arg1);
        if (arg0.vault_params.max_pending_orders_per_position <= v0) {
            return
        };
        arg0.vault_params.max_pending_orders_per_position = v0;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_max_pending_orders_updated(id<T0, T1>(arg0), v0);
    }

    public(friend) fun clip_min_owner_lock_usd<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::min_owner_lock_usd(arg1);
        let v1 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_owner_lock_usd(arg1);
        let v2 = arg0.vault_params.min_owner_lock_usd;
        let v3 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v2, v0)) {
            v0
        } else if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v2, v1)) {
            v1
        } else {
            return
        };
        arg0.vault_params.min_owner_lock_usd = v3;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_min_owner_lock_usd(id<T0, T1>(arg0), v3);
    }

    public(friend) fun clip_owner_fee_rate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_owner_fee_rate(arg1);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg0.vault_params.owner_fee_rate, v0)) {
            return
        };
        arg0.vault_params.owner_fee_rate = v0;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_owner_fee_rate(id<T0, T1>(arg0), v0);
    }

    fun create_deposit_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u256) : DepositSession<T0, T1> {
        DepositSession<T0, T1>{
            vault               : arg0,
            account             : arg1,
            sender              : arg2,
            timestamp_ms        : arg4,
            collateral_price    : arg5,
            ch_ids              : ch_ids<T0, T1>(&arg0),
            vault_balance_value : 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::collateral_balance<T1>(&arg1), arg0.vault_params.scaling_factor), arg5),
            provided_balance    : arg3,
        }
    }

    public(friend) fun create_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: UserLpCoin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert!(arg3 != 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_amount_zero());
        assert!(0x2::balance::value<T0>(&arg2.lp_balance) >= arg3, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_amount_too_big());
        let v0 = 0x2::tx_context::sender(arg6);
        assert_withdraw_request_does_not_already_exist<T0, T1>(arg0, v0);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg2.start_timestamp_ms + arg0.vault_params.lock_period <= v1, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::lock_period_not_passed());
        let v2 = if (0x2::balance::value<T0>(&arg2.lp_balance) == arg3) {
            WithdrawRequest<T0>{user_lp_coin: arg2, request_timestamp_ms: v1, min_expected_balance_out: arg4}
        } else {
            let v3 = &mut arg2;
            let v4 = split_user_lp_coin_<T0>(v3, arg3, arg6);
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::register_user_lp_coin(arg1, 0x2::object::uid_to_inner(&v4.id), 0x2::object::uid_to_inner(&arg0.id));
            0x2::transfer::public_transfer<UserLpCoin<T0>>(arg2, v0);
            WithdrawRequest<T0>{user_lp_coin: v4, request_timestamp_ms: v1, min_expected_balance_out: arg4}
        };
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(v0), v2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_create_withdraw_request(id<T0, T1>(arg0), v0, arg3, arg4);
    }

    fun create_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: address, arg3: UserLpCoin<T0>, arg4: u256, arg5: bool, arg6: u64) : WithdrawSession<T0, T1> {
        WithdrawSession<T0, T1>{
            vault                     : arg0,
            account                   : arg1,
            sender                    : arg2,
            collateral_price          : arg4,
            ch_ids                    : ch_ids<T0, T1>(&arg0),
            user_lp_coin              : arg3,
            vault_balance_value       : 0,
            accumulated_slippage      : 0,
            accumulated_withdraw_dust : 0,
            can_force_process         : arg5,
            min_expected_balance_out  : arg6,
        }
    }

    public(friend) fun end_deposit_session<T0, T1>(arg0: DepositSession<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64, arg3: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg4: &mut 0x2::tx_context::TxContext) : UserLpCoin<T0> {
        let DepositSession {
            vault               : v0,
            account             : v1,
            sender              : v2,
            timestamp_ms        : v3,
            collateral_price    : v4,
            ch_ids              : v5,
            vault_balance_value : v6,
            provided_balance    : v7,
        } = arg0;
        let v8 = v7;
        let v9 = v5;
        let v10 = v1;
        let v11 = v0;
        assert_package_version<T0, T1>(&v11);
        assert_vault_is_not_admin_paused<T0, T1>(&v11);
        assert!(0x1::vector::length<0x2::object::ID>(&v9) == 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::not_all_chs_processed());
        let v12 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x2::balance::value<T1>(&v8), v11.vault_params.scaling_factor), v4);
        assert_deposit_cap_not_exceeded<T0, T1>(&v11, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v6, v12), v4);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::deposit_collateral<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut v10, account_cap<T0, T1>(&v11), arg3, 0x2::coin::from_balance<T1>(v8, arg4));
        let v13 = multiply_by_rational_ifixed(v12, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(lp_supply_value<T0, T1>(&v11), 1000000000), v6);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v13), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::user_lp_calculation_negative());
        let v14 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v13, 1000000000);
        assert!(v14 != 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::user_lp_calculation_zero());
        let v15 = 0x2::balance::increase_supply<T0>(&mut v11.lp_supply, v14);
        let v16 = 0x2::balance::value<T0>(&v15);
        assert!(v16 >= arg2, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::slippage_check());
        let v17 = UserLpCoin<T0>{
            id                 : 0x2::object::new(arg4),
            lp_balance         : v15,
            start_timestamp_ms : v3,
            provided_value_usd : v12,
        };
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::register_user_lp_coin(arg1, 0x2::object::uid_to_inner(&v17.id), id<T0, T1>(&v11));
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_user_deposit(id<T0, T1>(&v11), v2, 0x2::balance::value<T1>(&v8), v16, v6);
        0x2::transfer::public_share_object<Vault<T0, T1>>(v11);
        0x2::transfer::public_share_object<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>>(v10);
        v17
    }

    public(friend) fun end_withdraw_session<T0, T1>(arg0: WithdrawSession<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_is_not_admin_paused<T0, T1>(&arg0.vault);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert!(arg0.sender == 0x2::tx_context::sender(arg3), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_sender());
        let WithdrawSession {
            vault                     : v0,
            account                   : v1,
            sender                    : v2,
            collateral_price          : v3,
            ch_ids                    : v4,
            user_lp_coin              : v5,
            vault_balance_value       : v6,
            accumulated_slippage      : v7,
            accumulated_withdraw_dust : v8,
            can_force_process         : v9,
            min_expected_balance_out  : v10,
        } = arg0;
        let v11 = v5;
        let v12 = v4;
        let v13 = v1;
        let v14 = v0;
        assert_vault_is_not_admin_paused<T0, T1>(&v14);
        let UserLpCoin {
            id                 : v15,
            lp_balance         : v16,
            start_timestamp_ms : _,
            provided_value_usd : v18,
        } = v11;
        let v19 = v16;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v12), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::not_all_chs_processed());
        assert_package_version<T0, T1>(&v14);
        let v20 = v14.vault_params.scaling_factor;
        let v21 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::collateral_balance<T1>(&v13), v20), v3), v6), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(v7));
        let v22 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(multiply_by_rational_ifixed(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x2::balance::value<T0>(&v19), 1000000000), v21, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(lp_supply_value<T0, T1>(&v14), 1000000000)), v7), v8);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v22), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::slippage_check());
        let v23 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v22, v3), v20);
        let v24 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::withdraw_collateral<T1>(&mut v13, account_cap<T0, T1>(&v14), arg2, v23, arg3);
        0x2::balance::decrease_supply<T0>(&mut v14.lp_supply, v19);
        let v25 = v18 == 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        if (!v25) {
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::unregister_user_lp_coin(arg1, 0x2::object::uid_to_inner(&v11.id));
        };
        0x2::object::delete(v15);
        let v26 = if (!v25) {
            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v14.vault_params.owner_fee_rate, 0)) {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v22, v18)
            } else {
                false
            }
        } else {
            false
        };
        if (v26) {
            let v27 = &mut v14;
            0x2::balance::join<T1>(owner_fees_mut<T0, T1>(v27), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v24), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v22, v18), v14.vault_params.owner_fee_rate), v3), v20)));
        };
        let v28 = 0x2::coin::value<T1>(&v24);
        assert!(v10 <= v28, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::slippage_check());
        0x2::transfer::public_share_object<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>>(v13);
        if (v9) {
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_user_force_withdraw(id<T0, T1>(&v14), v2, 0x2::balance::value<T0>(&v19), v28, v6);
            v14.paused = 0x1::option::none<u64>();
        } else if (v25) {
            let v29 = 0x2::balance::value<T0>(owner_locked_lp_balance<T0, T1>(&v14));
            assert!(v29 != 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::owner_locked_amount_too_low_after_withdraw());
            assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(multiply_by_rational_ifixed(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v29, 1000000000), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v21, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v28, v20), v3)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(lp_supply_value<T0, T1>(&v14), 1000000000)), v14.vault_params.min_owner_lock_usd), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::owner_locked_amount_too_low_after_withdraw());
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_owner_locked_liquidity_withdraw(id<T0, T1>(&v14), v2, 0x2::balance::value<T0>(&v19), v23, v29);
        } else {
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_owner_withdraw(id<T0, T1>(&v14), v2, 0x2::balance::value<T0>(&v19), v23, v6);
        };
        0x2::transfer::public_share_object<Vault<T0, T1>>(v14);
        v24
    }

    public(friend) fun end_withdraw_session_and_transfer_to_recipient<T0, T1>(arg0: WithdrawSession<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) {
        assert_vault_is_not_admin_paused<T0, T1>(&arg0.vault);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        let WithdrawSession {
            vault                     : v0,
            account                   : v1,
            sender                    : v2,
            collateral_price          : v3,
            ch_ids                    : v4,
            user_lp_coin              : v5,
            vault_balance_value       : v6,
            accumulated_slippage      : v7,
            accumulated_withdraw_dust : v8,
            can_force_process         : v9,
            min_expected_balance_out  : v10,
        } = arg0;
        let v11 = v5;
        let v12 = v4;
        let v13 = v1;
        let v14 = v0;
        assert_vault_is_not_admin_paused<T0, T1>(&v14);
        let UserLpCoin {
            id                 : v15,
            lp_balance         : v16,
            start_timestamp_ms : _,
            provided_value_usd : v18,
        } = v11;
        let v19 = v16;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v12), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::not_all_chs_processed());
        assert_package_version<T0, T1>(&v14);
        let v20 = v14.vault_params.scaling_factor;
        let v21 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::collateral_balance<T1>(&v13), v20), v3), v6), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(v7));
        let v22 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(multiply_by_rational_ifixed(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x2::balance::value<T0>(&v19), 1000000000), v21, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(lp_supply_value<T0, T1>(&v14), 1000000000)), v7), v8);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v22), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::slippage_check());
        let v23 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v22, v3), v20);
        let v24 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::withdraw_collateral<T1>(&mut v13, account_cap<T0, T1>(&v14), arg2, v23, arg3);
        0x2::balance::decrease_supply<T0>(&mut v14.lp_supply, v19);
        let v25 = v18 == 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        if (!v25) {
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::unregister_user_lp_coin(arg1, 0x2::object::uid_to_inner(&v11.id));
        };
        0x2::object::delete(v15);
        let v26 = if (!v25) {
            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v14.vault_params.owner_fee_rate, 0)) {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v22, v18)
            } else {
                false
            }
        } else {
            false
        };
        if (v26) {
            let v27 = &mut v14;
            0x2::balance::join<T1>(owner_fees_mut<T0, T1>(v27), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v24), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v22, v18), v14.vault_params.owner_fee_rate), v3), v20)));
        };
        let v28 = 0x2::coin::value<T1>(&v24);
        assert!(v10 <= v28, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::slippage_check());
        0x2::transfer::public_share_object<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>>(v13);
        if (v9) {
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_user_force_withdraw(id<T0, T1>(&v14), v2, 0x2::balance::value<T0>(&v19), v28, v6);
            v14.paused = 0x1::option::none<u64>();
        } else if (v25) {
            let v29 = 0x2::balance::value<T0>(owner_locked_lp_balance<T0, T1>(&v14));
            assert!(v29 != 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::owner_locked_amount_too_low_after_withdraw());
            assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(multiply_by_rational_ifixed(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v29, 1000000000), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v21, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v28, v20), v3)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(lp_supply_value<T0, T1>(&v14), 1000000000)), v14.vault_params.min_owner_lock_usd), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::owner_locked_amount_too_low_after_withdraw());
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_owner_locked_liquidity_withdraw(id<T0, T1>(&v14), v2, 0x2::balance::value<T0>(&v19), v23, v29);
        } else {
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_owner_withdraw(id<T0, T1>(&v14), v2, 0x2::balance::value<T0>(&v19), v23, v6);
        };
        0x2::transfer::public_share_object<Vault<T0, T1>>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v24, arg0.sender);
    }

    public(friend) fun execution_domain<T0, T1>(arg0: &Vault<T0, T1>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun executor<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::Executor {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::domain_executor(&arg0.id, arg1)
    }

    public(friend) fun force_withdraw_delay<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.force_withdraw_delay
    }

    fun get_price(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg1: &0x2::clock::Clock, arg2: u16, arg3: u64) : u256 {
        let (v0, v1) = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::price_and_timestamp_ms(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::price_feed(arg0, arg2));
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 - 0x1::u64::min(v2, arg3) <= v1, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::bad_oracle_price());
        (v0 as u256)
    }

    public(friend) fun get_vault_margin_in_market<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: u64, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: bool) : (u256, u256) {
        let (v0, v1) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::cum_funding_rates(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_state<T1>(arg1));
        let (v2, v3) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_with_fundings(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::position<T1>(arg1, arg2), arg4, arg3, arg5, v0, v1, arg6);
        let v4 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v2, 0)) {
            assert!(!arg7, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::non_positive_market_margin());
            0
        } else {
            v2
        };
        (v4, v3)
    }

    fun has_authority<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>(arg1) == 0x2::object::uid_to_inner(&arg0.id)) {
            if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>()) {
                true
            } else if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>()) {
                let v2 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>>(arg1);
                0x1::vector::contains<0x2::object::ID>(active_assistants<T0, T1>(arg0), &v2)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun has_treasury_authority<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>) : bool {
        if (0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>(arg1) != 0x2::object::uid_to_inner(&arg0.id)) {
            return false
        };
        if (!0x2::dynamic_field::exists<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key())) {
            return false
        };
        let v0 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>>(arg1);
        0x1::vector::contains<0x2::object::ID>(0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey, vector<0x2::object::ID>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key()), &v0)
    }

    public(friend) fun join_user_lp_coin<T0>(arg0: &mut UserLpCoin<T0>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: UserLpCoin<T0>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::unregister_user_lp_coin(arg1, 0x2::object::uid_to_inner(&arg2.id));
        join_user_lp_coin_<T0>(arg0, arg2);
    }

    fun join_user_lp_coin_<T0>(arg0: &mut UserLpCoin<T0>, arg1: UserLpCoin<T0>) {
        let UserLpCoin {
            id                 : v0,
            lp_balance         : v1,
            start_timestamp_ms : v2,
            provided_value_usd : v3,
        } = arg1;
        0x2::balance::join<T0>(&mut arg0.lp_balance, v1);
        if (v2 > arg0.start_timestamp_ms) {
            arg0.start_timestamp_ms = v2;
        };
        arg0.provided_value_usd = arg0.provided_value_usd + v3;
        0x2::object::delete(v0);
    }

    public(friend) fun last_paused_timestamp_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.last_paused_timestamp_ms
    }

    public(friend) fun lock_period<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.lock_period
    }

    public fun lp_supply_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.lp_supply)
    }

    public(friend) fun min_force_withdraw_position_usd<T0, T1>(arg0: &Vault<T0, T1>) : u256 {
        arg0.vault_params.min_force_withdraw_position_usd
    }

    public(friend) fun min_pause_vault_for_force_withdraw_frequency_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.min_pause_vault_for_force_withdraw_frequency_ms
    }

    fun multiply_by_rational_ifixed(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 0) {
            return 0
        };
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0, arg1), arg2)
    }

    public(friend) fun new_vault_assistant_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        assert_vault_authority_cap_is_valid<T0, T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_vault_assistant_cap<T0>(&mut arg0.id, arg3);
        let v1 = 0x2::dynamic_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveAssistantCapsKey, vector<0x2::object::ID>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_assistant_caps_key());
        assert!(0x1::vector::length<0x2::object::ID>(v1) < 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_assistants_per_vault(arg2), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::too_many_assistants());
        let v2 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&v0);
        0x1::vector::push_back<0x2::object::ID>(v1, v2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_create_vault_assistant_cap(id<T0, T1>(arg0), v2);
        v0
    }

    public(friend) fun new_vault_treasury_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY> {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert_vault_authority_cap_is_valid<T0, T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_vault_treasury_cap<T0>(&mut arg0.id, arg2);
        let v1 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>>(&v0);
        let v2 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key();
        if (!0x2::dynamic_field::exists<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey>(&arg0.id, v2)) {
            0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey, vector<0x2::object::ID>>(&mut arg0.id, v2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey, vector<0x2::object::ID>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key()), v1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_create_vault_treasury_cap(id<T0, T1>(arg0), v1);
        v0
    }

    public(friend) fun owner_fee_rate<T0, T1>(arg0: &Vault<T0, T1>) : u256 {
        arg0.vault_params.owner_fee_rate
    }

    public(friend) fun owner_fees<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::owner_fees_key())
    }

    public(friend) fun owner_fees_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::owner_fees_key())
    }

    public(friend) fun owner_locked_lp_balance<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::OwnerLockedLpCoinKey, 0x2::balance::Balance<T0>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::owner_user_lp_coin_key())
    }

    public(friend) fun owner_locked_lp_balance_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::OwnerLockedLpCoinKey, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::owner_user_lp_coin_key())
    }

    public(friend) fun pause_vault_for_force_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: &0x2::clock::Clock, arg3: address) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert_package_version<T0, T1>(arg0);
        assert_withdraw_request_exists<T0, T1>(arg0, arg3);
        assert!(0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(arg3)).request_timestamp_ms + arg0.vault_params.force_withdraw_delay <= v0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::force_withdraw_delay_not_passed());
        let v1 = &arg0.paused;
        let v2 = 0x1::option::is_some<u64>(v1) && *0x1::option::borrow<u64>(v1) == 18446744073709551615;
        if (!v2) {
            arg0.paused = 0x1::option::some<u64>(v0 + 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::force_withdraw_pause_ms(arg1));
        };
        assert!(arg0.last_paused_timestamp_ms + arg0.vault_params.min_pause_vault_for_force_withdraw_frequency_ms <= v0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::pause_vault_for_force_withdraw_too_frequent());
        arg0.last_paused_timestamp_ms = v0;
    }

    public(friend) fun process_clearing_house_for_deposit<T0, T1>(arg0: &mut DepositSession<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) {
        assert_package_version<T0, T1>(&arg0.vault);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0.vault);
        assert_base_price_feed_storage_is_correct(arg2, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::base_storage_id(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T1>(&arg1)));
        let v0 = &mut arg0.ch_ids;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            let v3 = 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>>(&arg1);
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 4 */
                if (0x1::option::is_none<u64>(&v2)) {
                    abort 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::clearing_house_id_not_found()
                };
                0x1::vector::remove<0x2::object::ID>(v0, 0x1::option::extract<u64>(&mut v2));
                0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::update_funding<T1>(&mut arg1, arg2, arg3);
                let (v4, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T1>(&arg0.account), 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::mark_price<T1>(&arg1, arg2, arg3), arg0.collateral_price, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(1), 0, true);
                arg0.vault_balance_value = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.vault_balance_value, v4);
                share_clearing_house<T1>(arg1);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    public(friend) fun process_clearing_house_for_force_withdraw<T0, T1>(arg0: &mut WithdrawSession<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: &vector<u128>, arg6: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_package_version<T0, T1>(&arg0.vault);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0.vault);
        assert!(arg0.can_force_process, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::cannot_force_withdraw());
        assert_base_price_feed_storage_is_correct(arg2, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::base_storage_id(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T1>(&arg1)));
        assert_collateral_price_feed_storage_is_correct(arg3, arg0.vault.vault_params.collateral_storage_id);
        assert!(get_price(arg3, arg7, arg0.vault.vault_params.collateral_source_id, arg0.vault.vault_params.collateral_pfs_tolerance) == arg0.collateral_price, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::bad_oracle_price());
        let v0 = &mut arg0.ch_ids;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            let v3 = 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>>(&arg1);
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 10 */
                if (0x1::option::is_none<u64>(&v2)) {
                    abort 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::clearing_house_id_not_found()
                };
                0x1::vector::remove<0x2::object::ID>(v0, 0x1::option::extract<u64>(&mut v2));
                0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::update_funding<T1>(&mut arg1, arg2, arg7);
                let v4 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T1>(&arg0.account);
                let v5 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::mark_price<T1>(&arg1, arg2, arg7);
                let v6 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T1>(&arg1);
                let v7 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::collateral_haircut(v6);
                let v8 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::margin_ratio_initial(v6);
                let (_, v10) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::maker_taker_fees(v6);
                let (v11, v12) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::cum_funding_rates(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_state<T1>(&arg1));
                let v13 = if (0x2::tx_context::gas_price(arg8) > 0x2::tx_context::reference_gas_price(arg8)) {
                    0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::resolve_priority_taker_fee(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::priority_taker_fee(v6))
                } else {
                    0
                };
                let v14 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::lot_size(v6), 1000000000);
                let (v15, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v4, v5, arg0.collateral_price, v8, 0, false);
                let (v17, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v4, v5, arg0.collateral_price, v8, v7, false);
                let v19 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v15, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x2::balance::value<T0>(&arg0.user_lp_coin.lp_balance), 1000000000), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(lp_supply_value<T0, T1>(&arg0.vault), 1000000000)));
                let v20 = v19;
                let v21 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::position<T1>(&arg1, v4);
                let v22 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::calculate_position_funding_internal(v21, v11, v12);
                let (v23, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v21);
                let v25 = if (v23 != 0) {
                    let v26 = if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v22) && v7 != 0) {
                        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v22, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(1), v7))
                    } else {
                        v22
                    };
                    0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v17, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::abs_net_base(v21), v5)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v21, v5), v26), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v23), v5)), v8), v8))
                } else {
                    v8
                };
                0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::set_position_initial_margin_ratio<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, v8);
                if (0x1::vector::length<u128>(arg5) != 0) {
                    let v27 = vector[];
                    let v28 = 0;
                    while (v28 < 0x1::vector::length<u128>(arg5)) {
                        0x1::vector::push_back<u128>(&mut v27, *0x1::vector::borrow<u128>(arg5, v28));
                        v28 = v28 + 1;
                    };
                    0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::cancel_orders<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, v27);
                };
                let v29 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::position<T1>(&arg1, v4);
                let (v30, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v29);
                let (v32, v33) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_base_amounts_by_side(v29);
                let v34 = if (v32 == 0) {
                    if (v33 == 0) {
                        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v29) == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v34, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::wrong_order_ids_in_force_withdraw());
                let v35 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v30), 1000000000);
                let v36 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v30), v5), arg0.vault.vault_params.min_force_withdraw_position_usd);
                let v37 = if (v36) {
                    v35
                } else {
                    0x1::u64::min(arg4, v35)
                };
                if (v37 != 0) {
                    let v38 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v30);
                    let v39 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::start_session<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, arg6, arg7, arg8);
                    0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::place_market_order<T1>(&mut v39, !v38, v37, true);
                    let (v40, v41) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::end_session<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(v39, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, false, false);
                    let v42 = v41;
                    arg1 = v40;
                    let v43 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v37, 1000000000), 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::execution_price(&v42, !v38));
                    let v44 = if (v38) {
                        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v37, 1000000000), v5), v43)
                    } else {
                        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v43, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v37, 1000000000), v5))
                    };
                    let v45 = v10;
                    if (v13 != 0) {
                        v45 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v10, v13);
                    };
                    let v46 = if (0x1::option::is_some<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>(&arg6)) {
                        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::integrator_fee(0x1::option::borrow<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>(&arg6))
                    } else {
                        0
                    };
                    let v47 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v44, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v45, v46), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v43)));
                    arg0.accumulated_slippage = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.accumulated_slippage, v47);
                    v20 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v19, v47);
                };
                assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v20), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::negative_amount_to_withdraw());
                if (v36) {
                    0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::deallocate_free_collateral<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, arg7);
                    let v48 = &arg0.vault.ch_ids;
                    let v49 = 0;
                    let v50;
                    while (v49 < 0x1::vector::length<0x2::object::ID>(v48)) {
                        if (*0x1::vector::borrow<0x2::object::ID>(v48, v49) == 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>>(&arg1)) {
                            v50 = 0x1::option::some<u64>(v49);
                            /* label 61 */
                            if (0x1::option::is_some<u64>(&v50)) {
                                0x1::vector::remove<0x2::object::ID>(&mut arg0.vault.ch_ids, 0x1::option::destroy_some<u64>(v50));
                            } else {
                                0x1::option::destroy_none<u64>(v50);
                            };
                            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::set_position_initial_margin_ratio<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v21, v8));
                            share_clearing_house<T1>(arg1);
                            return
                        };
                        v49 = v49 + 1;
                    };
                    v50 = 0x1::option::none<u64>();
                    /* goto 61 */
                } else {
                    let v51 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v20, arg0.collateral_price), arg0.vault.vault_params.scaling_factor);
                    let v52 = 0x1::u64::min(v51, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::collateral_to_deallocate_for_margin_ratio<T1>(&arg1, v4, arg2, arg3, arg7, 0x1::option::some<u256>(v8)));
                    let v53 = if (v52 == v51) {
                        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v20, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v52, arg0.vault.vault_params.scaling_factor), arg0.collateral_price))
                    } else {
                        0
                    };
                    if (v52 != 0) {
                        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::deallocate_collateral<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, v52, arg7);
                    };
                    let (v54, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v4, v5, arg0.collateral_price, v25, 0, false);
                    let (v56, v57) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v4, v5, arg0.collateral_price, v25, v7, false);
                    let v58 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::position<T1>(&arg1, v4);
                    let (v59, v60) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v58);
                    if (v37 != 0) {
                        if (v37 == v35) {
                            assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v58), arg0.collateral_price) <= arg0.vault.vault_params.min_force_withdraw_position_usd, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::force_withdraw_collateral_leftover());
                        } else {
                            assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v56, v57), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::force_withdraw_below_margin_ratio());
                            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v25, arg0.vault.vault_params.max_force_withdraw_mr_tolerance), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v56, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v59), v5)))) {
                                let v61 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v59);
                                let v62 = if (v61) {
                                    0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v14, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v60, v59), v5))
                                } else {
                                    0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v14, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v5, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v60, v59)))
                                };
                                let v63 = if (v61) {
                                    0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v59, v14)
                                } else {
                                    0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v59, v14)
                                };
                                if (v63 != 0) {
                                    assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v56, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v62, v7)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v63), v5)), v25), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::force_withdraw_above_margin_ratio_tolerance());
                                };
                            };
                        };
                    } else if (v30 != 0) {
                        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v56, v57), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::force_withdraw_below_margin_ratio());
                    };
                    if (v59 == 0) {
                        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::deallocate_free_collateral<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, arg7);
                        let v64 = &arg0.vault.ch_ids;
                        let v65 = 0;
                        let v66;
                        while (v65 < 0x1::vector::length<0x2::object::ID>(v64)) {
                            if (*0x1::vector::borrow<0x2::object::ID>(v64, v65) == 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>>(&arg1)) {
                                v66 = 0x1::option::some<u64>(v65);
                                /* label 105 */
                                if (0x1::option::is_some<u64>(&v66)) {
                                    0x1::vector::remove<0x2::object::ID>(&mut arg0.vault.ch_ids, 0x1::option::destroy_some<u64>(v66));
                                } else {
                                    0x1::option::destroy_none<u64>(v66);
                                };
                                0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::set_position_initial_margin_ratio<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v21, v8));
                                share_clearing_house<T1>(arg1);
                                return
                            };
                            v65 = v65 + 1;
                        };
                        v66 = 0x1::option::none<u64>();
                        /* goto 105 */
                    } else {
                        arg0.accumulated_withdraw_dust = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.accumulated_withdraw_dust, v53);
                        arg0.vault_balance_value = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.vault_balance_value, v54);
                        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::set_position_initial_margin_ratio<T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v21, v8));
                        share_clearing_house<T1>(arg1);
                        return
                    };
                };
            } else {
                v1 = v1 + 1;
            };
        };
        v2 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public(friend) fun process_clearing_house_for_withdraw<T0, T1>(arg0: &mut WithdrawSession<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) {
        assert_package_version<T0, T1>(&arg0.vault);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0.vault);
        assert!(!arg0.can_force_process, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::must_force_withdraw());
        assert_base_price_feed_storage_is_correct(arg2, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::base_storage_id(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T1>(&arg1)));
        let v0 = &mut arg0.ch_ids;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            let v3 = 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>>(&arg1);
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v2)) {
                    abort 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::clearing_house_id_not_found()
                };
                0x1::vector::remove<0x2::object::ID>(v0, 0x1::option::extract<u64>(&mut v2));
                0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::update_funding<T1>(&mut arg1, arg2, arg3);
                let (v4, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T1>(&arg0.account), 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::mark_price<T1>(&arg1, arg2, arg3), arg0.collateral_price, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::margin_ratio_initial(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T1>(&arg1)), 0, false);
                arg0.vault_balance_value = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.vault_balance_value, v4);
                share_clearing_house<T1>(arg1);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun remove_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) : UserLpCoin<T0> {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert_withdraw_request_exists<T0, T1>(arg0, v0);
        let WithdrawRequest {
            user_lp_coin             : v1,
            request_timestamp_ms     : _,
            min_expected_balance_out : _,
        } = 0x2::dynamic_field::remove<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(v0));
        let v4 = v1;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_remove_withdraw_request(id<T0, T1>(arg0), v0, 0x2::balance::value<T0>(&v4.lp_balance));
        v4
    }

    public(friend) fun resume_vault_for_force_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = &arg0.paused;
        if (0x1::option::is_some<u64>(v0) && 0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(v0)) {
            return
        };
        arg0.paused = 0x1::option::none<u64>();
    }

    public(friend) fun revoke_vault_assistant_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert_vault_authority_cap_is_valid<T0, T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveAssistantCapsKey, vector<0x2::object::ID>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_assistant_caps_key());
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 4 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(v0, 0x1::option::destroy_some<u64>(v2));
                    0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_revoke_vault_assistant_cap(id<T0, T1>(arg0), arg2);
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    public(friend) fun revoke_vault_treasury_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert_vault_authority_cap_is_valid<T0, T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        if (!0x2::dynamic_field::exists<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key())) {
            return
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::ActiveTreasuryCapsKey, vector<0x2::object::ID>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::active_treasury_caps_key());
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 7 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(v0, 0x1::option::destroy_some<u64>(v2));
                    0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_revoke_vault_treasury_cap(id<T0, T1>(arg0), arg2);
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 7 */
    }

    public(friend) fun set_collateral_pfs_info<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry) {
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let (v0, v1, v2) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::collateral_info<T1>(arg1);
        arg0.vault_params.collateral_storage_id = v0;
        arg0.vault_params.collateral_source_id = v1;
        arg0.vault_params.scaling_factor = v2;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_collateral_pfs_info(id<T0, T1>(arg0), v0, v1);
    }

    public(friend) fun set_collateral_pfs_tolerance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        arg0.vault_params.collateral_pfs_tolerance = arg1;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_collateral_pfs_tolerance(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun set_deposit_session_sender<T0, T1>(arg0: &mut DepositSession<T0, T1>, arg1: address) {
        assert_vault_is_not_admin_paused<T0, T1>(&arg0.vault);
        arg0.sender = arg1;
    }

    public(friend) fun set_force_withdraw_delay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert!(arg2 <= 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_force_withdraw_delay(arg1), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_force_withdraw_delay());
        arg0.vault_params.force_withdraw_delay = arg2;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_force_withdraw_delay(id<T0, T1>(arg0), arg2);
    }

    public(friend) fun set_lock_period<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert!(arg2 <= 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_lock_period(arg1), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_lock_period());
        arg0.vault_params.lock_period = arg2;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_lock_period(id<T0, T1>(arg0), arg2);
    }

    public(friend) fun set_max_force_withdraw_mr_tolerance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u256) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        arg0.vault_params.max_force_withdraw_mr_tolerance = arg2;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_max_force_withdraw_mr_tolerance(id<T0, T1>(arg0), arg2);
    }

    public(friend) fun set_max_markets_in_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert!(arg2 <= 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_markets_in_vault(arg1), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_max_markets_in_vault());
        arg0.vault_params.max_markets_in_vault = arg2;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_max_markets_updated(id<T0, T1>(arg0), arg2);
    }

    public(friend) fun set_max_pending_orders_per_position<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert!(arg2 <= 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_pending_orders_per_position(arg1), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_max_pending_orders_per_position());
        arg0.vault_params.max_pending_orders_per_position = arg2;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_max_pending_orders_updated(id<T0, T1>(arg0), arg2);
    }

    public(friend) fun set_max_total_deposited_collateral<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        arg0.vault_params.max_total_deposited_collateral = arg1;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_max_total_deposited_collateral(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun set_min_force_withdraw_position_usd<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u256) {
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        arg0.vault_params.min_force_withdraw_position_usd = arg1;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_min_force_withdraw_position_usd(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun set_min_pause_vault_for_force_withdraw_frequency_ms<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        arg0.vault_params.min_pause_vault_for_force_withdraw_frequency_ms = arg1;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_min_pause_vault_for_force_withdraw_frequency_ms(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun set_new_withdraw_request_slippage<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert_withdraw_request_exists<T0, T1>(arg0, v0);
        let v1 = withdraw_request_mut<T0, T1>(arg0, v0);
        v1.min_expected_balance_out = arg1;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_user_withdraw_request_set_slippage(id<T0, T1>(arg0), v0, arg1);
    }

    public(friend) fun set_owner_fee_rate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u256) {
        assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg2, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::max_owner_fee_rate(arg1)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_owner_fee_rate());
        arg0.vault_params.owner_fee_rate = arg2;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_update_owner_fee_rate(id<T0, T1>(arg0), arg2);
    }

    fun share_clearing_house<T0>(arg0: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg0);
    }

    public(friend) fun split_user_lp_coin<T0>(arg0: &mut UserLpCoin<T0>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : UserLpCoin<T0> {
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::user_lp_coin_record_vault_id(0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::user_lp_coin_record(arg1, 0x2::object::uid_to_inner(&arg0.id)));
        let v1 = split_user_lp_coin_<T0>(arg0, arg2, arg3);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::register_user_lp_coin(arg1, 0x2::object::uid_to_inner(&v1.id), v0);
        v1
    }

    fun split_user_lp_coin_<T0>(arg0: &mut UserLpCoin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UserLpCoin<T0> {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0.provided_value_usd, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg1, 1000000000), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x2::balance::value<T0>(&arg0.lp_balance), 1000000000)));
        assert!(v0 > 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::invalid_split_amount());
        arg0.provided_value_usd = arg0.provided_value_usd - v0;
        UserLpCoin<T0>{
            id                 : 0x2::object::new(arg2),
            lp_balance         : 0x2::balance::split<T0>(&mut arg0.lp_balance, arg1),
            start_timestamp_ms : arg0.start_timestamp_ms,
            provided_value_usd : v0,
        }
    }

    public(friend) fun start_deposit_session<T0, T1>(arg0: Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : DepositSession<T0, T1> {
        assert_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0);
        assert_account_has_vault_authority<T0, T1>(&arg0, &arg2);
        assert_collateral_price_feed_storage_is_correct(arg3, arg0.vault_params.collateral_storage_id);
        let v0 = get_price(arg3, arg5, arg0.vault_params.collateral_source_id, arg0.vault_params.collateral_pfs_tolerance);
        assert_minimum_user_deposit<T0, T1>(arg1, &arg0, v0, 0x2::coin::value<T1>(&arg4));
        create_deposit_session<T0, T1>(arg0, arg2, 0x2::tx_context::sender(arg6), 0x2::coin::into_balance<T1>(arg4), 0x2::clock::timestamp_ms(arg5), v0)
    }

    public(friend) fun start_force_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: address, arg4: &0x2::clock::Clock) : WithdrawSession<T0, T1> {
        assert_package_version<T0, T1>(&arg0);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0);
        assert_account_has_vault_authority<T0, T1>(&arg0, &arg1);
        assert_collateral_price_feed_storage_is_correct(arg2, arg0.vault_params.collateral_storage_id);
        assert_withdraw_request_exists<T0, T1>(&arg0, arg3);
        let WithdrawRequest {
            user_lp_coin             : v0,
            request_timestamp_ms     : v1,
            min_expected_balance_out : v2,
        } = 0x2::dynamic_field::remove<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(arg3));
        assert!(v1 + arg0.vault_params.force_withdraw_delay <= 0x2::clock::timestamp_ms(arg4), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::force_withdraw_delay_not_passed());
        create_withdraw_session<T0, T1>(arg0, arg1, arg3, v0, get_price(arg2, arg4, arg0.vault_params.collateral_source_id, arg0.vault_params.collateral_pfs_tolerance), true, v2)
    }

    public(friend) fun start_owner_locked_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : WithdrawSession<T0, T1> {
        assert_package_version<T0, T1>(&arg0);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0);
        assert!(arg3 != 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_amount_zero());
        assert_account_has_vault_authority<T0, T1>(&arg0, &arg1);
        assert_collateral_price_feed_storage_is_correct(arg2, arg0.vault_params.collateral_storage_id);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg0;
        create_withdraw_session<T0, T1>(arg0, arg1, v0, take_owner_locked_user_lp_coin<T0, T1>(v1, arg3, arg6), get_price(arg2, arg5, arg0.vault_params.collateral_source_id, arg0.vault_params.collateral_pfs_tolerance), false, arg4)
    }

    public(friend) fun start_owner_process_withdraw_request<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: address, arg4: &0x2::clock::Clock) : WithdrawSession<T0, T1> {
        assert_package_version<T0, T1>(&arg0);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0);
        assert_account_has_vault_authority<T0, T1>(&arg0, &arg1);
        assert_collateral_price_feed_storage_is_correct(arg2, arg0.vault_params.collateral_storage_id);
        assert_withdraw_request_exists<T0, T1>(&arg0, arg3);
        let WithdrawRequest {
            user_lp_coin             : v0,
            request_timestamp_ms     : _,
            min_expected_balance_out : v2,
        } = 0x2::dynamic_field::remove<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(arg3));
        create_withdraw_session<T0, T1>(arg0, arg1, arg3, v0, get_price(arg2, arg4, arg0.vault_params.collateral_source_id, arg0.vault_params.collateral_pfs_tolerance), false, v2)
    }

    public(friend) fun start_owner_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: UserLpCoin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : WithdrawSession<T0, T1> {
        assert_package_version<T0, T1>(&arg0);
        assert_vault_is_not_admin_paused<T0, T1>(&arg0);
        assert!(arg5 != 0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_amount_zero());
        let v0 = 0x2::balance::value<T0>(&arg4.lp_balance);
        assert!(arg5 <= v0, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_amount_too_big());
        assert_account_has_vault_authority<T0, T1>(&arg0, &arg2);
        assert_collateral_price_feed_storage_is_correct(arg3, arg0.vault_params.collateral_storage_id);
        let v1 = 0x2::tx_context::sender(arg8);
        if (arg5 < v0) {
            let v2 = &mut arg4;
            let v3 = split_user_lp_coin_<T0>(v2, v0 - arg5, arg8);
            0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::register_user_lp_coin(arg1, 0x2::object::uid_to_inner(&v3.id), 0x2::object::uid_to_inner(&arg0.id));
            0x2::transfer::public_transfer<UserLpCoin<T0>>(v3, v1);
        };
        create_withdraw_session<T0, T1>(arg0, arg2, v1, arg4, get_price(arg3, arg7, arg0.vault_params.collateral_source_id, arg0.vault_params.collateral_pfs_tolerance), false, arg6)
    }

    fun take_owner_locked_user_lp_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UserLpCoin<T0> {
        assert!(arg1 <= 0x2::balance::value<T0>(owner_locked_lp_balance<T0, T1>(arg0)), 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::withdraw_amount_too_big());
        UserLpCoin<T0>{
            id                 : 0x2::object::new(arg2),
            lp_balance         : 0x2::balance::split<T0>(owner_locked_lp_balance_mut<T0, T1>(arg0), arg1),
            start_timestamp_ms : 0,
            provided_value_usd : 115792089237316195423570985008687907853269984665640564039457584007913129639935,
        }
    }

    public(friend) fun upgrade_vault_version<T0, T1>(arg0: &mut Vault<T0, T1>) {
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 2;
        assert!(v0 > arg0.version, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::bad_new_vault_version());
        arg0.version = v0;
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_upgrade_vault_version(id<T0, T1>(arg0), v0);
    }

    public fun user_lp_coin_info<T0>(arg0: &UserLpCoin<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.lp_balance), arg0.start_timestamp_ms)
    }

    public(friend) fun version<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.version
    }

    public(friend) fun withdraw_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = id<T0, T1>(arg0);
        assert_package_version<T0, T1>(arg0);
        assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v1 = owner_fees_mut<T0, T1>(arg0);
        assert!(0x2::balance::value<T1>(v1) >= arg1, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::errors::not_enough_fees());
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_withdraw_fees(v0, arg1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, arg1), arg2)
    }

    public(friend) fun withdraw_request_mut<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address) : &mut WithdrawRequest<T0> {
        0x2::dynamic_field::borrow_mut<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::withdraw_request(arg1))
    }

    public(friend) fun withdraw_request_user_lp_coin_id<T0>(arg0: &WithdrawRequest<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.user_lp_coin.id)
    }

    // decompiled from Move bytecode v7
}

