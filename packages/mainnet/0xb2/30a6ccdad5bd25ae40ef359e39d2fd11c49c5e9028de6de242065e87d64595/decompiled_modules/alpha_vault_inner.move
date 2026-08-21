module 0xb230a6ccdad5bd25ae40ef359e39d2fd11c49c5e9028de6de242065e87d64595::alpha_vault_inner {
    struct AlphaVaultInner<phantom T0, phantom T1> has store {
        access: AccessControl,
        wallets: WalletConfig,
        whitelist: WhitelistConfig,
        runtime: RuntimeState,
        fees: FeeConfig,
        limits: LimitConfig,
        schedule: ScheduleConfig,
        counters: Counters,
        balances: VaultBalances<T0, T1>,
        books: VaultBooks,
    }

    struct AccessControl has drop, store {
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        controllers: 0x2::vec_set::VecSet<address>,
        operators: 0x2::vec_set::VecSet<address>,
        assessors: 0x2::vec_set::VecSet<address>,
        settlers: 0x2::vec_set::VecSet<address>,
    }

    struct WalletConfig has drop, store {
        fee_collector: address,
        issuer_treasury_wallet: address,
    }

    struct WhitelistConfig has drop, store {
        enabled: bool,
        users: 0x2::vec_set::VecSet<address>,
    }

    struct RuntimeState has drop, store {
        pause_flags: u8,
        usage_day: u64,
        daily_subscribed_usdc: u128,
        daily_redeemed_shares: u128,
    }

    struct FeeConfig has drop, store {
        subscription_fee_bps: u64,
        redemption_fee_bps: u64,
        cancellation_fee_bps: u64,
        redemption_cancellation_fee_bps: u64,
    }

    struct LimitConfig has drop, store {
        min_subscription_usdc: u64,
        max_subscription_usdc_per_request: u64,
        max_redemption_shares_per_request: u128,
        daily_subscription_limit_per_user: u64,
        daily_subscription_limit_system: u64,
        daily_redemption_limit_per_user: u128,
        daily_redemption_limit_system: u128,
        max_user_position_shares: u128,
    }

    struct ScheduleConfig has drop, store {
        real_time_start_seconds_utc: u32,
        real_time_end_seconds_utc: u32,
    }

    struct Counters has drop, store {
        next_request_id: u64,
        next_batch_id: u64,
    }

    struct VaultBalances<phantom T0, phantom T1> has store {
        usdc_balance: 0x2::balance::Balance<T0>,
        xaua_balance: 0x2::balance::Balance<T1>,
        fee_balance: 0x2::balance::Balance<T0>,
        xaua_dust: 0x2::balance::Balance<T1>,
        usdc_dust: 0x2::balance::Balance<T0>,
    }

    struct VaultBooks has drop, store {
        positions: 0x2::vec_map::VecMap<address, UserPosition>,
        subscriptions: 0x2::vec_map::VecMap<u64, SubscriptionRequest>,
        redemptions: 0x2::vec_map::VecMap<u64, RedemptionRequest>,
        batches: 0x2::vec_map::VecMap<u64, Batch>,
        active_subscriptions: 0x2::vec_set::VecSet<u64>,
        active_redemptions: 0x2::vec_set::VecSet<u64>,
        active_batches: 0x2::vec_set::VecSet<u64>,
    }

    struct UserPosition has copy, drop, store {
        available_shares: u128,
        locked_shares: u128,
        claimable_usdc: u64,
        pending_subscription_shares: u128,
        usage_day: u64,
        total_subscribed_usdc: u64,
        total_redeemed_shares: u128,
        total_claimed_usdc: u64,
    }

    struct SubscriptionRequest has copy, drop, store {
        id: u64,
        user: address,
        status: u8,
        batch_id: u64,
        processing_mode: u8,
        gross_usdc: u64,
        fee_usdc: u64,
        net_usdc: u64,
        cancellation_fee_bps: u64,
        min_shares_out: u128,
        max_shares_out: u128,
        allocated_shares: u128,
        created_at_ms: u64,
        submitted_at_ms: u64,
        finalized_at_ms: u64,
    }

    struct RedemptionRequest has copy, drop, store {
        id: u64,
        user: address,
        status: u8,
        batch_id: u64,
        processing_mode: u8,
        locked_shares: u128,
        min_usdc_out: u64,
        redemption_fee_bps: u64,
        redemption_cancellation_fee_bps: u64,
        submitted_xaua: u128,
        claimable_usdc: u64,
        fee_usdc: u64,
        created_at_ms: u64,
        submitted_at_ms: u64,
        finalized_at_ms: u64,
        claimed_at_ms: u64,
    }

    struct Batch has copy, drop, store {
        id: u64,
        kind: u8,
        processing_mode: u8,
        status: u8,
        request_ids: vector<u64>,
        total_gross_amount: u128,
        total_fee_amount: u128,
        total_net_amount: u128,
        outbound_amount: u128,
        inbound_amount: u128,
        dust_amount: u128,
        created_at_ms: u64,
        submitted_at_ms: u64,
        finalized_at_ms: u64,
        settlement_reference: vector<u8>,
    }

    struct BatchReferenceSeed has drop {
        vault_id: address,
        kind: u8,
        batch_id: u64,
    }

    struct SubscriptionRequested has copy, drop {
        request_id: u64,
        user: address,
        gross_usdc: u64,
        fee_usdc: u64,
        net_usdc: u64,
        min_shares_out: u128,
        max_shares_out: u128,
        processing_mode: u8,
        timestamp_ms: u64,
    }

    struct RedemptionRequested has copy, drop {
        request_id: u64,
        user: address,
        locked_shares: u128,
        min_usdc_out: u64,
        redemption_fee_bps: u64,
        processing_mode: u8,
        timestamp_ms: u64,
    }

    struct BatchSubmitted has copy, drop {
        batch_id: u64,
        kind: u8,
        outbound_amount: u128,
        timestamp_ms: u64,
    }

    struct BatchPrepared has copy, drop {
        vault_id: address,
        batch_id: u64,
        kind: u8,
        outbound_amount: u128,
        settlement_reference: vector<u8>,
        timestamp_ms: u64,
    }

    struct VaultPaymentSent has copy, drop {
        vault_id: address,
        reference_id: u64,
        is_batch: bool,
        kind: u8,
        amount: u128,
        destination: address,
        settlement_reference: vector<u8>,
        timestamp_ms: u64,
    }

    struct RealtimeRequestSubmitted has copy, drop {
        request_id: u64,
        kind: u8,
        outbound_amount: u128,
        timestamp_ms: u64,
    }

    struct BatchFinalized has copy, drop {
        batch_id: u64,
        kind: u8,
        inbound_amount: u128,
        dust_amount: u128,
        timestamp_ms: u64,
    }

    struct BatchRequestsLinked has copy, drop {
        batch_id: u64,
        kind: u8,
        request_ids: vector<u64>,
        timestamp_ms: u64,
    }

    struct RequestFinalized has copy, drop {
        request_id: u64,
        user: address,
        kind: u8,
        settled_amount: u128,
        fee_amount: u64,
        timestamp_ms: u64,
    }

    struct RealtimeRequestFinalized has copy, drop {
        request_id: u64,
        kind: u8,
        inbound_amount: u128,
        dust_amount: u128,
        timestamp_ms: u64,
    }

    struct RequestRefunded has copy, drop {
        request_id: u64,
        user: address,
        kind: u8,
        refund_amount: u128,
        timestamp_ms: u64,
    }

    struct BatchRefunded has copy, drop {
        batch_id: u64,
        kind: u8,
        refund_amount: u128,
        timestamp_ms: u64,
    }

    struct BatchCancelled has copy, drop {
        batch_id: u64,
        kind: u8,
        timestamp_ms: u64,
    }

    struct ClaimExecuted has copy, drop {
        user: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ConfigUpdated has copy, drop {
        key: u8,
    }

    struct AdminTransferStarted has copy, drop {
        previous_admin: address,
        new_admin: address,
    }

    struct AdminTransferCompleted has copy, drop {
        previous_admin: address,
        new_admin: address,
    }

    struct AdminTransferCancelled has copy, drop {
        admin: address,
    }

    struct SubscriptionCancelled has copy, drop {
        request_id: u64,
        user: address,
        refund_amount: u64,
        cancel_fee: u64,
        timestamp_ms: u64,
    }

    struct RedemptionCancelled has copy, drop {
        request_id: u64,
        user: address,
        unlocked_shares: u128,
        timestamp_ms: u64,
    }

    struct BatchCreated has copy, drop {
        batch_id: u64,
        kind: u8,
        processing_mode: u8,
        request_count: u64,
        total_net_amount: u128,
        timestamp_ms: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct DustWithdrawn has copy, drop {
        usdc_amount: u64,
        xaua_amount: u64,
        recipient: address,
    }

    struct RoleGranted has copy, drop {
        role: u8,
        account: address,
    }

    struct RoleRevoked has copy, drop {
        role: u8,
        account: address,
    }

    public(friend) fun accept_admin<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.access.pending_admin), 20);
        let v0 = *0x1::option::borrow<address>(&arg0.access.pending_admin);
        assert!(0x2::tx_context::sender(arg1) == v0, 19);
        let v1 = arg0.access.admin;
        if (0x2::vec_set::contains<address>(&arg0.access.controllers, &v1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.controllers, &v1);
        };
        if (0x2::vec_set::contains<address>(&arg0.access.operators, &v1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.operators, &v1);
        };
        if (0x2::vec_set::contains<address>(&arg0.access.assessors, &v1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.assessors, &v1);
        };
        if (0x2::vec_set::contains<address>(&arg0.access.settlers, &v1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.settlers, &v1);
        };
        if (!0x2::vec_set::contains<address>(&arg0.access.controllers, &v0)) {
            0x2::vec_set::insert<address>(&mut arg0.access.controllers, v0);
        };
        if (!0x2::vec_set::contains<address>(&arg0.access.operators, &v0)) {
            0x2::vec_set::insert<address>(&mut arg0.access.operators, v0);
        };
        if (!0x2::vec_set::contains<address>(&arg0.access.assessors, &v0)) {
            0x2::vec_set::insert<address>(&mut arg0.access.assessors, v0);
        };
        arg0.access.admin = v0;
        arg0.access.pending_admin = 0x1::option::none<address>();
        let v2 = AdminTransferCompleted{
            previous_admin : v1,
            new_admin      : v0,
        };
        0x2::event::emit<AdminTransferCompleted>(v2);
    }

    public(friend) fun add_assessor<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::vec_set::contains<address>(&arg0.access.assessors, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.access.assessors, arg1);
            let v0 = RoleGranted{
                role    : 2,
                account : arg1,
            };
            0x2::event::emit<RoleGranted>(v0);
        };
    }

    public(friend) fun add_controller<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::vec_set::contains<address>(&arg0.access.controllers, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.access.controllers, arg1);
            let v0 = RoleGranted{
                role    : 0,
                account : arg1,
            };
            0x2::event::emit<RoleGranted>(v0);
        };
    }

    public(friend) fun add_operator<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::vec_set::contains<address>(&arg0.access.operators, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.access.operators, arg1);
            let v0 = RoleGranted{
                role    : 1,
                account : arg1,
            };
            0x2::event::emit<RoleGranted>(v0);
        };
    }

    public(friend) fun add_settler<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::vec_set::contains<address>(&arg0.access.settlers, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.access.settlers, arg1);
            let v0 = RoleGranted{
                role    : 3,
                account : arg1,
            };
            0x2::event::emit<RoleGranted>(v0);
        };
    }

    public(friend) fun add_to_whitelist<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_assessor<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::vec_set::contains<address>(&arg0.whitelist.users, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.whitelist.users, arg1);
        };
        let v0 = ConfigUpdated{key: 1};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    fun assert_admin<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        assert!(arg1 == arg0.access.admin, 0);
    }

    public(friend) fun assert_admin_public<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        assert_admin<T0, T1>(arg0, arg1);
    }

    fun assert_assessor<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        assert!(arg1 == arg0.access.admin || 0x2::vec_set::contains<address>(&arg0.access.assessors, &arg1), 0);
    }

    fun assert_batch_cancellation_allowed<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: u8, arg2: &vector<u64>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        if (arg3 == arg0.access.admin || 0x2::vec_set::contains<address>(&arg0.access.operators, &arg3)) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg5) >= arg4 + 86400000, 27);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg2)) {
            let v2 = if (arg1 == 0) {
                0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, 0x1::vector::borrow<u64>(arg2, v1)).user
            } else {
                0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, 0x1::vector::borrow<u64>(arg2, v1)).user
            };
            if (v2 == arg3) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0);
    }

    fun assert_controller<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        assert!(arg1 == arg0.access.admin || 0x2::vec_set::contains<address>(&arg0.access.controllers, &arg1), 0);
    }

    public(friend) fun assert_controller_public<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        assert_controller<T0, T1>(arg0, arg1);
    }

    fun assert_existing_state_within_limits<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64, arg3: u128, arg4: u128) {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.books.active_subscriptions);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            let v2 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, 0x1::vector::borrow<u64>(v0, v1));
            assert!(v2.gross_usdc >= arg1, 25);
            if (arg2 > 0) {
                assert!(v2.gross_usdc <= arg2, 25);
            };
            v1 = v1 + 1;
        };
        let v3 = 0x2::vec_set::keys<u64>(&arg0.books.active_redemptions);
        v1 = 0;
        while (v1 < 0x1::vector::length<u64>(v3)) {
            let v4 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, 0x1::vector::borrow<u64>(v3, v1));
            if (arg3 > 0) {
                assert!(v4.locked_shares <= arg3, 25);
            };
            v1 = v1 + 1;
        };
        if (arg4 > 0) {
            let v5 = 0x2::vec_map::keys<address, UserPosition>(&arg0.books.positions);
            v1 = 0;
            while (v1 < 0x1::vector::length<address>(&v5)) {
                let v6 = 0x2::vec_map::get<address, UserPosition>(&arg0.books.positions, 0x1::vector::borrow<address>(&v5, v1));
                assert!(v6.available_shares + v6.locked_shares + v6.pending_subscription_shares <= arg4, 25);
                v1 = v1 + 1;
            };
        };
    }

    fun assert_operator<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        assert!(arg1 == arg0.access.admin || 0x2::vec_set::contains<address>(&arg0.access.operators, &arg1), 0);
    }

    public(friend) fun assert_operator_public<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        assert_operator<T0, T1>(arg0, arg1);
    }

    public(friend) fun assert_pas_initializable<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) {
        assert!(0x2::vec_set::is_empty<u64>(&arg0.books.active_subscriptions), 8);
        assert!(0x2::vec_set::is_empty<u64>(&arg0.books.active_redemptions), 8);
        assert!(0x2::vec_set::is_empty<u64>(&arg0.books.active_batches), 8);
        assert!(0x2::balance::value<T1>(&arg0.balances.xaua_balance) == 0, 8);
        assert!(0x2::balance::value<T1>(&arg0.balances.xaua_dust) == 0, 8);
    }

    public(friend) fun assert_settler_or_operator<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        let v0 = if (arg1 == arg0.access.admin) {
            true
        } else if (0x2::vec_set::contains<address>(&arg0.access.operators, &arg1)) {
            true
        } else {
            0x2::vec_set::contains<address>(&arg0.access.settlers, &arg1)
        };
        assert!(v0, 0);
    }

    fun assert_user_allowed<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) {
        if (arg0.whitelist.enabled) {
            assert!(0x2::vec_set::contains<address>(&arg0.whitelist.users, &arg1), 1);
        };
    }

    fun assert_valid_subscription_limits(arg0: u64, arg1: u64) {
        assert!(arg1 == 0 || arg0 <= arg1, 25);
    }

    public(friend) fun batch<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: u64) : Batch {
        *0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1)
    }

    public fun batch_settlement_reference_bytes(arg0: &Batch) : vector<u8> {
        arg0.settlement_reference
    }

    public fun batch_status(arg0: &Batch) : u8 {
        arg0.status
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        (calculate_fee_u128((arg0 as u128), arg1) as u64)
    }

    fun calculate_fee_u128(arg0: u128, arg1: u64) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (10000 as u128);
        let v1 = (arg1 as u128);
        let v2 = arg0 % v0 * v1;
        let v3 = if (v2 % v0 > 0) {
            1
        } else {
            0
        };
        arg0 / v0 * v1 + v2 / v0 + v3
    }

    public(friend) fun cancel_admin_transfer<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.access.pending_admin = 0x1::option::none<address>();
        let v0 = AdminTransferCancelled{admin: arg0.access.admin};
        0x2::event::emit<AdminTransferCancelled>(v0);
    }

    public(friend) fun cancel_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg1);
        assert!(v1.user == v0, 0);
        assert!(v1.status == 0, 8);
        assert!(v1.batch_id == 0, 9);
        v1.status = 4;
        v1.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1.locked_shares;
        let v3 = calculate_fee_u128(v2, v1.redemption_cancellation_fee_bps);
        let v4 = v2 - v3;
        let v5 = position_mut<T0, T1>(arg0, v0);
        assert!(v5.locked_shares >= v2, 7);
        v5.locked_shares = v5.locked_shares - v2;
        v5.available_shares = v5.available_shares + v4;
        deactivate_redemption<T0, T1>(arg0, arg1);
        let v6 = RedemptionCancelled{
            request_id      : arg1,
            user            : v0,
            unlocked_shares : v4,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RedemptionCancelled>(v6);
        v3
    }

    public(friend) fun cancel_stale_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1);
        assert!(v0.kind == 1, 15);
        assert!(v0.status == 0 || v0.status == 6, 8);
        let v1 = v0.status;
        let v2 = v0.request_ids;
        assert_batch_cancellation_allowed<T0, T1>(arg0, 1, &v2, 0x2::tx_context::sender(arg3), v0.created_at_ms, arg2);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v2)) {
            let v5 = *0x1::vector::borrow<u64>(&v2, v4);
            let v6 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &v5);
            assert!(v6.status == v1, 8);
            let v7 = v6.user;
            let v8 = v6.locked_shares;
            let v9 = calculate_fee_u128(v8, v6.redemption_cancellation_fee_bps);
            let v10 = v8 - v9;
            let v11 = position_mut<T0, T1>(arg0, v7);
            assert!(v11.locked_shares >= v8, 7);
            v11.locked_shares = v11.locked_shares - v8;
            v11.available_shares = v11.available_shares + v10;
            let v12 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &v5);
            v12.status = 4;
            v12.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
            deactivate_redemption<T0, T1>(arg0, v5);
            v3 = v3 + v9;
            let v13 = RedemptionCancelled{
                request_id      : v5,
                user            : v7,
                unlocked_shares : v10,
                timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<RedemptionCancelled>(v13);
            v4 = v4 + 1;
        };
        let v14 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v14.status = 4;
        v14.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v15 = BatchCancelled{
            batch_id     : arg1,
            kind         : 1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BatchCancelled>(v15);
        v3
    }

    public(friend) fun cancel_stale_subscription_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1);
        assert!(v0.kind == 0, 15);
        assert!(v0.status == 0 || v0.status == 6, 8);
        let v1 = v0.status;
        let v2 = v0.request_ids;
        assert_batch_cancellation_allowed<T0, T1>(arg0, 0, &v2, 0x2::tx_context::sender(arg3), v0.created_at_ms, arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = *0x1::vector::borrow<u64>(&v2, v3);
            let v5 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &v4);
            assert!(v5.status == v1, 8);
            let v6 = v5.user;
            let v7 = v5.net_usdc;
            let v8 = v5.max_shares_out;
            let v9 = calculate_fee(v7, v5.cancellation_fee_bps);
            let v10 = v7 - v9;
            if (v9 > 0) {
                0x2::balance::join<T0>(&mut arg0.balances.fee_balance, 0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, v9));
            };
            if (v10 > 0) {
                0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, v10), arg3), v6);
            };
            let v11 = position_mut<T0, T1>(arg0, v6);
            assert!(v11.pending_subscription_shares >= v8, 6);
            v11.pending_subscription_shares = v11.pending_subscription_shares - v8;
            let v12 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &v4);
            v12.status = 4;
            v12.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
            deactivate_subscription<T0, T1>(arg0, v4);
            let v13 = SubscriptionCancelled{
                request_id    : v4,
                user          : v6,
                refund_amount : v10,
                cancel_fee    : v9,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<SubscriptionCancelled>(v13);
            v3 = v3 + 1;
        };
        let v14 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v14.status = 4;
        v14.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v15 = BatchCancelled{
            batch_id     : arg1,
            kind         : 0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BatchCancelled>(v15);
    }

    public(friend) fun cancel_subscription<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &arg1);
        assert!(v1.user == v0, 0);
        assert!(v1.status == 0, 8);
        assert!(v1.batch_id == 0, 9);
        v1.status = 4;
        v1.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1.net_usdc;
        let v3 = v1.max_shares_out;
        let v4 = calculate_fee(v2, v1.cancellation_fee_bps);
        let v5 = v2 - v4;
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.fee_balance, 0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, v4));
        };
        if (v5 > 0) {
            0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, v5), arg3), v0);
        };
        let v6 = position_mut<T0, T1>(arg0, v0);
        assert!(v6.pending_subscription_shares >= v3, 6);
        v6.pending_subscription_shares = v6.pending_subscription_shares - v3;
        deactivate_subscription<T0, T1>(arg0, arg1);
        let v7 = SubscriptionCancelled{
            request_id    : arg1,
            user          : v0,
            refund_amount : v5,
            cancel_fee    : v4,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SubscriptionCancelled>(v7);
    }

    public(friend) fun claim_usdc<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = position_mut<T0, T1>(arg0, v0);
        let v2 = if (arg1 == 0) {
            v1.claimable_usdc
        } else {
            arg1
        };
        assert!(v2 > 0, 17);
        assert!(v2 <= v1.claimable_usdc, 12);
        v1.claimable_usdc = v1.claimable_usdc - v2;
        v1.total_claimed_usdc = v1.total_claimed_usdc + v2;
        0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, v2), arg3), v0);
        let v3 = ClaimExecuted{
            user         : v0,
            amount       : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ClaimExecuted>(v3);
    }

    public(friend) fun collect_native_redemption_cancellation_fee<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u128) {
        if (arg1 == 0) {
            return
        };
        assert!(arg1 <= 18446744073709551615, 5);
        0x2::balance::join<T1>(&mut arg0.balances.xaua_dust, 0x2::balance::split<T1>(&mut arg0.balances.xaua_balance, (arg1 as u64)));
    }

    fun create_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u8, arg2: vector<u64>, arg3: &0x2::clock::Clock) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg2), 16);
        let v0 = arg0.counters.next_batch_id;
        arg0.counters.next_batch_id = v0 + 1;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = if (arg1 == 0) {
            0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, 0x1::vector::borrow<u64>(&arg2, 0)).processing_mode
        } else {
            0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, 0x1::vector::borrow<u64>(&arg2, 0)).processing_mode
        };
        assert!(v4 == 1, 8);
        let v5 = 0x1::vector::length<u64>(&arg2);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = *0x1::vector::borrow<u64>(&arg2, v6);
            if (arg1 == 0) {
                let v8 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &v7);
                assert!(v8.status == 0, 8);
                assert!(v8.batch_id == 0, 9);
                assert!(v8.processing_mode == v4, 8);
                v8.batch_id = v0;
                v1 = v1 + (v8.gross_usdc as u128);
                v2 = v2 + (v8.fee_usdc as u128);
                v3 = v3 + (v8.net_usdc as u128);
            } else {
                let v9 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &v7);
                assert!(v9.status == 0, 8);
                assert!(v9.batch_id == 0, 9);
                assert!(v9.processing_mode == v4, 8);
                v9.batch_id = v0;
                v1 = v1 + v9.locked_shares;
                v3 = v3 + v9.locked_shares;
            };
            v6 = v6 + 1;
        };
        assert!(v3 > 0, 16);
        let v10 = Batch{
            id                   : v0,
            kind                 : arg1,
            processing_mode      : v4,
            status               : 0,
            request_ids          : arg2,
            total_gross_amount   : v1,
            total_fee_amount     : v2,
            total_net_amount     : v3,
            outbound_amount      : 0,
            inbound_amount       : 0,
            dust_amount          : 0,
            created_at_ms        : 0x2::clock::timestamp_ms(arg3),
            submitted_at_ms      : 0,
            finalized_at_ms      : 0,
            settlement_reference : b"",
        };
        0x2::vec_map::insert<u64, Batch>(&mut arg0.books.batches, v0, v10);
        0x2::vec_set::insert<u64>(&mut arg0.books.active_batches, v0);
        let v11 = BatchCreated{
            batch_id         : v0,
            kind             : arg1,
            processing_mode  : v4,
            request_count    : v5,
            total_net_amount : v3,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchCreated>(v11);
        let v12 = BatchRequestsLinked{
            batch_id     : v0,
            kind         : arg1,
            request_ids  : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchRequestsLinked>(v12);
        v0
    }

    fun create_batch_settlement_reference(arg0: address, arg1: u8, arg2: u64) : vector<u8> {
        let v0 = BatchReferenceSeed{
            vault_id : arg0,
            kind     : arg1,
            batch_id : arg2,
        };
        let v1 = 0x1::bcs::to_bytes<BatchReferenceSeed>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public(friend) fun create_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        create_batch<T0, T1>(arg0, 1, arg1, arg2)
    }

    public(friend) fun create_subscription_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        create_batch<T0, T1>(arg0, 0, arg1, arg2)
    }

    fun current_day(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 86400000
    }

    fun deactivate_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.books.active_batches, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.books.active_batches, &arg1);
        };
    }

    fun deactivate_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.books.active_redemptions, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.books.active_redemptions, &arg1);
        };
    }

    fun deactivate_subscription<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.books.active_subscriptions, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.books.active_subscriptions, &arg1);
        };
    }

    public(friend) fun emit_config_updated(arg0: u8) {
        let v0 = ConfigUpdated{key: arg0};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun fee_balance<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balances.fee_balance)
    }

    public(friend) fun fee_collector<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : address {
        arg0.wallets.fee_collector
    }

    public(friend) fun finalize_managed_realtime_subscription<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (u128, u128) {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 > 0, 3);
        let v0 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &arg1);
        assert!(v0.status == 1, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        let v1 = v0.user;
        let v2 = (arg2 as u128);
        let v3 = v0.max_shares_out;
        assert!(v2 >= v0.min_shares_out, 23);
        assert!(v2 <= v3, 24);
        let v4 = position_mut<T0, T1>(arg0, v1);
        assert!(v4.pending_subscription_shares >= v3, 6);
        v4.pending_subscription_shares = v4.pending_subscription_shares - v3;
        v4.available_shares = v4.available_shares + v2;
        let v5 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &arg1);
        v5.status = 2;
        v5.allocated_shares = v2;
        v5.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_subscription<T0, T1>(arg0, arg1);
        let v6 = RequestFinalized{
            request_id     : arg1,
            user           : v1,
            kind           : 0,
            settled_amount : v2,
            fee_amount     : 0,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestFinalized>(v6);
        let v7 = RealtimeRequestFinalized{
            request_id     : arg1,
            kind           : 0,
            inbound_amount : (arg2 as u128),
            dust_amount    : 0,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealtimeRequestFinalized>(v7);
        (v2, 0)
    }

    public(friend) fun finalize_managed_subscription_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (u128, u128) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 > 0, 3);
        let v0 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        assert!(v0.kind == 0, 15);
        assert!(v0.processing_mode == 1, 8);
        assert!(v0.status == 1, 8);
        let v1 = v0.total_net_amount;
        let v2 = v0.request_ids;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v2)) {
            let v5 = *0x1::vector::borrow<u64>(&v2, v4);
            let v6 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &v5);
            assert!(v6.status == 1, 8);
            let v7 = v6.user;
            let v8 = v6.max_shares_out;
            let v9 = (arg2 as u128) * (v6.net_usdc as u128) / v1;
            assert!(v9 >= v6.min_shares_out, 23);
            assert!(v9 <= v8, 24);
            let v10 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &v5);
            v10.status = 2;
            v10.allocated_shares = v9;
            v10.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
            let v11 = position_mut<T0, T1>(arg0, v7);
            assert!(v11.pending_subscription_shares >= v8, 6);
            v11.pending_subscription_shares = v11.pending_subscription_shares - v8;
            v11.available_shares = v11.available_shares + v9;
            deactivate_subscription<T0, T1>(arg0, v5);
            v3 = v3 + v9;
            let v12 = RequestFinalized{
                request_id     : v5,
                user           : v7,
                kind           : 0,
                settled_amount : v9,
                fee_amount     : 0,
                timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RequestFinalized>(v12);
            v4 = v4 + 1;
        };
        let v13 = (arg2 as u128) - v3;
        let v14 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v14.status = 2;
        v14.inbound_amount = (arg2 as u128);
        v14.dust_amount = v13;
        v14.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v15 = BatchFinalized{
            batch_id       : arg1,
            kind           : 0,
            inbound_amount : (arg2 as u128),
            dust_amount    : v13,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchFinalized>(v15);
        (v3, v13)
    }

    public(friend) fun finalize_realtime_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let v2 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &arg1);
        assert!(v2.status == 1, 8);
        assert!(v2.processing_mode == 0, 8);
        assert!(v2.batch_id == 0, 9);
        let v3 = v2.user;
        let v4 = v2.locked_shares;
        let v5 = calculate_fee(v0, v2.redemption_fee_bps);
        let v6 = v0 - v5;
        assert!(v6 >= v2.min_usdc_out, 23);
        let v7 = position_mut<T0, T1>(arg0, v3);
        assert!(v7.locked_shares >= v4, 7);
        v7.locked_shares = v7.locked_shares - v4;
        v7.claimable_usdc = v7.claimable_usdc + v6;
        let v8 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg1);
        v8.status = 2;
        v8.submitted_xaua = v4;
        v8.claimable_usdc = v6;
        v8.fee_usdc = v5;
        v8.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_redemption<T0, T1>(arg0, arg1);
        let v9 = RequestFinalized{
            request_id     : arg1,
            user           : v3,
            kind           : 1,
            settled_amount : (v6 as u128),
            fee_amount     : v5,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestFinalized>(v9);
        if (v5 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.fee_balance, 0x2::balance::split<T0>(&mut v1, v5));
        };
        if (v6 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.usdc_balance, 0x2::balance::split<T0>(&mut v1, v6));
        };
        let v10 = (0x2::balance::value<T0>(&v1) as u128);
        if (v10 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.usdc_dust, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
        let v11 = RealtimeRequestFinalized{
            request_id     : arg1,
            kind           : 1,
            inbound_amount : (v0 as u128),
            dust_amount    : v10,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealtimeRequestFinalized>(v11);
    }

    public(friend) fun finalize_realtime_subscription<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.balances.xaua_balance, 0x2::coin::into_balance<T1>(arg2));
        let v1 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &arg1);
        assert!(v1.status == 1, 8);
        assert!(v1.processing_mode == 0, 8);
        assert!(v1.batch_id == 0, 9);
        let v2 = v1.user;
        let v3 = (v0 as u128);
        let v4 = v1.max_shares_out;
        assert!(v3 >= v1.min_shares_out, 23);
        assert!(v3 <= v4, 24);
        let v5 = position_mut<T0, T1>(arg0, v2);
        assert!(v5.pending_subscription_shares >= v4, 6);
        v5.pending_subscription_shares = v5.pending_subscription_shares - v4;
        v5.available_shares = v5.available_shares + v3;
        let v6 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &arg1);
        v6.status = 2;
        v6.allocated_shares = v3;
        v6.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_subscription<T0, T1>(arg0, arg1);
        let v7 = RequestFinalized{
            request_id     : arg1,
            user           : v2,
            kind           : 0,
            settled_amount : v3,
            fee_amount     : 0,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestFinalized>(v7);
        let v8 = RealtimeRequestFinalized{
            request_id     : arg1,
            kind           : 0,
            inbound_amount : (v0 as u128),
            dust_amount    : 0,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealtimeRequestFinalized>(v8);
    }

    public(friend) fun finalize_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let v2 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        assert!(v2.kind == 1, 15);
        assert!(v2.processing_mode == 1, 8);
        assert!(v2.status == 1, 8);
        let v3 = v2.total_net_amount;
        let v4 = v2.request_ids;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v4)) {
            let v8 = *0x1::vector::borrow<u64>(&v4, v7);
            let v9 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &v8);
            assert!(v9.status == 1, 8);
            let v10 = v9.user;
            let v11 = v9.locked_shares;
            let v12 = (((v0 as u128) * v11 / v3) as u64);
            let v13 = calculate_fee(v12, v9.redemption_fee_bps);
            let v14 = v12 - v13;
            assert!(v14 >= v9.min_usdc_out, 23);
            let v15 = position_mut<T0, T1>(arg0, v10);
            assert!(v15.locked_shares >= v11, 7);
            v15.locked_shares = v15.locked_shares - v11;
            v15.claimable_usdc = v15.claimable_usdc + v14;
            let v16 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &v8);
            v16.status = 2;
            v16.claimable_usdc = v14;
            v16.fee_usdc = v13;
            v16.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
            let v17 = RequestFinalized{
                request_id     : v8,
                user           : v10,
                kind           : 1,
                settled_amount : (v14 as u128),
                fee_amount     : v13,
                timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RequestFinalized>(v17);
            v5 = v5 + (v12 as u128);
            v6 = v6 + v13;
            deactivate_redemption<T0, T1>(arg0, v8);
            v7 = v7 + 1;
        };
        if (v6 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.fee_balance, 0x2::balance::split<T0>(&mut v1, v6));
        };
        let v18 = (v5 as u64) - v6;
        if (v18 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.usdc_balance, 0x2::balance::split<T0>(&mut v1, v18));
        };
        let v19 = (0x2::balance::value<T0>(&v1) as u128);
        if (v19 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.usdc_dust, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
        let v20 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v20.status = 2;
        v20.inbound_amount = (v0 as u128);
        v20.dust_amount = v19;
        v20.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v21 = BatchFinalized{
            batch_id       : arg1,
            kind           : 1,
            inbound_amount : (v0 as u128),
            dust_amount    : v19,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchFinalized>(v21);
    }

    public(friend) fun finalize_subscription_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.balances.xaua_balance, 0x2::coin::into_balance<T1>(arg2));
        let v1 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        assert!(v1.kind == 0, 15);
        assert!(v1.processing_mode == 1, 8);
        assert!(v1.status == 1, 8);
        let v2 = v1.total_net_amount;
        let v3 = v1.request_ids;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v3)) {
            let v6 = *0x1::vector::borrow<u64>(&v3, v5);
            let v7 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &v6);
            assert!(v7.status == 1, 8);
            let v8 = v7.user;
            let v9 = v7.max_shares_out;
            let v10 = (v0 as u128) * (v7.net_usdc as u128) / v2;
            assert!(v10 >= v7.min_shares_out, 23);
            assert!(v10 <= v9, 24);
            let v11 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &v6);
            v11.status = 2;
            v11.allocated_shares = v10;
            v11.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
            let v12 = RequestFinalized{
                request_id     : v6,
                user           : v8,
                kind           : 0,
                settled_amount : v10,
                fee_amount     : 0,
                timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RequestFinalized>(v12);
            let v13 = position_mut<T0, T1>(arg0, v8);
            assert!(v13.pending_subscription_shares >= v9, 6);
            v13.pending_subscription_shares = v13.pending_subscription_shares - v9;
            v13.available_shares = v13.available_shares + v10;
            deactivate_subscription<T0, T1>(arg0, v6);
            v4 = v4 + v10;
            v5 = v5 + 1;
        };
        let v14 = (v0 as u128) - v4;
        if (v14 > 0) {
            0x2::balance::join<T1>(&mut arg0.balances.xaua_dust, 0x2::balance::split<T1>(&mut arg0.balances.xaua_balance, (v14 as u64)));
        };
        let v15 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v15.status = 2;
        v15.inbound_amount = (v0 as u128);
        v15.dust_amount = v14;
        v15.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v16 = BatchFinalized{
            batch_id       : arg1,
            kind           : 0,
            inbound_amount : (v0 as u128),
            dust_amount    : v14,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchFinalized>(v16);
    }

    fun is_paused<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: u8) : bool {
        arg0.runtime.pause_flags & arg1 != 0
    }

    fun is_terminal_status(arg0: u8) : bool {
        if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    public(friend) fun issuer_treasury_wallet<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : address {
        arg0.wallets.issuer_treasury_wallet
    }

    fun mark_redemption_requests_prepared<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64) {
        let v0 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1).request_ids;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            let v2 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, 0x1::vector::borrow<u64>(&v0, v1));
            assert!(v2.status == 0, 8);
            v2.status = 6;
            v1 = v1 + 1;
        };
    }

    fun mark_redemption_requests_submitted<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1).request_ids;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            let v2 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, 0x1::vector::borrow<u64>(&v0, v1));
            assert!(v2.status == 6, 8);
            v2.status = 1;
            v2.submitted_at_ms = arg2;
            v2.submitted_xaua = v2.locked_shares;
            v1 = v1 + 1;
        };
    }

    fun mark_subscription_requests_prepared<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64) {
        let v0 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1).request_ids;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            let v2 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, 0x1::vector::borrow<u64>(&v0, v1));
            assert!(v2.status == 0, 8);
            v2.status = 6;
            v1 = v1 + 1;
        };
    }

    fun mark_subscription_requests_submitted<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1).request_ids;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            let v2 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, 0x1::vector::borrow<u64>(&v0, v1));
            assert!(v2.status == 6, 8);
            v2.status = 1;
            v2.submitted_at_ms = arg2;
            v1 = v1 + 1;
        };
    }

    public(friend) fun new<T0, T1>(arg0: address, arg1: 0x2::vec_set::VecSet<address>, arg2: 0x2::vec_set::VecSet<address>, arg3: 0x2::vec_set::VecSet<address>, arg4: 0x2::vec_set::VecSet<address>, arg5: address, arg6: address, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u64, arg14: u64, arg15: u128, arg16: u128, arg17: u128) : AlphaVaultInner<T0, T1> {
        assert!(arg0 != @0x0, 21);
        assert!(arg5 != @0x0, 21);
        assert!(arg6 != @0x0, 21);
        assert!(arg8 < 10000, 13);
        assert!(arg9 < 10000, 13);
        assert_valid_subscription_limits(arg10, arg11);
        let v0 = AccessControl{
            admin         : arg0,
            pending_admin : 0x1::option::none<address>(),
            controllers   : arg1,
            operators     : arg2,
            assessors     : arg3,
            settlers      : arg4,
        };
        let v1 = WalletConfig{
            fee_collector          : arg5,
            issuer_treasury_wallet : arg6,
        };
        let v2 = WhitelistConfig{
            enabled : arg7,
            users   : 0x2::vec_set::empty<address>(),
        };
        let v3 = RuntimeState{
            pause_flags           : 0,
            usage_day             : 0,
            daily_subscribed_usdc : 0,
            daily_redeemed_shares : 0,
        };
        let v4 = FeeConfig{
            subscription_fee_bps            : arg8,
            redemption_fee_bps              : arg9,
            cancellation_fee_bps            : 0,
            redemption_cancellation_fee_bps : 0,
        };
        let v5 = LimitConfig{
            min_subscription_usdc             : arg10,
            max_subscription_usdc_per_request : arg11,
            max_redemption_shares_per_request : arg12,
            daily_subscription_limit_per_user : arg13,
            daily_subscription_limit_system   : arg14,
            daily_redemption_limit_per_user   : arg15,
            daily_redemption_limit_system     : arg16,
            max_user_position_shares          : arg17,
        };
        let v6 = ScheduleConfig{
            real_time_start_seconds_utc : 0,
            real_time_end_seconds_utc   : 36000,
        };
        let v7 = Counters{
            next_request_id : 1,
            next_batch_id   : 1,
        };
        let v8 = VaultBalances<T0, T1>{
            usdc_balance : 0x2::balance::zero<T0>(),
            xaua_balance : 0x2::balance::zero<T1>(),
            fee_balance  : 0x2::balance::zero<T0>(),
            xaua_dust    : 0x2::balance::zero<T1>(),
            usdc_dust    : 0x2::balance::zero<T0>(),
        };
        let v9 = VaultBooks{
            positions            : 0x2::vec_map::empty<address, UserPosition>(),
            subscriptions        : 0x2::vec_map::empty<u64, SubscriptionRequest>(),
            redemptions          : 0x2::vec_map::empty<u64, RedemptionRequest>(),
            batches              : 0x2::vec_map::empty<u64, Batch>(),
            active_subscriptions : 0x2::vec_set::empty<u64>(),
            active_redemptions   : 0x2::vec_set::empty<u64>(),
            active_batches       : 0x2::vec_set::empty<u64>(),
        };
        AlphaVaultInner<T0, T1>{
            access    : v0,
            wallets   : v1,
            whitelist : v2,
            runtime   : v3,
            fees      : v4,
            limits    : v5,
            schedule  : v6,
            counters  : v7,
            balances  : v8,
            books     : v9,
        }
    }

    public(friend) fun next_batch_id<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : u64 {
        arg0.counters.next_batch_id
    }

    public(friend) fun next_request_id<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : u64 {
        arg0.counters.next_request_id
    }

    public fun pause_operator_submission() : u8 {
        4
    }

    public fun pause_redemptions() : u8 {
        2
    }

    public fun pause_subscriptions() : u8 {
        1
    }

    public(friend) fun pending_admin<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : 0x1::option::Option<address> {
        arg0.access.pending_admin
    }

    public(friend) fun pending_redemption_ids<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : vector<u64> {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.books.active_redemptions);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v0)) {
            let v3 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, 0x1::vector::borrow<u64>(v0, v2));
            if (v3.status == 0 && v3.batch_id == 0) {
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(v0, v2));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun pending_subscription_ids<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : vector<u64> {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.books.active_subscriptions);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v0)) {
            let v3 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, 0x1::vector::borrow<u64>(v0, v2));
            if (v3.status == 0 && v3.batch_id == 0) {
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(v0, v2));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun position<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: address) : UserPosition {
        let v0 = 0x2::vec_map::try_get<address, UserPosition>(&arg0.books.positions, &arg1);
        if (0x1::option::is_some<UserPosition>(&v0)) {
            0x1::option::destroy_some<UserPosition>(v0)
        } else {
            0x1::option::destroy_none<UserPosition>(v0);
            zero_position()
        }
    }

    public fun position_available_shares(arg0: &UserPosition) : u128 {
        arg0.available_shares
    }

    public fun position_claimable_usdc(arg0: &UserPosition) : u64 {
        arg0.claimable_usdc
    }

    public fun position_locked_shares(arg0: &UserPosition) : u128 {
        arg0.locked_shares
    }

    fun position_mut<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address) : &mut UserPosition {
        if (!0x2::vec_map::contains<address, UserPosition>(&arg0.books.positions, &arg1)) {
            0x2::vec_map::insert<address, UserPosition>(&mut arg0.books.positions, arg1, zero_position());
        };
        0x2::vec_map::get_mut<address, UserPosition>(&mut arg0.books.positions, &arg1)
    }

    public fun position_pending_subscription_shares(arg0: &UserPosition) : u128 {
        arg0.pending_subscription_shares
    }

    public fun position_total_claimed_usdc(arg0: &UserPosition) : u64 {
        arg0.total_claimed_usdc
    }

    fun prepare_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        assert!(!is_paused<T0, T1>(arg0, 4), 2);
        let v0 = create_batch_settlement_reference(arg1, arg3, arg2);
        let v1 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg2);
        assert!(v1.kind == arg3, 15);
        assert!(v1.processing_mode == 1, 8);
        assert!(v1.status == 0, 10);
        let v2 = v1.total_net_amount;
        assert!(v2 > 0, 16);
        assert!(v2 <= 18446744073709551615, 5);
        assert!(0x1::vector::is_empty<u8>(&v1.settlement_reference), 10);
        v1.settlement_reference = v0;
        v1.status = 6;
        if (arg3 == 0) {
            mark_subscription_requests_prepared<T0, T1>(arg0, arg2);
        } else {
            mark_redemption_requests_prepared<T0, T1>(arg0, arg2);
        };
        let v3 = BatchPrepared{
            vault_id             : arg1,
            batch_id             : arg2,
            kind                 : arg3,
            outbound_amount      : v2,
            settlement_reference : v0,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BatchPrepared>(v3);
    }

    public(friend) fun prepare_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        prepare_batch<T0, T1>(arg0, arg1, arg2, 1, arg3, arg4);
    }

    public(friend) fun prepare_subscription_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        prepare_batch<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4);
    }

    public fun processing_batch() : u8 {
        1
    }

    fun processing_mode<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: &0x2::clock::Clock) : u8 {
        let v0 = ((0x2::clock::timestamp_ms(arg1) / 1000 % 86400) as u32);
        if (v0 >= arg0.schedule.real_time_start_seconds_utc && v0 < arg0.schedule.real_time_end_seconds_utc) {
            0
        } else {
            1
        }
    }

    public fun processing_real_time() : u8 {
        0
    }

    public(friend) fun prune_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        assert!(is_terminal_status(0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1).status), 26);
        assert!(!0x2::vec_set::contains<u64>(&arg0.books.active_batches, &arg1), 26);
        let (_, _) = 0x2::vec_map::remove<u64, Batch>(&mut arg0.books.batches, &arg1);
    }

    public(friend) fun prune_position<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::vec_map::get<address, UserPosition>(&arg0.books.positions, &arg1);
        assert!(v0.available_shares == 0, 26);
        assert!(v0.locked_shares == 0, 26);
        assert!(v0.claimable_usdc == 0, 26);
        assert!(v0.pending_subscription_shares == 0, 26);
        assert!(v0.usage_day < current_day(arg2), 26);
        let (_, _) = 0x2::vec_map::remove<address, UserPosition>(&mut arg0.books.positions, &arg1);
    }

    public(friend) fun prune_redemption_request<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        assert!(is_terminal_status(0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &arg1).status), 26);
        assert!(!0x2::vec_set::contains<u64>(&arg0.books.active_redemptions, &arg1), 26);
        let (_, _) = 0x2::vec_map::remove<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg1);
    }

    public(friend) fun prune_subscription_request<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        assert!(is_terminal_status(0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &arg1).status), 26);
        assert!(!0x2::vec_set::contains<u64>(&arg0.books.active_subscriptions, &arg1), 26);
        let (_, _) = 0x2::vec_map::remove<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &arg1);
    }

    public fun redemption_fee_bps(arg0: &RedemptionRequest) : u64 {
        arg0.redemption_fee_bps
    }

    public fun redemption_min_usdc_out(arg0: &RedemptionRequest) : u64 {
        arg0.min_usdc_out
    }

    public(friend) fun redemption_request<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: u64) : RedemptionRequest {
        *0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &arg1)
    }

    public fun redemption_status(arg0: &RedemptionRequest) : u8 {
        arg0.status
    }

    public(friend) fun refund_managed_realtime_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u128 {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &arg1);
        assert!(v0.status == 1, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        let v1 = v0.user;
        let v2 = v0.locked_shares;
        assert!((arg2 as u128) == v2, 18);
        let v3 = position_mut<T0, T1>(arg0, v1);
        assert!(v3.locked_shares >= v2, 7);
        v3.locked_shares = v3.locked_shares - v2;
        v3.available_shares = v3.available_shares + v2;
        let v4 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg1);
        v4.status = 5;
        v4.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_redemption<T0, T1>(arg0, arg1);
        let v5 = RequestRefunded{
            request_id    : arg1,
            user          : v1,
            kind          : 1,
            refund_amount : v2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestRefunded>(v5);
        v2
    }

    public(friend) fun refund_managed_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u128 {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1);
        assert!(v0.kind == 1, 15);
        assert!(v0.processing_mode == 1, 8);
        assert!(v0.status == 1, 8);
        assert!(v0.outbound_amount == (arg2 as u128), 18);
        let v1 = v0.request_ids;
        assert!(arg2 > 0, 3);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&v1, v3);
            let v5 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &v4);
            assert!(v5.status == 1, 8);
            let v6 = v5.user;
            let v7 = v5.locked_shares;
            let v8 = position_mut<T0, T1>(arg0, v6);
            assert!(v8.locked_shares >= v7, 7);
            v8.locked_shares = v8.locked_shares - v7;
            v8.available_shares = v8.available_shares + v7;
            let v9 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &v4);
            v9.status = 5;
            v9.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
            v2 = v2 + v7;
            let v10 = RequestRefunded{
                request_id    : v4,
                user          : v6,
                kind          : 1,
                refund_amount : v7,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RequestRefunded>(v10);
            deactivate_redemption<T0, T1>(arg0, v4);
            v3 = v3 + 1;
        };
        assert!(v2 == (arg2 as u128), 18);
        let v11 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v11.status = 5;
        v11.inbound_amount = (arg2 as u128);
        v11.dust_amount = 0;
        v11.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v12 = BatchRefunded{
            batch_id      : arg1,
            kind          : 1,
            refund_amount : (arg2 as u128),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchRefunded>(v12);
        v2
    }

    public(friend) fun refund_realtime_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &arg1);
        assert!(v0.status == 1, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        let v1 = v0.user;
        let v2 = v0.locked_shares;
        assert!((0x2::coin::value<T1>(&arg2) as u128) == v2, 18);
        0x2::balance::join<T1>(&mut arg0.balances.xaua_balance, 0x2::coin::into_balance<T1>(arg2));
        let v3 = position_mut<T0, T1>(arg0, v1);
        assert!(v3.locked_shares >= v2, 7);
        v3.locked_shares = v3.locked_shares - v2;
        v3.available_shares = v3.available_shares + v2;
        let v4 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg1);
        v4.status = 5;
        v4.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_redemption<T0, T1>(arg0, arg1);
        let v5 = RequestRefunded{
            request_id    : arg1,
            user          : v1,
            kind          : 1,
            refund_amount : v2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestRefunded>(v5);
    }

    public(friend) fun refund_realtime_subscription<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &arg1);
        assert!(v1.status == 1, 8);
        assert!(v1.processing_mode == 0, 8);
        assert!(v1.batch_id == 0, 9);
        let v2 = v1.user;
        let v3 = v1.max_shares_out;
        assert!(v0 == v1.net_usdc, 18);
        0x2::balance::join<T0>(&mut arg0.balances.usdc_balance, 0x2::coin::into_balance<T0>(arg2));
        let v4 = position_mut<T0, T1>(arg0, v2);
        assert!(v4.pending_subscription_shares >= v3, 6);
        v4.pending_subscription_shares = v4.pending_subscription_shares - v3;
        v4.claimable_usdc = v4.claimable_usdc + v0;
        let v5 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &arg1);
        v5.status = 5;
        v5.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_subscription<T0, T1>(arg0, arg1);
        let v6 = RequestRefunded{
            request_id    : arg1,
            user          : v2,
            kind          : 0,
            refund_amount : (v0 as u128),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestRefunded>(v6);
    }

    public(friend) fun refund_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1);
        assert!(v1.kind == 1, 15);
        assert!(v1.processing_mode == 1, 8);
        assert!(v1.status == 1, 8);
        assert!(v1.outbound_amount == (v0 as u128), 18);
        let v2 = v1.request_ids;
        assert!(v0 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.balances.xaua_balance, 0x2::coin::into_balance<T1>(arg2));
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = *0x1::vector::borrow<u64>(&v2, v3);
            let v5 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &v4);
            assert!(v5.status == 1, 8);
            let v6 = v5.user;
            let v7 = v5.locked_shares;
            let v8 = position_mut<T0, T1>(arg0, v6);
            assert!(v8.locked_shares >= v7, 7);
            v8.locked_shares = v8.locked_shares - v7;
            v8.available_shares = v8.available_shares + v7;
            let v9 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &v4);
            v9.status = 5;
            v9.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
            let v10 = RequestRefunded{
                request_id    : v4,
                user          : v6,
                kind          : 1,
                refund_amount : v7,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RequestRefunded>(v10);
            deactivate_redemption<T0, T1>(arg0, v4);
            v3 = v3 + 1;
        };
        let v11 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v11.status = 5;
        v11.inbound_amount = (v0 as u128);
        v11.dust_amount = 0;
        v11.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v12 = BatchRefunded{
            batch_id      : arg1,
            kind          : 1,
            refund_amount : (v0 as u128),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchRefunded>(v12);
    }

    public(friend) fun refund_subscription_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::vec_map::get<u64, Batch>(&arg0.books.batches, &arg1);
        assert!(v1.kind == 0, 15);
        assert!(v1.processing_mode == 1, 8);
        assert!(v1.status == 1, 8);
        assert!(v1.outbound_amount == (v0 as u128), 18);
        let v2 = v1.request_ids;
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.balances.usdc_balance, 0x2::coin::into_balance<T0>(arg2));
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = *0x1::vector::borrow<u64>(&v2, v3);
            let v5 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &v4);
            assert!(v5.status == 1, 8);
            let v6 = v5.user;
            let v7 = v5.net_usdc;
            let v8 = v5.max_shares_out;
            let v9 = position_mut<T0, T1>(arg0, v6);
            assert!(v9.pending_subscription_shares >= v8, 6);
            v9.pending_subscription_shares = v9.pending_subscription_shares - v8;
            v9.claimable_usdc = v9.claimable_usdc + v7;
            let v10 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &v4);
            v10.status = 5;
            v10.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
            let v11 = RequestRefunded{
                request_id    : v4,
                user          : v6,
                kind          : 0,
                refund_amount : (v7 as u128),
                timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RequestRefunded>(v11);
            deactivate_subscription<T0, T1>(arg0, v4);
            v3 = v3 + 1;
        };
        let v12 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg1);
        v12.status = 5;
        v12.inbound_amount = (v0 as u128);
        v12.dust_amount = 0;
        v12.finalized_at_ms = 0x2::clock::timestamp_ms(arg3);
        deactivate_batch<T0, T1>(arg0, arg1);
        let v13 = BatchRefunded{
            batch_id      : arg1,
            kind          : 0,
            refund_amount : (v0 as u128),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchRefunded>(v13);
    }

    public(friend) fun remove_assessor<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (0x2::vec_set::contains<address>(&arg0.access.assessors, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.assessors, &arg1);
            let v0 = RoleRevoked{
                role    : 2,
                account : arg1,
            };
            0x2::event::emit<RoleRevoked>(v0);
        };
    }

    public(friend) fun remove_controller<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (0x2::vec_set::contains<address>(&arg0.access.controllers, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.controllers, &arg1);
            let v0 = RoleRevoked{
                role    : 0,
                account : arg1,
            };
            0x2::event::emit<RoleRevoked>(v0);
        };
    }

    public(friend) fun remove_from_whitelist<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_assessor<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (0x2::vec_set::contains<address>(&arg0.whitelist.users, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.whitelist.users, &arg1);
        };
        let v0 = ConfigUpdated{key: 2};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun remove_operator<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (0x2::vec_set::contains<address>(&arg0.access.operators, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.operators, &arg1);
            let v0 = RoleRevoked{
                role    : 1,
                account : arg1,
            };
            0x2::event::emit<RoleRevoked>(v0);
        };
    }

    public(friend) fun remove_settler<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        if (0x2::vec_set::contains<address>(&arg0.access.settlers, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.access.settlers, &arg1);
            let v0 = RoleRevoked{
                role    : 3,
                account : arg1,
            };
            0x2::event::emit<RoleRevoked>(v0);
        };
    }

    public(friend) fun request_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u128, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_user_allowed<T0, T1>(arg0, v0);
        assert!(!is_paused<T0, T1>(arg0, 2), 2);
        assert!(arg1 > 0, 3);
        if (arg0.limits.max_redemption_shares_per_request > 0) {
            assert!(arg1 <= arg0.limits.max_redemption_shares_per_request, 5);
        };
        assert!(arg2 > 0, 22);
        let v1 = current_day(arg3);
        roll_system_usage_day<T0, T1>(arg0, v1);
        let v2 = arg0.limits.daily_redemption_limit_per_user;
        let v3 = position_mut<T0, T1>(arg0, v0);
        roll_usage_day(v3, v1);
        if (v2 > 0) {
            assert!(v3.total_redeemed_shares + arg1 <= v2, 6);
        };
        v3.total_redeemed_shares = v3.total_redeemed_shares + arg1;
        if (arg0.limits.daily_redemption_limit_system > 0) {
            assert!(arg0.runtime.daily_redeemed_shares + arg1 <= arg0.limits.daily_redemption_limit_system, 6);
        };
        arg0.runtime.daily_redeemed_shares = arg0.runtime.daily_redeemed_shares + arg1;
        let v4 = position_mut<T0, T1>(arg0, v0);
        assert!(v4.available_shares >= arg1, 7);
        v4.available_shares = v4.available_shares - arg1;
        v4.locked_shares = v4.locked_shares + arg1;
        let v5 = arg0.counters.next_request_id;
        arg0.counters.next_request_id = v5 + 1;
        let v6 = processing_mode<T0, T1>(arg0, arg3);
        let v7 = RedemptionRequest{
            id                              : v5,
            user                            : v0,
            status                          : 0,
            batch_id                        : 0,
            processing_mode                 : v6,
            locked_shares                   : arg1,
            min_usdc_out                    : arg2,
            redemption_fee_bps              : arg0.fees.redemption_fee_bps,
            redemption_cancellation_fee_bps : arg0.fees.redemption_cancellation_fee_bps,
            submitted_xaua                  : 0,
            claimable_usdc                  : 0,
            fee_usdc                        : 0,
            created_at_ms                   : 0x2::clock::timestamp_ms(arg3),
            submitted_at_ms                 : 0,
            finalized_at_ms                 : 0,
            claimed_at_ms                   : 0,
        };
        0x2::vec_map::insert<u64, RedemptionRequest>(&mut arg0.books.redemptions, v5, v7);
        0x2::vec_set::insert<u64>(&mut arg0.books.active_redemptions, v5);
        let v8 = RedemptionRequested{
            request_id         : v5,
            user               : v0,
            locked_shares      : arg1,
            min_usdc_out       : arg2,
            redemption_fee_bps : arg0.fees.redemption_fee_bps,
            processing_mode    : v6,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RedemptionRequested>(v8);
        v5
    }

    public(friend) fun resolve_failed_realtime_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg1);
        assert!(v0.status == 0, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        v0.status = 4;
        v0.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0.user;
        let v2 = v0.locked_shares;
        let v3 = position_mut<T0, T1>(arg0, v1);
        assert!(v3.locked_shares >= v2, 7);
        v3.locked_shares = v3.locked_shares - v2;
        v3.available_shares = v3.available_shares + v2;
        deactivate_redemption<T0, T1>(arg0, arg1);
        let v4 = RedemptionCancelled{
            request_id      : arg1,
            user            : v1,
            unlocked_shares : v2,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RedemptionCancelled>(v4);
    }

    public(friend) fun resolve_failed_realtime_subscription<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &arg1);
        assert!(v0.status == 0, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        v0.status = 4;
        v0.finalized_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0.user;
        let v2 = v0.net_usdc;
        let v3 = v0.fee_usdc;
        let v4 = v0.max_shares_out;
        if (v2 > 0) {
            0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, v2), arg3), v1);
        };
        if (v3 > 0) {
            0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.fee_balance, v3), arg3), v1);
        };
        let v5 = position_mut<T0, T1>(arg0, v1);
        assert!(v5.pending_subscription_shares >= v4, 6);
        v5.pending_subscription_shares = v5.pending_subscription_shares - v4;
        deactivate_subscription<T0, T1>(arg0, arg1);
        let v6 = SubscriptionCancelled{
            request_id    : arg1,
            user          : v1,
            refund_amount : v2 + v3,
            cancel_fee    : 0,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SubscriptionCancelled>(v6);
    }

    fun roll_system_usage_day<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64) {
        if (arg0.runtime.usage_day != arg1) {
            arg0.runtime.usage_day = arg1;
            arg0.runtime.daily_subscribed_usdc = 0;
            arg0.runtime.daily_redeemed_shares = 0;
        };
    }

    fun roll_usage_day(arg0: &mut UserPosition, arg1: u64) {
        if (arg0.usage_day != arg1) {
            arg0.usage_day = arg1;
            arg0.total_subscribed_usdc = 0;
            arg0.total_redeemed_shares = 0;
        };
    }

    public(friend) fun set_fee_collector<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 != @0x0, 21);
        arg0.wallets.fee_collector = arg1;
        let v0 = ConfigUpdated{key: 7};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun set_fees<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg1 < 10000, 13);
        assert!(arg2 < 10000, 13);
        assert!(arg3 < 10000, 13);
        assert!(arg4 < 10000, 13);
        arg0.fees.subscription_fee_bps = arg1;
        arg0.fees.redemption_fee_bps = arg2;
        arg0.fees.cancellation_fee_bps = arg3;
        arg0.fees.redemption_cancellation_fee_bps = arg4;
        let v0 = ConfigUpdated{key: 4};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun set_issuer_treasury_wallet<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 != @0x0, 21);
        arg0.wallets.issuer_treasury_wallet = arg1;
        let v0 = ConfigUpdated{key: 8};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun set_limits<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        assert_valid_subscription_limits(arg1, arg2);
        assert_existing_state_within_limits<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        arg0.limits.min_subscription_usdc = arg1;
        arg0.limits.max_subscription_usdc_per_request = arg2;
        arg0.limits.max_redemption_shares_per_request = arg3;
        arg0.limits.max_user_position_shares = arg4;
        let v0 = ConfigUpdated{key: 6};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun set_pause_flags<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        arg0.runtime.pause_flags = arg1;
        let v0 = ConfigUpdated{key: 3};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun set_real_time_window<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: u32, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1 < arg2 && arg2 <= 86400, 14);
        arg0.schedule.real_time_start_seconds_utc = arg1;
        arg0.schedule.real_time_end_seconds_utc = arg2;
        let v0 = ConfigUpdated{key: 5};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun status_claimed() : u8 {
        3
    }

    public fun status_prepared() : u8 {
        6
    }

    public fun status_refunded() : u8 {
        5
    }

    public fun status_requested() : u8 {
        0
    }

    public fun status_settled() : u8 {
        2
    }

    public fun status_submitted() : u8 {
        1
    }

    public(friend) fun submit_managed_realtime_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        assert!(!is_paused<T0, T1>(arg0, 4), 2);
        let v0 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &arg2);
        assert!(v0.status == 0, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        let v1 = v0.locked_shares;
        assert!(v1 <= 18446744073709551615, 5);
        let v2 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg2);
        v2.status = 1;
        v2.submitted_xaua = v1;
        v2.submitted_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v3 = RealtimeRequestSubmitted{
            request_id      : arg2,
            kind            : 1,
            outbound_amount : v1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealtimeRequestSubmitted>(v3);
        let v4 = VaultPaymentSent{
            vault_id             : arg1,
            reference_id         : arg2,
            is_batch             : false,
            kind                 : 1,
            amount               : v1,
            destination          : arg3,
            settlement_reference : b"",
            timestamp_ms         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultPaymentSent>(v4);
        (v1 as u64)
    }

    public(friend) fun submit_managed_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        assert!(!is_paused<T0, T1>(arg0, 4), 2);
        let v0 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg2);
        assert!(v0.kind == 1, 15);
        assert!(v0.processing_mode == 1, 8);
        assert!(v0.status == 6, 8);
        let v1 = v0.total_net_amount;
        assert!(v1 > 0, 16);
        assert!(v1 <= 18446744073709551615, 5);
        v0.status = 1;
        v0.outbound_amount = v1;
        v0.submitted_at_ms = 0x2::clock::timestamp_ms(arg4);
        mark_redemption_requests_submitted<T0, T1>(arg0, arg2, 0x2::clock::timestamp_ms(arg4));
        let v2 = BatchSubmitted{
            batch_id        : arg2,
            kind            : 1,
            outbound_amount : v1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BatchSubmitted>(v2);
        let v3 = VaultPaymentSent{
            vault_id             : arg1,
            reference_id         : arg2,
            is_batch             : true,
            kind                 : 1,
            amount               : v1,
            destination          : arg3,
            settlement_reference : v0.settlement_reference,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultPaymentSent>(v3);
        (v1 as u64)
    }

    public(friend) fun submit_realtime_redemption<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        assert!(!is_paused<T0, T1>(arg0, 4), 2);
        let v0 = 0x2::vec_map::get<u64, RedemptionRequest>(&arg0.books.redemptions, &arg2);
        assert!(v0.status == 0, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        let v1 = v0.locked_shares;
        assert!(v1 <= 18446744073709551615, 5);
        0x2::coin::send_funds<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balances.xaua_balance, (v1 as u64)), arg5), arg3);
        let v2 = 0x2::vec_map::get_mut<u64, RedemptionRequest>(&mut arg0.books.redemptions, &arg2);
        v2.status = 1;
        v2.submitted_xaua = v1;
        v2.submitted_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v3 = RealtimeRequestSubmitted{
            request_id      : arg2,
            kind            : 1,
            outbound_amount : v1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealtimeRequestSubmitted>(v3);
        let v4 = VaultPaymentSent{
            vault_id             : arg1,
            reference_id         : arg2,
            is_batch             : false,
            kind                 : 1,
            amount               : v1,
            destination          : arg3,
            settlement_reference : b"",
            timestamp_ms         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultPaymentSent>(v4);
    }

    public(friend) fun submit_realtime_subscription<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_settler_or_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        assert!(!is_paused<T0, T1>(arg0, 4), 2);
        let v0 = 0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &arg2);
        assert!(v0.status == 0, 8);
        assert!(v0.processing_mode == 0, 8);
        assert!(v0.batch_id == 0, 9);
        let v1 = v0.net_usdc;
        let v2 = arg0.wallets.issuer_treasury_wallet;
        0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, v1), arg4), v2);
        let v3 = 0x2::vec_map::get_mut<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, &arg2);
        v3.status = 1;
        v3.submitted_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v4 = RealtimeRequestSubmitted{
            request_id      : arg2,
            kind            : 0,
            outbound_amount : (v1 as u128),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealtimeRequestSubmitted>(v4);
        let v5 = VaultPaymentSent{
            vault_id             : arg1,
            reference_id         : arg2,
            is_batch             : false,
            kind                 : 0,
            amount               : (v1 as u128),
            destination          : v2,
            settlement_reference : b"",
            timestamp_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultPaymentSent>(v5);
    }

    public(friend) fun submit_redemption_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg5));
        assert!(!is_paused<T0, T1>(arg0, 4), 2);
        let v0 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg2);
        assert!(v0.kind == 1, 15);
        assert!(v0.processing_mode == 1, 8);
        assert!(v0.status == 6, 8);
        let v1 = v0.total_net_amount;
        assert!(v1 > 0, 16);
        assert!(v1 <= 18446744073709551615, 5);
        0x2::coin::send_funds<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balances.xaua_balance, (v1 as u64)), arg5), arg3);
        v0.status = 1;
        v0.outbound_amount = v1;
        v0.submitted_at_ms = 0x2::clock::timestamp_ms(arg4);
        mark_redemption_requests_submitted<T0, T1>(arg0, arg2, 0x2::clock::timestamp_ms(arg4));
        let v2 = BatchSubmitted{
            batch_id        : arg2,
            kind            : 1,
            outbound_amount : v1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BatchSubmitted>(v2);
        let v3 = VaultPaymentSent{
            vault_id             : arg1,
            reference_id         : arg2,
            is_batch             : true,
            kind                 : 1,
            amount               : v1,
            destination          : arg3,
            settlement_reference : v0.settlement_reference,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultPaymentSent>(v3);
    }

    public(friend) fun submit_subscription_batch<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_operator<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        assert!(!is_paused<T0, T1>(arg0, 4), 2);
        let v0 = 0x2::vec_map::get_mut<u64, Batch>(&mut arg0.books.batches, &arg2);
        assert!(v0.kind == 0, 15);
        assert!(v0.processing_mode == 1, 8);
        assert!(v0.status == 6, 8);
        let v1 = v0.total_net_amount;
        let v2 = v0.settlement_reference;
        assert!(v1 > 0, 16);
        assert!(v1 <= 18446744073709551615, 5);
        let v3 = arg0.wallets.issuer_treasury_wallet;
        0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.usdc_balance, (v1 as u64)), arg4), v3);
        v0.status = 1;
        v0.outbound_amount = v1;
        v0.submitted_at_ms = 0x2::clock::timestamp_ms(arg3);
        mark_subscription_requests_submitted<T0, T1>(arg0, arg2, 0x2::clock::timestamp_ms(arg3));
        let v4 = BatchSubmitted{
            batch_id        : arg2,
            kind            : 0,
            outbound_amount : v1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchSubmitted>(v4);
        let v5 = VaultPaymentSent{
            vault_id             : arg1,
            reference_id         : arg2,
            is_batch             : true,
            kind                 : 0,
            amount               : v1,
            destination          : v3,
            settlement_reference : v2,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultPaymentSent>(v5);
    }

    public(friend) fun submitted_batch_ids<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : vector<u64> {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.books.active_batches);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v0)) {
            if (0x2::vec_map::get<u64, Batch>(&arg0.books.batches, 0x1::vector::borrow<u64>(v0, v2)).status == 1) {
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(v0, v2));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun subscribe<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_user_allowed<T0, T1>(arg0, v0);
        assert!(!is_paused<T0, T1>(arg0, 1), 2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 3);
        assert!(v1 >= arg0.limits.min_subscription_usdc, 4);
        if (arg0.limits.max_subscription_usdc_per_request > 0) {
            assert!(v1 <= arg0.limits.max_subscription_usdc_per_request, 5);
        };
        let v2 = if (arg2 > 0) {
            if (arg2 <= arg3) {
                arg3 <= 18446744073709551615
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 22);
        let v3 = current_day(arg4);
        roll_system_usage_day<T0, T1>(arg0, v3);
        let v4 = arg0.limits.daily_subscription_limit_per_user;
        let v5 = arg0.limits.max_user_position_shares;
        let v6 = position_mut<T0, T1>(arg0, v0);
        roll_usage_day(v6, v3);
        if (v4 > 0) {
            assert!(v6.total_subscribed_usdc + v1 <= v4, 6);
        };
        if (v5 > 0) {
            assert!(v6.available_shares + v6.locked_shares + v6.pending_subscription_shares + arg3 <= v5, 6);
        };
        v6.total_subscribed_usdc = v6.total_subscribed_usdc + v1;
        v6.pending_subscription_shares = v6.pending_subscription_shares + arg3;
        if (arg0.limits.daily_subscription_limit_system > 0) {
            assert!(arg0.runtime.daily_subscribed_usdc + (v1 as u128) <= (arg0.limits.daily_subscription_limit_system as u128), 6);
        };
        arg0.runtime.daily_subscribed_usdc = arg0.runtime.daily_subscribed_usdc + (v1 as u128);
        let v7 = calculate_fee(v1, arg0.fees.subscription_fee_bps);
        let v8 = v1 - v7;
        assert!(v8 > 0, 3);
        let v9 = 0x2::coin::into_balance<T0>(arg1);
        if (v7 > 0) {
            0x2::balance::join<T0>(&mut arg0.balances.fee_balance, 0x2::balance::split<T0>(&mut v9, v7));
        };
        0x2::balance::join<T0>(&mut arg0.balances.usdc_balance, v9);
        let v10 = arg0.counters.next_request_id;
        arg0.counters.next_request_id = v10 + 1;
        let v11 = processing_mode<T0, T1>(arg0, arg4);
        let v12 = SubscriptionRequest{
            id                   : v10,
            user                 : v0,
            status               : 0,
            batch_id             : 0,
            processing_mode      : v11,
            gross_usdc           : v1,
            fee_usdc             : v7,
            net_usdc             : v8,
            cancellation_fee_bps : arg0.fees.cancellation_fee_bps,
            min_shares_out       : arg2,
            max_shares_out       : arg3,
            allocated_shares     : 0,
            created_at_ms        : 0x2::clock::timestamp_ms(arg4),
            submitted_at_ms      : 0,
            finalized_at_ms      : 0,
        };
        0x2::vec_map::insert<u64, SubscriptionRequest>(&mut arg0.books.subscriptions, v10, v12);
        0x2::vec_set::insert<u64>(&mut arg0.books.active_subscriptions, v10);
        let v13 = SubscriptionRequested{
            request_id      : v10,
            user            : v0,
            gross_usdc      : v1,
            fee_usdc        : v7,
            net_usdc        : v8,
            min_shares_out  : arg2,
            max_shares_out  : arg3,
            processing_mode : v11,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SubscriptionRequested>(v13);
        v10
    }

    public fun subscription_max_shares_out(arg0: &SubscriptionRequest) : u128 {
        arg0.max_shares_out
    }

    public fun subscription_min_shares_out(arg0: &SubscriptionRequest) : u128 {
        arg0.min_shares_out
    }

    public fun subscription_net_usdc(arg0: &SubscriptionRequest) : u64 {
        arg0.net_usdc
    }

    public fun subscription_processing_mode(arg0: &SubscriptionRequest) : u8 {
        arg0.processing_mode
    }

    public(friend) fun subscription_request<T0, T1>(arg0: &AlphaVaultInner<T0, T1>, arg1: u64) : SubscriptionRequest {
        *0x2::vec_map::get<u64, SubscriptionRequest>(&arg0.books.subscriptions, &arg1)
    }

    public fun subscription_status(arg0: &SubscriptionRequest) : u8 {
        arg0.status
    }

    public(friend) fun transfer_admin<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 != @0x0, 21);
        arg0.access.pending_admin = 0x1::option::some<address>(arg1);
        let v0 = AdminTransferStarted{
            previous_admin : arg0.access.admin,
            new_admin      : arg1,
        };
        0x2::event::emit<AdminTransferStarted>(v0);
    }

    public(friend) fun usdc_balance<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balances.usdc_balance)
    }

    public(friend) fun usdc_dust_balance<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balances.usdc_dust)
    }

    public(friend) fun withdraw_dust<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x2::balance::value<T0>(&arg0.balances.usdc_dust);
        if (v0 > 0) {
            0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.usdc_dust, v0), arg1), arg0.wallets.fee_collector);
        };
        let v1 = 0x2::balance::value<T1>(&arg0.balances.xaua_dust);
        if (v1 > 0) {
            0x2::coin::send_funds<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balances.xaua_dust, v1), arg1), arg0.wallets.fee_collector);
        };
        if (v0 > 0 || v1 > 0) {
            let v2 = DustWithdrawn{
                usdc_amount : v0,
                xaua_amount : v1,
                recipient   : arg0.wallets.fee_collector,
            };
            0x2::event::emit<DustWithdrawn>(v2);
        };
    }

    public(friend) fun withdraw_fees<T0, T1>(arg0: &mut AlphaVaultInner<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_controller<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x2::balance::value<T0>(&arg0.balances.fee_balance);
        if (v0 > 0) {
            0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balances.fee_balance, v0), arg1), arg0.wallets.fee_collector);
            let v1 = FeesWithdrawn{
                amount    : v0,
                recipient : arg0.wallets.fee_collector,
            };
            0x2::event::emit<FeesWithdrawn>(v1);
        };
    }

    public(friend) fun xaua_balance<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balances.xaua_balance)
    }

    public(friend) fun xaua_dust_balance<T0, T1>(arg0: &AlphaVaultInner<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balances.xaua_dust)
    }

    fun zero_position() : UserPosition {
        UserPosition{
            available_shares            : 0,
            locked_shares               : 0,
            claimable_usdc              : 0,
            pending_subscription_shares : 0,
            usage_day                   : 0,
            total_subscribed_usdc       : 0,
            total_redeemed_shares       : 0,
            total_claimed_usdc          : 0,
        }
    }

    // decompiled from Move bytecode v7
}

