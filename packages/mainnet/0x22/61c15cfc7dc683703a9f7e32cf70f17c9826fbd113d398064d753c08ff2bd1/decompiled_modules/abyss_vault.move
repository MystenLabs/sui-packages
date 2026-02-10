module 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::abyss_vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        margin_pool_id: 0x2::object::ID,
        abyss_vault_state: VaultState,
        protocol_config: 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::ProtocolConfig,
        atoken_treasury_cap: 0x2::coin::TreasuryCap<T1>,
        atoken_incentives: VaultIncentives,
        fee_manager: 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::fee_manager::FeeManager<T0>,
        underlying_decimals: u8,
    }

    struct VaultState has store {
        margin_pool_shares: u64,
    }

    struct AToken<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct VaultIncentives has store {
        sui_incentives: 0x2::balance::Balance<0x2::sui::SUI>,
        deep_incentives: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        protocol_config: 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::ProtocolConfig,
        underlying_decimals: u8,
        timestamp: u64,
    }

    struct VaultSupply has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        supplier: address,
        asset_amount: u64,
        margin_pool_shares: u64,
        atoken_amount: u64,
        timestamp: u64,
    }

    struct VaultWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        receiver: address,
        asset_amount: u64,
        margin_pool_shares: u64,
        atoken_amount: u64,
        timestamp: u64,
    }

    struct VaultFeesAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        fee_amount: u64,
        timestamp: u64,
    }

    struct VaultFeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        admin_cap_id: 0x2::object::ID,
        fees: u64,
        timestamp: u64,
    }

    struct VaultIncentivesAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        incentive_manager_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        sui_incentives: u64,
        deep_incentives: u64,
        timestamp: u64,
    }

    struct VaultIncentivesTaken has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        incentive_manager_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        sui_incentives: u64,
        deep_incentives: u64,
        timestamp: u64,
    }

    struct VaultIncentivesCompounded has copy, drop {
        vault_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        incentive_manager_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        incentives_amount: u64,
        margin_pool_shares: u64,
        atoken_amount: u64,
        timestamp: u64,
    }

    struct VaultConfigUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        vault_manager_cap_id: 0x2::object::ID,
        protocol_config: 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::ProtocolConfig,
        timestamp: u64,
    }

    public fun add_incentives<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultIncentivesManagerCap, arg5: &0x2::clock::Clock) {
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_inner(arg1);
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::validate_vault_incentives_manager_cap(arg4, vault_id<T0, T1>(arg0));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0 || 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3) > 0, 7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.atoken_incentives.sui_incentives, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.atoken_incentives.deep_incentives, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3));
        let v0 = VaultIncentivesAccrued{
            vault_id                 : 0x2::object::id<Vault<T0, T1>>(arg0),
            margin_pool_id           : arg0.margin_pool_id,
            incentive_manager_cap_id : 0x2::object::id<0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultIncentivesManagerCap>(arg4),
            asset_type               : 0x1::type_name::with_defining_ids<T0>(),
            sui_incentives           : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            deep_incentives          : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3),
            timestamp                : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<VaultIncentivesAccrued>(v0);
    }

    fun apply_fee<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::protocol_fee(&arg0.protocol_config) > 0
    }

    public fun atoken_amount_to_mp_share<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::supply_value<T1>(0x2::coin::supply_immut<T1>(&arg0.atoken_treasury_cap));
        if (v0 == 0 || arg0.abyss_vault_state.margin_pool_shares == 0) {
            arg1
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(arg0.abyss_vault_state.margin_pool_shares, v0))
        }
    }

    public fun compound_incentives<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultRegistry, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::AbyssSupplierCap, arg6: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultIncentivesManagerCap, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_inner(arg1);
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::validate_vault_incentives_manager_cap(arg6, vault_id<T0, T1>(arg0));
        assert!(0x2::coin::value<T0>(&arg4) > 0, 7);
        assert!(0x2::balance::supply_value<T1>(0x2::coin::supply_immut<T1>(&arg0.atoken_treasury_cap)) >= 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::min_atoken_supply(&arg0.protocol_config), 6);
        let v0 = 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_supplier_cap(arg5);
        let v1 = 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::protocol_fee(&arg0.protocol_config);
        let v2 = &mut arg4;
        take_fee<T0, T1>(arg0, v2, v1, arg8, arg9);
        let v3 = 0x2::coin::value<T0>(&arg4);
        let v4 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg2, arg3, v0, arg4, arg7, arg8) - 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_shares<T0>(arg2, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(v0));
        arg0.abyss_vault_state.margin_pool_shares = arg0.abyss_vault_state.margin_pool_shares + v4;
        let v5 = VaultIncentivesCompounded{
            vault_id                 : 0x2::object::id<Vault<T0, T1>>(arg0),
            margin_pool_id           : arg0.margin_pool_id,
            incentive_manager_cap_id : 0x2::object::id<0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultIncentivesManagerCap>(arg6),
            asset_type               : 0x1::type_name::with_defining_ids<T0>(),
            incentives_amount        : v3,
            margin_pool_shares       : v4,
            atoken_amount            : mp_share_to_atoken_amount<T0, T1>(arg0, v4),
            timestamp                : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<VaultIncentivesCompounded>(v5);
        v3
    }

    public fun convert_to_assets<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply_with_interest<T0>(arg1, arg3);
        let v1 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply_shares<T0>(arg1);
        if (v1 == 0 || v0 == 0) {
            atoken_amount_to_mp_share<T0, T1>(arg0, arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(atoken_amount_to_mp_share<T0, T1>(arg0, arg2), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v0, v1))
        }
    }

    public fun convert_to_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply_with_interest<T0>(arg1, arg3);
        let v1 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply_shares<T0>(arg1);
        let v2 = if (v0 == 0 || v1 == 0) {
            arg2
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v1, v0))
        };
        mp_share_to_atoken_amount<T0, T1>(arg0, v2)
    }

    public fun create_vault<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &mut 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultRegistry, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::ProtocolConfig, arg4: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::AbyssAdminCap, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::MetadataCap<AToken<T0>>, 0x2::object::ID) {
        assert!(arg9 >= 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::abyss_constants::min_underlying_decimals() && arg9 <= 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::abyss_constants::max_underlying_decimals(), 9);
        let (v0, v1) = 0x2::coin_registry::new_currency<AToken<T0>>(arg2, arg9, arg6, arg5, arg7, arg8, arg11);
        let v2 = VaultState{margin_pool_shares: 0};
        let v3 = VaultIncentives{
            sui_incentives  : 0x2::balance::zero<0x2::sui::SUI>(),
            deep_incentives : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
        };
        let v4 = Vault<T0, AToken<T0>>{
            id                  : 0x2::object::new(arg11),
            margin_pool_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg0),
            abyss_vault_state   : v2,
            protocol_config     : arg3,
            atoken_treasury_cap : v1,
            atoken_incentives   : v3,
            fee_manager         : 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::fee_manager::new_fee_manager<T0>(arg11),
            underlying_decimals : arg9,
        };
        let v5 = 0x1::type_name::with_defining_ids<T0>();
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::register_vault(arg1, arg4, v5, 0x2::object::id<Vault<T0, AToken<T0>>>(&v4), arg10, arg11);
        let v6 = VaultCreated{
            vault_id            : 0x2::object::id<Vault<T0, AToken<T0>>>(&v4),
            margin_pool_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg0),
            admin_cap_id        : 0x2::object::id<0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::AbyssAdminCap>(arg4),
            asset_type          : v5,
            protocol_config     : arg3,
            underlying_decimals : arg9,
            timestamp           : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<VaultCreated>(v6);
        0x2::transfer::public_share_object<Vault<T0, AToken<T0>>>(v4);
        (0x2::coin_registry::finalize<AToken<T0>>(v0, arg11), 0x2::object::id<Vault<T0, AToken<T0>>>(&v4))
    }

    public fun incentives_balance<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.atoken_incentives.sui_incentives), 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.atoken_incentives.deep_incentives))
    }

    public fun margin_pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.margin_pool_id
    }

    public fun max_supply<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply_cap<T0>(arg0);
        let v1 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply_with_interest<T0>(arg0, arg1);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun max_withdraw<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_borrow<T0>(arg0);
        let v1 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply_with_interest<T0>(arg0, arg1);
        if (v1 > v0) {
            v1 - v0
        } else {
            0
        }
    }

    public fun mp_share_to_atoken_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::supply_value<T1>(0x2::coin::supply_immut<T1>(&arg0.atoken_treasury_cap));
        if (arg0.abyss_vault_state.margin_pool_shares == 0 || v0 == 0) {
            arg1
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v0, arg0.abyss_vault_state.margin_pool_shares))
        }
    }

    public fun supply<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_inner(arg2);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 8);
        assert!(v0 <= max_supply<T0>(arg1, arg7), 2);
        let v1 = 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_supplier_cap(arg5);
        let v2 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg1, arg3, v1, arg4, arg6, arg7) - 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_shares<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(v1));
        let v3 = 0x2::coin::mint<T1>(&mut arg0.atoken_treasury_cap, mp_share_to_atoken_amount<T0, T1>(arg0, v2), arg8);
        arg0.abyss_vault_state.margin_pool_shares = arg0.abyss_vault_state.margin_pool_shares + v2;
        let v4 = VaultSupply{
            vault_id           : 0x2::object::id<Vault<T0, T1>>(arg0),
            margin_pool_id     : arg0.margin_pool_id,
            asset_type         : 0x1::type_name::with_defining_ids<T0>(),
            supplier           : 0x2::tx_context::sender(arg8),
            asset_amount       : v0,
            margin_pool_shares : v2,
            atoken_amount      : 0x2::coin::value<T1>(&v3),
            timestamp          : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<VaultSupply>(v4);
        v3
    }

    fun take_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (apply_fee<T0, T1>(arg0)) {
            let v0 = VaultFeesAccrued{
                vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
                margin_pool_id : arg0.margin_pool_id,
                asset_type     : 0x1::type_name::with_defining_ids<T0>(),
                fee_amount     : 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::fee_manager::take_fee<T0>(&mut arg0.fee_manager, arg1, arg2, arg4),
                timestamp      : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<VaultFeesAccrued>(v0);
        };
    }

    public fun take_incentives<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultRegistry, arg2: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultIncentivesManagerCap, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_inner(arg1);
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::validate_vault_incentives_manager_cap(arg2, vault_id<T0, T1>(arg0));
        let v0 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.atoken_incentives.deep_incentives);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.atoken_incentives.sui_incentives);
        let v2 = &mut arg0.atoken_incentives.sui_incentives;
        let v3 = if (0x1::option::is_some<u64>(&arg3)) {
            let v4 = 0x1::option::destroy_some<u64>(arg3);
            assert!(v4 <= v1, 4);
            0x1::option::some<u64>(v4)
        } else {
            0x1::option::destroy_none<u64>(arg3);
            0x1::option::none<u64>()
        };
        let v5 = v3;
        let v6 = if (0x1::option::is_some<u64>(&v5)) {
            0x1::option::destroy_some<u64>(v5)
        } else {
            0x1::option::destroy_none<u64>(v5);
            v1
        };
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v2, v6), arg6);
        let v8 = &mut arg0.atoken_incentives.deep_incentives;
        let v9 = if (0x1::option::is_some<u64>(&arg4)) {
            let v10 = 0x1::option::destroy_some<u64>(arg4);
            assert!(v10 <= v0, 5);
            0x1::option::some<u64>(v10)
        } else {
            0x1::option::destroy_none<u64>(arg4);
            0x1::option::none<u64>()
        };
        let v11 = v9;
        let v12 = if (0x1::option::is_some<u64>(&v11)) {
            0x1::option::destroy_some<u64>(v11)
        } else {
            0x1::option::destroy_none<u64>(v11);
            v0
        };
        let v13 = 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8, v12), arg6);
        let v14 = VaultIncentivesTaken{
            vault_id                 : 0x2::object::id<Vault<T0, T1>>(arg0),
            margin_pool_id           : arg0.margin_pool_id,
            incentive_manager_cap_id : 0x2::object::id<0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultIncentivesManagerCap>(arg2),
            asset_type               : 0x1::type_name::with_defining_ids<T0>(),
            sui_incentives           : 0x2::coin::value<0x2::sui::SUI>(&v7),
            deep_incentives          : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v13),
            timestamp                : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<VaultIncentivesTaken>(v14);
        (v7, v13)
    }

    public fun total_assets<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2::clock::Clock) : u64 {
        convert_to_assets<T0, T1>(arg0, arg1, total_supply<T0, T1>(arg0), arg2)
    }

    public fun total_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::supply_value<T1>(0x2::coin::supply_immut<T1>(&arg0.atoken_treasury_cap))
    }

    public fun update_protocol_config<T0>(arg0: &mut Vault<T0, AToken<T0>>, arg1: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultRegistry, arg2: 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::config::ProtocolConfig, arg3: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultManagerCap, arg4: &0x2::clock::Clock) {
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_inner(arg1);
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::validate_vault_manager_cap(arg3, vault_id<T0, AToken<T0>>(arg0));
        arg0.protocol_config = arg2;
        let v0 = VaultConfigUpdated{
            vault_id             : vault_id<T0, AToken<T0>>(arg0),
            vault_manager_cap_id : 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::vault_manager_cap_id(arg3),
            protocol_config      : arg2,
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultConfigUpdated>(v0);
    }

    public(friend) fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_inner(arg2);
        let v0 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = convert_to_assets<T0, T1>(arg0, arg1, v0, arg6);
        assert!(v1 <= max_withdraw<T0>(arg1, arg6), 3);
        let v2 = 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::load_supplier_cap(arg5);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg1, arg3, v2, 0x1::option::some<u64>(v1), arg6, arg7);
        let v4 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_shares<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(v2)) - 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_shares<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(v2));
        0x2::coin::burn<T1>(&mut arg0.atoken_treasury_cap, arg4);
        arg0.abyss_vault_state.margin_pool_shares = arg0.abyss_vault_state.margin_pool_shares - v4;
        let v5 = VaultWithdraw{
            vault_id           : 0x2::object::id<Vault<T0, T1>>(arg0),
            margin_pool_id     : arg0.margin_pool_id,
            asset_type         : 0x1::type_name::with_defining_ids<T0>(),
            receiver           : 0x2::tx_context::sender(arg7),
            asset_amount       : 0x2::coin::value<T0>(&v3),
            margin_pool_shares : v4,
            atoken_amount      : v0,
            timestamp          : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<VaultWithdraw>(v5);
        v3
    }

    public fun withdraw_protocol_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::AbyssAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::fee_manager::withdraw_protocol_fees<T0>(&mut arg0.fee_manager, arg3);
        let v1 = VaultFeesCollected{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            margin_pool_id : arg0.margin_pool_id,
            asset_type     : 0x1::type_name::with_defining_ids<T0>(),
            admin_cap_id   : 0x2::object::id<0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::vault_registry::AbyssAdminCap>(arg1),
            fees           : 0x2::coin::value<T0>(&v0),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VaultFeesCollected>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

