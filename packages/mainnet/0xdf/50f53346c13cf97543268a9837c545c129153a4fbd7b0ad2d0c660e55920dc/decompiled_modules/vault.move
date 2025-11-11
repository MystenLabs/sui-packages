module 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun borrow<T0>(arg0: &Vault<T0>) : &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow<u64, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::StateV1<T0>>(&arg0.id, arg0.version);
        assert!(arg0.version == 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::version(), 1);
        v0
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut Vault<T0>) : &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::StateV1<T0>>(&mut arg0.id, arg0.version);
        assert!(arg0.version == 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::version(), 1);
        v0
    }

    public fun new<T0>(arg0: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg0);
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg7),
            version : 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::version(),
        };
        let v1 = &mut v0;
        let v2 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::new<T0>(&mut v0.id, arg1, (0x2::coin_registry::decimals<T0>(arg2) as u64), arg3, arg4, arg5, arg6, arg7);
        assert!(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::vault_id<T0>(&v2) == 0x2::object::uid_to_inner(&v1.id), 0);
        0x2::dynamic_object_field::add<u64, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::StateV1<T0>>(&mut v1.id, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::version(), v2);
        (v0, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::create_vault_admin_cap(&mut v0.id))
    }

    public fun active_liquidity<T0>(arg0: &Vault<T0>) : vector<vector<u64>> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::active_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::active_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type_in_extension<T0, T1>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::active_liquidity_of_type_in_extension<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun add_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: T2, arg4: T3) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::add_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun add_profit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock) {
        if (0x2::coin::value<T1>(&arg2) == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            return
        };
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg1);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::add_profit<T0, T1>(borrow_mut<T0>(arg0), arg2, arg3);
    }

    public fun admin_deposit<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg2: T2, arg3: 0x2::coin::Coin<T1>) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg1);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::admin_deposit<T0, T1, T2>(borrow_mut<T0>(arg0), arg2, arg3);
    }

    public fun admin_withdraw<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg2: T2, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg1);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::admin_withdraw<T0, T1, T2>(borrow_mut<T0>(arg0), arg2, arg3, arg4)
    }

    public fun allow_deposits_of_type<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin_registry::Currency<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        allow_deposits_of_type_unsafe<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin_registry::decimals<T2>(arg4) as u64), arg5, arg6, arg7, arg8, arg9);
    }

    public fun assert_can_be_mutated_by<T0, T1>(arg0: &Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::assert_can_be_mutated_by<T0, T1>(borrow<T0>(arg0), arg1);
    }

    public fun borrow_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &Vault<T0>, arg1: T1) : &T2 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::borrow_extension<T0, T1, T2>(borrow<T0>(arg0), arg1)
    }

    public fun borrow_mut_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut Vault<T0>, arg1: T1) : &mut T2 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::borrow_mut_extension<T0, T1, T2>(borrow_mut<T0>(arg0), arg1)
    }

    public fun cache_staleness_threshold_ms<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::cache_staleness_threshold_ms<T0>(borrow<T0>(arg0))
    }

    public fun convert_to_single_collateral<T0>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::convert_to_single_collateral<T0, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>(borrow_mut<T0>(arg0), arg1);
    }

    public fun deposit_cap<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::deposit_cap<T0, T1>(borrow<T0>(arg0))
    }

    public fun depositor_is_whitelisted<T0>(arg0: &Vault<T0>, arg1: &address) : bool {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::depositor_is_whitelisted<T0>(borrow<T0>(arg0), arg1)
    }

    public fun extensions<T0>(arg0: &Vault<T0>) : &vector<0x1::type_name::TypeName> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::extensions<T0>(borrow<T0>(arg0))
    }

    public fun extensions_size<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::extensions_size<T0>(borrow<T0>(arg0))
    }

    public fun force_withdraw_delay_ms<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::force_withdraw_delay_ms<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity<T0>(arg0: &Vault<T0>) : vector<u64> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::idle_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::idle_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun is_single_collateral<T0>(arg0: &Vault<T0>) : bool {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun last_unlock_timestamp_ms_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::last_unlock_timestamp_ms_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun lock_duration_ms<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::lock_duration_ms<T0>(borrow<T0>(arg0))
    }

    public fun lp_supply<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::lp_supply<T0>(borrow<T0>(arg0))
    }

    public fun management_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::management_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::performance_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun price_feed_storages<T0>(arg0: &Vault<T0>) : &vector<0x2::object::ID> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::price_feed_storages<T0>(borrow<T0>(arg0))
    }

    public fun remove_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: T2) : T3 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::remove_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun rotate_assistant<T0>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg1);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::rotate_assistant<T0>(borrow_mut<T0>(arg0), arg2, arg3, arg4);
    }

    public fun set_cache_staleness_threshold_ms<T0>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_cache_staleness_threshold_ms<T0>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_deposit_cap<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_deposit_cap<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64, arg4: u64, arg5: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_fees<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_force_withdraw_delay_ms<T0>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_force_withdraw_delay_ms<T0, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_last_unlock_timestamp_ms<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_last_unlock_timestamp_ms<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_lock_duration_ms<T0>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_lock_duration_ms<T0, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_unlock_frequency_ms<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_unlock_frequency_ms<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_unlock_rate<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: u64) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::set_unlock_rate<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun size<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::size<T0>(borrow<T0>(arg0))
    }

    public fun staleness_thresholds_ms<T0>(arg0: &Vault<T0>) : vector<u64> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::staleness_thresholds_ms<T0>(borrow<T0>(arg0))
    }

    public fun supports<T0, T1>(arg0: &Vault<T0>) : bool {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::supports<T0, T1>(borrow<T0>(arg0))
    }

    public fun supports_extension<T0, T1: copy + drop + store>(arg0: &Vault<T0>, arg1: T1) : bool {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::supports_extension<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun supports_type_name<T0>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::supports_type_name<T0>(borrow<T0>(arg0), arg1)
    }

    public fun total_active_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::total_active_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::total_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_profit_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::total_profit_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_unlockable_profit_of_type<T0, T1>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::total_unlockable_profit_of_type<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun unlock_frequency_ms_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::unlock_frequency_ms_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun unlock_profit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg2: &0x2::clock::Clock) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg1);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::unlock_profit<T0, T1>(borrow_mut<T0>(arg0), arg2);
    }

    public fun unlock_rate_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::unlock_rate_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun vault_type<T0>(arg0: &Vault<T0>) : 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::VaultType {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::vault_type<T0>(borrow<T0>(arg0))
    }

    public fun whitelist_depositor<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: address) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::whitelist_depositor<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::withdraw_fees<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun withdraw_queue<T0>(arg0: &Vault<T0>) : &vector<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::WithdrawTicket<T0>> {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::withdraw_queue<T0>(borrow<T0>(arg0))
    }

    public fun withdrawal_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::withdrawal_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun allow_deposits_of_type_from_coin_metadata<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin::CoinMetadata<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        allow_deposits_of_type_unsafe<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin::get_decimals<T2>(arg4) as u64), arg5, arg6, arg7, arg8, arg9);
    }

    public fun allow_deposits_of_type_unsafe<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg2);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::allow_deposits_of_type<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun is_multi_collateral<T0>(arg0: &Vault<T0>) : bool {
        !0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun new_from_coin_metadata<T0>(arg0: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::ADMIN>) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg0);
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg7),
            version : 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::version(),
        };
        let v1 = &mut v0;
        let v2 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::new<T0>(&mut v0.id, arg1, (0x2::coin::get_decimals<T0>(&arg2) as u64), arg3, arg4, arg5, arg6, arg7);
        assert!(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::vault_id<T0>(&v2) == 0x2::object::uid_to_inner(&v1.id), 0);
        0x2::dynamic_object_field::add<u64, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::StateV1<T0>>(&mut v1.id, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::state::version(), v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        (v0, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::create_vault_admin_cap(&mut v0.id))
    }

    // decompiled from Move bytecode v6
}

