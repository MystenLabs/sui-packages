module 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank {
    struct ProtocolFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DisabledLendingKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ATokenBalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BToken<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct Bank<phantom T0> has store, key {
        id: 0x2::object::UID,
        funds_available: 0x2::balance::Balance<T0>,
        lending: 0x1::option::Option<Lending>,
        min_token_block_size: u64,
        btoken_supply: 0x2::balance::Supply<BToken<T0>>,
        metadata_cap: 0x2::coin_registry::MetadataCap<BToken<T0>>,
        extension_fields: 0x2::bag::Bag,
    }

    struct Lending has store {
        target_utilisation_bps: u16,
        utilisation_buffer_bps: u16,
        referral: 0x1::option::Option<0x2::object::ID>,
        vault_id: 0x2::object::ID,
    }

    struct NewBankEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        btoken_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    struct MintBTokenEvent has copy, drop, store {
        user: address,
        bank_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        deposited_amount: u64,
        minted_amount: u64,
    }

    struct BurnBTokenEvent has copy, drop, store {
        user: address,
        bank_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        withdrawn_amount: u64,
        burned_amount: u64,
    }

    struct DeployEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        deployed_amount: u64,
        shares_minted: u64,
    }

    struct RecallEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        recalled_amount: u64,
        shares_burned: u64,
    }

    struct BankLiquidityEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        funds_available: u64,
        funds_deployed: u64,
    }

    struct NeedsRebalance has copy, drop, store {
        needs_rebalance: bool,
    }

    public fun burn_btoken<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &mut 0x2::coin::Coin<BToken<T0>>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        if (arg8 == 0) {
            return 0x2::coin::zero<T0>(arg10)
        };
        assert!(0x2::coin::value<BToken<T0>>(arg7) != 0, 12);
        assert!(0x2::coin::value<BToken<T0>>(arg7) >= arg8, 13);
        let v0 = 0x2::balance::supply_value<BToken<T0>>(&arg0.btoken_supply) - arg8;
        if (v0 < 1000) {
            arg8 = arg8 - 1000 - v0;
        };
        assert!(arg8 > 0, 14);
        let v1 = from_btokens<T0, T1>(arg0, arg1, arg4, arg5, arg8, arg9);
        0x2::balance::decrease_supply<BToken<T0>>(&mut arg0.btoken_supply, 0x2::coin::into_balance<BToken<T0>>(0x2::coin::split<BToken<T0>>(arg7, arg8, arg10)));
        let v2 = 0x2::balance::value<T0>(&arg0.funds_available);
        assert!(v2 + 1 >= v1, 9);
        let v3 = 0x1::u64::min(v1, v2);
        assert!(v3 > 0, 15);
        let v4 = BurnBTokenEvent{
            user             : 0x2::tx_context::sender(arg10),
            bank_id          : 0x2::object::id<Bank<T0>>(arg0),
            vault_id         : 0x1::option::borrow<Lending>(&arg0.lending).vault_id,
            withdrawn_amount : v3,
            burned_amount    : arg8,
        };
        0x2::event::emit<BurnBTokenEvent>(v4);
        let v5 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0>>(arg0),
            funds_available : 0x2::balance::value<T0>(&arg0.funds_available),
            funds_deployed  : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg4, arg5, arg9)),
        };
        0x2::event::emit<BankLiquidityEvent>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds_available, v3), arg10)
    }

    public fun burn_btokens<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &mut 0x2::coin::Coin<BToken<T0>>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        let v0 = from_btokens<T0, T1>(arg0, arg1, arg4, arg5, arg8, arg9);
        if (0x2::balance::value<T0>(&arg0.funds_available) < v0) {
            prepare_for_pending_withdraw<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, v0, arg9, arg10);
        };
        burn_btoken<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun claim_fees<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        let v0 = ProtocolFeeKey{dummy_field: false};
        let v1 = 0x2::coin::from_balance<BToken<T0>>(0x2::balance::withdraw_all<BToken<T0>>(0x2::dynamic_field::borrow_mut<ProtocolFeeKey, 0x2::balance::Balance<BToken<T0>>>(&mut arg0.id, v0)), arg9);
        let v2 = &mut v1;
        let v3 = burn_btoken<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v2, 0x2::coin::value<BToken<T0>>(&v1), arg8, arg9);
        if (0x2::coin::value<BToken<T0>>(&v1) > 0) {
            let v4 = ProtocolFeeKey{dummy_field: false};
            0x2::balance::join<BToken<T0>>(0x2::dynamic_field::borrow_mut<ProtocolFeeKey, 0x2::balance::Balance<BToken<T0>>>(&mut arg0.id, v4), 0x2::coin::into_balance<BToken<T0>>(v1));
        } else {
            0x2::coin::destroy_zero<BToken<T0>>(v1);
        };
        distribute_coins<T0>(v3, arg7, arg9);
    }

    public fun compound_bank_incentives<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultIncentivesManagerCap, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg10));
        assert!(0x1::option::is_some<Lending>(&arg0.lending), 7);
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::compound_incentives<T0, T1>(arg2, arg4, arg3, arg5, arg8, arg6, arg7, 0x1::option::none<0x2::object::ID>(), arg9, arg10);
        let v0 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0>>(arg0),
            funds_available : 0x2::balance::value<T0>(&arg0.funds_available),
            funds_deployed  : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg2, arg3, arg9)),
        };
        0x2::event::emit<BankLiquidityEvent>(v0);
    }

    public fun create_bank<T0, T1>(arg0: &mut 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::Registry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : Bank<T0> {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::string::utf8(b"bToken ");
        0x1::string::append(&mut v0, 0x2::coin_registry::symbol<T0>(arg3));
        let v1 = 0x1::string::from_ascii(0x1::ascii::string(b"b"));
        0x1::string::append(&mut v1, 0x2::coin_registry::symbol<T0>(arg3));
        let (v2, v3) = 0x2::coin_registry::new_currency<BToken<T0>>(arg2, 9, v1, v0, 0x1::string::utf8(b"Turbos OMM bToken"), 0x1::string::utf8(b"https://app.turbos.finance/icon/btoken.png"), arg5);
        let v4 = Bank<T0>{
            id                   : 0x2::object::new(arg5),
            funds_available      : 0x2::balance::zero<T0>(),
            lending              : 0x1::option::none<Lending>(),
            min_token_block_size : 1000000000,
            btoken_supply        : 0x2::coin::treasury_into_supply<BToken<T0>>(v3),
            metadata_cap         : 0x2::coin_registry::finalize<BToken<T0>>(v2, arg5),
            extension_fields     : 0x2::bag::new(arg5),
        };
        let v5 = NewBankEvent{
            bank_id     : 0x2::object::id<Bank<T0>>(&v4),
            coin_type   : 0x1::type_name::with_defining_ids<T0>(),
            btoken_type : 0x1::type_name::with_defining_ids<BToken<T0>>(),
            vault_id    : 0x2::object::id<0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>>(arg4),
        };
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::register_bank(arg0, v5.bank_id, v5.coin_type, v5.btoken_type, v5.vault_id);
        0x2::event::emit<NewBankEvent>(v5);
        v4
    }

    public fun create_bank_and_share<T0, T1>(arg0: &mut 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::Registry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Bank<T0>>(create_bank<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    fun deploy<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Lending>(&arg0.lending), 7);
        if (arg6 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.funds_available) >= arg6, 9);
        let v0 = 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::supply<T0, T1>(arg3, arg4, arg1, arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds_available, arg6), arg8), arg5, 0x1::option::borrow<Lending>(&arg0.lending).referral, arg7, arg8);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = ATokenBalanceKey<T1>{dummy_field: false};
        0x2::balance::join<T1>(0x2::bag::borrow_mut<ATokenBalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.extension_fields, v2), 0x2::coin::into_balance<T1>(v0));
        let v3 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0>>(arg0),
            funds_available : 0x2::balance::value<T0>(&arg0.funds_available),
            funds_deployed  : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg3, arg4, arg7)),
        };
        0x2::event::emit<BankLiquidityEvent>(v3);
        let v4 = DeployEvent{
            bank_id         : 0x2::object::id<Bank<T0>>(arg0),
            vault_id        : 0x1::option::borrow<Lending>(&arg0.lending).vault_id,
            deployed_amount : 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::convert_to_assets<T0, T1>(arg3, arg4, v1, arg7),
            shares_minted   : v1,
        };
        0x2::event::emit<DeployEvent>(v4);
    }

    public fun disable_lending<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg8));
        assert!(0x1::option::is_some<Lending>(&arg0.lending), 7);
        let Lending {
            target_utilisation_bps : _,
            utilisation_buffer_bps : _,
            referral               : _,
            vault_id               : _,
        } = 0x1::option::extract<Lending>(&mut arg0.lending);
        let v4 = ATokenBalanceKey<T1>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<ATokenBalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.extension_fields, v4);
        if (0x2::balance::value<T1>(v5) > 0) {
            0x2::balance::join<T0>(&mut arg0.funds_available, 0x2::coin::into_balance<T0>(0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg4, arg5, arg2, arg3, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(v5), arg8), arg6, arg7, arg8)));
        };
        let v6 = ATokenBalanceKey<T1>{dummy_field: false};
        0x2::balance::destroy_zero<T1>(0x2::bag::remove<ATokenBalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.extension_fields, v6));
        let v7 = DisabledLendingKey{dummy_field: false};
        0x2::bag::add<DisabledLendingKey, bool>(&mut arg0.extension_fields, v7, true);
    }

    fun distribute_coins<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::get_fee_receivers(arg1);
        let v2 = 0x1::vector::length<u64>(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::fee_weights(v1));
        let v3 = 0;
        while (v3 < v2) {
            let v4 = if (v3 == v2 - 1) {
                0x2::balance::withdraw_all<T0>(&mut v0)
            } else {
                0x2::balance::split<T0>(&mut v0, (0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::base_math::safe_mul_div(0x2::balance::value<T0>(&v0), *0x1::vector::borrow<u64>(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::fee_weights(v1), v3), 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::fee_total_weight(v1)) as u64))
            };
            let v5 = v4;
            if (0x2::balance::value<T0>(&v5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), *0x1::vector::borrow<address>(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::registry::fee_receivers(v1), v3));
            } else {
                0x2::balance::destroy_zero<T0>(v5);
            };
            v3 = v3 + 1;
        };
        0x2::balance::destroy_zero<T0>(v0);
    }

    public(friend) fun effective_utilisation_bps<T0>(arg0: &Bank<T0>, arg1: u64) : u64 {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank_math::compute_utilisation_bps(0x2::balance::value<T0>(&arg0.funds_available), arg1)
    }

    public fun from_btokens<T0, T1>(arg0: &Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        if (0x1::option::is_some<Lending>(&arg0.lending)) {
            let (v1, v2) = get_btoken_ratio<T0, T1>(arg0, arg2, arg3, arg5);
            0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::div(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::mul(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(arg4), v1), v2))
        } else {
            arg4
        }
    }

    public fun funds_available<T0>(arg0: &Bank<T0>) : &0x2::balance::Balance<T0> {
        &arg0.funds_available
    }

    public(friend) fun funds_deployed<T0, T1>(arg0: &Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::Decimal {
        if (0x1::option::is_some<Lending>(&arg0.lending)) {
            let v1 = ATokenBalanceKey<T1>{dummy_field: false};
            0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::convert_to_assets<T0, T1>(arg1, arg2, 0x2::balance::value<T1>(0x2::bag::borrow<ATokenBalanceKey<T1>, 0x2::balance::Balance<T1>>(&arg0.extension_fields, v1)), arg3))
        } else {
            0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(0)
        }
    }

    public(friend) fun get_btoken_ratio<T0, T1>(arg0: &Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) : (0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::Decimal, 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::Decimal) {
        let v0 = 0x2::balance::supply_value<BToken<T0>>(&arg0.btoken_supply);
        if (0x1::option::is_some<Lending>(lending<T0>(arg0)) && v0 > 0) {
            (total_funds<T0, T1>(arg0, arg1, arg2, arg3), 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(v0))
        } else {
            (0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(1), 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(1))
        }
    }

    public fun init_lending<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg3: u16, arg4: u16, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg7));
        assert!(0x1::option::is_none<Lending>(&arg0.lending), 5);
        assert!(arg3 + arg4 <= 10000, 3);
        assert!(arg3 >= arg4, 4);
        let v0 = ATokenBalanceKey<T1>{dummy_field: false};
        0x2::bag::add<ATokenBalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.extension_fields, v0, 0x2::balance::zero<T1>());
        let v1 = Lending{
            target_utilisation_bps : arg3,
            utilisation_buffer_bps : arg4,
            referral               : arg5,
            vault_id               : 0x2::object::id<0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>>(arg2),
        };
        0x1::option::fill<Lending>(&mut arg0.lending, v1);
    }

    public fun lending<T0>(arg0: &Bank<T0>) : &0x1::option::Option<Lending> {
        &arg0.lending
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun mint_btoken<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &mut 0x2::coin::Coin<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BToken<T0>> {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        if (0x2::balance::supply_value<BToken<T0>>(&arg0.btoken_supply) == 0) {
            assert!(arg8 > 1000, 16);
        } else {
            assert!(arg8 > 0, 11);
        };
        assert!(0x2::coin::value<T0>(arg7) >= arg8, 10);
        let v0 = to_btokens<T0, T1>(arg0, arg1, arg4, arg5, arg8, arg9);
        assert!(v0 > 0, 18);
        let v1 = MintBTokenEvent{
            user             : 0x2::tx_context::sender(arg10),
            bank_id          : 0x2::object::id<Bank<T0>>(arg0),
            vault_id         : 0x1::option::borrow<Lending>(&arg0.lending).vault_id,
            deposited_amount : arg8,
            minted_amount    : v0,
        };
        0x2::event::emit<MintBTokenEvent>(v1);
        0x2::balance::join<T0>(&mut arg0.funds_available, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg7, arg8, arg10)));
        let v2 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0>>(arg0),
            funds_available : 0x2::balance::value<T0>(&arg0.funds_available),
            funds_deployed  : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg4, arg5, arg9)),
        };
        0x2::event::emit<BankLiquidityEvent>(v2);
        0x2::coin::from_balance<BToken<T0>>(0x2::balance::increase_supply<BToken<T0>>(&mut arg0.btoken_supply, v0), arg10)
    }

    public fun mint_btokens<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &mut 0x2::coin::Coin<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BToken<T0>> {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        mint_btoken<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun move_fees<T0>(arg0: &mut Bank<T0>, arg1: 0x2::balance::Balance<BToken<T0>>) {
        let v0 = ProtocolFeeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ProtocolFeeKey>(&arg0.id, v0)) {
            let v1 = ProtocolFeeKey{dummy_field: false};
            0x2::dynamic_field::add<ProtocolFeeKey, 0x2::balance::Balance<BToken<T0>>>(&mut arg0.id, v1, 0x2::balance::zero<BToken<T0>>());
        };
        let v2 = ProtocolFeeKey{dummy_field: false};
        0x2::balance::join<BToken<T0>>(0x2::dynamic_field::borrow_mut<ProtocolFeeKey, 0x2::balance::Balance<BToken<T0>>>(&mut arg0.id, v2), arg1);
    }

    public fun needs_rebalance<T0, T1>(arg0: &Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) : NeedsRebalance {
        if (0x1::option::is_none<Lending>(&arg0.lending)) {
            return NeedsRebalance{needs_rebalance: false}
        };
        let v0 = effective_utilisation_bps<T0>(arg0, 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg1, arg2, arg3)));
        let v1 = target_utilisation_bps_unchecked<T0>(arg0);
        let v2 = utilisation_buffer_bps_unchecked<T0>(arg0);
        let v3 = v0 <= v1 + v2 && v0 >= v1 - v2;
        NeedsRebalance{needs_rebalance: !v3}
    }

    public(friend) fun prepare_for_pending_withdraw<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<Lending>(&arg0.lending)) {
            return
        };
        let v0 = 0x1::option::borrow<Lending>(&arg0.lending);
        let v1 = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank_math::compute_recall_for_pending_withdraw(0x2::balance::value<T0>(&arg0.funds_available), arg6, 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg3, arg4, arg7)), (v0.target_utilisation_bps as u64), (v0.utilisation_buffer_bps as u64));
        withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg7, arg8);
    }

    public fun rebalance<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        if (0x1::option::is_none<Lending>(&arg0.lending)) {
            return
        };
        let v0 = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg4, arg5, arg7));
        let v1 = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank_math::compute_utilisation_bps(0x2::balance::value<T0>(&arg0.funds_available), v0);
        let v2 = target_utilisation_bps_unchecked<T0>(arg0);
        let v3 = utilisation_buffer_bps<T0>(arg0);
        if (v1 < v2 - v3) {
            let v4 = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank_math::compute_amount_to_deploy(0x2::balance::value<T0>(&arg0.funds_available), v0, v2);
            deploy<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, v4, arg7, arg8);
        } else if (v1 > v2 + v3) {
            let v5 = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank_math::compute_amount_to_recall(0x2::balance::value<T0>(&arg0.funds_available), 0, v0, v2);
            withdraw<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, v5, arg7, arg8);
        };
    }

    public fun set_min_token_block_size<T0>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 >= 1000000000, 17);
        arg0.min_token_block_size = arg2;
    }

    public fun set_referral<T0>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x1::option::borrow_mut<Lending>(&mut arg0.lending).referral = arg2;
    }

    public fun set_utilisation_bps<T0>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: u16, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg4));
        assert!(0x1::option::is_some<Lending>(&arg0.lending), 7);
        assert!(arg2 + arg3 <= 10000, 3);
        assert!(arg2 >= arg3, 4);
        let v0 = 0x1::option::borrow_mut<Lending>(&mut arg0.lending);
        v0.target_utilisation_bps = arg2;
        v0.utilisation_buffer_bps = arg3;
    }

    public fun target_utilisation_bps<T0>(arg0: &Bank<T0>) : u64 {
        if (0x1::option::is_some<Lending>(&arg0.lending)) {
            target_utilisation_bps_unchecked<T0>(arg0)
        } else {
            0
        }
    }

    public fun target_utilisation_bps_unchecked<T0>(arg0: &Bank<T0>) : u64 {
        (0x1::option::borrow<Lending>(&arg0.lending).target_utilisation_bps as u64)
    }

    public fun to_btokens<T0, T1>(arg0: &Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        if (0x1::option::is_some<Lending>(&arg0.lending)) {
            let (v1, v2) = get_btoken_ratio<T0, T1>(arg0, arg2, arg3, arg5);
            0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::div(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::mul(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(arg4), v2), v1))
        } else {
            arg4
        }
    }

    public(friend) fun total_funds<T0, T1>(arg0: &Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::Decimal {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::add(funds_deployed<T0, T1>(arg0, arg1, arg2, arg3), 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(0x2::balance::value<T0>(&arg0.funds_available)))
    }

    public fun update_bank_metadata<T0>(arg0: &mut Bank<T0>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &mut 0x2::coin_registry::Currency<BToken<T0>>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg7));
        0x2::coin_registry::set_name<BToken<T0>>(arg3, &arg0.metadata_cap, arg4);
        0x2::coin_registry::set_description<BToken<T0>>(arg3, &arg0.metadata_cap, arg5);
        0x2::coin_registry::set_icon_url<BToken<T0>>(arg3, &arg0.metadata_cap, arg6);
    }

    public fun utilisation_buffer_bps<T0>(arg0: &Bank<T0>) : u64 {
        if (0x1::option::is_some<Lending>(&arg0.lending)) {
            utilisation_buffer_bps_unchecked<T0>(arg0)
        } else {
            0
        }
    }

    public fun utilisation_buffer_bps_unchecked<T0>(arg0: &Bank<T0>) : u64 {
        (0x1::option::borrow<Lending>(&arg0.lending).utilisation_buffer_bps as u64)
    }

    fun withdraw<T0, T1>(arg0: &mut Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg6 == 0) {
            return
        };
        let v0 = ATokenBalanceKey<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<ATokenBalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.extension_fields, v0);
        let v2 = 0x1::u64::min(0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::convert_to_shares<T0, T1>(arg3, arg4, 0x1::u64::max(arg6, arg0.min_token_block_size), arg7), 0x2::balance::value<T1>(v1));
        let v3 = 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg3, arg4, arg1, arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, v2), arg8), arg5, arg7, arg8);
        0x2::balance::join<T0>(&mut arg0.funds_available, 0x2::coin::into_balance<T0>(v3));
        let v4 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0>>(arg0),
            funds_available : 0x2::balance::value<T0>(&arg0.funds_available),
            funds_deployed  : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::floor(funds_deployed<T0, T1>(arg0, arg3, arg4, arg7)),
        };
        0x2::event::emit<BankLiquidityEvent>(v4);
        let v5 = RecallEvent{
            bank_id         : 0x2::object::id<Bank<T0>>(arg0),
            vault_id        : 0x1::option::borrow<Lending>(&arg0.lending).vault_id,
            recalled_amount : 0x2::coin::value<T0>(&v3),
            shares_burned   : v2,
        };
        0x2::event::emit<RecallEvent>(v5);
    }

    public fun withdraw_referral_fees<T0>(arg0: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw_referral_fees<T0>(arg2, arg1, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

