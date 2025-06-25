module 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::alpha_router {
    struct ALPHA_ROUTER has drop {
        dummy_field: bool,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
        admin_address: address,
    }

    struct IntermediateStorage has key {
        id: 0x2::object::UID,
    }

    struct MemeboxManager has key {
        id: 0x2::object::UID,
        super_admin: address,
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        created_at: u64,
        total_trades: u64,
        total_volume_usdc: u64,
        intermediate_storage_id: 0x2::object::ID,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct MemeboxManagerCreated has copy, drop {
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Swapped has copy, drop {
        dex_type: u8,
        trade_id: u64,
        timestamp: u64,
    }

    struct Traded has copy, drop {
        trade_id: u64,
        trade_type: u8,
        usdc_amount: u64,
        meme_amount: u64,
        price: u64,
        trader: address,
        timestamp: u64,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun after_execute<T0>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::USDCVault, arg3: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::AdminCap, arg4: &mut 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::VaultManager, arg5: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: 0x2::coin::Coin<T0>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        verify_admin_permission(arg0, arg1, 0x2::tx_context::sender(arg9));
        assert!(0x2::object::id<IntermediateStorage>(arg6) == arg0.intermediate_storage_id, 1);
        store_intermediate_coin<T0>(arg6, arg7);
        if (arg8) {
            if (is_usdc<T0>()) {
                let v0 = extract_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, 0x2::coin::value<T0>(&arg7), arg9);
                0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::deposit(arg2, arg3, v0, arg9);
            } else {
                let v1 = extract_intermediate_coin<T0>(arg6, 0x2::coin::value<T0>(&arg7), arg9);
                0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::deposit<T0>(arg4, arg5, v1, arg9);
            };
        };
    }

    fun before_execute<T0>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::USDCVault, arg3: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::AdminCap, arg4: &mut 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::VaultManager, arg5: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_admin_permission(arg0, arg1, 0x2::tx_context::sender(arg9));
        assert!(0x2::object::id<IntermediateStorage>(arg6) == arg0.intermediate_storage_id, 1);
        assert!(arg7 > 0, 3);
        if (arg8) {
            if (is_usdc<T0>()) {
                store_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::withdraw(arg2, arg3, arg7, arg9));
            } else {
                store_intermediate_coin<T0>(arg6, 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::withdraw<T0>(arg4, arg5, arg7, arg9));
            };
        };
        extract_intermediate_coin<T0>(arg6, arg7, arg9)
    }

    public entry fun create_admin_caps_batch(arg0: &MemeboxManager, arg1: &SuperAdminCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = AdminCap{
                id            : 0x2::object::new(arg3),
                manager_id    : 0x2::object::id<MemeboxManager>(arg0),
                admin_address : v1,
            };
            let v3 = AdminCapCreated{
                admin_cap_id : 0x2::object::id<AdminCap>(&v2),
                admin        : v1,
                manager_id   : 0x2::object::id<MemeboxManager>(arg0),
                timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<AdminCapCreated>(v3);
            0x2::transfer::transfer<AdminCap>(v2, v1);
            v0 = v0 + 1;
        };
    }

    fun create_manager(arg0: &mut 0x2::tx_context::TxContext) : (MemeboxManager, SuperAdminCap) {
        let v0 = IntermediateStorage{id: 0x2::object::new(arg0)};
        let v1 = MemeboxManager{
            id                      : 0x2::object::new(arg0),
            super_admin             : 0x2::tx_context::sender(arg0),
            revoked_caps            : 0x2::table::new<0x2::object::ID, bool>(arg0),
            created_at              : 0x2::tx_context::epoch_timestamp_ms(arg0),
            total_trades            : 0,
            total_volume_usdc       : 0,
            intermediate_storage_id : 0x2::object::id<IntermediateStorage>(&v0),
        };
        let v2 = SuperAdminCap{
            id         : 0x2::object::new(arg0),
            manager_id : 0x2::object::id<MemeboxManager>(&v1),
        };
        0x2::transfer::share_object<IntermediateStorage>(v0);
        let v3 = MemeboxManagerCreated{
            manager_id : 0x2::object::id<MemeboxManager>(&v1),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<MemeboxManagerCreated>(v3);
        (v1, v2)
    }

    public entry fun execute_cetus_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::USDCVault, arg3: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::AdminCap, arg4: &mut 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::VaultManager, arg5: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: u64, arg8: bool, arg9: bool, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg13) {
            let v1 = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg15);
            let v2 = 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::cetus_warpper::swap_a2b<T0, T1>(arg10, arg11, arg12, v1, arg14, arg15);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v2, arg9, arg15);
            0x2::coin::value<T1>(&v2)
        } else {
            let v3 = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg15);
            let v4 = 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::cetus_warpper::swap_b2a<T0, T1>(arg10, arg11, arg12, v3, arg14, arg15);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, arg9, arg15);
            0x2::coin::value<T0>(&v4)
        }
    }

    fun extract_intermediate_coin<T0>(arg0: &mut IntermediateStorage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0);
        assert!(0x2::coin::value<T0>(v1) >= arg1, 2);
        0x2::coin::split<T0>(v1, arg1, arg2)
    }

    public fun get_intermediate_balance<T0>(arg0: &IntermediateStorage) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::coin::value<T0>(0x2::dynamic_field::borrow<CoinKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun get_intermediate_storage_id(arg0: &MemeboxManager) : 0x2::object::ID {
        arg0.intermediate_storage_id
    }

    public fun get_manager_info(arg0: &MemeboxManager) : (address, u64, u64, u64) {
        (arg0.super_admin, arg0.total_trades, arg0.total_volume_usdc, arg0.created_at)
    }

    fun get_next_trade_id(arg0: &0x2::tx_context::TxContext) : u64 {
        0x2::tx_context::epoch(arg0) * 1000000 + 0x2::tx_context::epoch_timestamp_ms(arg0) % 1000000
    }

    public fun get_super_admin(arg0: &MemeboxManager) : address {
        arg0.super_admin
    }

    public fun get_trading_stats<T0>(arg0: &MemeboxManager, arg1: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::USDCVault, arg2: &0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::VaultManager) : (u64, u64, u64, u64) {
        (0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::usdc_vault::get_balance(arg1), 0x31d50d85423ddbe1a7e3e522689a8117bf6159573fa2b7d2f8f59eff6f816d0e::meme_vault::get_vault_info<T0>(arg2), arg0.total_trades, arg0.total_volume_usdc)
    }

    fun init(arg0: ALPHA_ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_manager(arg1);
        0x2::transfer::share_object<MemeboxManager>(v0);
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_admin_cap_id_revoked(arg0: &MemeboxManager, arg1: 0x2::object::ID) : bool {
        is_admin_cap_revoked(arg0, arg1)
    }

    fun is_admin_cap_revoked(arg0: &MemeboxManager, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_caps, arg1)
    }

    fun is_usdc<T0>() : bool {
        0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::type_name::into_string(0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>())
    }

    public fun is_valid_admin_cap(arg0: &MemeboxManager, arg1: &AdminCap) : bool {
        arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0) && !is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1))
    }

    public entry fun revoke_admin_permissions_batch(arg0: &mut MemeboxManager, arg1: &SuperAdminCap, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_caps, v1)) {
                0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_caps, v1, true);
                let v2 = AdminCapRevoked{
                    admin_cap_id : v1,
                    admin        : @0x0,
                    manager_id   : 0x2::object::id<MemeboxManager>(arg0),
                    timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
                };
                0x2::event::emit<AdminCapRevoked>(v2);
            };
            v0 = v0 + 1;
        };
    }

    fun store_intermediate_coin<T0>(arg0: &mut IntermediateStorage, arg1: 0x2::coin::Coin<T0>) {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    fun verify_admin_permission(arg0: &MemeboxManager, arg1: &AdminCap, arg2: address) {
        assert!(arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0), 1);
        assert!(arg1.admin_address == arg2, 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
    }

    fun verify_super_admin_cap(arg0: &MemeboxManager, arg1: &SuperAdminCap) {
        assert!(arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0), 5);
    }

    // decompiled from Move bytecode v6
}

