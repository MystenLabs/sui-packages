module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault {
    struct WithdrawalRequest has copy, drop, store {
        owner: address,
        receiver: address,
        shares: u64,
        estimated_withdraw_amount: u64,
        timestamp: u64,
        sequence_number: u128,
    }

    struct Account has copy, drop, store {
        total_pending_withdrawal_shares: u64,
        pending_withdrawal_requests: vector<WithdrawalRequest>,
        cancel_withdraw_request: vector<u128>,
    }

    struct PlatformFee has copy, drop, store {
        accrued: u64,
        last_charged_at: u64,
    }

    struct Rate has copy, drop, store {
        value: u64,
        max_rate_change_per_update: u64,
        rate_update_interval: u64,
        last_updated_at: u64,
    }

    struct EmberShareConfig has copy, drop, store {
        whitelisted: bool,
        fee_percentage: u64,
        max_capacity_percentage: u64,
        holdback_percentage: u64,
        epoch_started_at: u64,
        epoch_used_amount: u64,
        max_utilization_percentage: u64,
        fee_multiplier_curve: vector<FeeMultiplierTier>,
        min_swap_gross: u64,
        max_held_value_absolute: u64,
    }

    struct FeeMultiplierTier has copy, drop, store {
        threshold: u64,
        multiplier: u64,
    }

    struct HoldbackEntry has copy, drop, store {
        share_vault_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
        created_at: u64,
        sequence_number: u128,
    }

    struct WithdrawalFee has store {
        permanent_fee_percentage: u64,
        time_based_fee_percentage: u64,
        time_based_fee_threshold: u64,
        fee_exempt: vector<address>,
        last_deposit_ts: 0x2::table::Table<address, u64>,
    }

    struct AtomicLiquidityVault<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        admin: address,
        operator: address,
        rate_manager: address,
        sub_accounts: vector<address>,
        blacklisted: vector<address>,
        paused_deposits: bool,
        paused_withdrawals: bool,
        paused_privileged_operations: bool,
        rate: Rate,
        fee_percentage: u64,
        fee: PlatformFee,
        shares: 0x2::table::Table<address, u64>,
        total_shares: u64,
        pending_burn_shares: u64,
        min_withdrawal_shares: u64,
        max_tvl: u64,
        balance: 0x2::balance::Balance<T0>,
        pending_withdrawals: 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<WithdrawalRequest>,
        accounts: 0x2::table::Table<address, Account>,
        strategy_kind: u8,
        max_instant_withdraw_shares: u64,
        cumulative_instant_withdraw_shares: u64,
        instant_withdraw_fee_percentage: u64,
        ember_share_configs: 0x2::table::Table<0x2::object::ID, EmberShareConfig>,
        holdback_queues: 0x2::table::Table<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>,
        fee_waived_addresses: vector<address>,
        holdback_waived_addresses: vector<address>,
        redemption_active_sources: 0x2::vec_set::VecSet<0x2::object::ID>,
        sequence_number: u128,
    }

    struct ShareVaultTicket {
        dummy_field: bool,
    }

    struct CollectedEmberSharesKey has copy, drop, store {
        source_vault_id: 0x2::object::ID,
    }

    fun assert_admin<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 8000);
    }

    fun assert_admin_or_operator<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || v0 == arg0.operator, 8000);
    }

    fun assert_backing_strategy<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: u8) {
        assert!(arg0.strategy_kind == arg1 || arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_none(), 8026);
    }

    fun assert_deposit_from_sub_account_allowed<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg3);
        assert!(0x1::vector::contains<address>(&arg0.sub_accounts, &arg2), 8001);
    }

    fun assert_fee_curve_monotonic(arg0: &vector<FeeMultiplierTier>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<FeeMultiplierTier>(arg0)) {
            assert!(0x1::vector::borrow<FeeMultiplierTier>(arg0, v0).multiplier >= 0x1::vector::borrow<FeeMultiplierTier>(arg0, v0 - 1).multiplier, 8024);
            v0 = v0 + 1;
        };
    }

    fun assert_operator<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 8000);
    }

    fun assert_rate_manager<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.rate_manager, 8000);
    }

    public fun available_instant_withdraw_shares<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        let v0 = arg0.max_instant_withdraw_shares;
        let v1 = arg0.cumulative_instant_withdraw_shares;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun balance_of<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, arg1)
        } else {
            0
        }
    }

    fun bump_sequence<T0>(arg0: &mut AtomicLiquidityVault<T0>) : u128 {
        arg0.sequence_number = arg0.sequence_number + 1;
        arg0.sequence_number
    }

    public fun calculate_amount_from_shares<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: u64) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div_ceil(arg1, arg0.rate.value)
    }

    public fun calculate_shares_from_amount<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: u64) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(arg1, arg0.rate.value)
    }

    public fun cancel_pending_withdrawal_request<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_withdrawals, 8006);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Account>(&arg0.accounts, v0), 8013);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        let (v2, _) = 0x1::vector::index_of<u128>(&v1.cancel_withdraw_request, &arg2);
        assert!(!v2, 8012);
        let v4 = &v1.pending_withdrawal_requests;
        let v5 = 0;
        let v6;
        while (v5 < 0x1::vector::length<WithdrawalRequest>(v4)) {
            if (0x1::vector::borrow<WithdrawalRequest>(v4, v5).sequence_number == arg2) {
                v6 = 0x1::option::some<u64>(v5);
                /* label 14 */
                assert!(0x1::option::is_some<u64>(&v6), 8012);
                let v7 = 0x1::vector::borrow<WithdrawalRequest>(&v1.pending_withdrawal_requests, *0x1::option::borrow<u64>(&v6));
                0x1::vector::push_back<u128>(&mut v1.cancel_withdraw_request, arg2);
                0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_request_cancelled_event(0x2::object::uid_to_inner(&arg0.id), v7.owner, v7.sequence_number, v1.cancel_withdraw_request);
                return
            };
            v5 = v5 + 1;
        };
        v6 = 0x1::option::none<u64>();
        /* goto 14 */
    }

    public fun change_vault_admin<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg3: address) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::assert_role_candidate_valid(arg3, arg0.admin, arg0.operator, arg0.rate_manager, &arg0.sub_accounts, &arg0.blacklisted);
        let v0 = arg0.admin;
        arg0.admin = arg3;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_admin_changed_event(0x2::object::uid_to_inner(&arg0.id), v0, arg3, v1);
    }

    public fun change_vault_operator<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg3);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::assert_role_candidate_valid(arg2, arg0.admin, arg0.operator, arg0.rate_manager, &arg0.sub_accounts, &arg0.blacklisted);
        let v0 = arg0.operator;
        arg0.operator = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_operator_changed_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    public fun change_vault_rate_update_interval<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_admin<T0>(arg0, arg3);
        assert!(arg2 >= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_min_rate_interval(arg1) && arg2 <= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_max_rate_interval(arg1), 8010);
        assert!(arg2 != arg0.rate.rate_update_interval, 8014);
        let v0 = arg0.rate.rate_update_interval;
        arg0.rate.rate_update_interval = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_rate_update_interval_changed_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    fun charge_accrued_platform_fees<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.fee.last_charged_at;
        if (v0 == v1) {
            return
        };
        if (arg0.fee_percentage == 0) {
            arg0.fee.last_charged_at = v0;
            return
        };
        let v2 = get_vault_tvl_u128<T0>(arg0);
        let v3 = (arg0.fee.accrued as u128);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        let v5 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::compute_platform_fee_delta(v4, arg0.fee_percentage, v1, v0);
        arg0.fee.last_charged_at = v0;
        if (v5 == 0) {
            return
        };
        arg0.fee.accrued = arg0.fee.accrued + v5;
        let v6 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_platform_fee_charged_event(0x2::object::uid_to_inner(&arg0.id), v5, arg0.fee.accrued, arg0.fee.last_charged_at, v6);
    }

    public fun claim_received_collateral<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg3);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2);
        let v1 = 0x2::coin::value<T0>(&v0);
        assert!(v1 > 0, 8004);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v0));
        let v3 = 0x2::balance::value<T0>(&arg0.balance);
        let v4 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_deposit_without_minting_shares_event<T0>(0x2::object::uid_to_inner(&arg0.id), @0x0, v2, v3, v1, v4);
    }

    public fun claim_returned_ember_shares<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg4);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_id<T0, T1>(arg2);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg0.id, arg3);
        let v2 = 0x2::coin::value<T1>(&v1);
        assert!(v2 > 0, 8004);
        let v3 = CollectedEmberSharesKey{source_vault_id: v0};
        let v4 = 0x2::coin::into_balance<T1>(v1);
        let v5 = if (0x2::dynamic_field::exists_with_type<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&arg0.id, v3)) {
            let v6 = 0x2::dynamic_field::borrow_mut<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v3);
            0x2::balance::join<T1>(v6, v4);
            0x2::balance::value<T1>(v6)
        } else {
            0x2::dynamic_field::add<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v3, v4);
            0x2::balance::value<T1>(&v4)
        };
        let v7 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_ember_shares_returned_event<T1>(0x2::object::uid_to_inner(&arg0.id), v0, v2, v5, v7);
    }

    public fun claim_suilend_strategy_reward<T0, T1, T2, T3>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: address, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_admin_or_operator<T0>(arg0, arg7);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(0x1::vector::contains<address>(&arg0.sub_accounts, &arg3), 8001);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::claim_suilend_reward<T1, T2, T3>(&arg0.id, arg2, arg6, arg4, arg5, arg7);
        forward_strategy_reward<T0, T3>(arg0, arg3, v0)
    }

    public fun collect_platform_fee<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg4);
        charge_accrued_platform_fees<T0>(arg0, arg3);
        let v0 = arg0.fee.accrued;
        assert!(v0 > 0, 8004);
        assert!(arg2 <= v0, 8011);
        let v1 = v0 - arg2;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v1, 8007);
        arg0.fee.accrued = 0;
        let v2 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_platform_fee_recipient(arg1);
        assert!(v2 != @0x0, 8001);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg4), v2);
        };
        let v3 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_atomic_protocol_fee_collected_event<T0>(0x2::object::uid_to_inner(&arg0.id), v1, arg2, 0x2::balance::value<T0>(&arg0.balance), v2, v3);
    }

    public fun create_atomic_liquidity_vault<T0>(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<address>, arg12: &mut 0x2::tx_context::TxContext) : (AtomicLiquidityVault<T0>, ShareVaultTicket) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg0);
        assert!(arg9 >= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_min_rate_interval(arg0) && arg9 <= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_max_rate_interval(arg0), 8010);
        assert!(arg8 > 0, 8011);
        assert!(arg10 > 0, 8011);
        assert!(arg6 > 0 && arg6 < 1000000000, 8011);
        let v0 = if (arg3 != @0x0) {
            if (arg4 != @0x0) {
                if (arg5 != @0x0) {
                    if (arg3 != arg4) {
                        if (arg3 != arg5) {
                            if (arg4 != arg5) {
                                if (!0x1::vector::contains<address>(&arg11, &arg3)) {
                                    if (!0x1::vector::contains<address>(&arg11, &arg4)) {
                                        !0x1::vector::contains<address>(&arg11, &arg5)
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8001);
        assert!(arg7 <= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_max_allowed_fee_percentage(arg0), 8003);
        let v1 = 0;
        let v2 = 0x1::vector::length<address>(&arg11);
        while (v1 < v2) {
            let v3 = *0x1::vector::borrow<address>(&arg11, v1);
            assert!(v3 != @0x0, 8001);
            let v4 = v1 + 1;
            while (v4 < v2) {
                assert!(v3 != *0x1::vector::borrow<address>(&arg11, v4), 8001);
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        let v5 = 0x2::object::new(arg12);
        let v6 = Rate{
            value                      : 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_default_rate(arg0),
            max_rate_change_per_update : arg6,
            rate_update_interval       : arg9,
            last_updated_at            : 0,
        };
        let v7 = PlatformFee{
            accrued         : 0,
            last_charged_at : 0,
        };
        let v8 = AtomicLiquidityVault<T0>{
            id                                 : v5,
            name                               : arg2,
            admin                              : arg3,
            operator                           : arg4,
            rate_manager                       : arg5,
            sub_accounts                       : arg11,
            blacklisted                        : 0x1::vector::empty<address>(),
            paused_deposits                    : false,
            paused_withdrawals                 : false,
            paused_privileged_operations       : false,
            rate                               : v6,
            fee_percentage                     : arg7,
            fee                                : v7,
            shares                             : 0x2::table::new<address, u64>(arg12),
            total_shares                       : 0,
            pending_burn_shares                : 0,
            min_withdrawal_shares              : arg8,
            max_tvl                            : arg10,
            balance                            : 0x2::balance::zero<T0>(),
            pending_withdrawals                : 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::new<WithdrawalRequest>(arg12),
            accounts                           : 0x2::table::new<address, Account>(arg12),
            strategy_kind                      : 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_none(),
            max_instant_withdraw_shares        : 0,
            cumulative_instant_withdraw_shares : 0,
            instant_withdraw_fee_percentage    : 0,
            ember_share_configs                : 0x2::table::new<0x2::object::ID, EmberShareConfig>(arg12),
            holdback_queues                    : 0x2::table::new<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(arg12),
            fee_waived_addresses               : 0x1::vector::empty<address>(),
            holdback_waived_addresses          : 0x1::vector::empty<address>(),
            redemption_active_sources          : 0x2::vec_set::empty<0x2::object::ID>(),
            sequence_number                    : 0,
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_atomic_vault_created_event<T0>(0x2::object::uid_to_inner(&v5), arg2, arg3, arg4, arg5, arg11, arg8, arg7, arg6, arg9, v6.value, arg10);
        let v9 = ShareVaultTicket{dummy_field: false};
        (v8, v9)
    }

    fun current_held_share_value_in_collateral<T0, T1>(arg0: &AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: u64) : u64 {
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_id<T0, T1>(arg1);
        let v1 = CollectedEmberSharesKey{source_vault_id: v0};
        let v2 = if (0x2::dynamic_field::exists_with_type<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&arg0.id, v1)) {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&arg0.id, v1))
        } else {
            0
        };
        let v3 = if (!0x2::vec_set::is_empty<0x2::object::ID>(&arg0.redemption_active_sources) && 0x2::vec_set::contains<0x2::object::ID>(&arg0.redemption_active_sources, &v0)) {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_account_total_pending_withdrawal_shares<T0, T1>(arg1, 0x2::object::uid_to_address(&arg0.id))
        } else {
            0
        };
        let v4 = v2 + v3 + arg2;
        if (v4 == 0) {
            return 0
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::calculate_amount_from_shares_floor<T0, T1>(arg1, v4)
    }

    public fun decode_withdrawal_request(arg0: &WithdrawalRequest) : (address, address, u64, u64, u64, u128) {
        (arg0.owner, arg0.receiver, arg0.shares, arg0.estimated_withdraw_amount, arg0.timestamp, arg0.sequence_number)
    }

    fun decrement_account_shares(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        assert!(*v0 >= arg2, 8009);
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            0x2::table::remove<address, u64>(arg0, arg1);
        };
    }

    public fun deposit<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_deposits, 8006);
        charge_accrued_platform_fees<T0>(arg0, arg5);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &v0), 8008);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &arg4), 8008);
        assert!(!0x1::vector::contains<address>(&arg0.sub_accounts, &v0), 8016);
        assert!(!0x1::vector::contains<address>(&arg0.sub_accounts, &arg4), 8016);
        if (0x2::dynamic_field::exists_with_type<vector<u8>, vector<address>>(&arg0.id, b"deposit_user_list")) {
            assert!(0x1::vector::contains<address>(0x2::dynamic_field::borrow<vector<u8>, vector<address>>(&arg0.id, b"deposit_user_list"), &v0), 8028);
        };
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 8004);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        let v2 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v1, arg0.rate.value);
        assert!(v2 > 0, 8004);
        assert!(v2 >= arg3, 8017);
        let v3 = &mut arg0.shares;
        let v4 = increment_account_shares(v3, arg4, v2);
        arg0.total_shares = arg0.total_shares + v2;
        assert!(get_vault_tvl_u128<T0>(arg0) <= (arg0.max_tvl as u128), 8015);
        let v5 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_deposit_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg4, v1, v2, 0x2::balance::value<T0>(&arg0.balance) - v1, 0x2::balance::value<T0>(&arg0.balance), arg0.total_shares, v5);
        let v6 = if (0x2::table::contains<address, Account>(&arg0.accounts, arg4)) {
            0x2::table::borrow<address, Account>(&arg0.accounts, arg4).total_pending_withdrawal_shares
        } else {
            0
        };
        let v7 = (v4 as u128) + (v6 as u128);
        ensure_withdrawal_fee_exists<T0>(arg0, arg6);
        let v8 = 0x2::clock::timestamp_ms(arg5);
        let v9 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, WithdrawalFee>(&mut arg0.id, b"withdrawal_fee").last_deposit_ts;
        let v10 = 0x2::table::contains<address, u64>(v9, arg4);
        let v11 = if (v10) {
            *0x2::table::borrow<address, u64>(v9, arg4)
        } else {
            v8
        };
        if (v10) {
            *0x2::table::borrow_mut<address, u64>(v9, arg4) = (((v7 * (v11 as u128) + (v2 as u128) * (v8 as u128)) / (v7 + (v2 as u128))) as u64);
        } else {
            0x2::table::add<address, u64>(v9, arg4, (((v7 * (v11 as u128) + (v2 as u128) * (v8 as u128)) / (v7 + (v2 as u128))) as u64));
        };
        v2
    }

    public fun deposit_from_sub_account<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert_deposit_from_sub_account_allowed<T0>(arg0, arg1, arg3, arg4);
        let v0 = 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2));
        deposit_from_sub_account_internal<T0>(arg0, v0, arg3);
    }

    fun deposit_from_sub_account_internal<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 8004);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_deposit_without_minting_shares_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg2, v1, v2, v0, v3);
    }

    public fun deposit_from_sub_account_v2<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert_deposit_from_sub_account_allowed<T0>(arg0, arg1, arg3, arg4);
        assert!(arg2 > 0, 8004);
        let v0 = 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2));
        deposit_from_sub_account_internal<T0>(arg0, v0, arg3);
    }

    fun do_instant_withdraw_core<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_withdrawals, 8006);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &v0), 8008);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &arg3), 8008);
        assert!(arg3 != @0x0, 8031);
        assert!(arg2 > 0, 8004);
        assert!(arg2 >= arg0.min_withdrawal_shares, 8009);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.shares, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, v0)
        } else {
            0
        };
        assert!(v1 >= arg2, 8009);
        let v2 = arg0.cumulative_instant_withdraw_shares + arg2;
        assert!(v2 <= arg0.max_instant_withdraw_shares, 8018);
        charge_accrued_platform_fees<T0>(arg0, arg4);
        bump_sequence<T0>(arg0);
        let v3 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div(arg2, arg0.rate.value);
        assert!(v3 > 0, 8004);
        let v4 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v3, arg0.instant_withdraw_fee_percentage);
        let v5 = &mut arg0.shares;
        decrement_account_shares(v5, v0, arg2);
        arg0.total_shares = arg0.total_shares - arg2;
        arg0.cumulative_instant_withdraw_shares = v2;
        if (v4 > 0) {
            arg0.fee.accrued = arg0.fee.accrued + v4;
        };
        (v3, v4, v3 - v4)
    }

    fun do_swap_ember_shares_core<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: address, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_withdrawals, 8006);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &v0), 8008);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &arg4), 8008);
        assert!(arg4 != @0x0, 8001);
        assert!(!0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::is_withdrawals_paused<T0, T1>(arg2), 8032);
        assert!(!0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::is_blacklisted<T0, T1>(arg2, 0x2::object::uid_to_address(&arg0.id)), 8008);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v1 > 0, 8004);
        let v2 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_id<T0, T1>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, v2), 8020);
        let v3 = 0x2::clock::timestamp_ms(arg7);
        let v4 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::calculate_amount_from_shares_floor<T0, T1>(arg2, v1);
        assert!(v4 > 0, 8004);
        let v5 = current_held_share_value_in_collateral<T0, T1>(arg0, arg2, v1);
        let v6 = get_vault_tvl<T0>(arg0);
        assert!(v6 > 0, 8023);
        let v7 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div(v5, v6);
        let v8 = 0x2::table::borrow_mut<0x2::object::ID, EmberShareConfig>(&mut arg0.ember_share_configs, v2);
        assert!(v8.whitelisted, 8020);
        assert!(v8.min_swap_gross == 0 || v4 >= v8.min_swap_gross, 8029);
        let v9 = if (v8.epoch_started_at == 0 || v3 >= v8.epoch_started_at + 86400000) {
            v8.epoch_started_at = v3;
            v8.epoch_used_amount = 0;
            0
        } else {
            v8.epoch_used_amount
        };
        assert!(v9 + v4 <= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_tvl<T0, T1>(arg2), v8.max_capacity_percentage), 8021);
        v8.epoch_used_amount = v9 + v4;
        assert!(v8.max_held_value_absolute == 0 || v5 <= v8.max_held_value_absolute, 8030);
        assert!(v8.max_utilization_percentage > 0, 8022);
        assert!(v7 <= v8.max_utilization_percentage, 8022);
        let v10 = lookup_fee_multiplier(&v8.fee_multiplier_curve, v7);
        let v11 = v8.holdback_percentage;
        let v12 = v8.epoch_used_amount;
        let v13 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v8.fee_percentage, v10);
        assert!(v13 < 1000000000, 8025);
        let v14 = 0x1::vector::contains<address>(&arg0.holdback_waived_addresses, &v0);
        let v15 = if (0x1::vector::contains<address>(&arg0.fee_waived_addresses, &v0)) {
            0
        } else {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v4, v13)
        };
        let v16 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v4, v11);
        let v17 = v15 + v16;
        assert!(v17 <= v4, 8025);
        let v18 = v4 - v17;
        let v19 = CollectedEmberSharesKey{source_vault_id: v2};
        if (0x2::dynamic_field::exists_with_type<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&arg0.id, v19)) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v19), 0x2::coin::into_balance<T1>(arg3));
        } else {
            0x2::dynamic_field::add<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v19, 0x2::coin::into_balance<T1>(arg3));
        };
        let v20 = if (v14) {
            v18 + v16
        } else {
            v18
        };
        assert!(v20 >= arg5, 8017);
        let v21 = if (v14) {
            0
        } else {
            v16
        };
        let v22 = &mut arg0.balance;
        let v23 = pay_exact<T0>(v22, v20, arg4, arg8);
        assert!(v23 >= arg5, 8017);
        if (v15 > 0) {
            arg0.fee.accrued = arg0.fee.accrued + v15;
        };
        if (v21 > 0) {
            ensure_holdback_queue_exists<T0>(arg0, v2, arg8);
            let v24 = HoldbackEntry{
                share_vault_id  : v2,
                receiver        : arg4,
                amount          : v21,
                created_at      : v3,
                sequence_number : arg6,
            };
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::enqueue<HoldbackEntry>(0x2::table::borrow_mut<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(&mut arg0.holdback_queues, v2), v24);
        };
        let v25 = if (v14) {
            v16
        } else {
            0
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_ember_share_swapped_event<T0>(0x2::object::uid_to_inner(&arg0.id), v2, v0, arg4, v1, v4, v15, v21, v16, v25, v23, v12, v7, v10, arg6);
        (v4, v15, v21, v18, v23)
    }

    fun emit_instant_withdraw<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_instant_withdrawn_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg1, arg2, arg3, arg4, arg5, arg6, arg0.cumulative_instant_withdraw_shares, arg0.total_shares, arg0.sequence_number);
    }

    fun ensure_holdback_queue_exists<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(&arg0.holdback_queues, arg1)) {
            0x2::table::add<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(&mut arg0.holdback_queues, arg1, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::new<HoldbackEntry>(arg2));
        };
    }

    fun ensure_liquidity_suilend<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 >= arg2) {
            return
        };
        let v1 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::withdraw_from_suilend<T1, T0>(&mut arg0.id, arg1, arg3, arg2 - v0, arg4);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_withdrawn_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.strategy_kind, 0x2::balance::value<T0>(&v1), arg0.sequence_number);
    }

    fun ensure_liquidity_suilend_sui<T0>(arg0: &mut AtomicLiquidityVault<0x2::sui::SUI>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3 == 0) {
            return
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 >= arg3) {
            return
        };
        let v1 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::withdraw_from_suilend_sui<T0>(&mut arg0.id, arg1, arg2, arg4, arg3 - v0, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_withdrawn_event<0x2::sui::SUI>(0x2::object::uid_to_inner(&arg0.id), arg0.strategy_kind, 0x2::balance::value<0x2::sui::SUI>(&v1), arg0.sequence_number);
    }

    fun ensure_withdrawal_fee_exists<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, WithdrawalFee>(&arg0.id, b"withdrawal_fee")) {
            0x2::dynamic_field::add<vector<u8>, WithdrawalFee>(&mut arg0.id, b"withdrawal_fee", init_withdrawal_fee(arg1));
        };
    }

    fun forward_strategy_reward<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: address, arg2: 0x2::coin::Coin<T1>) : u64 {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = bump_sequence<T0>(arg0);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, arg1);
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_reward_collected_event<T1>(0x2::object::uid_to_inner(&arg0.id), arg0.strategy_kind, v0, arg1, v1);
        v0
    }

    public fun get_account_cancelled_withdrawal_sequence_numbers<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address) : vector<u128> {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            0x1::vector::empty<u128>()
        } else {
            0x2::table::borrow<address, Account>(&arg0.accounts, arg1).cancel_withdraw_request
        }
    }

    public fun get_account_pending_withdrawal_requests<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address) : vector<WithdrawalRequest> {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            0x1::vector::empty<WithdrawalRequest>()
        } else {
            0x2::table::borrow<address, Account>(&arg0.accounts, arg1).pending_withdrawal_requests
        }
    }

    public fun get_account_total_pending_withdrawal_shares<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            0
        } else {
            0x2::table::borrow<address, Account>(&arg0.accounts, arg1).total_pending_withdrawal_shares
        }
    }

    public fun get_accrued_platform_fee<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.fee.accrued
    }

    public fun get_collected_ember_share_balance<T0, T1>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = CollectedEmberSharesKey{source_vault_id: arg1};
        if (!0x2::dynamic_field::exists_with_type<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&arg0.id, v0))
        }
    }

    public fun get_cumulative_instant_withdraw_shares<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.cumulative_instant_withdraw_shares
    }

    public fun get_ember_share_config<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID) : (bool, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1);
        (v0.whitelisted, v0.fee_percentage, v0.max_capacity_percentage, v0.holdback_percentage, v0.epoch_started_at, v0.epoch_used_amount)
    }

    public fun get_ember_share_fee_multiplier_at<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID, arg2: u64) : u64 {
        if (!0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1)) {
            return 1000000000
        };
        lookup_fee_multiplier(&0x2::table::borrow<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1).fee_multiplier_curve, arg2)
    }

    public fun get_ember_share_fee_multiplier_curve_length<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1)) {
            return 0
        };
        0x1::vector::length<FeeMultiplierTier>(&0x2::table::borrow<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1).fee_multiplier_curve)
    }

    public fun get_ember_share_fee_multiplier_tier_at<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID, arg2: u64) : (u64, u64) {
        let v0 = 0x1::vector::borrow<FeeMultiplierTier>(&0x2::table::borrow<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1).fee_multiplier_curve, arg2);
        (v0.threshold, v0.multiplier)
    }

    public fun get_ember_share_limits<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID) : (u64, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1);
        (v0.max_utilization_percentage, v0.min_swap_gross, v0.max_held_value_absolute)
    }

    public fun get_ember_share_max_utilization<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1)) {
            return 0
        };
        0x2::table::borrow<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1).max_utilization_percentage
    }

    public fun get_ember_share_utilization<T0, T1>(arg0: &AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>) : u64 {
        let v0 = current_held_share_value_in_collateral<T0, T1>(arg0, arg1, 0);
        if (v0 == 0) {
            return 0
        };
        let v1 = get_vault_tvl<T0>(arg0);
        if (v1 == 0) {
            return 0
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div(v0, v1)
    }

    public fun get_holdback_queue_length<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(&arg0.holdback_queues, arg1)) {
            0
        } else {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::len<HoldbackEntry>(0x2::table::borrow<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(&arg0.holdback_queues, arg1))
        }
    }

    public fun get_instant_withdraw_fee_percentage<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.instant_withdraw_fee_percentage
    }

    public fun get_max_instant_withdraw_shares<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.max_instant_withdraw_shares
    }

    public fun get_pending_burn_shares<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.pending_burn_shares
    }

    public fun get_strategy_kind<T0>(arg0: &AtomicLiquidityVault<T0>) : u8 {
        arg0.strategy_kind
    }

    public fun get_suilend_obligation_id<T0>(arg0: &AtomicLiquidityVault<T0>) : 0x2::object::ID {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::suilend_obligation_id(&arg0.id)
    }

    public fun get_suilend_strategy_assets<T0, T1>(arg0: &AtomicLiquidityVault<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg2: &0x2::clock::Clock) : u64 {
        if (arg0.strategy_kind != 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend()) {
            return 0
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::get_suilend_supplied_value<T1, T0>(&arg0.id, arg1, arg2)
    }

    public fun get_total_backing_suilend<T0, T1>(arg0: &AtomicLiquidityVault<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg2: &0x2::clock::Clock) : u128 {
        assert_backing_strategy<T0>(arg0, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend());
        (0x2::balance::value<T0>(&arg0.balance) as u128) + (get_suilend_strategy_assets<T0, T1>(arg0, arg1, arg2) as u128)
    }

    public fun get_total_shares<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.total_shares
    }

    public fun get_vault_admin<T0>(arg0: &AtomicLiquidityVault<T0>) : address {
        arg0.admin
    }

    public fun get_vault_balance<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_vault_blacklisted<T0>(arg0: &AtomicLiquidityVault<T0>) : vector<address> {
        arg0.blacklisted
    }

    public fun get_vault_fee_percentage<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.fee_percentage
    }

    public fun get_vault_id<T0>(arg0: &AtomicLiquidityVault<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_vault_last_updated_at<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.rate.last_updated_at
    }

    public fun get_vault_max_rate_change_per_update<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.rate.max_rate_change_per_update
    }

    public fun get_vault_max_tvl<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.max_tvl
    }

    public fun get_vault_min_withdrawal_shares<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.min_withdrawal_shares
    }

    public fun get_vault_name<T0>(arg0: &AtomicLiquidityVault<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_vault_operator<T0>(arg0: &AtomicLiquidityVault<T0>) : address {
        arg0.operator
    }

    public fun get_vault_rate<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.rate.value
    }

    public fun get_vault_rate_manager<T0>(arg0: &AtomicLiquidityVault<T0>) : address {
        arg0.rate_manager
    }

    public fun get_vault_rate_update_interval<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        arg0.rate.rate_update_interval
    }

    public fun get_vault_sequence_number<T0>(arg0: &AtomicLiquidityVault<T0>) : u128 {
        arg0.sequence_number
    }

    public fun get_vault_sub_accounts<T0>(arg0: &AtomicLiquidityVault<T0>) : vector<address> {
        arg0.sub_accounts
    }

    public fun get_vault_tvl<T0>(arg0: &AtomicLiquidityVault<T0>) : u64 {
        if (arg0.total_shares == 0) {
            0
        } else {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div(arg0.total_shares, arg0.rate.value)
        }
    }

    public fun get_vault_tvl_u128<T0>(arg0: &AtomicLiquidityVault<T0>) : u128 {
        if (arg0.total_shares == 0) {
            0
        } else {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div_u128(arg0.total_shares, arg0.rate.value)
        }
    }

    public fun guardian_set_blacklisted_account<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_guardian(arg1, arg4);
        set_blacklisted_account_internal<T0>(arg0, arg2, arg3);
    }

    public fun guardian_set_pause_status<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: vector<u8>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_guardian(arg1, arg4);
        set_pause_status_internal<T0>(arg0, arg2, arg3);
    }

    public fun has_ember_share_config<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg1)
    }

    public fun has_suilend_obligation<T0>(arg0: &AtomicLiquidityVault<T0>) : bool {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::has_suilend_obligation(&arg0.id)
    }

    fun increment_account_shares(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) : u64 {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
            *v1 = *v1 + arg2;
            *v1
        } else {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
            0
        }
    }

    fun init_withdrawal_fee(arg0: &mut 0x2::tx_context::TxContext) : WithdrawalFee {
        WithdrawalFee{
            permanent_fee_percentage  : 0,
            time_based_fee_percentage : 0,
            time_based_fee_threshold  : 0,
            fee_exempt                : 0x1::vector::empty<address>(),
            last_deposit_ts           : 0x2::table::new<address, u64>(arg0),
        }
    }

    public fun instant_withdraw<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_none(), 8026);
        let (v0, v1, v2) = do_instant_withdraw_core<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v2, 8007);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg5), arg3);
        };
        emit_instant_withdraw<T0>(arg0, 0x2::tx_context::sender(arg5), arg3, arg2, v0, v1, v2);
        v2
    }

    public fun instant_withdraw_with_suilend<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        let (v1, v2, v3) = do_instant_withdraw_core<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
        ensure_liquidity_suilend<T0, T1>(arg0, arg2, v3, arg5, arg6);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg6), arg4);
        };
        emit_instant_withdraw<T0>(arg0, v0, arg4, arg3, v1, v2, v3);
        v3
    }

    public fun instant_withdraw_with_suilend_sui<T0>(arg0: &mut AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        let (v1, v2, v3) = do_instant_withdraw_core<0x2::sui::SUI>(arg0, arg1, arg4, arg5, arg6, arg7);
        ensure_liquidity_suilend_sui<T0>(arg0, arg2, arg3, v3, arg6, arg7);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg7), arg5);
        };
        emit_instant_withdraw<0x2::sui::SUI>(arg0, v0, arg5, arg4, v1, v2, v3);
        v3
    }

    public fun is_blacklisted<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.blacklisted, &arg1)
    }

    public fun is_fee_waived<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.fee_waived_addresses, &arg1)
    }

    public fun is_holdback_waived<T0>(arg0: &AtomicLiquidityVault<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.holdback_waived_addresses, &arg1)
    }

    public fun is_paused_deposits<T0>(arg0: &AtomicLiquidityVault<T0>) : bool {
        arg0.paused_deposits
    }

    public fun is_paused_privileged_operations<T0>(arg0: &AtomicLiquidityVault<T0>) : bool {
        arg0.paused_privileged_operations
    }

    public fun is_paused_withdrawals<T0>(arg0: &AtomicLiquidityVault<T0>) : bool {
        arg0.paused_withdrawals
    }

    fun lookup_fee_multiplier(arg0: &vector<FeeMultiplierTier>, arg1: u64) : u64 {
        let v0 = 1000000000;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeMultiplierTier>(arg0)) {
            let v2 = 0x1::vector::borrow<FeeMultiplierTier>(arg0, v1);
            if (arg1 >= v2.threshold) {
                v0 = v2.multiplier;
                v1 = v1 + 1;
            } else {
                break
            };
        };
        v0
    }

    public fun open_suilend_obligation<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_admin_or_operator<T0>(arg0, arg3);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::open_suilend_obligation<T1, T0>(&mut arg0.id, arg2, arg3);
        let v0 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_suilend_obligation_opened_event(0x2::object::uid_to_inner(&arg0.id), 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::suilend_market_id(&arg0.id), 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::suilend_obligation_id(&arg0.id), 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::suilend_reserve_index(&arg0.id), v0);
    }

    fun pay_exact<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg1 == 0) {
            return 0
        };
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 8007);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg3), arg2);
        arg1
    }

    public fun preview_swap_ember_shares<T0, T1>(arg0: &AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: u64, arg3: address) : u64 {
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_id<T0, T1>(arg1);
        if (!0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, v0)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, v0);
        if (!v1.whitelisted) {
            return 0
        };
        if (0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::is_withdrawals_paused<T0, T1>(arg1)) {
            return 0
        };
        if (0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::is_blacklisted<T0, T1>(arg1, 0x2::object::uid_to_address(&arg0.id))) {
            return 0
        };
        let v2 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::calculate_amount_from_shares_floor<T0, T1>(arg1, arg2);
        if (v2 == 0) {
            return 0
        };
        if (v1.min_swap_gross != 0 && v2 < v1.min_swap_gross) {
            return 0
        };
        let v3 = current_held_share_value_in_collateral<T0, T1>(arg0, arg1, arg2);
        if (v1.max_held_value_absolute != 0 && v3 > v1.max_held_value_absolute) {
            return 0
        };
        let v4 = get_vault_tvl<T0>(arg0);
        if (v4 == 0) {
            return 0
        };
        let v5 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div(v3, v4);
        if (v1.max_utilization_percentage == 0) {
            return 0
        };
        if (v5 > v1.max_utilization_percentage) {
            return 0
        };
        let v6 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v1.fee_percentage, lookup_fee_multiplier(&v1.fee_multiplier_curve, v5));
        if (v6 >= 1000000000) {
            return 0
        };
        let v7 = if (0x1::vector::contains<address>(&arg0.fee_waived_addresses, &arg3)) {
            0
        } else {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v2, v6)
        };
        let v8 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v2, v1.holdback_percentage);
        if (v7 + v8 > v2) {
            return 0
        };
        if (0x1::vector::contains<address>(&arg0.holdback_waived_addresses, &arg3)) {
            v2 - v7 - v8 + v8
        } else {
            v2 - v7 - v8
        }
    }

    fun process_request<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &WithdrawalRequest, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (bool, bool, u64, u64) {
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div(arg1.shares, arg0.rate.value);
        let v1 = v0;
        let v2 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1.owner);
        let v3 = 0x1::vector::length<u128>(&v2.cancel_withdraw_request);
        let (v4, v5) = 0x1::vector::index_of<u128>(&v2.cancel_withdraw_request, &arg1.sequence_number);
        let v6 = if (v4) {
            0x1::option::some<u64>(v5)
        } else {
            0x1::option::none<u64>()
        };
        let v7 = v6;
        let v8 = if (0x1::vector::contains<address>(&arg0.blacklisted, &arg1.owner)) {
            true
        } else if (0x1::vector::contains<address>(&arg0.blacklisted, &arg1.receiver)) {
            true
        } else if (v4) {
            true
        } else {
            v0 == 0
        };
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        if (v8) {
            if (!v4) {
                v7 = 0x1::option::some<u64>(v3);
            };
            v1 = 0;
            arg0.pending_burn_shares = arg0.pending_burn_shares - arg1.shares;
            let v12 = &mut arg0.shares;
            increment_account_shares(v12, arg1.owner, arg1.shares);
        } else {
            arg0.pending_burn_shares = arg0.pending_burn_shares - arg1.shares;
            arg0.total_shares = arg0.total_shares - arg1.shares;
            v9 = arg1.shares;
            if (0x2::dynamic_field::exists_with_type<vector<u8>, WithdrawalFee>(&arg0.id, b"withdrawal_fee")) {
                let v13 = 0x2::dynamic_field::borrow<vector<u8>, WithdrawalFee>(&arg0.id, b"withdrawal_fee");
                if (!0x1::vector::contains<address>(&v13.fee_exempt, &arg1.owner)) {
                    if (v13.permanent_fee_percentage > 0) {
                        v10 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v0, v13.permanent_fee_percentage);
                    };
                    if (v13.time_based_fee_percentage > 0 && v13.time_based_fee_threshold > 0) {
                        let v14 = if (0x2::table::contains<address, u64>(&v13.last_deposit_ts, arg1.owner)) {
                            *0x2::table::borrow<address, u64>(&v13.last_deposit_ts, arg1.owner)
                        } else {
                            0
                        };
                        let v15 = if (v14 == 0) {
                            true
                        } else if (arg2 < v14) {
                            true
                        } else {
                            v13.time_based_fee_threshold > arg2 - v14
                        };
                        if (v15) {
                            v11 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v0, v13.time_based_fee_percentage);
                        };
                    };
                    v1 = v0 - v10 + v11;
                };
            };
            assert!(v1 > 0, 8004);
            assert!(0x2::balance::value<T0>(&arg0.balance) >= v1, 8007);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg3), arg1.receiver);
        };
        update_account_state<T0>(arg0, arg1, false, v7);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_request_processed_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg1.owner, arg1.receiver, arg1.shares, v1, arg1.timestamp, arg2, v8, v4, arg0.total_shares, arg0.pending_burn_shares, arg0.sequence_number, arg1.sequence_number);
        if (v10 > 0 || v11 > 0) {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_withdrawal_fee_charged_event(0x2::object::uid_to_inner(&arg0.id), arg1.owner, arg1.sequence_number, v10, v11);
        };
        (v8, v4, v1, v9)
    }

    public fun process_withdrawal_requests<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_withdrawals, 8006);
        assert_operator<T0>(arg0, arg4);
        assert!(arg2 > 0, 8004);
        charge_accrued_platform_fees<T0>(arg0, arg3);
        bump_sequence<T0>(arg0);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::len<WithdrawalRequest>(&arg0.pending_withdrawals);
        let v6 = if (arg2 < v5) {
            arg2
        } else {
            v5
        };
        let v7 = 0;
        while (v7 < v6) {
            let v8 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::dequeue<WithdrawalRequest>(&mut arg0.pending_withdrawals);
            let (v9, v10, v11, v12) = process_request<T0>(arg0, &v8, 0x2::clock::timestamp_ms(arg3), arg4);
            v1 = v1 + 1;
            v0 = v0 + v12;
            v2 = v2 + v11;
            if (v9) {
                v3 = v3 + 1;
            };
            if (v10) {
                v4 = v4 + 1;
            };
            v7 = v7 + 1;
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_process_requests_summary_event(0x2::object::uid_to_inner(&arg0.id), v1, v3, v4, v0, v2, arg0.total_shares, arg0.pending_burn_shares, arg0.rate.value, arg0.sequence_number);
    }

    public fun process_withdrawal_requests_up_to_timestamp<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_withdrawals, 8006);
        assert_operator<T0>(arg0, arg4);
        charge_accrued_platform_fees<T0>(arg0, arg3);
        bump_sequence<T0>(arg0);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (!0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::is_empty<WithdrawalRequest>(&arg0.pending_withdrawals)) {
            if (0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::peek<WithdrawalRequest>(&arg0.pending_withdrawals).timestamp > arg2) {
                break
            };
            let v5 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::dequeue<WithdrawalRequest>(&mut arg0.pending_withdrawals);
            let (v6, v7, v8, v9) = process_request<T0>(arg0, &v5, 0x2::clock::timestamp_ms(arg3), arg4);
            v1 = v1 + 1;
            v0 = v0 + v9;
            v2 = v2 + v8;
            if (v6) {
                v3 = v3 + 1;
            };
            if (v7) {
                v4 = v4 + 1;
            };
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_process_requests_summary_event(0x2::object::uid_to_inner(&arg0.id), v1, v3, v4, v0, v2, arg0.total_shares, arg0.pending_burn_shares, arg0.rate.value, arg0.sequence_number);
    }

    public fun redeem_collected_ember_shares<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg5);
        assert!(arg3 > 0, 8004);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_id<T0, T1>(arg2);
        let v1 = CollectedEmberSharesKey{source_vault_id: v0};
        assert!(0x2::dynamic_field::exists_with_type<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&arg0.id, v1), 8012);
        let v2 = 0x2::dynamic_field::borrow_mut<CollectedEmberSharesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T1>(v2) >= arg3, 8007);
        let v3 = 0x2::balance::split<T1>(v2, arg3);
        let v4 = 0x2::balance::value<T1>(v2);
        let v5 = 0x2::object::uid_to_address(&arg0.id);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares_for_owner<T0, T1>(arg2, arg1, v3, v5, v5, arg4);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.redemption_active_sources, &v0)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.redemption_active_sources, v0);
        };
        let v6 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_ember_shares_redemption_initiated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg3, v4, v6);
    }

    public fun redeem_shares<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : WithdrawalRequest {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_withdrawals, 8006);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &v0), 8008);
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &arg3), 8008);
        assert!(arg3 != @0x0, 8031);
        assert!(arg2 >= arg0.min_withdrawal_shares, 8009);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.shares, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, v0)
        } else {
            0
        };
        assert!(v1 >= arg2, 8009);
        let v2 = &mut arg0.shares;
        decrement_account_shares(v2, v0, arg2);
        arg0.pending_burn_shares = arg0.pending_burn_shares + arg2;
        let v3 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::div(arg2, arg0.rate.value);
        bump_sequence<T0>(arg0);
        let v4 = WithdrawalRequest{
            owner                     : v0,
            receiver                  : arg3,
            shares                    : arg2,
            estimated_withdraw_amount : v3,
            timestamp                 : 0x2::clock::timestamp_ms(arg4),
            sequence_number           : arg0.sequence_number,
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::enqueue<WithdrawalRequest>(&mut arg0.pending_withdrawals, v4);
        update_account_state<T0>(arg0, &v4, true, 0x1::option::none<u64>());
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_request_redeemed_event<T0>(0x2::object::uid_to_inner(&arg0.id), v4.owner, v4.receiver, v4.shares, v4.timestamp, arg0.total_shares, arg0.pending_burn_shares, arg0.sequence_number);
        v4
    }

    public fun release_users_holdback<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg6);
        assert!(arg3 <= 1000000000, 8025);
        assert!(arg4 > 0, 8004);
        if (!0x2::table::contains<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(&arg0.holdback_queues, arg2)) {
            return (0, 0)
        };
        charge_accrued_platform_fees<T0>(arg0, arg5);
        let v0 = arg0.blacklisted;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0x2::table::borrow_mut<0x2::object::ID, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::Queue<HoldbackEntry>>(&mut arg0.holdback_queues, arg2);
        let v9 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::len<HoldbackEntry>(v8);
        let v10 = if (arg4 < v9) {
            arg4
        } else {
            v9
        };
        let v11 = 0;
        while (v11 < v10) {
            let v12 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::dequeue<HoldbackEntry>(v8);
            if (v11 == 0) {
                v6 = v12.sequence_number;
            };
            v7 = v12.sequence_number;
            v4 = v4 + 1;
            if (0x1::vector::contains<address>(&v0, &v12.receiver)) {
                v5 = v5 + 1;
                v11 = v11 + 1;
                continue
            };
            let v13 = if (arg3 == 0) {
                0
            } else {
                0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v12.amount, arg3)
            };
            let v14 = v13;
            let v15 = if (arg3 != 0) {
                if (v13 == 0) {
                    if (v12.amount > 0) {
                        v12.amount <= 100
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v15) {
                v14 = v12.amount;
            };
            if (v14 > 0) {
                0x1::vector::push_back<address>(&mut v1, v12.receiver);
                0x1::vector::push_back<u64>(&mut v2, v14);
                v3 = v3 + v14;
            };
            v11 = v11 + 1;
        };
        let v16 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue::head<HoldbackEntry>(v8);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v3, 8007);
        let v17 = 0;
        while (v17 < 0x1::vector::length<address>(&v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, *0x1::vector::borrow<u64>(&v2, v17)), arg6), *0x1::vector::borrow<address>(&v1, v17));
            v17 = v17 + 1;
        };
        let v18 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_holdback_released_event(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, v4, v5, v3, v16, v6, v7, v18);
        (v4, v3)
    }

    public fun remove_ember_share_fee_multiplier_tier<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg4);
        assert!(0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg2), 8020);
        let v0 = &mut 0x2::table::borrow_mut<0x2::object::ID, EmberShareConfig>(&mut arg0.ember_share_configs, arg2).fee_multiplier_curve;
        assert!(remove_fee_multiplier_tier(v0, arg3), 8012);
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_ember_share_fee_multiplier_tier_removed_event(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, v1);
    }

    fun remove_fee_multiplier_tier(arg0: &mut vector<FeeMultiplierTier>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeMultiplierTier>(arg0)) {
            if (0x1::vector::borrow<FeeMultiplierTier>(arg0, v0).threshold == arg1) {
                0x1::vector::remove<FeeMultiplierTier>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun set_blacklisted_account<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_operator<T0>(arg0, arg4);
        set_blacklisted_account_internal<T0>(arg0, arg2, arg3);
    }

    fun set_blacklisted_account_internal<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: address, arg2: bool) {
        assert!(!arg2 || !0x1::vector::contains<address>(&arg0.sub_accounts, &arg1), 8001);
        let v0 = arg0.blacklisted;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::update_accounts(&mut arg0.blacklisted, arg1, arg2);
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_blacklisted_account_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg0.blacklisted, arg1, arg2, v1);
    }

    public fun set_deposit_user_list<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_operator<T0>(arg0, arg4);
        assert!(!arg3 || !0x1::vector::contains<address>(&arg0.blacklisted, &arg2), 8008);
        let v0 = if (arg2 != arg0.admin) {
            if (arg2 != arg0.operator) {
                arg2 != arg0.rate_manager
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8001);
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, vector<address>>(&arg0.id, b"deposit_user_list")) {
            0x2::dynamic_field::add<vector<u8>, vector<address>>(&mut arg0.id, b"deposit_user_list", 0x1::vector::empty<address>());
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, vector<address>>(&mut arg0.id, b"deposit_user_list");
        let v2 = *v1;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::update_accounts(v1, arg2, arg3);
        let v3 = *v1;
        let v4 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_deposit_user_list_updated_event(0x2::object::uid_to_inner(&arg0.id), v2, v3, arg2, arg3, v4);
        if (0x1::vector::is_empty<address>(&v3)) {
            0x2::dynamic_field::remove<vector<u8>, vector<address>>(&mut arg0.id, b"deposit_user_list");
        };
    }

    public fun set_ember_share_fee_multiplier_tier<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg5);
        assert!(arg3 <= 1000000000, 8025);
        assert!(arg4 >= 1000000000 && arg4 <= 100000000000, 8024);
        assert!(0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg2), 8020);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, EmberShareConfig>(&mut arg0.ember_share_configs, arg2);
        let v1 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(v0.fee_percentage, arg4);
        assert!(v1 < 1000000000 && v1 + v0.holdback_percentage <= 1000000000, 8024);
        let v2 = &mut v0.fee_multiplier_curve;
        upsert_fee_multiplier_tier(v2, arg3, arg4);
        assert!(0x1::vector::length<FeeMultiplierTier>(&v0.fee_multiplier_curve) <= 20, 8024);
        assert_fee_curve_monotonic(&v0.fee_multiplier_curve);
        let v3 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_ember_share_fee_multiplier_tier_set_event(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, arg4, v3);
    }

    public fun set_ember_share_max_utilization<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg4);
        assert!(arg3 <= 1000000000, 8025);
        assert!(0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg2), 8020);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, EmberShareConfig>(&mut arg0.ember_share_configs, arg2);
        let v1 = v0.max_utilization_percentage;
        assert!(v1 != arg3, 8014);
        v0.max_utilization_percentage = arg3;
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_ember_share_utilization_updated_event(0x2::object::uid_to_inner(&arg0.id), arg2, v1, arg3, v2);
    }

    public fun set_ember_share_whitelist<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg10);
        let v0 = if (arg4 < 1000000000) {
            if (arg5 <= 1000000000) {
                if (arg6 <= 1000000000) {
                    arg7 <= 1000000000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8025);
        assert!(arg4 + arg6 <= 1000000000, 8025);
        if (0x2::table::contains<0x2::object::ID, EmberShareConfig>(&arg0.ember_share_configs, arg2)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, EmberShareConfig>(&mut arg0.ember_share_configs, arg2);
            v1.whitelisted = arg3;
            v1.fee_percentage = arg4;
            v1.max_capacity_percentage = arg5;
            v1.holdback_percentage = arg6;
            v1.max_utilization_percentage = arg7;
            v1.min_swap_gross = arg8;
            v1.max_held_value_absolute = arg9;
            let v2 = 0x1::vector::length<FeeMultiplierTier>(&v1.fee_multiplier_curve);
            if (v2 > 0) {
                let v3 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::mul(arg4, 0x1::vector::borrow<FeeMultiplierTier>(&v1.fee_multiplier_curve, v2 - 1).multiplier);
                assert!(v3 < 1000000000 && v3 + arg6 <= 1000000000, 8024);
            };
        } else {
            let v4 = EmberShareConfig{
                whitelisted                : arg3,
                fee_percentage             : arg4,
                max_capacity_percentage    : arg5,
                holdback_percentage        : arg6,
                epoch_started_at           : 0,
                epoch_used_amount          : 0,
                max_utilization_percentage : arg7,
                fee_multiplier_curve       : 0x1::vector::empty<FeeMultiplierTier>(),
                min_swap_gross             : arg8,
                max_held_value_absolute    : arg9,
            };
            0x2::table::add<0x2::object::ID, EmberShareConfig>(&mut arg0.ember_share_configs, arg2, v4);
        };
        let v5 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_ember_share_whitelist_updated_event(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v5);
    }

    public fun set_fee_exemption_list<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_operator<T0>(arg0, arg4);
        assert!(!arg3 || !0x1::vector::contains<address>(&arg0.blacklisted, &arg2), 8008);
        let v0 = if (arg2 != arg0.admin) {
            if (arg2 != arg0.operator) {
                arg2 != arg0.rate_manager
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8001);
        ensure_withdrawal_fee_exists<T0>(arg0, arg4);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, WithdrawalFee>(&mut arg0.id, b"withdrawal_fee");
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::update_accounts(&mut v1.fee_exempt, arg2, arg3);
        let v2 = v1.fee_exempt;
        let v3 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_fee_exempt_list_updated_event(0x2::object::uid_to_inner(&arg0.id), v1.fee_exempt, v2, arg2, arg3, v3);
    }

    public fun set_instant_withdraw_fee_percentage<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg3);
        assert!(arg2 < 1000000000, 8019);
        assert!(arg2 != arg0.instant_withdraw_fee_percentage, 8014);
        let v0 = arg0.instant_withdraw_fee_percentage;
        arg0.instant_withdraw_fee_percentage = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_instant_withdraw_fee_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    public fun set_max_instant_withdraw_shares<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg3);
        assert!(arg2 != arg0.max_instant_withdraw_shares, 8014);
        let v0 = arg0.max_instant_withdraw_shares;
        arg0.max_instant_withdraw_shares = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_instant_withdraw_limit_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, arg0.cumulative_instant_withdraw_shares, v1);
    }

    public fun set_min_withdrawal_shares<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg3);
        assert!(arg2 > 0, 8004);
        assert!(arg2 != arg0.min_withdrawal_shares, 8011);
        let v0 = arg0.min_withdrawal_shares;
        arg0.min_withdrawal_shares = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_min_withdrawal_shares_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    public fun set_pause_status<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: vector<u8>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg4);
        set_pause_status_internal<T0>(arg0, arg2, arg3);
    }

    fun set_pause_status_internal<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: vector<u8>, arg2: bool) {
        let v0 = if (arg1 == b"deposits") {
            if (arg0.paused_deposits == arg2) {
                false
            } else {
                arg0.paused_deposits = arg2;
                true
            }
        } else if (arg1 == b"withdrawals") {
            if (arg0.paused_withdrawals == arg2) {
                false
            } else {
                arg0.paused_withdrawals = arg2;
                true
            }
        } else {
            assert!(arg1 == b"privileged_operations", 8027);
            if (arg0.paused_privileged_operations == arg2) {
                false
            } else {
                arg0.paused_privileged_operations = arg2;
                true
            }
        };
        assert!(v0, 8005);
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_atomic_vault_pause_status_updated_event(0x2::object::uid_to_inner(&arg0.id), 0x1::string::utf8(arg1), arg2, v1);
    }

    public fun set_permanent_fee_percentage<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_admin<T0>(arg0, arg3);
        ensure_withdrawal_fee_exists<T0>(arg0, arg3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, WithdrawalFee>(&mut arg0.id, b"withdrawal_fee");
        let v1 = v0.permanent_fee_percentage;
        assert!(arg2 <= 500000000, 8003);
        assert!(arg2 + v0.time_based_fee_percentage <= 500000000, 8003);
        assert!(v1 != arg2, 8014);
        v0.permanent_fee_percentage = arg2;
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_permanent_fee_percentage_updated_event(0x2::object::uid_to_inner(&arg0.id), v1, arg2, v2);
    }

    public fun set_strategy_none_from_suilend<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_admin<T0>(arg0, arg4);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(!0x1::vector::is_empty<address>(&arg0.sub_accounts), 8033);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::clear_suilend_state<T1, T0>(&mut arg0.id, arg2, arg3, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg0.balance, v0);
        let v2 = arg0.strategy_kind;
        arg0.strategy_kind = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_none();
        let v3 = bump_sequence<T0>(arg0);
        if (v1 > 0) {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_withdrawn_event<T0>(0x2::object::uid_to_inner(&arg0.id), v2, v1, v3);
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_updated_event(0x2::object::uid_to_inner(&arg0.id), v2, arg0.strategy_kind, v3);
    }

    public fun set_strategy_none_from_suilend_sui<T0>(arg0: &mut AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_admin<0x2::sui::SUI>(arg0, arg5);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(!0x1::vector::is_empty<address>(&arg0.sub_accounts), 8033);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::clear_suilend_state_sui<T0>(&mut arg0.id, arg2, arg3, arg4, arg5);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v0);
        let v2 = arg0.strategy_kind;
        arg0.strategy_kind = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_none();
        let v3 = bump_sequence<0x2::sui::SUI>(arg0);
        if (v1 > 0) {
            0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_withdrawn_event<0x2::sui::SUI>(0x2::object::uid_to_inner(&arg0.id), v2, v1, v3);
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_updated_event(0x2::object::uid_to_inner(&arg0.id), v2, arg0.strategy_kind, v3);
    }

    public fun set_strategy_suilend<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg4);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_none(), 8026);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::init_suilend_state<T1, T0>(&mut arg0.id, arg2, arg3);
        let v0 = arg0.strategy_kind;
        arg0.strategy_kind = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend();
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg0.strategy_kind, v1);
    }

    public fun set_sub_account<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg4);
        assert!(!arg3 || !0x1::vector::contains<address>(&arg0.blacklisted, &arg2), 8008);
        let v0 = if (arg2 != arg0.admin) {
            if (arg2 != arg0.operator) {
                arg2 != arg0.rate_manager
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8001);
        let v1 = arg0.sub_accounts;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::update_accounts(&mut arg0.sub_accounts, arg2, arg3);
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_sub_account_updated_event(0x2::object::uid_to_inner(&arg0.id), v1, arg0.sub_accounts, arg2, arg3, v2);
    }

    public fun set_swap_waiver<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg5);
        assert!(arg2 != @0x0, 8001);
        let v0 = &mut arg0.fee_waived_addresses;
        toggle_address(v0, arg2, arg3);
        let v1 = &mut arg0.holdback_waived_addresses;
        toggle_address(v1, arg2, arg4);
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_swap_waiver_updated_event(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, arg4, v2);
    }

    public fun set_time_based_fee_percentage<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_admin<T0>(arg0, arg3);
        ensure_withdrawal_fee_exists<T0>(arg0, arg3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, WithdrawalFee>(&mut arg0.id, b"withdrawal_fee");
        let v1 = v0.time_based_fee_percentage;
        assert!(arg2 <= 500000000, 8003);
        assert!(arg2 + v0.permanent_fee_percentage <= 500000000, 8003);
        assert!(v1 != arg2, 8014);
        v0.time_based_fee_percentage = arg2;
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_time_based_fee_percentage_updated_event(0x2::object::uid_to_inner(&arg0.id), v1, arg2, v2);
    }

    public fun set_time_based_fee_threshold<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_admin<T0>(arg0, arg3);
        ensure_withdrawal_fee_exists<T0>(arg0, arg3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, WithdrawalFee>(&mut arg0.id, b"withdrawal_fee");
        let v1 = v0.time_based_fee_threshold;
        assert!(v1 != arg2, 8014);
        v0.time_based_fee_threshold = arg2;
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_time_based_fee_threshold_updated_event(0x2::object::uid_to_inner(&arg0.id), v1, arg2, v2);
    }

    public fun share_atomic_vault<T0>(arg0: AtomicLiquidityVault<T0>, arg1: ShareVaultTicket) {
        let ShareVaultTicket {  } = arg1;
        0x2::transfer::share_object<AtomicLiquidityVault<T0>>(arg0);
    }

    public fun solvency_margin<T0>(arg0: &AtomicLiquidityVault<T0>) : (u128, u128, bool) {
        let v0 = (0x2::balance::value<T0>(&arg0.balance) as u128);
        let v1 = get_vault_tvl_u128<T0>(arg0) + (arg0.fee.accrued as u128);
        (v0, v1, v0 >= v1)
    }

    public fun supply_to_sub_account<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg4);
        assert!(0x1::vector::contains<address>(&arg0.sub_accounts, &arg2), 8001);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg0.balance), 8007);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg4), arg2);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_withdrawal_without_redeeming_shares_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg2, v0, v1, arg3, v2);
    }

    public fun supply_to_suilend_strategy<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg5);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(arg3 > 0, 8004);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg3, 8007);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::supply_to_suilend<T1, T0>(&mut arg0.id, arg2, arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg5), arg5);
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_supplied_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.strategy_kind, v0, v1);
        v0
    }

    public fun swap_ember_shares<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_none(), 8026);
        charge_accrued_platform_fees<T0>(arg0, arg6);
        let v0 = bump_sequence<T0>(arg0);
        let (_, _, _, _, v5) = do_swap_ember_shares_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
        v5
    }

    public fun swap_ember_shares_with_suilend<T0, T1, T2>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: 0x2::coin::Coin<T1>, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        let v0 = preview_swap_ember_shares<T0, T1>(arg0, arg2, 0x2::coin::value<T1>(&arg4), 0x2::tx_context::sender(arg8));
        charge_accrued_platform_fees<T0>(arg0, arg7);
        let v1 = bump_sequence<T0>(arg0);
        ensure_liquidity_suilend<T0, T2>(arg0, arg3, v0, arg7, arg8);
        let (_, _, _, _, v6) = do_swap_ember_shares_core<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, v1, arg7, arg8);
        v6
    }

    public fun swap_ember_shares_with_suilend_sui<T0, T1>(arg0: &mut AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0x2::sui::SUI, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        let v0 = preview_swap_ember_shares<0x2::sui::SUI, T0>(arg0, arg2, 0x2::coin::value<T0>(&arg5), 0x2::tx_context::sender(arg9));
        charge_accrued_platform_fees<0x2::sui::SUI>(arg0, arg8);
        let v1 = bump_sequence<0x2::sui::SUI>(arg0);
        ensure_liquidity_suilend_sui<T1>(arg0, arg3, arg4, v0, arg8, arg9);
        let (_, _, _, _, v6) = do_swap_ember_shares_core<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg5, arg6, arg7, v1, arg8, arg9);
        v6
    }

    fun toggle_address(arg0: &mut vector<address>, arg1: address, arg2: bool) {
        let (v0, v1) = 0x1::vector::index_of<address>(arg0, &arg1);
        if (arg2 && !v0) {
            0x1::vector::push_back<address>(arg0, arg1);
        } else if (!arg2 && v0) {
            0x1::vector::remove<address>(arg0, v1);
        };
    }

    fun update_account_state<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &WithdrawalRequest, arg2: bool, arg3: 0x1::option::Option<u64>) {
        let v0 = arg2 && 0x1::option::is_some<u64>(&arg3);
        assert!(!v0, 8012);
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1.owner)) {
            let v1 = Account{
                total_pending_withdrawal_shares : 0,
                pending_withdrawal_requests     : 0x1::vector::empty<WithdrawalRequest>(),
                cancel_withdraw_request         : 0x1::vector::empty<u128>(),
            };
            0x2::table::add<address, Account>(&mut arg0.accounts, arg1.owner, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1.owner);
        if (arg2) {
            v2.total_pending_withdrawal_shares = v2.total_pending_withdrawal_shares + arg1.shares;
            0x1::vector::push_back<WithdrawalRequest>(&mut v2.pending_withdrawal_requests, *arg1);
        } else {
            v2.total_pending_withdrawal_shares = v2.total_pending_withdrawal_shares - arg1.shares;
            0x1::vector::remove<WithdrawalRequest>(&mut v2.pending_withdrawal_requests, 0);
            if (0x1::option::is_some<u64>(&arg3) && *0x1::option::borrow<u64>(&arg3) < 0x1::vector::length<u128>(&v2.cancel_withdraw_request)) {
                0x1::vector::remove<u128>(&mut v2.cancel_withdraw_request, *0x1::option::borrow<u64>(&arg3));
            };
        };
        if (v2.total_pending_withdrawal_shares == 0) {
            0x2::table::remove<address, Account>(&mut arg0.accounts, arg1.owner);
        };
    }

    public fun update_vault_fee_percentage<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg4);
        assert!(arg2 <= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_max_allowed_fee_percentage(arg1), 8003);
        assert!(arg2 != arg0.fee_percentage, 8014);
        charge_accrued_platform_fees<T0>(arg0, arg3);
        let v0 = arg0.fee_percentage;
        arg0.fee_percentage = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_fee_percentage_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    public fun update_vault_max_rate_change_per_update<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_admin<T0>(arg0, arg3);
        let v0 = if (arg2 > 0) {
            if (arg2 < 1000000000) {
                arg2 != arg0.rate.max_rate_change_per_update
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8011);
        let v1 = arg0.rate.max_rate_change_per_update;
        arg0.rate.max_rate_change_per_update = arg2;
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_max_rate_change_per_update_updated_event(0x2::object::uid_to_inner(&arg0.id), v1, arg2, v2);
    }

    public fun update_vault_max_tvl<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg3);
        assert!(arg2 > 0, 8011);
        assert!(arg2 != arg0.max_tvl, 8014);
        assert!(get_vault_tvl_u128<T0>(arg0) <= (arg2 as u128), 8015);
        let v0 = arg0.max_tvl;
        arg0.max_tvl = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_max_tvl_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    public fun update_vault_name<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert_admin<T0>(arg0, arg3);
        assert!(arg2 != arg0.name, 8014);
        let v0 = arg0.name;
        arg0.name = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_name_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    public fun update_vault_rate<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_rate_manager<T0>(arg0, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.rate.last_updated_at >= arg0.rate.rate_update_interval, 8010);
        let v1 = if (arg2 >= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_min_rate(arg1)) {
            if (arg2 <= 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::get_max_rate(arg1)) {
                0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::percent_change_from(arg0.rate.value, arg2) <= arg0.rate.max_rate_change_per_update
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 8002);
        assert!(arg2 != arg0.rate.value, 8014);
        charge_accrued_platform_fees<T0>(arg0, arg3);
        let v2 = arg0.rate.value;
        arg0.rate.value = arg2;
        arg0.rate.last_updated_at = v0;
        let v3 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_rate_updated_event(0x2::object::uid_to_inner(&arg0.id), v2, arg2, v3);
    }

    public fun update_vault_rate_manager<T0>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        assert_admin<T0>(arg0, arg3);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common::assert_role_candidate_valid(arg2, arg0.admin, arg0.operator, arg0.rate_manager, &arg0.sub_accounts, &arg0.blacklisted);
        let v0 = arg0.rate_manager;
        arg0.rate_manager = arg2;
        let v1 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_vault_rate_manager_updated_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2, v1);
    }

    fun upsert_fee_multiplier_tier(arg0: &mut vector<FeeMultiplierTier>, arg1: u64, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeMultiplierTier>(arg0)) {
            let v1 = 0x1::vector::borrow<FeeMultiplierTier>(arg0, v0);
            if (v1.threshold == arg1) {
                0x1::vector::borrow_mut<FeeMultiplierTier>(arg0, v0).multiplier = arg2;
                return
            };
            if (v1.threshold > arg1) {
                let v2 = FeeMultiplierTier{
                    threshold  : arg1,
                    multiplier : arg2,
                };
                0x1::vector::insert<FeeMultiplierTier>(arg0, v2, v0);
                return
            };
            v0 = v0 + 1;
        };
        let v3 = FeeMultiplierTier{
            threshold  : arg1,
            multiplier : arg2,
        };
        0x1::vector::push_back<FeeMultiplierTier>(arg0, v3);
    }

    public fun withdraw_from_suilend_strategy<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<T0>(arg0, arg5);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(arg3 > 0, 8004);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::withdraw_from_suilend<T1, T0>(&mut arg0.id, arg2, arg4, arg3, arg5);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg0.balance, v0);
        let v2 = bump_sequence<T0>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_withdrawn_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.strategy_kind, v1, v2);
        v1
    }

    public fun withdraw_from_suilend_strategy_sui<T0>(arg0: &mut AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_operator<0x2::sui::SUI>(arg0, arg6);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(arg4 > 0, 8004);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::withdraw_from_suilend_sui<T0>(&mut arg0.id, arg2, arg3, arg5, arg4, arg6);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v0);
        let v2 = bump_sequence<0x2::sui::SUI>(arg0);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_strategy_withdrawn_event<0x2::sui::SUI>(0x2::object::uid_to_inner(&arg0.id), arg0.strategy_kind, v1, v2);
        v1
    }

    public fun withdraw_suilend_secondary_collateral<T0, T1, T2>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_admin_or_operator<T0>(arg0, arg5);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(0x1::vector::contains<address>(&arg0.sub_accounts, &arg3), 8001);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::withdraw_secondary_collateral<T1, T2>(&arg0.id, arg2, arg4, arg5);
        forward_strategy_reward<T0, T2>(arg0, arg3, v0)
    }

    public fun withdraw_suilend_secondary_collateral_sui<T0, T1>(arg0: &mut AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_supported_package(arg1);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::verify_protocol_not_paused(arg1);
        assert!(!arg0.paused_privileged_operations, 8006);
        assert_admin_or_operator<T0>(arg0, arg6);
        assert!(arg0.strategy_kind == 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::strategy_suilend(), 8026);
        assert!(0x1::vector::contains<address>(&arg0.sub_accounts, &arg4), 8001);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy::withdraw_secondary_collateral_sui<T1>(&arg0.id, arg2, arg3, arg5, arg6);
        forward_strategy_reward<T0, 0x2::sui::SUI>(arg0, arg4, v0)
    }

    // decompiled from Move bytecode v7
}

