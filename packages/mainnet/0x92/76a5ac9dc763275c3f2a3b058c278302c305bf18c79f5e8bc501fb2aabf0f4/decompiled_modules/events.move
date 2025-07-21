module 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events {
    struct DepositEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        asset_amount: u64,
        shares_value_minted: u64,
    }

    struct BulkWithdrawEvent<phantom T0, phantom T1> has copy, drop {
        witness: 0x1::type_name::TypeName,
        shares: u64,
        assets_returned: u64,
    }

    struct NewNonUserDepositableAssetAddedEvent<phantom T0, phantom T1> has copy, drop {
        dummy_field: bool,
    }

    struct WithdrawCapacityUpdatedEvent<phantom T0, phantom T1> has copy, drop {
        withdraw_capacity: u64,
    }

    struct NewVaultCreatedEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct EnableGlobalPauseEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct DisableGlobalPauseEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct VaultOperationsPauseToggledEvent<phantom T0> has copy, drop {
        new_is_paused: bool,
    }

    struct DepositLimitChanged<phantom T0> has copy, drop {
        deposit_limit: u64,
    }

    struct SelfSolverPolicyChanged<phantom T0> has copy, drop {
        allow_self_solvers: bool,
    }

    struct ThirdPartySolverPolicyChanged<phantom T0> has copy, drop {
        allow_third_party_solvers: bool,
    }

    struct FeesClaimedEvent<phantom T0> has copy, drop {
        fees_owed: u64,
    }

    struct NewUserDepositableAssetAddedEvent<phantom T0, phantom T1> has copy, drop {
        ms_to_maturity: u64,
        minimum_ms_to_deadline: u64,
        min_discount: u64,
        max_discount: u64,
        minimum_shares: u64,
        withdraw_capacity: u64,
    }

    struct UserDepositableAssetUpdatedEvent<phantom T0, phantom T1> has copy, drop {
        allow_withdraws: bool,
        allow_deposits: bool,
        ms_to_maturity: u64,
        minimum_ms_to_deadline: u64,
        min_discount: u64,
        max_discount: u64,
        minimum_shares: u64,
        withdraw_capacity: u64,
    }

    struct UserDepositableAssetRemoved<phantom T0, phantom T1> has copy, drop {
        dummy_field: bool,
    }

    struct VersionAccountantUpdated<phantom T0> has copy, drop {
        version: u64,
    }

    struct PriceFeedInserted<phantom T0> has copy, drop {
        key: 0x1::ascii::String,
        value: vector<u8>,
    }

    struct PriceFeedRemoved<phantom T0> has copy, drop {
        key: 0x1::ascii::String,
    }

    struct PriceFeedPeggedToBase<phantom T0> has copy, drop {
        key: 0x1::ascii::String,
    }

    struct PlatformFeeUpdated<phantom T0> has copy, drop {
        old_fee: u16,
        new_fee: u16,
    }

    struct PerformanceFeeUpdated<phantom T0> has copy, drop {
        old_fee: u16,
        new_fee: u16,
    }

    struct PayoutAddressUpdated<phantom T0> has copy, drop {
        old_address: address,
        new_address: address,
    }

    struct DelayInMsecondsUpdated<phantom T0> has copy, drop {
        old_delay: u64,
        new_delay: u64,
    }

    struct LowerBoundUpdated<phantom T0> has copy, drop {
        old_bound: u16,
        new_bound: u16,
    }

    struct UpperBoundUpdated<phantom T0> has copy, drop {
        old_bound: u16,
        new_bound: u16,
    }

    struct ExchangeRateUpdated<phantom T0> has copy, drop {
        old_rate: u64,
        new_rate: u64,
        current_time: u64,
    }

    struct VersionManagerUpdated<phantom T0> has copy, drop {
        version: u64,
    }

    struct VersionVaultUpdated<phantom T0> has copy, drop {
        version: u64,
    }

    struct StalenessThresholdUpdated<phantom T0> has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
    }

    struct SlippageThresholdUpdated<phantom T0> has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
    }

    struct AddCapabilityEvent<phantom T0> has copy, drop {
        account: address,
        cap_type: 0x1::type_name::TypeName,
    }

    struct RemoveCapabilityEvent<phantom T0> has copy, drop {
        account: address,
        cap_type: 0x1::type_name::TypeName,
    }

    struct AddBulkWithdrawCapabilityEvent<phantom T0> has copy, drop {
        owner: 0x1::ascii::String,
    }

    struct RemoveBulkWithdrawCapabilityEvent<phantom T0> has copy, drop {
        owner: 0x1::ascii::String,
    }

    struct ActionAuthorized<phantom T0> has copy, drop {
        strategist: address,
        action: 0x1::ascii::String,
    }

    struct ActionGranted<phantom T0> has copy, drop {
        strategist: address,
        action: 0x1::ascii::String,
    }

    struct ActionRemoved<phantom T0> has copy, drop {
        strategist: address,
        action: 0x1::ascii::String,
    }

    struct ArgsRemoved<phantom T0> has copy, drop {
        strategist: address,
        action: 0x1::ascii::String,
        args_array: vector<u8>,
    }

    struct StrategistRemoved<phantom T0> has copy, drop {
        strategist: address,
    }

    struct AssetsWithdrawn<phantom T0> has copy, drop {
        strategist: address,
        amount: u64,
    }

    struct AssetsReturned<phantom T0> has copy, drop {
        strategist: address,
        amount: u64,
    }

    struct Paused<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct HighwaterMarkReset<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    public(friend) fun emit_action_authorized<T0>(arg0: address, arg1: 0x1::ascii::String) {
        let v0 = ActionAuthorized<T0>{
            strategist : arg0,
            action     : arg1,
        };
        0x2::event::emit<ActionAuthorized<T0>>(v0);
    }

    public(friend) fun emit_action_granted<T0>(arg0: address, arg1: 0x1::ascii::String) {
        let v0 = ActionGranted<T0>{
            strategist : arg0,
            action     : arg1,
        };
        0x2::event::emit<ActionGranted<T0>>(v0);
    }

    public(friend) fun emit_action_removed<T0>(arg0: address, arg1: 0x1::ascii::String) {
        let v0 = ActionRemoved<T0>{
            strategist : arg0,
            action     : arg1,
        };
        0x2::event::emit<ActionRemoved<T0>>(v0);
    }

    public(friend) fun emit_add_bulk_withdraw_capability_event<T0>(arg0: 0x1::ascii::String) {
        let v0 = AddBulkWithdrawCapabilityEvent<T0>{owner: arg0};
        0x2::event::emit<AddBulkWithdrawCapabilityEvent<T0>>(v0);
    }

    public(friend) fun emit_add_capability_event<T0>(arg0: address, arg1: 0x1::type_name::TypeName) {
        let v0 = AddCapabilityEvent<T0>{
            account  : arg0,
            cap_type : arg1,
        };
        0x2::event::emit<AddCapabilityEvent<T0>>(v0);
    }

    public(friend) fun emit_args_removed<T0>(arg0: address, arg1: 0x1::ascii::String, arg2: vector<u8>) {
        let v0 = ArgsRemoved<T0>{
            strategist : arg0,
            action     : arg1,
            args_array : arg2,
        };
        0x2::event::emit<ArgsRemoved<T0>>(v0);
    }

    public(friend) fun emit_assets_returned<T0>(arg0: address, arg1: u64) {
        let v0 = AssetsReturned<T0>{
            strategist : arg0,
            amount     : arg1,
        };
        0x2::event::emit<AssetsReturned<T0>>(v0);
    }

    public(friend) fun emit_assets_withdrawn<T0>(arg0: address, arg1: u64) {
        let v0 = AssetsWithdrawn<T0>{
            strategist : arg0,
            amount     : arg1,
        };
        0x2::event::emit<AssetsWithdrawn<T0>>(v0);
    }

    public(friend) fun emit_bulk_withdraw_event<T0, T1>(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64) {
        let v0 = BulkWithdrawEvent<T0, T1>{
            witness         : arg0,
            shares          : arg1,
            assets_returned : arg2,
        };
        0x2::event::emit<BulkWithdrawEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_delay_in_mseconds_updated<T0>(arg0: u64, arg1: u64) {
        let v0 = DelayInMsecondsUpdated<T0>{
            old_delay : arg0,
            new_delay : arg1,
        };
        0x2::event::emit<DelayInMsecondsUpdated<T0>>(v0);
    }

    public(friend) fun emit_deposit_event<T0, T1>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = DepositEvent<T0, T1>{
            user                : arg0,
            asset_amount        : arg1,
            shares_value_minted : arg2,
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_deposit_limit_changed_event<T0>(arg0: u64) {
        let v0 = DepositLimitChanged<T0>{deposit_limit: arg0};
        0x2::event::emit<DepositLimitChanged<T0>>(v0);
    }

    public(friend) fun emit_disable_global_pause_event<T0>() {
        let v0 = DisableGlobalPauseEvent<T0>{dummy_field: false};
        0x2::event::emit<DisableGlobalPauseEvent<T0>>(v0);
    }

    public(friend) fun emit_enable_global_pause_event<T0>() {
        let v0 = EnableGlobalPauseEvent<T0>{dummy_field: false};
        0x2::event::emit<EnableGlobalPauseEvent<T0>>(v0);
    }

    public(friend) fun emit_exchange_rate_updated<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = ExchangeRateUpdated<T0>{
            old_rate     : arg0,
            new_rate     : arg1,
            current_time : arg2,
        };
        0x2::event::emit<ExchangeRateUpdated<T0>>(v0);
    }

    public(friend) fun emit_fees_claimed_event<T0>(arg0: u64) {
        let v0 = FeesClaimedEvent<T0>{fees_owed: arg0};
        0x2::event::emit<FeesClaimedEvent<T0>>(v0);
    }

    public(friend) fun emit_highwater_mark_reset<T0>() {
        let v0 = HighwaterMarkReset<T0>{dummy_field: false};
        0x2::event::emit<HighwaterMarkReset<T0>>(v0);
    }

    public(friend) fun emit_lower_bound_updated<T0>(arg0: u16, arg1: u16) {
        let v0 = LowerBoundUpdated<T0>{
            old_bound : arg0,
            new_bound : arg1,
        };
        0x2::event::emit<LowerBoundUpdated<T0>>(v0);
    }

    public(friend) fun emit_non_user_depositable_asset_added_event<T0, T1>() {
        let v0 = NewNonUserDepositableAssetAddedEvent<T0, T1>{dummy_field: false};
        0x2::event::emit<NewNonUserDepositableAssetAddedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_paused<T0>() {
        let v0 = Paused<T0>{dummy_field: false};
        0x2::event::emit<Paused<T0>>(v0);
    }

    public(friend) fun emit_payout_address_updated<T0>(arg0: address, arg1: address) {
        let v0 = PayoutAddressUpdated<T0>{
            old_address : arg0,
            new_address : arg1,
        };
        0x2::event::emit<PayoutAddressUpdated<T0>>(v0);
    }

    public(friend) fun emit_performance_fee_updated<T0>(arg0: u16, arg1: u16) {
        let v0 = PerformanceFeeUpdated<T0>{
            old_fee : arg0,
            new_fee : arg1,
        };
        0x2::event::emit<PerformanceFeeUpdated<T0>>(v0);
    }

    public(friend) fun emit_platform_fee_updated<T0>(arg0: u16, arg1: u16) {
        let v0 = PlatformFeeUpdated<T0>{
            old_fee : arg0,
            new_fee : arg1,
        };
        0x2::event::emit<PlatformFeeUpdated<T0>>(v0);
    }

    public(friend) fun emit_price_feed_inserted<T0>(arg0: 0x1::ascii::String, arg1: vector<u8>) {
        let v0 = PriceFeedInserted<T0>{
            key   : arg0,
            value : arg1,
        };
        0x2::event::emit<PriceFeedInserted<T0>>(v0);
    }

    public(friend) fun emit_price_feed_pegged_to_base<T0>(arg0: 0x1::ascii::String) {
        let v0 = PriceFeedPeggedToBase<T0>{key: arg0};
        0x2::event::emit<PriceFeedPeggedToBase<T0>>(v0);
    }

    public(friend) fun emit_price_feed_removed<T0>(arg0: 0x1::ascii::String) {
        let v0 = PriceFeedRemoved<T0>{key: arg0};
        0x2::event::emit<PriceFeedRemoved<T0>>(v0);
    }

    public(friend) fun emit_remove_bulk_withdraw_capability_event<T0>(arg0: 0x1::ascii::String) {
        let v0 = RemoveBulkWithdrawCapabilityEvent<T0>{owner: arg0};
        0x2::event::emit<RemoveBulkWithdrawCapabilityEvent<T0>>(v0);
    }

    public(friend) fun emit_remove_capability_event<T0>(arg0: address, arg1: 0x1::type_name::TypeName) {
        let v0 = RemoveCapabilityEvent<T0>{
            account  : arg0,
            cap_type : arg1,
        };
        0x2::event::emit<RemoveCapabilityEvent<T0>>(v0);
    }

    public(friend) fun emit_self_solver_policy_changed_event<T0>(arg0: bool) {
        let v0 = SelfSolverPolicyChanged<T0>{allow_self_solvers: arg0};
        0x2::event::emit<SelfSolverPolicyChanged<T0>>(v0);
    }

    public(friend) fun emit_slippage_threshold_updated<T0>(arg0: u64, arg1: u64) {
        let v0 = SlippageThresholdUpdated<T0>{
            old_threshold : arg0,
            new_threshold : arg1,
        };
        0x2::event::emit<SlippageThresholdUpdated<T0>>(v0);
    }

    public(friend) fun emit_staleness_threshold_updated<T0>(arg0: u64, arg1: u64) {
        let v0 = StalenessThresholdUpdated<T0>{
            old_threshold : arg0,
            new_threshold : arg1,
        };
        0x2::event::emit<StalenessThresholdUpdated<T0>>(v0);
    }

    public(friend) fun emit_strategist_removed<T0>(arg0: address) {
        let v0 = StrategistRemoved<T0>{strategist: arg0};
        0x2::event::emit<StrategistRemoved<T0>>(v0);
    }

    public(friend) fun emit_third_party_solver_policy_changed_event<T0>(arg0: bool) {
        let v0 = ThirdPartySolverPolicyChanged<T0>{allow_third_party_solvers: arg0};
        0x2::event::emit<ThirdPartySolverPolicyChanged<T0>>(v0);
    }

    public(friend) fun emit_unpaused<T0>() {
        let v0 = Unpaused<T0>{dummy_field: false};
        0x2::event::emit<Unpaused<T0>>(v0);
    }

    public(friend) fun emit_upper_bound_updated<T0>(arg0: u16, arg1: u16) {
        let v0 = UpperBoundUpdated<T0>{
            old_bound : arg0,
            new_bound : arg1,
        };
        0x2::event::emit<UpperBoundUpdated<T0>>(v0);
    }

    public(friend) fun emit_user_depositable_asset_added_event<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = NewUserDepositableAssetAddedEvent<T0, T1>{
            ms_to_maturity         : arg0,
            minimum_ms_to_deadline : arg1,
            min_discount           : arg2,
            max_discount           : arg3,
            minimum_shares         : arg4,
            withdraw_capacity      : arg5,
        };
        0x2::event::emit<NewUserDepositableAssetAddedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_user_depositable_asset_removed_event<T0, T1>() {
        let v0 = UserDepositableAssetRemoved<T0, T1>{dummy_field: false};
        0x2::event::emit<UserDepositableAssetRemoved<T0, T1>>(v0);
    }

    public(friend) fun emit_user_depositable_asset_updated_event<T0, T1>(arg0: bool, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = UserDepositableAssetUpdatedEvent<T0, T1>{
            allow_withdraws        : arg0,
            allow_deposits         : arg1,
            ms_to_maturity         : arg2,
            minimum_ms_to_deadline : arg3,
            min_discount           : arg4,
            max_discount           : arg5,
            minimum_shares         : arg6,
            withdraw_capacity      : arg7,
        };
        0x2::event::emit<UserDepositableAssetUpdatedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_vault_created_event<T0>() {
        let v0 = NewVaultCreatedEvent<T0>{dummy_field: false};
        0x2::event::emit<NewVaultCreatedEvent<T0>>(v0);
    }

    public(friend) fun emit_vault_operations_pause_toggled_event<T0>(arg0: bool) {
        let v0 = VaultOperationsPauseToggledEvent<T0>{new_is_paused: arg0};
        0x2::event::emit<VaultOperationsPauseToggledEvent<T0>>(v0);
    }

    public(friend) fun emit_version_accountant_updated<T0>(arg0: u64) {
        let v0 = VersionAccountantUpdated<T0>{version: arg0};
        0x2::event::emit<VersionAccountantUpdated<T0>>(v0);
    }

    public(friend) fun emit_version_manager_updated_event<T0>(arg0: u64) {
        let v0 = VersionManagerUpdated<T0>{version: arg0};
        0x2::event::emit<VersionManagerUpdated<T0>>(v0);
    }

    public(friend) fun emit_version_vault_updated_event<T0>(arg0: u64) {
        let v0 = VersionVaultUpdated<T0>{version: arg0};
        0x2::event::emit<VersionVaultUpdated<T0>>(v0);
    }

    public(friend) fun emit_withdraw_capacity_updated_event<T0, T1>(arg0: u64) {
        let v0 = WithdrawCapacityUpdatedEvent<T0, T1>{withdraw_capacity: arg0};
        0x2::event::emit<WithdrawCapacityUpdatedEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

