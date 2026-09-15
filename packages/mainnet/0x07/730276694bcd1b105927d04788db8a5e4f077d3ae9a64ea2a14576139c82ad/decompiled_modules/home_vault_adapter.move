module 0x7730276694bcd1b105927d04788db8a5e4f077d3ae9a64ea2a14576139c82ad::home_vault_adapter {
    struct HomeVaultBinding has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        adapter_key: vector<u8>,
        executor: address,
    }

    struct HomeVaultCustody<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct HomeVaultAdminCap has key {
        id: 0x2::object::UID,
        binding_id: 0x2::object::ID,
    }

    struct BindAnchor has key {
        id: 0x2::object::UID,
        bound: bool,
    }

    struct HomeVaultBound has copy, drop {
        binding_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
    }

    struct HomeVaultDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        assets_micros: u64,
        shares_minted: u64,
    }

    struct HomeVaultWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        shares_burned: u64,
        assets_micros: u64,
    }

    struct HOME_VAULT_ADAPTER has drop {
        dummy_field: bool,
    }

    public fun admin_binding_id(arg0: &HomeVaultAdminCap) : 0x2::object::ID {
        arg0.binding_id
    }

    fun assert_and_mark_bindable(arg0: &mut BindAnchor) {
        assert!(!arg0.bound, 12);
        arg0.bound = true;
    }

    fun assert_asset<T0>(arg0: &HomeVaultBinding) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.asset_type, 3);
    }

    fun assert_binding(arg0: &HomeVaultBinding, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault) {
        assert!(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault>(arg2) == arg0.vault_id, 3);
        assert!(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig>(arg1) == arg0.config_id, 3);
    }

    fun assert_custody_vault<T0>(arg0: &HomeVaultCustody<T0>, arg1: &HomeVaultBinding) {
        assert!(arg0.vault_id == arg1.vault_id, 3);
    }

    fun assert_deposit_authority(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2) {
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::is_paused(arg1), 5);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0) == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 6);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter>(arg1) == @0xa0722a3dd74837d9daa4a82c2ffd7ed4c1b6013d57a362a42cb5a6c9c004db6f, 7);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_adapter_registry_v2_id(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg2)), 8);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg2, b"sui-home-vault", b"sui");
    }

    public entry fun bind_home_vault<T0>(arg0: &mut BindAnchor, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg6: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert_and_mark_bindable(arg0);
        assert!(arg7 != @0x0, 9);
        assert_deposit_authority(arg1, arg2, arg3);
        let v0 = 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault>(arg5);
        let v1 = HomeVaultBinding{
            id          : 0x2::object::new(arg8),
            config_id   : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig>(arg4),
            vault_id    : v0,
            asset_type  : 0x1::type_name::with_defining_ids<T0>(),
            adapter_key : b"sui-home-vault",
            executor    : arg7,
        };
        let v2 = 0x2::object::id<HomeVaultBinding>(&v1);
        let v3 = HomeVaultBound{
            binding_id : v2,
            vault_id   : v0,
            config_id  : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig>(arg4),
        };
        0x2::event::emit<HomeVaultBound>(v3);
        0x2::transfer::share_object<HomeVaultBinding>(v1);
        let v4 = HomeVaultCustody<T0>{
            id       : 0x2::object::new(arg8),
            vault_id : v0,
            balance  : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<HomeVaultCustody<T0>>(v4);
        let v5 = HomeVaultAdminCap{
            id         : 0x2::object::new(arg8),
            binding_id : v2,
        };
        0x2::transfer::transfer<HomeVaultAdminCap>(v5, 0x2::tx_context::sender(arg8));
    }

    public fun binding_executor(arg0: &HomeVaultBinding) : address {
        arg0.executor
    }

    public fun binding_ids(arg0: &HomeVaultBinding) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.config_id, arg0.vault_id)
    }

    public fun custody_value<T0>(arg0: &HomeVaultCustody<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun deposit<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig, arg4: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg5: &HomeVaultBinding, arg6: &mut HomeVaultCustody<T0>, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg7) > 0, 2);
        assert_binding(arg5, arg3, arg4);
        assert_asset<T0>(arg5);
        assert_custody_vault<T0>(arg6, arg5);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::is_paused(arg3), 4);
        assert_deposit_authority(arg0, arg1, arg2);
        abort 1
    }

    public entry fun deposit_for_owner<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig, arg4: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg5: &HomeVaultBinding, arg6: &mut HomeVaultCustody<T0>, arg7: 0x2::coin::Coin<T0>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 != @0x0, 9);
        assert!(0x2::tx_context::sender(arg9) == arg5.executor, 10);
        assert!(0x2::coin::value<T0>(&arg7) > 0, 2);
        assert_binding(arg5, arg3, arg4);
        assert_asset<T0>(arg5);
        assert_custody_vault<T0>(arg6, arg5);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::is_paused(arg3), 4);
        assert_deposit_authority(arg0, arg1, arg2);
        abort 1
    }

    fun init(arg0: HOME_VAULT_ADAPTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BindAnchor{
            id    : 0x2::object::new(arg1),
            bound : false,
        };
        0x2::transfer::share_object<BindAnchor>(v0);
    }

    public fun quoted_assets(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg1: u64) : u64 {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::convert_to_assets(arg1, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::total_assets(arg0), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::total_shares(arg0))
    }

    public fun quoted_shares(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg1: u64) : u64 {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::convert_to_shares(arg1, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::total_assets(arg0), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::total_shares(arg0))
    }

    public entry fun withdraw<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg2: &HomeVaultBinding, arg3: &mut HomeVaultCustody<T0>, arg4: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Position, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        withdraw_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdraw_all<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg2: &HomeVaultBinding, arg3: &mut HomeVaultCustody<T0>, arg4: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Position, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::position_shares(arg4);
        assert!(v0 > 0, 2);
        withdraw_inner<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg5);
    }

    fun withdraw_inner<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::VaultConfig, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault, arg2: &HomeVaultBinding, arg3: &mut HomeVaultCustody<T0>, arg4: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Position, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_binding(arg2, arg0, arg1);
        assert_asset<T0>(arg2);
        assert_custody_vault<T0>(arg3, arg2);
        assert!(arg5 > 0, 2);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::convert_to_assets(arg5, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::total_assets(arg1), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::total_shares(arg1));
        assert!(v0 > 0, 2);
        assert!(0x2::balance::value<T0>(&arg3.balance) >= v0, 11);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::withdraw_liquid(arg0, arg1, arg4, arg5, arg6);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::position_owner(arg4);
        let v3 = HomeVaultWithdrawn{
            vault_id      : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault::Vault>(arg1),
            owner         : v2,
            shares_burned : arg5,
            assets_micros : v1,
        };
        0x2::event::emit<HomeVaultWithdrawn>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.balance, v1), arg6), v2);
    }

    // decompiled from Move bytecode v7
}

