module 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::vault {
    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VaultSharePolicy<phantom T0> {
        dummy_field: bool,
    }

    struct SwapCap<phantom T0, phantom T1, phantom T2> {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0>(arg0: &Vault<T0>) : &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow<u64, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::StateV1<T0>>(&arg0.id, arg0.version);
        assert!(arg0.version == 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::version(), 13835628006032539653);
        v0
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::StateV1<T0> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::StateV1<T0>>(&mut arg0.id, arg0.version);
        assert!(arg0.version == 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::version(), 13835628061867114501);
        v0
    }

    public fun create_vault_assistant_cap<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config) : 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ASSISTANT> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::create_vault_assistant_cap<T0>(&mut arg0.id)
    }

    public fun create_vault_pause_guardian_cap<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::metadata::VaultMetadata<T0>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>, arg3: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config) : 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::PAUSE_GUARDIAN> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg3);
        let v0 = 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::create_vault_pause_guardian_cap<T0>(&mut arg0.id);
        let v1 = 0x2::object::id<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::PAUSE_GUARDIAN>>(&v0);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::metadata::set_extra_field<T0, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>(arg1, arg2, 0x1::ascii::string(b"PAUSE_GUARDIAN"), 0x2::address::to_ascii_string(0x2::object::id_to_address(&v1)));
        v0
    }

    public fun active_liquidity<T0>(arg0: &Vault<T0>) : vector<vector<u64>> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::active_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::active_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun active_liquidity_of_type_in_extension<T0, T1>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::active_liquidity_of_type_in_extension<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun add_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: T2, arg4: T3, arg5: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::add_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun add_profit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock) {
        if (0x2::coin::value<T1>(&arg2) == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            return
        };
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::add_profit<T0, T1>(borrow_mut<T0>(arg0), arg2, arg3);
    }

    public fun admin_deposit<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: T3, arg4: 0x2::coin::Coin<T2>) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::admin_deposit<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun admin_withdraw<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: T3, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::admin_withdraw<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5)
    }

    public fun allow_deposits_of_type<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin_registry::Currency<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        allow_deposits_of_type_with_decimals<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin_registry::decimals<T2>(arg4) as u64), arg5, arg6, arg7, arg8, arg9);
    }

    public fun begin_admin_swap_tx<T0, T1, T2, T3>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (SwapCap<T0, T2, T3>, 0x2::coin::Coin<T2>) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        let v0 = SwapCap<T0, T2, T3>{dummy_field: false};
        (v0, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::begin_admin_swap_tx<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3, arg4))
    }

    public fun borrow_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &Vault<T0>, arg1: T1) : &T2 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::borrow_extension<T0, T1, T2>(borrow<T0>(arg0), arg1)
    }

    public fun borrow_mut_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut Vault<T0>, arg1: T1) : &mut T2 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::borrow_mut_extension<T0, T1, T2>(borrow_mut<T0>(arg0), arg1)
    }

    public fun cache_staleness_threshold_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::cache_staleness_threshold_ms<T0>(borrow<T0>(arg0))
    }

    public fun cancel_deposit_ticket<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::cancel_deposit_ticket<T0, T1>(borrow_mut<T0>(arg0), arg2, arg3)
    }

    public fun cancel_withdraw_ticket<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::cancel_withdraw_ticket<T0>(borrow_mut<T0>(arg0), arg2, arg3)
    }

    public fun convert_to_single_collateral<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::convert_to_single_collateral<T0, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>(borrow_mut<T0>(arg0), arg1);
    }

    public fun create_deposit_ticket<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::create_deposit_ticket<T0, T1>(borrow_mut<T0>(arg0), arg2, arg3)
    }

    public fun create_withdraw_ticket<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::create_withdraw_ticket<T0, T1>(borrow_mut<T0>(arg0), arg2, arg3, arg4)
    }

    public fun deposit_cap<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::deposit_cap<T0, T1>(borrow<T0>(arg0))
    }

    public fun deposit_queue<T0>(arg0: &Vault<T0>) : &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::linked_list::LinkedList<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::DepositTicket> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::deposit_queue<T0>(borrow<T0>(arg0))
    }

    public fun depositor_is_whitelisted<T0>(arg0: &Vault<T0>, arg1: &address) : bool {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::depositor_is_whitelisted<T0>(borrow<T0>(arg0), arg1)
    }

    public fun end_admin_swap_tx<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: SwapCap<T0, T1, T2>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: 0x2::coin::Coin<T2>) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        let SwapCap {  } = arg1;
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::end_admin_swap_tx<T0, T2>(borrow_mut<T0>(arg0), arg3);
    }

    public fun extension_deposit_cap<T0, T1, T2>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::extension_deposit_cap<T0, T1, T2>(borrow<T0>(arg0))
    }

    public fun extensions<T0>(arg0: &Vault<T0>) : &vector<0x1::type_name::TypeName> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::extensions<T0>(borrow<T0>(arg0))
    }

    public fun extensions_size<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::extensions_size<T0>(borrow<T0>(arg0))
    }

    public fun force_withdraw_delay_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::force_withdraw_delay_ms<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::idle_liquidity<T0>(borrow<T0>(arg0))
    }

    public fun idle_liquidity_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::idle_liquidity_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun is_paused<T0>(arg0: &Vault<T0>) : bool {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::is_paused<T0>(borrow<T0>(arg0))
    }

    public fun is_single_collateral<T0>(arg0: &Vault<T0>) : bool {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun last_unlock_timestamp_ms_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::last_unlock_timestamp_ms_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun lock_duration_ms<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::lock_duration_ms<T0>(borrow<T0>(arg0))
    }

    public fun lp_supply<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::lp_supply<T0>(borrow<T0>(arg0))
    }

    public fun make_extension_policy_whitelisted_only<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::make_extension_policy_whitelisted_only<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2);
    }

    public fun new<T0>(arg0: &mut 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>, VaultSharePolicy<T0>) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg0);
        let v0 = VaultKey<T0>{dummy_field: false};
        let v1 = 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::borrow_mut_id(arg0);
        assert!(!0x2::derived_object::exists<VaultKey<T0>>(v1, v0), 13835058566383271937);
        let v2 = Vault<T0>{
            id      : 0x2::derived_object::claim<VaultKey<T0>>(v1, v0),
            version : 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::version(),
        };
        let v3 = &mut v2;
        let v4 = 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::new<T0>(&mut v2.id, arg1, (0x2::coin_registry::decimals<T0>(arg2) as u64), arg3, arg4, arg5, arg11, arg12);
        assert!(0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::vault_id<T0>(&v4) == 0x2::object::uid_to_inner(&v3.id), 13835346470926155779);
        0x2::dynamic_object_field::add<u64, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::StateV1<T0>>(&mut v3.id, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::version(), v4);
        let v5 = &mut v2.id;
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::metadata::create_vault_metadata_and_share<T0>(v5, arg6, arg7, arg8, arg9, arg10);
        let v6 = VaultSharePolicy<T0>{dummy_field: false};
        (v2, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::create_vault_admin_cap<T0>(v5), v6)
    }

    public fun peek_deposit_queue<T0>(arg0: &Vault<T0>) : 0x1::option::Option<0x2::object::ID> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::peek_deposit_queue<T0>(borrow<T0>(arg0))
    }

    public fun peek_withdraw_queue<T0>(arg0: &Vault<T0>) : 0x1::option::Option<0x2::object::ID> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::peek_withdraw_queue<T0>(borrow<T0>(arg0))
    }

    public fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::performance_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun price_feed_storages<T0>(arg0: &Vault<T0>) : &vector<0x2::object::ID> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::price_feed_storages<T0>(borrow<T0>(arg0))
    }

    public fun remove_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: T2) : T3 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::remove_extension<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun set_allow_session_atomic_deposits<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_allow_session_atomic_deposits<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_allow_session_atomic_withdraws<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_allow_session_atomic_withdraws<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_allow_session_deposits_into_extension<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64, arg4: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_allow_session_deposits_into_extension<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun set_allow_session_swaps_with_active_liquidity<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_allow_session_swaps_with_active_liquidity<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_allow_session_swaps_with_idle_liquidity<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_allow_session_swaps_with_idle_liquidity<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_allowable_price_feed_storage_sources<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: vector<0x2::object::ID>) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_allowable_price_feed_storage_sources<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_cache_staleness_threshold_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_cache_staleness_threshold_ms<T0>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_deposit_cap<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_deposit_cap<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_deposit_extension_preference<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: vector<u64>) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_deposit_extension_preference<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_extension_deposit_cap<T0, T1, T2, T3>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_extension_deposit_cap<T0, T1, T2, T3>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_force_withdraw_delay_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_force_withdraw_delay_ms<T0, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_last_unlock_timestamp_ms<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_last_unlock_timestamp_ms<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_lock_duration_ms<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_lock_duration_ms<T0, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::ADMIN>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_paused<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::PAUSE_GUARDIAN>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_paused<T0>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_performance_fee_bps<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_performance_fee_bps<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2, arg3);
    }

    public fun set_prefer_idle_deposits<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: bool) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_prefer_idle_deposits<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_swap_fee_bps<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_swap_fee_bps<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2, arg3);
    }

    public fun set_unlock_frequency_ms<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_unlock_frequency_ms<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_unlock_rate<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_unlock_rate<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_withdraw_extension_order<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: vector<u64>) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_withdraw_extension_order<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun set_withdraw_ticket_recipient<T0>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_withdraw_ticket_recipient<T0>(borrow_mut<T0>(arg0), arg2, arg3, arg4);
    }

    public fun set_withdrawal_fee_bps<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: u64) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::set_withdrawal_fee_bps<T0, T1>(borrow_mut<T0>(arg0), arg1, arg2, arg3);
    }

    public fun size<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::size<T0>(borrow<T0>(arg0))
    }

    public fun staleness_thresholds_ms<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::staleness_thresholds_ms<T0>(borrow<T0>(arg0))
    }

    public fun supports<T0, T1>(arg0: &Vault<T0>) : bool {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::supports<T0, T1>(borrow<T0>(arg0))
    }

    public fun supports_extension<T0, T1: copy + drop + store>(arg0: &Vault<T0>, arg1: T1) : bool {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::supports_extension<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun supports_type_name<T0>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::supports_type_name<T0>(borrow<T0>(arg0), arg1)
    }

    public fun swap_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::swap_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun total_active_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::total_active_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_deposits<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::total_deposits<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_profit_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::total_profit_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun total_unlockable_profit_of_type<T0, T1>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::total_unlockable_profit_of_type<T0, T1>(borrow<T0>(arg0), arg1)
    }

    public fun unlock_frequency_ms_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::unlock_frequency_ms_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun unlock_profit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg2: &0x2::clock::Clock) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::unlock_profit<T0, T1>(borrow_mut<T0>(arg0), arg2);
    }

    public fun unlock_rate_of_type<T0, T1>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::unlock_rate_of_type<T0, T1>(borrow<T0>(arg0))
    }

    public fun whitelist_depositor<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: address) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::whitelist_depositor<T0, T1>(borrow_mut<T0>(arg0), arg1, arg3);
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::withdraw_fees<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3)
    }

    public fun withdraw_queue<T0>(arg0: &Vault<T0>) : &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::linked_list::LinkedList<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::WithdrawTicket<T0>> {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::withdraw_queue<T0>(borrow<T0>(arg0))
    }

    public fun withdrawal_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::withdrawal_fee_bps<T0>(borrow<T0>(arg0))
    }

    public fun allow_deposits_of_type_from_coin_metadata<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0x2::coin::CoinMetadata<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        allow_deposits_of_type_with_decimals<T0, T1, T2>(arg0, arg1, arg2, arg3, (0x2::coin::get_decimals<T2>(arg4) as u64), arg5, arg6, arg7, arg8, arg9);
    }

    public fun allow_deposits_of_type_with_decimals<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::assert_package_version(arg2);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::assert_is_admin_or_assistant<T1>();
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::allow_deposits_of_type<T0, T1, T2>(borrow_mut<T0>(arg0), arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun consume_share_policy_and_share<T0>(arg0: Vault<T0>, arg1: VaultSharePolicy<T0>) {
        let VaultSharePolicy {  } = arg1;
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public fun is_multi_collateral<T0>(arg0: &Vault<T0>) : bool {
        !0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::state::is_single_collateral<T0>(borrow<T0>(arg0))
    }

    public fun maybe_destroy_zero_or_keep<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

