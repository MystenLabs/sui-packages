module 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket {
    struct AuthorizedTransferTicket {
        assets: 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::AssetStore,
        balance_sheet: 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet,
        account_id: 0x2::object::ID,
        policies: vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>,
        strategy_name: 0x1::string::String,
        current_adapter: 0x1::string::String,
        is_agent: bool,
        perf_fee: 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::AssetStore,
        perf_fee_val: u64,
    }

    public fun asset_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::asset_balance<T0>(&arg0.assets, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::create_asset_key<T0>())
    }

    public fun has_any_assets(arg0: &AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::has_any_assets(&arg0.assets)
    }

    public fun has_any_rewards(arg0: &AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::has_any_rewards(&arg0.assets)
    }

    public fun reward_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::reward_balance<T0>(&arg0.assets, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::create_reward_key<T0>())
    }

    public fun withdraw_object<T0: store + key, T1>(arg0: &mut AuthorizedTransferTicket, arg1: &T1) : T0 {
        verify_adapter_access<T1>(arg0, arg1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public fun withdraw_reward<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &T1, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_adapter_access<T1>(arg0, arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg1, arg3)
    }

    public fun has_adapter_record<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::has_adapter_record(&arg0.balance_sheet, 0x1::type_name::get<T0>())
    }

    public fun reset_adapter_deposits<T0>(arg0: &mut AuthorizedTransferTicket, arg1: &T0) {
        verify_adapter_access<T0>(arg0, arg1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::reset_adapter_deposits<T0>(&mut arg0.balance_sheet);
    }

    public fun adapter_total_deposited<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::total_deposited(&arg0.balance_sheet, 0x1::type_name::get<T0>())
    }

    public fun add_coin<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::coin::Coin<T0>, arg2: &T1) {
        verify_adapter_access<T1>(arg0, arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::deposit<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_coin_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::coin::Coin<T0>) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::deposit<T0>(&mut arg0.assets, arg1);
    }

    public fun add_object<T0: store + key, T1>(arg0: &mut AuthorizedTransferTicket, arg1: T0, arg2: &T1) {
        verify_adapter_access<T1>(arg0, arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::deposit_object<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_object_internal<T0: store + key>(arg0: &mut AuthorizedTransferTicket, arg1: T0) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::deposit_object<T0>(&mut arg0.assets, arg1);
    }

    public fun add_reward<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::balance::Balance<T0>, arg2: &T1) {
        verify_adapter_access<T1>(arg0, arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_reward_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::balance::Balance<T0>) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg1);
    }

    public(friend) fun assert_belongs_to_account(arg0: &AuthorizedTransferTicket, arg1: 0x2::object::ID) {
        assert!(arg0.account_id == arg1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::invalid_account());
    }

    public fun burn(arg0: AuthorizedTransferTicket, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount) {
        let AuthorizedTransferTicket {
            assets          : v0,
            balance_sheet   : v1,
            account_id      : _,
            policies        : _,
            strategy_name   : v4,
            current_adapter : _,
            is_agent        : _,
            perf_fee        : v7,
            perf_fee_val    : _,
        } = arg0;
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::destroy(v0);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::destroy(v7);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::return_balance_sheet(arg1, v4, v1);
    }

    public fun calculate_performance_fee(arg0: &AuthorizedTransferTicket, arg1: u64) : u64 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::math::safe_mul_div(arg1, arg0.perf_fee_val, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::constants::basis_points_divisor())
    }

    public fun collect_performance_fee<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x2::coin::Coin<T0>) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::deposit<T0>(&mut arg0.perf_fee, arg1);
    }

    public fun get_account_id(arg0: &AuthorizedTransferTicket) : 0x2::object::ID {
        arg0.account_id
    }

    public fun get_asset_keys(arg0: &AuthorizedTransferTicket) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::AssetKey> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::active_asset_keys(&arg0.assets)
    }

    public fun get_balance_sheet(arg0: &AuthorizedTransferTicket) : &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet {
        &arg0.balance_sheet
    }

    public fun get_current_adapter(arg0: &AuthorizedTransferTicket) : 0x1::string::String {
        arg0.current_adapter
    }

    public fun get_perf_fee_asset_keys(arg0: &AuthorizedTransferTicket) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::AssetKey> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::active_asset_keys(&arg0.perf_fee)
    }

    public fun get_perf_fee_val(arg0: &AuthorizedTransferTicket) : u64 {
        arg0.perf_fee_val
    }

    public fun get_policies(arg0: &AuthorizedTransferTicket) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy> {
        &arg0.policies
    }

    public fun get_reward_keys(arg0: &AuthorizedTransferTicket) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::RewardKey> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::active_reward_keys(&arg0.assets)
    }

    public fun get_strategy_name(arg0: &AuthorizedTransferTicket) : 0x1::string::String {
        arg0.strategy_name
    }

    public fun has_any_perf_fees(arg0: &AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::has_any_assets(&arg0.perf_fee)
    }

    public fun has_asset_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::has_asset_key(&arg0.assets, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::create_asset_key<T0>())
    }

    public fun has_reward_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::reward_exists(&arg0.assets, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::create_reward_key<T0>())
    }

    public fun is_agent_ticket(arg0: &AuthorizedTransferTicket) : bool {
        arg0.is_agent
    }

    public(friend) fun issue(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : AuthorizedTransferTicket {
        AuthorizedTransferTicket{
            assets          : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::new(arg5),
            balance_sheet   : arg2,
            account_id      : arg0,
            policies        : 0x1::vector::empty<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(),
            strategy_name   : arg1,
            current_adapter : 0x1::string::utf8(b""),
            is_agent        : arg3,
            perf_fee        : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::new(arg5),
            perf_fee_val    : arg4,
        }
    }

    public fun perf_fee_asset_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::asset_balance<T0>(&arg0.perf_fee, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::create_asset_key<T0>())
    }

    public fun record_adapter_deposit<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &T0) {
        verify_adapter_access<T0>(arg0, arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::record_deposit<T0>(&mut arg0.balance_sheet, arg1);
    }

    public fun set_adapter_name<T0>(arg0: &mut AuthorizedTransferTicket, arg1: 0x1::string::String, arg2: &T0) {
        verify_adapter_access<T0>(arg0, arg2);
        arg0.current_adapter = arg1;
    }

    public(friend) fun set_current_adapter(arg0: &mut AuthorizedTransferTicket, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::string::String) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        arg0.current_adapter = arg2;
    }

    public(friend) fun set_policies(arg0: &mut AuthorizedTransferTicket, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        arg0.policies = arg2;
    }

    public fun verify_adapter_access<T0>(arg0: &AuthorizedTransferTicket, arg1: &T0) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(&arg0.policies) && !v0) {
            if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::is_adapter_type_allowed(0x1::vector::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(&arg0.policies, v1), 0x1::type_name::get<T0>())) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::adapter_not_whitelisted());
    }

    public fun withdraw_coin<T0, T1>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &T1, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_adapter_access<T1>(arg0, arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::withdraw<T0>(&mut arg0.assets, arg1, arg3)
    }

    public(friend) fun withdraw_coin_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::withdraw<T0>(&mut arg0.assets, arg1, arg2)
    }

    public(friend) fun withdraw_object_internal<T0: store + key>(arg0: &mut AuthorizedTransferTicket) : T0 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public(friend) fun withdraw_performance_fee<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::withdraw<T0>(&mut arg0.perf_fee, arg1, arg2)
    }

    public(friend) fun withdraw_reward_internal<T0>(arg0: &mut AuthorizedTransferTicket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

