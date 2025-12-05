module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events {
    struct PauseNonAdminOperationsEvent has copy, drop {
        status: bool,
    }

    struct SupportedVersionUpdateEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct PlatformFeeRecipientUpdateEvent has copy, drop {
        previous_recipient: address,
        new_recipient: address,
    }

    struct MinRateUpdateEvent has copy, drop {
        previous_min_rate: u64,
        new_min_rate: u64,
    }

    struct MaxRateUpdateEvent has copy, drop {
        previous_max_rate: u64,
        new_max_rate: u64,
    }

    struct DefaultRateUpdateEvent has copy, drop {
        previous_default_rate: u64,
        new_default_rate: u64,
    }

    struct VaultCreatedEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        admin: address,
        operator: address,
        sub_accounts: vector<address>,
        min_withdrawal_shares: u64,
        max_rate_change_per_update: u64,
        fee_percentage: u64,
        rate_update_interval: u64,
        rate: u64,
        max_tvl: u64,
    }

    struct VaultMaxTVLUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_max_tvl: u64,
        new_max_tvl: u64,
        sequence_number: u128,
    }

    struct VaultRateUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_rate: u64,
        new_rate: u64,
        sequence_number: u128,
    }

    struct VaultAdminChangedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_admin: address,
        new_admin: address,
        sequence_number: u128,
    }

    struct VaultOperatorChangedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_operator: address,
        new_operator: address,
        sequence_number: u128,
    }

    struct MaxAllowedFeePercentageUpdatedEvent has copy, drop, store {
        previous_max_fee_percentage: u64,
        new_max_fee_percentage: u64,
    }

    struct VaultFeePercentageUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_fee_percentage: u64,
        new_fee_percentage: u64,
        sequence_number: u128,
    }

    struct ProtocolFeeCollectedEvent<phantom T0> has copy, drop, store {
        vault_id: 0x2::object::ID,
        collected_fee: u64,
        current_vault_balance: u64,
        recipient: address,
        sequence_number: u128,
    }

    struct VaultPausedStatusUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        status: bool,
        sequence_number: u128,
    }

    struct VaultSubAccountUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_sub_accounts: vector<address>,
        new_sub_accounts: vector<address>,
        account: address,
        status: bool,
        sequence_number: u128,
    }

    struct VaultBlacklistedAccountUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_blacklisted: vector<address>,
        new_blacklisted: vector<address>,
        account: address,
        status: bool,
        sequence_number: u128,
    }

    struct VaultWithdrawalWithoutRedeemingSharesEvent<phantom T0> has copy, drop, store {
        vault_id: 0x2::object::ID,
        sub_account: address,
        previous_balance: u64,
        new_balance: u64,
        amount: u64,
        sequence_number: u128,
    }

    struct VaultDepositWithoutMintingSharesEvent<phantom T0> has copy, drop, store {
        vault_id: 0x2::object::ID,
        sub_account: address,
        previous_balance: u64,
        new_balance: u64,
        amount: u64,
        sequence_number: u128,
    }

    struct VaultDepositEvent<phantom T0> has copy, drop, store {
        vault_id: 0x2::object::ID,
        owner: address,
        total_amount: u64,
        shares_minted: u64,
        previous_balance: u64,
        current_balance: u64,
        total_shares: u64,
        sequence_number: u128,
    }

    struct RequestRedeemedEvent<phantom T0> has copy, drop, store {
        vault_id: 0x2::object::ID,
        owner: address,
        receiver: address,
        shares: u64,
        timestamp: u64,
        total_shares: u64,
        total_shares_pending_to_burn: u64,
        sequence_number: u128,
    }

    struct VaultPlatformFeeChargedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        fee_amount: u64,
        total_fee_accrued: u64,
        last_charged_at: u64,
        sequence_number: u128,
    }

    struct RequestProcessedEvent<phantom T0> has copy, drop, store {
        vault_id: 0x2::object::ID,
        owner: address,
        receiver: address,
        shares: u64,
        withdraw_amount: u64,
        request_timestamp: u64,
        processed_timestamp: u64,
        request_sequence_number: u128,
        skipped: bool,
        cancelled: bool,
        total_shares: u64,
        total_shares_pending_to_burn: u64,
        sequence_number: u128,
    }

    struct ProcessRequestsSummaryEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_request_processed: u64,
        requests_skipped: u64,
        requests_cancelled: u64,
        total_shares_burnt: u64,
        total_amount_withdrawn: u64,
        total_shares: u64,
        total_shares_pending_to_burn: u64,
        rate: u64,
        sequence_number: u128,
    }

    struct MinWithdrawalSharesUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_min_withdrawal_shares: u64,
        new_min_withdrawal_shares: u64,
        sequence_number: u128,
    }

    struct VaultRateUpdateIntervalChangedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_interval: u64,
        new_interval: u64,
        sequence_number: u128,
    }

    struct RequestCancelledEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        owner: address,
        sequence_number: u128,
        cancel_withdraw_request: vector<u128>,
    }

    struct MinRateIntervalUpdateEvent has copy, drop, store {
        previous_min_rate_interval: u64,
        new_min_rate_interval: u64,
    }

    struct MaxRateIntervalUpdateEvent has copy, drop, store {
        previous_max_rate_interval: u64,
        new_max_rate_interval: u64,
    }

    struct DefaultRateIntervalUpdateEvent has copy, drop, store {
        previous_default_rate_interval: u64,
        new_default_rate_interval: u64,
    }

    struct VaultNameUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_name: 0x1::string::String,
        new_name: 0x1::string::String,
        sequence_number: u128,
    }

    struct VaultRateManagerUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_manager: address,
        new_manager: address,
        sequence_number: u128,
    }

    struct VaultMaxRateChangePerUpdateUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        previous_max_rate_change_per_update: u64,
        new_max_rate_change_per_update: u64,
        sequence_number: u128,
    }

    public(friend) fun emit_default_rate_interval_update_event(arg0: u64, arg1: u64) {
        let v0 = DefaultRateIntervalUpdateEvent{
            previous_default_rate_interval : arg0,
            new_default_rate_interval      : arg1,
        };
        0x2::event::emit<DefaultRateIntervalUpdateEvent>(v0);
    }

    public(friend) fun emit_default_rate_update_event(arg0: u64, arg1: u64) {
        let v0 = DefaultRateUpdateEvent{
            previous_default_rate : arg0,
            new_default_rate      : arg1,
        };
        0x2::event::emit<DefaultRateUpdateEvent>(v0);
    }

    public(friend) fun emit_max_allowed_fee_percentage_updated_event(arg0: u64, arg1: u64) {
        let v0 = MaxAllowedFeePercentageUpdatedEvent{
            previous_max_fee_percentage : arg0,
            new_max_fee_percentage      : arg1,
        };
        0x2::event::emit<MaxAllowedFeePercentageUpdatedEvent>(v0);
    }

    public(friend) fun emit_max_rate_interval_update_event(arg0: u64, arg1: u64) {
        let v0 = MaxRateIntervalUpdateEvent{
            previous_max_rate_interval : arg0,
            new_max_rate_interval      : arg1,
        };
        0x2::event::emit<MaxRateIntervalUpdateEvent>(v0);
    }

    public(friend) fun emit_max_rate_update_event(arg0: u64, arg1: u64) {
        let v0 = MaxRateUpdateEvent{
            previous_max_rate : arg0,
            new_max_rate      : arg1,
        };
        0x2::event::emit<MaxRateUpdateEvent>(v0);
    }

    public(friend) fun emit_min_rate_interval_update_event(arg0: u64, arg1: u64) {
        let v0 = MinRateIntervalUpdateEvent{
            previous_min_rate_interval : arg0,
            new_min_rate_interval      : arg1,
        };
        0x2::event::emit<MinRateIntervalUpdateEvent>(v0);
    }

    public(friend) fun emit_min_rate_update_event(arg0: u64, arg1: u64) {
        let v0 = MinRateUpdateEvent{
            previous_min_rate : arg0,
            new_min_rate      : arg1,
        };
        0x2::event::emit<MinRateUpdateEvent>(v0);
    }

    public(friend) fun emit_min_withdrawal_shares_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = MinWithdrawalSharesUpdatedEvent{
            vault_id                       : arg0,
            previous_min_withdrawal_shares : arg1,
            new_min_withdrawal_shares      : arg2,
            sequence_number                : arg3,
        };
        0x2::event::emit<MinWithdrawalSharesUpdatedEvent>(v0);
    }

    public(friend) fun emit_pause_non_admin_operations_event(arg0: bool) {
        let v0 = PauseNonAdminOperationsEvent{status: arg0};
        0x2::event::emit<PauseNonAdminOperationsEvent>(v0);
    }

    public(friend) fun emit_platform_fee_recipient_update_event(arg0: address, arg1: address) {
        let v0 = PlatformFeeRecipientUpdateEvent{
            previous_recipient : arg0,
            new_recipient      : arg1,
        };
        0x2::event::emit<PlatformFeeRecipientUpdateEvent>(v0);
    }

    public(friend) fun emit_process_requests_summary_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128) {
        let v0 = ProcessRequestsSummaryEvent{
            vault_id                     : arg0,
            total_request_processed      : arg1,
            requests_skipped             : arg2,
            requests_cancelled           : arg3,
            total_shares_burnt           : arg4,
            total_amount_withdrawn       : arg5,
            total_shares                 : arg6,
            total_shares_pending_to_burn : arg7,
            rate                         : arg8,
            sequence_number              : arg9,
        };
        0x2::event::emit<ProcessRequestsSummaryEvent>(v0);
    }

    public(friend) fun emit_protocol_fee_collected_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u128) {
        let v0 = ProtocolFeeCollectedEvent<T0>{
            vault_id              : arg0,
            collected_fee         : arg1,
            current_vault_balance : arg2,
            recipient             : arg3,
            sequence_number       : arg4,
        };
        0x2::event::emit<ProtocolFeeCollectedEvent<T0>>(v0);
    }

    public(friend) fun emit_request_cancelled_event(arg0: 0x2::object::ID, arg1: address, arg2: u128, arg3: vector<u128>) {
        let v0 = RequestCancelledEvent{
            vault_id                : arg0,
            owner                   : arg1,
            sequence_number         : arg2,
            cancel_withdraw_request : arg3,
        };
        0x2::event::emit<RequestCancelledEvent>(v0);
    }

    public(friend) fun emit_request_processed_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: u128) {
        let v0 = RequestProcessedEvent<T0>{
            vault_id                     : arg0,
            owner                        : arg1,
            receiver                     : arg2,
            shares                       : arg3,
            withdraw_amount              : arg4,
            request_timestamp            : arg5,
            processed_timestamp          : arg6,
            request_sequence_number      : arg12,
            skipped                      : arg7,
            cancelled                    : arg8,
            total_shares                 : arg9,
            total_shares_pending_to_burn : arg10,
            sequence_number              : arg11,
        };
        0x2::event::emit<RequestProcessedEvent<T0>>(v0);
    }

    public(friend) fun emit_request_redeemed_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128) {
        let v0 = RequestRedeemedEvent<T0>{
            vault_id                     : arg0,
            owner                        : arg1,
            receiver                     : arg2,
            shares                       : arg3,
            timestamp                    : arg4,
            total_shares                 : arg5,
            total_shares_pending_to_burn : arg6,
            sequence_number              : arg7,
        };
        0x2::event::emit<RequestRedeemedEvent<T0>>(v0);
    }

    public(friend) fun emit_supported_version_update_event(arg0: u64, arg1: u64) {
        let v0 = SupportedVersionUpdateEvent{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<SupportedVersionUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_admin_changed_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u128) {
        let v0 = VaultAdminChangedEvent{
            vault_id        : arg0,
            previous_admin  : arg1,
            new_admin       : arg2,
            sequence_number : arg3,
        };
        0x2::event::emit<VaultAdminChangedEvent>(v0);
    }

    public(friend) fun emit_vault_blacklisted_account_updated_event(arg0: 0x2::object::ID, arg1: vector<address>, arg2: vector<address>, arg3: address, arg4: bool, arg5: u128) {
        let v0 = VaultBlacklistedAccountUpdatedEvent{
            vault_id             : arg0,
            previous_blacklisted : arg1,
            new_blacklisted      : arg2,
            account              : arg3,
            status               : arg4,
            sequence_number      : arg5,
        };
        0x2::event::emit<VaultBlacklistedAccountUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_created_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: vector<address>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = VaultCreatedEvent<T0, T1>{
            vault_id                   : arg0,
            name                       : arg1,
            admin                      : arg2,
            operator                   : arg3,
            sub_accounts               : arg4,
            min_withdrawal_shares      : arg5,
            max_rate_change_per_update : arg7,
            fee_percentage             : arg6,
            rate_update_interval       : arg8,
            rate                       : arg9,
            max_tvl                    : arg10,
        };
        0x2::event::emit<VaultCreatedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_vault_deposit_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128) {
        let v0 = VaultDepositEvent<T0>{
            vault_id         : arg0,
            owner            : arg1,
            total_amount     : arg2,
            shares_minted    : arg3,
            previous_balance : arg4,
            current_balance  : arg5,
            total_shares     : arg6,
            sequence_number  : arg7,
        };
        0x2::event::emit<VaultDepositEvent<T0>>(v0);
    }

    public(friend) fun emit_vault_deposit_without_minting_shares_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = VaultDepositWithoutMintingSharesEvent<T0>{
            vault_id         : arg0,
            sub_account      : arg1,
            previous_balance : arg2,
            new_balance      : arg3,
            amount           : arg4,
            sequence_number  : arg5,
        };
        0x2::event::emit<VaultDepositWithoutMintingSharesEvent<T0>>(v0);
    }

    public(friend) fun emit_vault_fee_percentage_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = VaultFeePercentageUpdatedEvent{
            vault_id                : arg0,
            previous_fee_percentage : arg1,
            new_fee_percentage      : arg2,
            sequence_number         : arg3,
        };
        0x2::event::emit<VaultFeePercentageUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_max_rate_change_per_update_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = VaultMaxRateChangePerUpdateUpdatedEvent{
            vault_id                            : arg0,
            previous_max_rate_change_per_update : arg1,
            new_max_rate_change_per_update      : arg2,
            sequence_number                     : arg3,
        };
        0x2::event::emit<VaultMaxRateChangePerUpdateUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_max_tvl_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = VaultMaxTVLUpdatedEvent{
            vault_id         : arg0,
            previous_max_tvl : arg1,
            new_max_tvl      : arg2,
            sequence_number  : arg3,
        };
        0x2::event::emit<VaultMaxTVLUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_name_updated_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u128) {
        let v0 = VaultNameUpdatedEvent{
            vault_id        : arg0,
            previous_name   : arg1,
            new_name        : arg2,
            sequence_number : arg3,
        };
        0x2::event::emit<VaultNameUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_operator_changed_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u128) {
        let v0 = VaultOperatorChangedEvent{
            vault_id          : arg0,
            previous_operator : arg1,
            new_operator      : arg2,
            sequence_number   : arg3,
        };
        0x2::event::emit<VaultOperatorChangedEvent>(v0);
    }

    public(friend) fun emit_vault_paused_status_updated_event(arg0: 0x2::object::ID, arg1: bool, arg2: u128) {
        let v0 = VaultPausedStatusUpdatedEvent{
            vault_id        : arg0,
            status          : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<VaultPausedStatusUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_platform_fee_charged_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u128) {
        let v0 = VaultPlatformFeeChargedEvent{
            vault_id          : arg0,
            fee_amount        : arg1,
            total_fee_accrued : arg2,
            last_charged_at   : arg3,
            sequence_number   : arg4,
        };
        0x2::event::emit<VaultPlatformFeeChargedEvent>(v0);
    }

    public(friend) fun emit_vault_rate_manager_updated_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u128) {
        let v0 = VaultRateManagerUpdatedEvent{
            vault_id         : arg0,
            previous_manager : arg1,
            new_manager      : arg2,
            sequence_number  : arg3,
        };
        0x2::event::emit<VaultRateManagerUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_rate_update_interval_changed_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = VaultRateUpdateIntervalChangedEvent{
            vault_id          : arg0,
            previous_interval : arg1,
            new_interval      : arg2,
            sequence_number   : arg3,
        };
        0x2::event::emit<VaultRateUpdateIntervalChangedEvent>(v0);
    }

    public(friend) fun emit_vault_rate_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = VaultRateUpdatedEvent{
            vault_id        : arg0,
            previous_rate   : arg1,
            new_rate        : arg2,
            sequence_number : arg3,
        };
        0x2::event::emit<VaultRateUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_sub_account_updated_event(arg0: 0x2::object::ID, arg1: vector<address>, arg2: vector<address>, arg3: address, arg4: bool, arg5: u128) {
        let v0 = VaultSubAccountUpdatedEvent{
            vault_id              : arg0,
            previous_sub_accounts : arg1,
            new_sub_accounts      : arg2,
            account               : arg3,
            status                : arg4,
            sequence_number       : arg5,
        };
        0x2::event::emit<VaultSubAccountUpdatedEvent>(v0);
    }

    public(friend) fun emit_vault_withdrawal_without_redeeming_shares_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = VaultWithdrawalWithoutRedeemingSharesEvent<T0>{
            vault_id         : arg0,
            sub_account      : arg1,
            previous_balance : arg2,
            new_balance      : arg3,
            amount           : arg4,
            sequence_number  : arg5,
        };
        0x2::event::emit<VaultWithdrawalWithoutRedeemingSharesEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

