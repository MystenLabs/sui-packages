module 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket {
    struct AuthorizedTransferTicket {
        assets: 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::AssetStore,
        balance_sheet: 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::balance_sheet::BalanceSheet,
        account_id: 0x2::object::ID,
        policies: vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>,
        strategy_name: 0x1::string::String,
        current_adapter: 0x1::string::String,
        is_agent: bool,
        perf_fee: 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::AssetStore,
        perf_fee_val: u64,
        base_asset_types: vector<0x1::type_name::TypeName>,
    }

    public fun asset_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::asset_balance<T0>(&arg0.assets, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::create_asset_key<T0>())
    }

    public fun has_any_assets(arg0: &AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::has_any_assets(&arg0.assets)
    }

    public fun has_any_rewards(arg0: &AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::has_any_rewards(&arg0.assets)
    }

    public fun reward_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::reward_balance<T0>(&arg0.assets, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::create_reward_key<T0>())
    }

    public fun withdraw_object<T0: store + key, T1>(arg0: &mut AuthorizedTransferTicket, arg1: &T1) : T0 {
        verify_adapter_access<T1>(arg0, arg1);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public fun withdraw_reward<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &T1, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_adapter_access<T1>(arg0, arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg1, arg3)
    }

    public fun has_adapter_record<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::balance_sheet::has_adapter_record(&arg0.balance_sheet, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun reset_adapter_deposits<T0>(arg0: &mut AuthorizedTransferTicket, arg1: &T0) {
        verify_adapter_access<T0>(arg0, arg1);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::balance_sheet::reset_adapter_deposits<T0>(&mut arg0.balance_sheet);
    }

    public fun adapter_total_deposited<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::balance_sheet::total_deposited(&arg0.balance_sheet, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun add_coin<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::coin::Coin<T0>, arg2: &T1) {
        verify_adapter_access<T1>(arg0, arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::deposit<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_coin_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::coin::Coin<T0>) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::deposit<T0>(&mut arg0.assets, arg1);
    }

    public fun add_object<T0: store + key, T1>(arg0: &mut AuthorizedTransferTicket, arg1: T0, arg2: &T1) {
        verify_adapter_access<T1>(arg0, arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::deposit_object<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_object_internal<T0: store + key>(arg0: &mut AuthorizedTransferTicket, arg1: T0) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::deposit_object<T0>(&mut arg0.assets, arg1);
    }

    public fun add_reward<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::balance::Balance<T0>, arg2: &T1) {
        verify_adapter_access<T1>(arg0, arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_reward_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::balance::Balance<T0>) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun assert_belongs_to_account(arg0: &AuthorizedTransferTicket, arg1: 0x2::object::ID) {
        assert!(arg0.account_id == arg1, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::errors::invalid_account());
    }

    public fun assert_supports_asset_type<T0>(arg0: &AuthorizedTransferTicket) {
        assert!(supports_asset_type<T0>(arg0), 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::errors::invalid_asset_type_for_strategy());
    }

    public fun burn(arg0: AuthorizedTransferTicket, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount) {
        let AuthorizedTransferTicket {
            assets           : v0,
            balance_sheet    : v1,
            account_id       : _,
            policies         : _,
            strategy_name    : v4,
            current_adapter  : _,
            is_agent         : _,
            perf_fee         : v7,
            perf_fee_val     : _,
            base_asset_types : _,
        } = arg0;
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::destroy(v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::destroy(v7);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::return_balance_sheet(arg1, v4, v1);
    }

    public fun calculate_performance_fee(arg0: &AuthorizedTransferTicket, arg1: u64) : u64 {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::math::safe_mul_div(arg1, arg0.perf_fee_val, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::constants::basis_points_divisor())
    }

    public fun collect_performance_fee<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::coin::Coin<T0>) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::deposit<T0>(&mut arg0.perf_fee, arg1);
    }

    public fun get_account_id(arg0: &AuthorizedTransferTicket) : 0x2::object::ID {
        arg0.account_id
    }

    public fun get_asset_keys(arg0: &AuthorizedTransferTicket) : &vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::AssetKey> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::active_asset_keys(&arg0.assets)
    }

    public fun get_balance_sheet(arg0: &AuthorizedTransferTicket) : &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::balance_sheet::BalanceSheet {
        &arg0.balance_sheet
    }

    public fun get_base_asset_types(arg0: &AuthorizedTransferTicket) : &vector<0x1::type_name::TypeName> {
        &arg0.base_asset_types
    }

    public fun get_current_adapter(arg0: &AuthorizedTransferTicket) : 0x1::string::String {
        arg0.current_adapter
    }

    public fun get_perf_fee_asset_keys(arg0: &AuthorizedTransferTicket) : &vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::AssetKey> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::active_asset_keys(&arg0.perf_fee)
    }

    public fun get_perf_fee_val(arg0: &AuthorizedTransferTicket) : u64 {
        arg0.perf_fee_val
    }

    public fun get_policies(arg0: &AuthorizedTransferTicket) : &vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy> {
        &arg0.policies
    }

    public fun get_reward_keys(arg0: &AuthorizedTransferTicket) : &vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::RewardKey> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::active_reward_keys(&arg0.assets)
    }

    public fun get_strategy_name(arg0: &AuthorizedTransferTicket) : 0x1::string::String {
        arg0.strategy_name
    }

    public fun has_any_perf_fees(arg0: &AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::has_any_assets(&arg0.perf_fee)
    }

    public fun has_asset_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::has_asset_key(&arg0.assets, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::create_asset_key<T0>())
    }

    public fun has_reward_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::reward_exists(&arg0.assets, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::create_reward_key<T0>())
    }

    public fun is_agent_ticket(arg0: &AuthorizedTransferTicket) : bool {
        arg0.is_agent
    }

    public(friend) fun issue(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::balance_sheet::BalanceSheet, arg3: bool, arg4: u64, arg5: vector<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) : AuthorizedTransferTicket {
        AuthorizedTransferTicket{
            assets           : 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::new(arg6),
            balance_sheet    : arg2,
            account_id       : arg0,
            policies         : 0x1::vector::empty<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>(),
            strategy_name    : arg1,
            current_adapter  : 0x1::string::utf8(b""),
            is_agent         : arg3,
            perf_fee         : 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::new(arg6),
            perf_fee_val     : arg4,
            base_asset_types : arg5,
        }
    }

    public fun perf_fee_asset_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::asset_balance<T0>(&arg0.perf_fee, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::create_asset_key<T0>())
    }

    public fun record_adapter_deposit<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &T0) {
        verify_adapter_access<T0>(arg0, arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::balance_sheet::record_deposit<T0>(&mut arg0.balance_sheet, arg1);
    }

    public fun set_adapter_name<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x1::string::String, arg2: &T0) {
        verify_adapter_access<T0>(arg0, arg2);
        arg0.current_adapter = arg1;
    }

    public(friend) fun set_current_adapter(arg0: &mut AuthorizedTransferTicket, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: 0x1::string::String) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg1);
        arg0.current_adapter = arg2;
    }

    public(friend) fun set_policies(arg0: &mut AuthorizedTransferTicket, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg1);
        arg0.policies = arg2;
    }

    public fun supports_asset_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.base_asset_types)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.base_asset_types, v0) == 0x1::type_name::with_defining_ids<T0>()) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun verify_adapter_access<T0>(arg0: &AuthorizedTransferTicket, arg1: &T0) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>(&arg0.policies) && !v0) {
            if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::is_adapter_type_allowed(0x1::vector::borrow<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>(&arg0.policies, v1), 0x1::type_name::with_defining_ids<T0>())) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::errors::adapter_not_whitelisted());
    }

    public fun withdraw_coin<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &T1, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_adapter_access<T1>(arg0, arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::withdraw<T0>(&mut arg0.assets, arg1, arg3)
    }

    public(friend) fun withdraw_coin_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::withdraw<T0>(&mut arg0.assets, arg1, arg2)
    }

    public(friend) fun withdraw_object_internal<T0: store + key>(arg0: &mut AuthorizedTransferTicket) : T0 {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public(friend) fun withdraw_performance_fee<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::withdraw<T0>(&mut arg0.perf_fee, arg1, arg2)
    }

    public(friend) fun withdraw_reward_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

