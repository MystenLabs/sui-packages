module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow {
    struct FeeConfig has key {
        id: 0x2::object::UID,
        sui_fee_bps: u64,
        sui_fee_recipient: address,
        pending_sui_fee_bps: u64,
        pending_sui_fee_recipient: address,
        pending_effective_at_ms: u64,
        has_pending_update: bool,
        pending_treasury_approved: bool,
        timelock_ms: u64,
        updated_at_ms: u64,
    }

    struct FeeConfigInitialized has copy, drop {
        config_id: address,
        actor: address,
        sui_fee_bps: u64,
        sui_fee_recipient: address,
        timelock_ms: u64,
    }

    struct FeeConfigUpdateQueued has copy, drop {
        config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct FeeConfigUpdated has copy, drop {
        config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    struct FeeConfigUpdateApproved has copy, drop {
        config_id: address,
        actor: address,
    }

    struct FeeConfigUpdateCanceled has copy, drop {
        config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct ListingFeePolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingListingFeePolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ListingFeePolicy has store {
        reference_exec_gas: u64,
        multiplier_bps: u64,
        min_sui: u64,
        max_sui: u64,
    }

    struct PendingListingFeePolicy has store {
        reference_exec_gas: u64,
        multiplier_bps: u64,
        min_sui: u64,
        max_sui: u64,
        effective_at_ms: u64,
        treasury_approved: bool,
    }

    struct ManagedStorageFeePolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ManagedStorageFeePolicy has store {
        asset: 0x1::string::String,
        min_atomic: u64,
        recipient: address,
        requires_chain_event: bool,
        event_type: 0x1::string::String,
        pending_asset: 0x1::string::String,
        pending_min_atomic: u64,
        pending_recipient: address,
        pending_requires_chain_event: bool,
        pending_event_type: 0x1::string::String,
        pending_effective_at_ms: u64,
        pending_treasury_approved: bool,
    }

    struct ListingFeePolicySeeded has copy, drop {
        host_config_id: address,
        actor: address,
        reference_exec_gas: u64,
        multiplier_bps: u64,
        min_sui: u64,
        max_sui: u64,
    }

    struct ListingFeePolicyUpdateQueued has copy, drop {
        host_config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct ListingFeePolicyUpdateApproved has copy, drop {
        host_config_id: address,
        actor: address,
    }

    struct ListingFeePolicyUpdateCanceled has copy, drop {
        host_config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct ListingFeePolicyUpdated has copy, drop {
        host_config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    struct ManagedStorageFeePolicySeeded has copy, drop {
        host_config_id: address,
        actor: address,
        asset: 0x1::string::String,
        min_atomic: u64,
        recipient: address,
        requires_chain_event: bool,
        event_type: 0x1::string::String,
    }

    struct ManagedStorageFeePolicyUpdateQueued has copy, drop {
        host_config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct ManagedStorageFeePolicyUpdateApproved has copy, drop {
        host_config_id: address,
        actor: address,
    }

    struct ManagedStorageFeePolicyUpdateCanceled has copy, drop {
        host_config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct ManagedStorageFeePolicyUpdated has copy, drop {
        host_config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    public fun apply_listing_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(has_listing_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(has_pending_listing_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        let v0 = PendingListingFeePolicyKey{dummy_field: false};
        let PendingListingFeePolicy {
            reference_exec_gas : v1,
            multiplier_bps     : v2,
            min_sui            : v3,
            max_sui            : v4,
            effective_at_ms    : v5,
            treasury_approved  : v6,
        } = 0x2::dynamic_field::remove<PendingListingFeePolicyKey, PendingListingFeePolicy>(&mut arg2.id, v0);
        assert!(v6, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_update_not_approved());
        let v7 = 0x2::clock::timestamp_ms(arg3);
        assert!(v7 >= v5, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_timelock_not_elapsed());
        let v8 = ListingFeePolicyKey{dummy_field: false};
        let v9 = 0x2::dynamic_field::borrow_mut<ListingFeePolicyKey, ListingFeePolicy>(&mut arg2.id, v8);
        v9.reference_exec_gas = v1;
        v9.multiplier_bps = v2;
        v9.min_sui = v3;
        v9.max_sui = v4;
        let v10 = 0x2::object::id<FeeConfig>(arg2);
        let v11 = ListingFeePolicyUpdated{
            host_config_id : 0x2::object::id_to_address(&v10),
            actor          : 0x2::tx_context::sender(arg4),
            applied_at_ms  : v7,
        };
        0x2::event::emit<ListingFeePolicyUpdated>(v11);
    }

    public fun apply_managed_storage_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(has_managed_storage_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(has_pending_managed_storage_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<FeeConfig>(arg2);
        let v2 = ManagedStorageFeePolicyKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<ManagedStorageFeePolicyKey, ManagedStorageFeePolicy>(&mut arg2.id, v2);
        assert!(v3.pending_treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_update_not_approved());
        assert!(v0 >= v3.pending_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_timelock_not_elapsed());
        v3.asset = v3.pending_asset;
        v3.min_atomic = v3.pending_min_atomic;
        v3.recipient = v3.pending_recipient;
        v3.requires_chain_event = v3.pending_requires_chain_event;
        v3.event_type = v3.pending_event_type;
        v3.pending_asset = 0x1::string::utf8(b"");
        v3.pending_min_atomic = 0;
        v3.pending_recipient = @0x0;
        v3.pending_requires_chain_event = false;
        v3.pending_event_type = 0x1::string::utf8(b"");
        v3.pending_effective_at_ms = 0;
        v3.pending_treasury_approved = false;
        let v4 = ManagedStorageFeePolicyUpdated{
            host_config_id : 0x2::object::id_to_address(&v1),
            actor          : 0x2::tx_context::sender(arg4),
            applied_at_ms  : v0,
        };
        0x2::event::emit<ManagedStorageFeePolicyUpdated>(v4);
    }

    public fun apply_sui_fee_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        assert!(arg2.pending_treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_update_not_approved());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.pending_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_timelock_not_elapsed());
        arg2.sui_fee_bps = arg2.pending_sui_fee_bps;
        arg2.sui_fee_recipient = arg2.pending_sui_fee_recipient;
        arg2.pending_sui_fee_bps = 0;
        arg2.pending_sui_fee_recipient = @0x0;
        arg2.pending_effective_at_ms = 0;
        arg2.has_pending_update = false;
        arg2.pending_treasury_approved = false;
        arg2.updated_at_ms = v0;
        let v1 = 0x2::object::id<FeeConfig>(arg2);
        let v2 = FeeConfigUpdated{
            config_id     : 0x2::object::id_to_address(&v1),
            actor         : 0x2::tx_context::sender(arg4),
            applied_at_ms : v0,
        };
        0x2::event::emit<FeeConfigUpdated>(v2);
    }

    public fun approve_pending_listing_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(has_pending_listing_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        let v0 = PendingListingFeePolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PendingListingFeePolicyKey, PendingListingFeePolicy>(&mut arg2.id, v0).treasury_approved = true;
        let v1 = 0x2::object::id<FeeConfig>(arg2);
        let v2 = ListingFeePolicyUpdateApproved{
            host_config_id : 0x2::object::id_to_address(&v1),
            actor          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ListingFeePolicyUpdateApproved>(v2);
    }

    public fun approve_pending_managed_storage_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(has_pending_managed_storage_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        let v0 = 0x2::object::id<FeeConfig>(arg2);
        let v1 = ManagedStorageFeePolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ManagedStorageFeePolicyKey, ManagedStorageFeePolicy>(&mut arg2.id, v1).pending_treasury_approved = true;
        let v2 = ManagedStorageFeePolicyUpdateApproved{
            host_config_id : 0x2::object::id_to_address(&v0),
            actor          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ManagedStorageFeePolicyUpdateApproved>(v2);
    }

    public fun approve_pending_sui_fee_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        arg2.pending_treasury_approved = true;
        let v0 = 0x2::object::id<FeeConfig>(arg2);
        let v1 = FeeConfigUpdateApproved{
            config_id : 0x2::object::id_to_address(&v0),
            actor     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeConfigUpdateApproved>(v1);
    }

    fun assert_valid_fee_config(arg0: u64, arg1: address) {
        assert!(arg0 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        if (arg0 > 0) {
            assert!(arg1 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        };
    }

    fun assert_valid_listing_fee_policy(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg1 > 0 && arg1 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg2 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg2 <= arg3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
    }

    fun assert_valid_managed_storage_fee_policy(arg0: &0x1::string::String, arg1: u64, arg2: address, arg3: bool, arg4: &0x1::string::String) {
        let v0 = 0x1::string::length(arg0);
        let v1 = 0x1::string::length(arg4);
        assert!(v0 > 0 && v0 <= 16, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg1 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg2 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(v1 <= 256, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        if (arg3) {
            assert!(v1 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        };
    }

    public fun cancel_pending_listing_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut FeeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_pending_listing_fee_policy(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        let v0 = PendingListingFeePolicyKey{dummy_field: false};
        let PendingListingFeePolicy {
            reference_exec_gas : _,
            multiplier_bps     : _,
            min_sui            : _,
            max_sui            : _,
            effective_at_ms    : v5,
            treasury_approved  : _,
        } = 0x2::dynamic_field::remove<PendingListingFeePolicyKey, PendingListingFeePolicy>(&mut arg1.id, v0);
        let v7 = 0x2::object::id<FeeConfig>(arg1);
        let v8 = ListingFeePolicyUpdateCanceled{
            host_config_id          : 0x2::object::id_to_address(&v7),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : v5,
        };
        0x2::event::emit<ListingFeePolicyUpdateCanceled>(v8);
    }

    public fun cancel_pending_managed_storage_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut FeeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_pending_managed_storage_fee_policy(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        let v0 = 0x2::object::id<FeeConfig>(arg1);
        let v1 = ManagedStorageFeePolicyKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ManagedStorageFeePolicyKey, ManagedStorageFeePolicy>(&mut arg1.id, v1);
        v2.pending_asset = 0x1::string::utf8(b"");
        v2.pending_min_atomic = 0;
        v2.pending_recipient = @0x0;
        v2.pending_requires_chain_event = false;
        v2.pending_event_type = 0x1::string::utf8(b"");
        v2.pending_effective_at_ms = 0;
        v2.pending_treasury_approved = false;
        let v3 = ManagedStorageFeePolicyUpdateCanceled{
            host_config_id          : 0x2::object::id_to_address(&v0),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : v2.pending_effective_at_ms,
        };
        0x2::event::emit<ManagedStorageFeePolicyUpdateCanceled>(v3);
    }

    public fun cancel_pending_sui_fee_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut FeeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        arg1.pending_sui_fee_bps = 0;
        arg1.pending_sui_fee_recipient = @0x0;
        arg1.pending_effective_at_ms = 0;
        arg1.has_pending_update = false;
        arg1.pending_treasury_approved = false;
        let v0 = 0x2::object::id<FeeConfig>(arg1);
        let v1 = FeeConfigUpdateCanceled{
            config_id               : 0x2::object::id_to_address(&v0),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : arg1.pending_effective_at_ms,
        };
        0x2::event::emit<FeeConfigUpdateCanceled>(v1);
    }

    public(friend) fun fee_config_uid(arg0: &FeeConfig) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun fee_config_uid_mut(arg0: &mut FeeConfig) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun has_listing_fee_policy(arg0: &FeeConfig) : bool {
        let v0 = ListingFeePolicyKey{dummy_field: false};
        0x2::dynamic_field::exists_<ListingFeePolicyKey>(&arg0.id, v0)
    }

    fun has_managed_storage_fee_policy(arg0: &FeeConfig) : bool {
        let v0 = ManagedStorageFeePolicyKey{dummy_field: false};
        0x2::dynamic_field::exists_<ManagedStorageFeePolicyKey>(&arg0.id, v0)
    }

    fun has_pending_listing_fee_policy(arg0: &FeeConfig) : bool {
        let v0 = PendingListingFeePolicyKey{dummy_field: false};
        0x2::dynamic_field::exists_<PendingListingFeePolicyKey>(&arg0.id, v0)
    }

    fun has_pending_managed_storage_fee_policy(arg0: &FeeConfig) : bool {
        if (!has_managed_storage_fee_policy(arg0)) {
            return false
        };
        let v0 = ManagedStorageFeePolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow<ManagedStorageFeePolicyKey, ManagedStorageFeePolicy>(&arg0.id, v0).pending_min_atomic > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = new_fee_config(0, @0x0, 86400000, 0, arg0);
        let v2 = 0x2::object::id<FeeConfig>(&v1);
        let v3 = FeeConfigInitialized{
            config_id         : 0x2::object::id_to_address(&v2),
            actor             : v0,
            sui_fee_bps       : v1.sui_fee_bps,
            sui_fee_recipient : v1.sui_fee_recipient,
            timelock_ms       : v1.timelock_ms,
        };
        0x2::event::emit<FeeConfigInitialized>(v3);
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    fun new_fee_config(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : FeeConfig {
        assert_valid_fee_config(arg0, arg1);
        assert!(arg2 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        FeeConfig{
            id                        : 0x2::object::new(arg4),
            sui_fee_bps               : arg0,
            sui_fee_recipient         : arg1,
            pending_sui_fee_bps       : 0,
            pending_sui_fee_recipient : @0x0,
            pending_effective_at_ms   : 0,
            has_pending_update        : false,
            pending_treasury_approved : false,
            timelock_ms               : arg2,
            updated_at_ms             : arg3,
        }
    }

    public fun queue_listing_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_listing_fee_policy(arg3, arg4, arg5, arg6);
        assert!(has_listing_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(!has_pending_listing_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = 0x2::clock::timestamp_ms(arg7) + arg2.timelock_ms;
        let v1 = PendingListingFeePolicyKey{dummy_field: false};
        let v2 = PendingListingFeePolicy{
            reference_exec_gas : arg3,
            multiplier_bps     : arg4,
            min_sui            : arg5,
            max_sui            : arg6,
            effective_at_ms    : v0,
            treasury_approved  : false,
        };
        0x2::dynamic_field::add<PendingListingFeePolicyKey, PendingListingFeePolicy>(&mut arg2.id, v1, v2);
        let v3 = 0x2::object::id<FeeConfig>(arg2);
        let v4 = ListingFeePolicyUpdateQueued{
            host_config_id  : 0x2::object::id_to_address(&v3),
            actor           : 0x2::tx_context::sender(arg8),
            effective_at_ms : v0,
        };
        0x2::event::emit<ListingFeePolicyUpdateQueued>(v4);
    }

    public fun queue_managed_storage_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: bool, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_managed_storage_fee_policy(&arg3, arg4, arg5, arg6, &arg7);
        assert!(has_managed_storage_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(!has_pending_managed_storage_fee_policy(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = 0x2::object::id<FeeConfig>(arg2);
        let v1 = ManagedStorageFeePolicyKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ManagedStorageFeePolicyKey, ManagedStorageFeePolicy>(&mut arg2.id, v1);
        v2.pending_asset = arg3;
        v2.pending_min_atomic = arg4;
        v2.pending_recipient = arg5;
        v2.pending_requires_chain_event = arg6;
        v2.pending_event_type = arg7;
        v2.pending_effective_at_ms = 0x2::clock::timestamp_ms(arg8) + arg2.timelock_ms;
        v2.pending_treasury_approved = false;
        let v3 = ManagedStorageFeePolicyUpdateQueued{
            host_config_id  : 0x2::object::id_to_address(&v0),
            actor           : 0x2::tx_context::sender(arg9),
            effective_at_ms : v2.pending_effective_at_ms,
        };
        0x2::event::emit<ManagedStorageFeePolicyUpdateQueued>(v3);
    }

    public fun queue_sui_fee_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut FeeConfig, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_fee_config(arg3, arg4);
        assert!(!arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = 0x2::clock::timestamp_ms(arg5) + arg2.timelock_ms;
        arg2.pending_sui_fee_bps = arg3;
        arg2.pending_sui_fee_recipient = arg4;
        arg2.pending_effective_at_ms = v0;
        arg2.has_pending_update = true;
        arg2.pending_treasury_approved = false;
        let v1 = 0x2::object::id<FeeConfig>(arg2);
        let v2 = FeeConfigUpdateQueued{
            config_id       : 0x2::object::id_to_address(&v1),
            actor           : 0x2::tx_context::sender(arg6),
            effective_at_ms : v0,
        };
        0x2::event::emit<FeeConfigUpdateQueued>(v2);
    }

    public fun seed_listing_fee_policy_if_missing(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut FeeConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_listing_fee_policy(arg2, arg3, arg4, arg5);
        assert!(!has_listing_fee_policy(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = ListingFeePolicyKey{dummy_field: false};
        let v1 = ListingFeePolicy{
            reference_exec_gas : arg2,
            multiplier_bps     : arg3,
            min_sui            : arg4,
            max_sui            : arg5,
        };
        0x2::dynamic_field::add<ListingFeePolicyKey, ListingFeePolicy>(&mut arg1.id, v0, v1);
        let v2 = 0x2::object::id<FeeConfig>(arg1);
        let v3 = ListingFeePolicySeeded{
            host_config_id     : 0x2::object::id_to_address(&v2),
            actor              : 0x2::tx_context::sender(arg6),
            reference_exec_gas : arg2,
            multiplier_bps     : arg3,
            min_sui            : arg4,
            max_sui            : arg5,
        };
        0x2::event::emit<ListingFeePolicySeeded>(v3);
    }

    public fun seed_managed_storage_fee_policy_if_missing(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut FeeConfig, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: bool, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_managed_storage_fee_policy(&arg2, arg3, arg4, arg5, &arg6);
        assert!(!has_managed_storage_fee_policy(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = ManagedStorageFeePolicyKey{dummy_field: false};
        let v1 = ManagedStorageFeePolicy{
            asset                        : arg2,
            min_atomic                   : arg3,
            recipient                    : arg4,
            requires_chain_event         : arg5,
            event_type                   : arg6,
            pending_asset                : 0x1::string::utf8(b""),
            pending_min_atomic           : 0,
            pending_recipient            : @0x0,
            pending_requires_chain_event : false,
            pending_event_type           : 0x1::string::utf8(b""),
            pending_effective_at_ms      : 0,
            pending_treasury_approved    : false,
        };
        0x2::dynamic_field::add<ManagedStorageFeePolicyKey, ManagedStorageFeePolicy>(&mut arg1.id, v0, v1);
        let v2 = 0x2::object::id<FeeConfig>(arg1);
        let v3 = ManagedStorageFeePolicySeeded{
            host_config_id       : 0x2::object::id_to_address(&v2),
            actor                : 0x2::tx_context::sender(arg7),
            asset                : arg2,
            min_atomic           : arg3,
            recipient            : arg4,
            requires_chain_event : arg5,
            event_type           : arg6,
        };
        0x2::event::emit<ManagedStorageFeePolicySeeded>(v3);
    }

    public fun sui_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.sui_fee_bps
    }

    public fun sui_fee_recipient(arg0: &FeeConfig) : address {
        arg0.sui_fee_recipient
    }

    // decompiled from Move bytecode v7
}

