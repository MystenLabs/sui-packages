module 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun borrow<T0>(arg0: &Vault<T0>) : &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow<u64, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::StateV1<T0>>(&arg0.id, arg0.version);
        assert!(arg0.version == 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::version(), 1);
        v0
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::StateV1<T0>>(&mut arg0.id, arg0.version);
        assert!(arg0.version == 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::version(), 1);
        v0
    }

    public fun new<T0>(arg0: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg0);
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg7),
            version : 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::version(),
        };
        let v1 = &mut v0;
        let v2 = 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::new<T0>(&mut v0.id, arg1, (0x2::coin_registry::decimals<T0>(arg2) as u64), arg3, arg4, arg5, arg6);
        assert!(0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::vault_id<T0>(&v2) == 0x2::object::uid_to_inner(&v1.id), 0);
        0x2::dynamic_object_field::add<u64, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::StateV1<T0>>(&mut v1.id, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::version(), v2);
        (v0, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::create_vault_admin_cap(&mut v0.id))
    }

    public fun active_liquidity<T0>(arg0: &Vault<T0>) : vector<vector<u64>> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::active_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::active_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun add_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: T2, arg4: T3) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::add_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun add_yield<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg2: 0x2::coin::Coin<T1>) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg1);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::add_yield<T0, T1>(borrow_mut<T0>(arg0), arg2);
    }

    public fun admin_deposit<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg2: T2, arg3: 0x2::coin::Coin<T1>) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg1);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::admin_deposit<T0, T1, T2>(borrow_mut<T0>(arg0), arg2, arg3);
    }

    public fun admin_withdraw<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg2: T2, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg1);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::admin_withdraw<T0, T1, T2>(borrow_mut<T0>(arg0), arg2, arg3, arg4)
    }

    public fun allow_deposits_of_type<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin_registry::Currency<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        allow_deposits_of_type_unsafe<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin_registry::decimals<T2>(arg4) as u64), arg5, arg6);
    }

    public fun assert_can_be_mutated_by<T0, T1>(arg0: &Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::assert_can_be_mutated_by<T0, T1>(borrow<T0>(arg0), arg1);
    }

    public fun borrow_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &Vault<T0>, arg1: T1) : &T2 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::borrow_extension<T0, T1, T2>(borrow<T0>(arg0), arg1)
    }

    public fun borrow_mut_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut Vault<T0>, arg1: T1) : &mut T2 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::borrow_mut_extension<T0, T1, T2>(borrow_mut<T0>(arg0), arg1)
    }

    public fun cache_staleness_threshold_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::cache_staleness_threshold_ms<T0>(borrow<T0>(arg0))
    }

    public fun convert_to_single_collateral<T0>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::convert_to_single_collateral<T0, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>(borrow_mut<T0>(arg0), arg1);
    }

    public fun deposit_cap<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::deposit_cap<T0, T1>(borrow<T0>(arg0))
    }

    public fun depositor_is_whitelisted<T0>(arg0: &Vault<T0>, arg1: &address) : bool {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::depositor_is_whitelisted<T0>(borrow<T0>(arg0), arg1)
    }

    public fun extensions<T0>(arg0: &Vault<T0>) : &vector<0x1::type_name::TypeName> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::extensions<T0>(borrow<T0>(arg0))
    }

    public fun extensions_size<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::extensions_size<T0>(borrow<T0>(arg0))
    }

    public fun force_withdraw_delay_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::force_withdraw_delay_ms<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::idle_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::idle_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun is_single_collateral<T0>(arg0: &Vault<T0>) : bool {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun lock_duration_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::lock_duration_ms<T0>(borrow<T0>(arg0))
    }

    public fun lp_supply<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::lp_supply<T0>(borrow<T0>(arg0))
    }

    public fun management_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::management_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::performance_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun price_feed_storages<T0>(arg0: &Vault<T0>) : &vector<0x2::object::ID> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::price_feed_storages<T0>(borrow<T0>(arg0))
    }

    public fun remove_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: T2) : T3 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::remove_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun rotate_assistant<T0>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg1);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::rotate_assistant<T0>(borrow_mut<T0>(arg0), arg2, arg3, arg4);
    }

    public fun set_cache_staleness_threshold_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: u64) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::set_cache_staleness_threshold_ms<T0>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_deposit_cap<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: u64) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::set_deposit_cap<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: u64, arg4: u64, arg5: u64) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::set_fees<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_force_withdraw_delay_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: u64) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::set_force_withdraw_delay_ms<T0, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_lock_duration_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: u64) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::set_lock_duration_ms<T0, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun size<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::size<T0>(borrow<T0>(arg0))
    }

    public fun staleness_thresholds_ms<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::staleness_thresholds_ms<T0>(borrow<T0>(arg0))
    }

    public fun supports<T0, T1>(arg0: &Vault<T0>) : bool {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::supports<T0, T1>(borrow<T0>(arg0))
    }

    public fun supports_extension<T0, T1: copy + drop + store>(arg0: &Vault<T0>, arg1: T1) : bool {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::supports_extension<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun supports_type_name<T0>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::supports_type_name<T0>(borrow<T0>(arg0), arg1)
    }

    public fun total_active_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::total_active_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::total_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun vault_type<T0>(arg0: &Vault<T0>) : 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::VaultType {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::vault_type<T0>(borrow<T0>(arg0))
    }

    public fun whitelist_depositor<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: address) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::whitelist_depositor<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::withdraw_fees<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun withdraw_queue<T0>(arg0: &Vault<T0>) : &vector<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::WithdrawTicket<T0>> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::withdraw_queue<T0>(borrow<T0>(arg0))
    }

    public fun withdrawal_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::withdrawal_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun allow_deposits_of_type_from_coin_metadata<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin::CoinMetadata<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        allow_deposits_of_type_unsafe<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin::get_decimals<T2>(arg4) as u64), arg5, arg6);
    }

    public fun allow_deposits_of_type_unsafe<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, T1>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::allow_deposits_of_type<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5, arg6);
    }

    public fun is_multi_collateral<T0>(arg0: &Vault<T0>) : bool {
        !0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun new_from_coin_metadata<T0>(arg0: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::VAULT, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::ADMIN>) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg0);
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg7),
            version : 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::version(),
        };
        let v1 = &mut v0;
        let v2 = 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::new<T0>(&mut v0.id, arg1, (0x2::coin::get_decimals<T0>(&arg2) as u64), arg3, arg4, arg5, arg6);
        assert!(0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::vault_id<T0>(&v2) == 0x2::object::uid_to_inner(&v1.id), 0);
        0x2::dynamic_object_field::add<u64, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::StateV1<T0>>(&mut v1.id, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::version(), v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        (v0, 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::create_vault_admin_cap(&mut v0.id))
    }

    // decompiled from Move bytecode v6
}

