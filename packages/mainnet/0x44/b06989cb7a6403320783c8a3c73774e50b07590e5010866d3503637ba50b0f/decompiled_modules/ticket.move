module 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket {
    struct AuthorizedTransferTicket {
        issued_to: 0x2::object::ID,
        issuer: 0x2::object::ID,
        assets: 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::AssetStore,
        balance_sheet: 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet::BalanceSheet,
        account_id: 0x2::object::ID,
        policies: vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>,
        strategy_name: 0x1::string::String,
        current_adapter: 0x1::string::String,
        is_agent: bool,
        perf_fee: 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::AssetStore,
        perf_fee_val: u64,
    }

    public fun asset_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::asset_balance<T0>(&arg0.assets, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::create_asset_key<T0>())
    }

    public fun has_any_assets(arg0: &AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::has_any_assets(&arg0.assets)
    }

    public fun has_any_rewards(arg0: &AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::has_any_rewards(&arg0.assets)
    }

    public fun reward_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::reward_balance<T0>(&arg0.assets, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::create_reward_key<T0>())
    }

    public fun withdraw_object<T0: store + key, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: &T2) : T0 {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T2>(arg0, arg2);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public fun withdraw_reward<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &T2, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T2>(arg0, arg3);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg2, arg4)
    }

    public fun has_adapter_record<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet::has_adapter_record(&arg0.balance_sheet, 0x1::type_name::get<T0>())
    }

    public fun reset_adapter_deposits<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: &T0) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T0>(arg0, arg2);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet::reset_adapter_deposits<T0>(&mut arg0.balance_sheet);
    }

    public fun adapter_total_deposited<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet::total_deposited(&arg0.balance_sheet, 0x1::type_name::get<T0>())
    }

    public fun add_coin<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::coin::Coin<T0>, arg3: &T2) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T2>(arg0, arg3);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::deposit<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun add_coin_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::deposit<T0>(&mut arg0.assets, arg2);
    }

    public fun add_object<T0: store + key, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: T0, arg3: &T2) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T2>(arg0, arg3);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::deposit_object<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun add_object_internal<T0: store + key, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: T0) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::deposit_object<T0>(&mut arg0.assets, arg2);
    }

    public fun add_reward<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::balance::Balance<T0>, arg3: &T2) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T2>(arg0, arg3);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun add_reward_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::balance::Balance<T0>) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun assert_belongs_to_account(arg0: &AuthorizedTransferTicket, arg1: 0x2::object::ID) {
        assert!(arg0.account_id == arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_account());
    }

    public fun burn(arg0: AuthorizedTransferTicket, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount) {
        let AuthorizedTransferTicket {
            issued_to       : _,
            issuer          : _,
            assets          : v2,
            balance_sheet   : v3,
            account_id      : _,
            policies        : _,
            strategy_name   : v6,
            current_adapter : _,
            is_agent        : _,
            perf_fee        : v9,
            perf_fee_val    : _,
        } = arg0;
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::destroy(v2);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::destroy(v9);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::return_balance_sheet(arg1, v6, v3);
    }

    public fun calculate_performance_fee(arg0: &AuthorizedTransferTicket, arg1: u64) : u64 {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::math::safe_mul_div(arg1, arg0.perf_fee_val, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::constants::basis_points_divisor())
    }

    public fun collect_performance_fee<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::deposit<T0>(&mut arg0.perf_fee, arg2);
    }

    public fun get_account_id(arg0: &AuthorizedTransferTicket) : 0x2::object::ID {
        arg0.account_id
    }

    public fun get_asset_keys(arg0: &AuthorizedTransferTicket) : &vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::AssetKey> {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::active_asset_keys(&arg0.assets)
    }

    public fun get_balance_sheet(arg0: &AuthorizedTransferTicket) : &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet::BalanceSheet {
        &arg0.balance_sheet
    }

    public fun get_current_adapter(arg0: &AuthorizedTransferTicket) : 0x1::string::String {
        arg0.current_adapter
    }

    public fun get_issuer(arg0: &AuthorizedTransferTicket) : 0x2::object::ID {
        arg0.issuer
    }

    public fun get_perf_fee_asset_keys(arg0: &AuthorizedTransferTicket) : &vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::AssetKey> {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::active_asset_keys(&arg0.perf_fee)
    }

    public fun get_perf_fee_val(arg0: &AuthorizedTransferTicket) : u64 {
        arg0.perf_fee_val
    }

    public fun get_policies(arg0: &AuthorizedTransferTicket) : &vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy> {
        &arg0.policies
    }

    public fun get_reward_keys(arg0: &AuthorizedTransferTicket) : &vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::RewardKey> {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::active_reward_keys(&arg0.assets)
    }

    public fun get_strategy_name(arg0: &AuthorizedTransferTicket) : 0x1::string::String {
        arg0.strategy_name
    }

    public fun has_any_perf_fees(arg0: &AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::has_any_assets(&arg0.perf_fee)
    }

    public fun has_asset_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::has_asset_key(&arg0.assets, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::create_asset_key<T0>())
    }

    public fun has_reward_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::reward_exists(&arg0.assets, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::create_reward_key<T0>())
    }

    public fun is_agent_ticket(arg0: &AuthorizedTransferTicket) : bool {
        arg0.is_agent
    }

    public(friend) fun issue(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet::BalanceSheet, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : AuthorizedTransferTicket {
        AuthorizedTransferTicket{
            issued_to       : arg0,
            issuer          : arg1,
            assets          : 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::new(arg7),
            balance_sheet   : arg4,
            account_id      : arg2,
            policies        : 0x1::vector::empty<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>(),
            strategy_name   : arg3,
            current_adapter : 0x1::string::utf8(b""),
            is_agent        : arg5,
            perf_fee        : 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::new(arg7),
            perf_fee_val    : arg6,
        }
    }

    public fun perf_fee_asset_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::asset_balance<T0>(&arg0.perf_fee, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::create_asset_key<T0>())
    }

    public fun record_adapter_deposit<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &T0) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T0>(arg0, arg3);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet::record_deposit<T0>(&mut arg0.balance_sheet, arg2);
    }

    public fun set_adapter_name<T0: key, T1>(arg0: &mut AuthorizedTransferTicket, arg1: &T0, arg2: 0x1::string::String, arg3: &T1) {
        assert!(0x2::object::id<T0>(arg1) == arg0.issued_to || 0x2::object::id<T0>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T1>(arg0, arg3);
        arg0.current_adapter = arg2;
    }

    public(friend) fun set_current_adapter(arg0: &mut AuthorizedTransferTicket, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: 0x1::string::String) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg1);
        arg0.current_adapter = arg2;
    }

    public(friend) fun set_policies(arg0: &mut AuthorizedTransferTicket, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg1);
        arg0.policies = arg2;
    }

    public fun verify_adapter_access<T0>(arg0: &AuthorizedTransferTicket, arg1: &T0) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>(&arg0.policies) && !v0) {
            if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::is_adapter_type_allowed(0x1::vector::borrow<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>(&arg0.policies, v1), 0x1::type_name::get<T0>())) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::adapter_not_whitelisted());
    }

    public fun withdraw_coin<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &T2, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        verify_adapter_access<T2>(arg0, arg3);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::withdraw<T0>(&mut arg0.assets, arg2, arg4)
    }

    public(friend) fun withdraw_coin_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::withdraw<T0>(&mut arg0.assets, arg2, arg3)
    }

    public(friend) fun withdraw_object_internal<T0: store + key, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1) : T0 {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public(friend) fun withdraw_performance_fee<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::withdraw<T0>(&mut arg0.perf_fee, arg2, arg3)
    }

    public(friend) fun withdraw_reward_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::invalid_acl());
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

