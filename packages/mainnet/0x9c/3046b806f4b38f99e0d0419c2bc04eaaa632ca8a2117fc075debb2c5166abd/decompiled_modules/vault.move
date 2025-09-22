module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun borrow<T0>(arg0: &Vault<T0>) : &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow<u64, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::StateV1<T0>>(&arg0.id, arg0.version);
        assert!(arg0.version == 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::version(), 1);
        v0
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::StateV1<T0>>(&mut arg0.id, arg0.version);
        assert!(arg0.version == 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::version(), 1);
        v0
    }

    public fun new<T0>(arg0: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::ADMIN>) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg0);
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg7),
            version : 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::version(),
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = &mut v0;
        let v3 = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::new<T0>(v1, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::vault_id<T0>(&v3) == 0x2::object::uid_to_inner(&v2.id), 0);
        0x2::dynamic_object_field::add<u64, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::StateV1<T0>>(&mut v2.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::version(), v3);
        (v0, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::create_vault_admin_cap(v1, arg7))
    }

    public fun active_liquidity<T0>(arg0: &Vault<T0>) : vector<vector<u64>> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::active_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::active_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun add_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: T2, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::add_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5);
    }

    public fun add_yield<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: 0x2::coin::Coin<T1>) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::add_yield<T0, T1>(borrow_mut<T0>(arg0), arg2);
    }

    public fun allow_deposits_of_type<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin::CoinMetadata<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::allow_deposits_of_type<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5, arg6);
    }

    public(friend) fun assert_can_be_mutated_by<T0, T1>(arg0: &Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::assert_can_be_mutated_by<T0, T1>(borrow<T0>(arg0), arg1);
    }

    public fun borrow_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &Vault<T0>, arg1: T1) : &T2 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::borrow_extension<T0, T1, T2>(borrow<T0>(arg0), arg1)
    }

    public fun borrow_mut_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut Vault<T0>, arg1: T1) : &mut T2 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::borrow_mut_extension<T0, T1, T2>(borrow_mut<T0>(arg0), arg1)
    }

    public fun cache_staleness_threshold_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::cache_staleness_threshold_ms<T0>(borrow<T0>(arg0))
    }

    public fun deposit_cap<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::deposit_cap<T0, T1>(borrow<T0>(arg0))
    }

    public fun deposit_funds<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: T2, arg3: 0x2::coin::Coin<T1>) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::deposit_funds<T0, T1, T2>(borrow_mut<T0>(arg0), arg2, arg3);
    }

    public fun depositor_is_whitelisted<T0>(arg0: &Vault<T0>, arg1: &address) : bool {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::depositor_is_whitelisted<T0>(borrow<T0>(arg0), arg1)
    }

    public fun extensions<T0>(arg0: &Vault<T0>) : &vector<0x1::type_name::TypeName> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::extensions<T0>(borrow<T0>(arg0))
    }

    public fun extensions_size<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::extensions_size<T0>(borrow<T0>(arg0))
    }

    public fun force_withdraw_delay_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::force_withdraw_delay_ms<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::idle_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::idle_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun lock_duration_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::lock_duration_ms<T0>(borrow<T0>(arg0))
    }

    public fun lp_supply<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::lp_supply<T0>(borrow<T0>(arg0))
    }

    public fun management_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::management_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::performance_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun price_feed_storages<T0>(arg0: &Vault<T0>) : &vector<0x2::object::ID> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::price_feed_storages<T0>(borrow<T0>(arg0))
    }

    public fun remove_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: T2) : T3 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::remove_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun rotate_assistant<T0>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::ADMIN>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::rotate_assistant<T0>(borrow_mut<T0>(arg0), arg2, arg3, arg4);
    }

    public fun set_deposit_cap<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: u64) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::set_deposit_cap<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: u64, arg4: u64, arg5: u64) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::set_fees<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun size<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::size<T0>(borrow<T0>(arg0))
    }

    public fun staleness_thresholds_ms<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::staleness_thresholds_ms<T0>(borrow<T0>(arg0))
    }

    public fun supports<T0, T1>(arg0: &Vault<T0>) : bool {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::supports<T0, T1>(borrow<T0>(arg0))
    }

    public fun supports_type_name<T0>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::supports_type_name<T0>(borrow<T0>(arg0), arg1)
    }

    public fun total_active_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::total_active_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::total_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun whitelist_depositor<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: address) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::whitelist_depositor<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::withdraw_fees<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun withdraw_funds<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: T2, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::withdraw_funds<T0, T1, T2>(borrow_mut<T0>(arg0), arg2, arg3, arg4)
    }

    public fun withdraw_queue<T0>(arg0: &Vault<T0>) : &vector<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::WithdrawTicket<T0>> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::withdraw_queue<T0>(borrow<T0>(arg0))
    }

    public fun withdrawal_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::withdrawal_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun supports_extension<T0, T1: copy + drop + store>(arg0: &Vault<T0>, arg1: T1) : bool {
        0x2::dynamic_object_field::exists_<T1>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

