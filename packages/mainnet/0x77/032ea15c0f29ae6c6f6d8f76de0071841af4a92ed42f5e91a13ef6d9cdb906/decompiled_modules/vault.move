module 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault {
    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct SwapCap<phantom T0, phantom T1, phantom T2> {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0>(arg0: &Vault<T0>) : &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow<u64, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::StateV1<T0>>(&arg0.id, arg0.version);
        assert!(arg0.version == 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::version(), 2);
        v0
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::StateV1<T0>>(&mut arg0.id, arg0.version);
        assert!(arg0.version == 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::version(), 2);
        v0
    }

    public fun new<T0>(arg0: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg0);
        let v0 = VaultKey<T0>{dummy_field: false};
        let v1 = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::borrow_mut_id(arg0);
        assert!(!0x2::derived_object::exists<VaultKey<T0>>(v1, v0), 0);
        let v2 = Vault<T0>{
            id      : 0x2::derived_object::claim<VaultKey<T0>>(v1, v0),
            version : 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::version(),
        };
        let v3 = &mut v2;
        let v4 = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::new<T0>(&mut v2.id, arg1, (0x2::coin_registry::decimals<T0>(arg2) as u64), arg3, arg4, arg5, arg10, arg11);
        assert!(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::vault_id<T0>(&v4) == 0x2::object::uid_to_inner(&v3.id), 1);
        0x2::dynamic_object_field::add<u64, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::StateV1<T0>>(&mut v3.id, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::version(), v4);
        let v5 = &mut v2.id;
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::metadata::create_vault_metadata_and_share<T0>(v5, arg6, arg7, arg8, arg9);
        (v2, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::create_vault_admin_cap(v5))
    }

    public fun create_vault_assistant_cap<T0>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config) : 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ASSISTANT> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::assert_can_be_mutated_by<T0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>(borrow<T0>(arg0), arg1);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::create_vault_assistant_cap(&mut arg0.id)
    }

    public fun active_liquidity<T0>(arg0: &Vault<T0>) : vector<vector<u64>> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::active_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::active_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type_in_extension<T0, T1>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::active_liquidity_of_type_in_extension<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun add_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: T2, arg4: T3, arg5: bool) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::add_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun add_profit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock) {
        if (0x2::coin::value<T1>(&arg2) == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            return
        };
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::add_profit<T0, T1>(borrow_mut<T0>(arg0), arg2, arg3);
    }

    public fun admin_deposit<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: T3, arg4: 0x2::coin::Coin<T2>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::admin_deposit<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun admin_withdraw<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: T3, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::admin_withdraw<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5)
    }

    public fun allow_deposits_of_type<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin_registry::Currency<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        allow_deposits_of_type_with_decimals<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin_registry::decimals<T2>(arg4) as u64), arg5, arg6, arg7, arg8, arg9);
    }

    public fun assert_can_be_mutated_by<T0, T1>(arg0: &Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::assert_can_be_mutated_by<T0, T1>(borrow<T0>(arg0), arg1);
    }

    public fun begin_admin_swap_tx<T0, T1, T2, T3>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (SwapCap<T0, T2, T3>, 0x2::coin::Coin<T2>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        let v0 = SwapCap<T0, T2, T3>{dummy_field: false};
        (v0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::begin_admin_swap_tx<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3, arg4))
    }

    public fun borrow_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &Vault<T0>, arg1: T1) : &T2 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::borrow_extension<T0, T1, T2>(borrow<T0>(arg0), arg1)
    }

    public fun borrow_mut_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut Vault<T0>, arg1: T1) : &mut T2 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::borrow_mut_extension<T0, T1, T2>(borrow_mut<T0>(arg0), arg1)
    }

    public fun cache_staleness_threshold_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::cache_staleness_threshold_ms<T0>(borrow<T0>(arg0))
    }

    public fun convert_to_single_collateral<T0>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::convert_to_single_collateral<T0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>(borrow_mut<T0>(arg0), arg1);
    }

    public fun deposit_cap<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::deposit_cap<T0, T1>(borrow<T0>(arg0))
    }

    public fun depositor_is_whitelisted<T0>(arg0: &Vault<T0>, arg1: &address) : bool {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::depositor_is_whitelisted<T0>(borrow<T0>(arg0), arg1)
    }

    public fun end_admin_swap_tx<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: SwapCap<T0, T1, T2>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: 0x2::coin::Coin<T2>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        let SwapCap {  } = arg1;
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::end_admin_swap_tx<T0, T2>(borrow_mut<T0>(arg0), arg3);
    }

    public fun extensions<T0>(arg0: &Vault<T0>) : &vector<0x1::type_name::TypeName> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::extensions<T0>(borrow<T0>(arg0))
    }

    public fun extensions_size<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::extensions_size<T0>(borrow<T0>(arg0))
    }

    public fun force_withdraw_delay_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::force_withdraw_delay_ms<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::idle_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::idle_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun is_single_collateral<T0>(arg0: &Vault<T0>) : bool {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun last_unlock_timestamp_ms_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::last_unlock_timestamp_ms_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun lock_duration_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::lock_duration_ms<T0>(borrow<T0>(arg0))
    }

    public fun lp_supply<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::lp_supply<T0>(borrow<T0>(arg0))
    }

    public fun make_extension_policy_whitelisted_only<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::make_extension_policy_whitelisted_only<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2);
    }

    public fun management_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::management_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::performance_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun price_feed_storages<T0>(arg0: &Vault<T0>) : &vector<0x2::object::ID> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::price_feed_storages<T0>(borrow<T0>(arg0))
    }

    public fun remove_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: T2) : T3 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::remove_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun set_allow_session_deposits_into_extension<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64, arg4: bool) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_allow_session_deposits_into_extension<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun set_allow_session_swaps<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: bool) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_allow_session_swaps<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_cache_staleness_threshold_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_cache_staleness_threshold_ms<T0>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_deposit_cap<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_deposit_cap<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_deposit_extension_preference<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: vector<u64>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_deposit_extension_preference<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64, arg4: u64, arg5: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_fees<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_force_withdraw_delay_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_force_withdraw_delay_ms<T0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_last_unlock_timestamp_ms<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_last_unlock_timestamp_ms<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_lock_duration_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_lock_duration_ms<T0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_prefer_idle_deposits<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: bool) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_prefer_idle_deposits<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_unlock_frequency_ms<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_unlock_frequency_ms<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_unlock_rate<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: u64) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_unlock_rate<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_withdraw_extension_preference<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: vector<u64>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::set_withdraw_extension_preference<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun size<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::size<T0>(borrow<T0>(arg0))
    }

    public fun staleness_thresholds_ms<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::staleness_thresholds_ms<T0>(borrow<T0>(arg0))
    }

    public fun supports<T0, T1>(arg0: &Vault<T0>) : bool {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::supports<T0, T1>(borrow<T0>(arg0))
    }

    public fun supports_extension<T0, T1: copy + drop + store>(arg0: &Vault<T0>, arg1: T1) : bool {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::supports_extension<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun supports_type_name<T0>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::supports_type_name<T0>(borrow<T0>(arg0), arg1)
    }

    public fun total_active_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::total_active_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::total_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_profit_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::total_profit_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_unlockable_profit_of_type<T0, T1>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::total_unlockable_profit_of_type<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun unlock_frequency_ms_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::unlock_frequency_ms_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun unlock_profit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: &0x2::clock::Clock) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::unlock_profit<T0, T1>(borrow_mut<T0>(arg0), arg2);
    }

    public fun unlock_rate_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::unlock_rate_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun whitelist_depositor<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: address) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::whitelist_depositor<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::withdraw_fees<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun withdraw_queue<T0>(arg0: &Vault<T0>) : &vector<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::WithdrawTicket<T0>> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::withdraw_queue<T0>(borrow<T0>(arg0))
    }

    public fun withdrawal_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::withdrawal_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun allow_deposits_of_type_from_coin_metadata<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin::CoinMetadata<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        allow_deposits_of_type_with_decimals<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin::get_decimals<T2>(arg4) as u64), arg5, arg6, arg7, arg8, arg9);
    }

    public fun allow_deposits_of_type_with_decimals<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::allow_deposits_of_type<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun is_multi_collateral<T0>(arg0: &Vault<T0>) : bool {
        !0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun maybe_destroy_zero_or_keep<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun new_from_coin_metadata<T0>(arg0: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::ADMIN>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg0);
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg11),
            version : 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::version(),
        };
        let v1 = &mut v0;
        let v2 = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::new<T0>(&mut v0.id, arg1, (0x2::coin::get_decimals<T0>(&arg2) as u64), arg3, arg4, arg5, arg10, arg11);
        assert!(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::vault_id<T0>(&v2) == 0x2::object::uid_to_inner(&v1.id), 1);
        0x2::dynamic_object_field::add<u64, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::StateV1<T0>>(&mut v1.id, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::version(), v2);
        let v3 = &mut v0.id;
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::metadata::create_vault_metadata_and_share<T0>(v3, arg6, arg7, arg8, arg9);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        (v0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::create_vault_admin_cap(v3))
    }

    // decompiled from Move bytecode v6
}

