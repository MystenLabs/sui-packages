module 0xa7bf2950ee4ee0a3ef80cc5b3192df1bb3f76992942740647aed53c9f824f274::referral {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PoolDirectory has key {
        id: 0x2::object::UID,
        pools: vector<PoolInfo>,
    }

    struct PendingRoot has drop, store {
        epoch: u64,
        merkle_root: vector<u8>,
        total_cumulative: u64,
        metadata_digest: vector<u8>,
        proposed_at_ms: u64,
        activate_after_ms: u64,
    }

    struct ReferralPool<phantom T0> has key {
        id: 0x2::object::UID,
        publisher: address,
        guardian: address,
        settlement_enabled: bool,
        claims_paused: bool,
        root_delay_ms: u64,
        vault: 0x2::balance::Balance<T0>,
        active_epoch: u64,
        active_root: vector<u8>,
        active_total_cumulative: u64,
        active_metadata_digest: vector<u8>,
        pending_root: 0x1::option::Option<PendingRoot>,
        claimed_amounts: 0x2::table::Table<address, u64>,
        total_claimed: u64,
    }

    struct DirectoryCreated has copy, drop {
        directory_id: 0x2::object::ID,
        admin: address,
    }

    struct PoolCreated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        publisher: address,
        guardian: address,
        root_delay_ms: u64,
    }

    struct Deposited<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    struct RootProposed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        epoch: u64,
        merkle_root: vector<u8>,
        total_cumulative: u64,
        metadata_digest: vector<u8>,
        proposed_at_ms: u64,
        activate_after_ms: u64,
    }

    struct RootActivated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        epoch: u64,
        merkle_root: vector<u8>,
        total_cumulative: u64,
        metadata_digest: vector<u8>,
        activated_at_ms: u64,
        activator: address,
    }

    struct RootCanceled<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        epoch: u64,
        canceled_by: address,
    }

    struct RewardClaimed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        epoch: u64,
        recipient: address,
        cumulative_amount: u64,
        previously_claimed: u64,
        payout: u64,
    }

    struct PublisherChanged<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        old_publisher: address,
        new_publisher: address,
    }

    struct GuardianChanged<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        old_guardian: address,
        new_guardian: address,
    }

    struct RootDelayChanged<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        old_delay_ms: u64,
        new_delay_ms: u64,
    }

    struct SettlementEnabledChanged<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        enabled: bool,
    }

    struct ClaimsPaused<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        paused_by: address,
    }

    struct ClaimsResumed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        resumed_by: address,
    }

    struct ExcessWithdrawn<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct EmergencyWithdrawal<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        epoch: u64,
        recipient: address,
        amount: u64,
        outstanding_liability: u64,
        reason_digest: vector<u8>,
    }

    public fun activate_root<T0>(arg0: &mut ReferralPool<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.settlement_enabled, 6);
        assert!(0x1::option::is_some<PendingRoot>(&arg0.pending_root), 9);
        let v0 = 0x1::option::borrow<PendingRoot>(&arg0.pending_root);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.activate_after_ms, 10);
        assert!(v0.epoch == arg0.active_epoch + 1, 11);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v0.total_cumulative - arg0.total_claimed, 15);
        let PendingRoot {
            epoch             : v1,
            merkle_root       : v2,
            total_cumulative  : v3,
            metadata_digest   : v4,
            proposed_at_ms    : _,
            activate_after_ms : _,
        } = 0x1::option::extract<PendingRoot>(&mut arg0.pending_root);
        arg0.active_epoch = v1;
        arg0.active_root = v2;
        arg0.active_total_cumulative = v3;
        arg0.active_metadata_digest = v4;
        let v7 = RootActivated<T0>{
            pool_id          : 0x2::object::id<ReferralPool<T0>>(arg0),
            epoch            : v1,
            merkle_root      : v2,
            total_cumulative : v3,
            metadata_digest  : v4,
            activated_at_ms  : 0x2::clock::timestamp_ms(arg1),
            activator        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RootActivated<T0>>(v7);
    }

    public fun active_epoch<T0>(arg0: &ReferralPool<T0>) : u64 {
        arg0.active_epoch
    }

    public fun active_metadata_digest<T0>(arg0: &ReferralPool<T0>) : vector<u8> {
        arg0.active_metadata_digest
    }

    public fun active_root<T0>(arg0: &ReferralPool<T0>) : vector<u8> {
        arg0.active_root
    }

    public fun active_total_cumulative<T0>(arg0: &ReferralPool<T0>) : u64 {
        arg0.active_total_cumulative
    }

    public fun admin_cancel_pending_root<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: &0x2::tx_context::TxContext) {
        cancel_pending<T0>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun admin_pause_claims<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: &0x2::tx_context::TxContext) {
        pause_claims<T0>(arg1, 0x2::tx_context::sender(arg2));
    }

    fun cancel_pending<T0>(arg0: &mut ReferralPool<T0>, arg1: address) {
        assert!(0x1::option::is_some<PendingRoot>(&arg0.pending_root), 9);
        let PendingRoot {
            epoch             : v0,
            merkle_root       : _,
            total_cumulative  : _,
            metadata_digest   : _,
            proposed_at_ms    : _,
            activate_after_ms : _,
        } = 0x1::option::extract<PendingRoot>(&mut arg0.pending_root);
        let v6 = RootCanceled<T0>{
            pool_id     : 0x2::object::id<ReferralPool<T0>>(arg0),
            epoch       : v0,
            canceled_by : arg1,
        };
        0x2::event::emit<RootCanceled<T0>>(v6);
    }

    public fun cancel_pending_root<T0>(arg0: &mut ReferralPool<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.publisher || v0 == arg0.guardian, 5);
        cancel_pending<T0>(arg0, v0);
    }

    public fun claim<T0>(arg0: &mut ReferralPool<T0>, arg1: u64, arg2: u64, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claims_paused, 7);
        assert!(arg0.active_epoch > 0 && arg1 == arg0.active_epoch, 11);
        assert!(arg2 <= arg0.active_total_cumulative, 18);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xa7bf2950ee4ee0a3ef80cc5b3192df1bb3f76992942740647aed53c9f824f274::merkle::proof_root(0xa7bf2950ee4ee0a3ef80cc5b3192df1bb3f76992942740647aed53c9f824f274::merkle::claim_leaf(0x2::object::uid_to_bytes(&arg0.id), arg1, v0, arg2), arg3) == arg0.active_root, 16);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.claimed_amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed_amounts, v0)
        } else {
            0
        };
        assert!(arg2 > v1, 17);
        let v2 = arg2 - v1;
        assert!(v2 <= arg0.active_total_cumulative - arg0.total_claimed, 18);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v2, 15);
        if (0x2::table::contains<address, u64>(&arg0.claimed_amounts, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed_amounts, v0) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claimed_amounts, v0, arg2);
        };
        arg0.total_claimed = arg0.total_claimed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v2), arg4), v0);
        let v3 = RewardClaimed<T0>{
            pool_id            : 0x2::object::id<ReferralPool<T0>>(arg0),
            epoch              : arg1,
            recipient          : v0,
            cumulative_amount  : arg2,
            previously_claimed : v1,
            payout             : v2,
        };
        0x2::event::emit<RewardClaimed<T0>>(v3);
    }

    public fun claimed_amount<T0>(arg0: &ReferralPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed_amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed_amounts, arg1)
        } else {
            0
        }
    }

    public fun claims_paused<T0>(arg0: &ReferralPool<T0>) : bool {
        arg0.claims_paused
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: &mut PoolDirectory, arg2: address, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = new_pool<T0>(arg1, arg2, arg3, arg4, arg5);
        let v1 = PoolCreated<T0>{
            pool_id       : 0x2::object::id<ReferralPool<T0>>(&v0),
            publisher     : arg2,
            guardian      : arg3,
            root_delay_ms : arg4,
        };
        0x2::event::emit<PoolCreated<T0>>(v1);
        0x2::transfer::share_object<ReferralPool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut ReferralPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Deposited<T0>{
            pool_id   : 0x2::object::id<ReferralPool<T0>>(arg0),
            depositor : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<Deposited<T0>>(v1);
    }

    fun directory_contains_type(arg0: &PoolDirectory, arg1: &0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolInfo>(&arg0.pools)) {
            if (&0x1::vector::borrow<PoolInfo>(&arg0.pools, v0).coin_type == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun directory_pool_count(arg0: &PoolDirectory) : u64 {
        0x1::vector::length<PoolInfo>(&arg0.pools)
    }

    public fun emergency_shutdown_and_withdraw_all<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 1);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13);
        let v0 = arg1.active_total_cumulative - arg1.total_claimed;
        arg1.claims_paused = true;
        arg1.settlement_enabled = false;
        if (0x1::option::is_some<PendingRoot>(&arg1.pending_root)) {
            cancel_pending<T0>(arg1, 0x2::tx_context::sender(arg4));
        };
        let v1 = 0x2::balance::value<T0>(&arg1.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v1), arg4), arg2);
        let v2 = EmergencyWithdrawal<T0>{
            pool_id               : 0x2::object::id<ReferralPool<T0>>(arg1),
            epoch                 : arg1.active_epoch,
            recipient             : arg2,
            amount                : v1,
            outstanding_liability : v0,
            reason_digest         : arg3,
        };
        0x2::event::emit<EmergencyWithdrawal<T0>>(v2);
    }

    public fun guardian<T0>(arg0: &ReferralPool<T0>) : address {
        arg0.guardian
    }

    public fun guardian_pause_claims<T0>(arg0: &mut ReferralPool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.guardian, 5);
        pause_claims<T0>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun has_pending_root<T0>(arg0: &ReferralPool<T0>) : bool {
        0x1::option::is_some<PendingRoot>(&arg0.pending_root)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = PoolDirectory{
            id    : 0x2::object::new(arg0),
            pools : 0x1::vector::empty<PoolInfo>(),
        };
        let v3 = DirectoryCreated{
            directory_id : 0x2::object::id<PoolDirectory>(&v2),
            admin        : v0,
        };
        0x2::event::emit<DirectoryCreated>(v3);
        0x2::transfer::share_object<PoolDirectory>(v2);
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
    }

    fun new_pool<T0>(arg0: &mut PoolDirectory, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : ReferralPool<T0> {
        assert!(arg1 != @0x0, 1);
        assert!(arg2 != @0x0, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!directory_contains_type(arg0, &v0), 3);
        let v1 = ReferralPool<T0>{
            id                      : 0x2::object::new(arg4),
            publisher               : arg1,
            guardian                : arg2,
            settlement_enabled      : true,
            claims_paused           : false,
            root_delay_ms           : arg3,
            vault                   : 0x2::balance::zero<T0>(),
            active_epoch            : 0,
            active_root             : b"",
            active_total_cumulative : 0,
            active_metadata_digest  : b"",
            pending_root            : 0x1::option::none<PendingRoot>(),
            claimed_amounts         : 0x2::table::new<address, u64>(arg4),
            total_claimed           : 0,
        };
        let v2 = PoolInfo{
            pool_id   : 0x2::object::id<ReferralPool<T0>>(&v1),
            coin_type : v0,
        };
        0x1::vector::push_back<PoolInfo>(&mut arg0.pools, v2);
        v1
    }

    public fun outstanding_liability<T0>(arg0: &ReferralPool<T0>) : u64 {
        let v0 = if (0x1::option::is_some<PendingRoot>(&arg0.pending_root)) {
            0x1::option::borrow<PendingRoot>(&arg0.pending_root).total_cumulative
        } else {
            arg0.active_total_cumulative
        };
        v0 - arg0.total_claimed
    }

    fun pause_claims<T0>(arg0: &mut ReferralPool<T0>, arg1: address) {
        arg0.claims_paused = true;
        let v0 = ClaimsPaused<T0>{
            pool_id   : 0x2::object::id<ReferralPool<T0>>(arg0),
            paused_by : arg1,
        };
        0x2::event::emit<ClaimsPaused<T0>>(v0);
    }

    public fun pending_activate_after_ms<T0>(arg0: &ReferralPool<T0>) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<PendingRoot>(&arg0.pending_root)) {
            0x1::option::some<u64>(0x1::option::borrow<PendingRoot>(&arg0.pending_root).activate_after_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun pending_epoch<T0>(arg0: &ReferralPool<T0>) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<PendingRoot>(&arg0.pending_root)) {
            0x1::option::some<u64>(0x1::option::borrow<PendingRoot>(&arg0.pending_root).epoch)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun pending_merkle_root<T0>(arg0: &ReferralPool<T0>) : 0x1::option::Option<vector<u8>> {
        if (0x1::option::is_some<PendingRoot>(&arg0.pending_root)) {
            0x1::option::some<vector<u8>>(0x1::option::borrow<PendingRoot>(&arg0.pending_root).merkle_root)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun pending_metadata_digest<T0>(arg0: &ReferralPool<T0>) : 0x1::option::Option<vector<u8>> {
        if (0x1::option::is_some<PendingRoot>(&arg0.pending_root)) {
            0x1::option::some<vector<u8>>(0x1::option::borrow<PendingRoot>(&arg0.pending_root).metadata_digest)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun pending_total_cumulative<T0>(arg0: &ReferralPool<T0>) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<PendingRoot>(&arg0.pending_root)) {
            0x1::option::some<u64>(0x1::option::borrow<PendingRoot>(&arg0.pending_root).total_cumulative)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun pool_id_bytes<T0>(arg0: &ReferralPool<T0>) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun propose_root<T0>(arg0: &mut ReferralPool<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.publisher, 4);
        assert!(arg0.settlement_enabled, 6);
        assert!(0x1::option::is_none<PendingRoot>(&arg0.pending_root), 8);
        assert!(arg1 == arg0.active_epoch + 1, 11);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 12);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13);
        assert!(arg3 >= arg0.active_total_cumulative, 14);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg3 - arg0.total_claimed, 15);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 + arg0.root_delay_ms;
        let v2 = PendingRoot{
            epoch             : arg1,
            merkle_root       : arg2,
            total_cumulative  : arg3,
            metadata_digest   : arg4,
            proposed_at_ms    : v0,
            activate_after_ms : v1,
        };
        arg0.pending_root = 0x1::option::some<PendingRoot>(v2);
        let v3 = RootProposed<T0>{
            pool_id           : 0x2::object::id<ReferralPool<T0>>(arg0),
            epoch             : arg1,
            merkle_root       : arg2,
            total_cumulative  : arg3,
            metadata_digest   : arg4,
            proposed_at_ms    : v0,
            activate_after_ms : v1,
        };
        0x2::event::emit<RootProposed<T0>>(v3);
    }

    public fun publisher<T0>(arg0: &ReferralPool<T0>) : address {
        arg0.publisher
    }

    public fun resume_claims<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.vault) >= arg1.active_total_cumulative - arg1.total_claimed, 15);
        arg1.claims_paused = false;
        let v0 = ClaimsResumed<T0>{
            pool_id    : 0x2::object::id<ReferralPool<T0>>(arg1),
            resumed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ClaimsResumed<T0>>(v0);
    }

    public fun root_delay_ms<T0>(arg0: &ReferralPool<T0>) : u64 {
        arg0.root_delay_ms
    }

    public fun set_guardian<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: address) {
        assert!(arg2 != @0x0, 1);
        arg1.guardian = arg2;
        let v0 = GuardianChanged<T0>{
            pool_id      : 0x2::object::id<ReferralPool<T0>>(arg1),
            old_guardian : arg1.guardian,
            new_guardian : arg2,
        };
        0x2::event::emit<GuardianChanged<T0>>(v0);
    }

    public fun set_publisher<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: address) {
        assert!(arg2 != @0x0, 1);
        arg1.publisher = arg2;
        let v0 = PublisherChanged<T0>{
            pool_id       : 0x2::object::id<ReferralPool<T0>>(arg1),
            old_publisher : arg1.publisher,
            new_publisher : arg2,
        };
        0x2::event::emit<PublisherChanged<T0>>(v0);
    }

    public fun set_root_delay<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: u64) {
        arg1.root_delay_ms = arg2;
        let v0 = RootDelayChanged<T0>{
            pool_id      : 0x2::object::id<ReferralPool<T0>>(arg1),
            old_delay_ms : arg1.root_delay_ms,
            new_delay_ms : arg2,
        };
        0x2::event::emit<RootDelayChanged<T0>>(v0);
    }

    public fun set_settlement_enabled<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        if (!arg2 && 0x1::option::is_some<PendingRoot>(&arg1.pending_root)) {
            cancel_pending<T0>(arg1, 0x2::tx_context::sender(arg3));
        };
        arg1.settlement_enabled = arg2;
        let v0 = SettlementEnabledChanged<T0>{
            pool_id : 0x2::object::id<ReferralPool<T0>>(arg1),
            enabled : arg2,
        };
        0x2::event::emit<SettlementEnabledChanged<T0>>(v0);
    }

    public fun settlement_enabled<T0>(arg0: &ReferralPool<T0>) : bool {
        arg0.settlement_enabled
    }

    public fun total_claimed<T0>(arg0: &ReferralPool<T0>) : u64 {
        arg0.total_claimed
    }

    public fun vault_balance<T0>(arg0: &ReferralPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun withdraw_excess<T0>(arg0: &AdminCap, arg1: &mut ReferralPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(arg3 != @0x0, 1);
        assert!(arg2 <= withdrawable_excess<T0>(arg1), 19);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, arg2), arg4), arg3);
        let v0 = ExcessWithdrawn<T0>{
            pool_id   : 0x2::object::id<ReferralPool<T0>>(arg1),
            recipient : arg3,
            amount    : arg2,
        };
        0x2::event::emit<ExcessWithdrawn<T0>>(v0);
    }

    public fun withdrawable_excess<T0>(arg0: &ReferralPool<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.vault);
        let v1 = outstanding_liability<T0>(arg0);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

