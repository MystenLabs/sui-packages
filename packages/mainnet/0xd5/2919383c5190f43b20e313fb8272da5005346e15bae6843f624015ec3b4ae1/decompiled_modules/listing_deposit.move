module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::listing_deposit {
    struct ListingDepositConfig has key {
        id: 0x2::object::UID,
        deposit_amount_sui: u64,
        partial_refund_bps: u64,
        forfeit_sink: address,
        pending_deposit_amount_sui: u64,
        pending_partial_refund_bps: u64,
        pending_forfeit_sink: address,
        pending_effective_at_ms: u64,
        has_pending_update: bool,
        pending_treasury_approved: bool,
        timelock_ms: u64,
        updated_at_ms: u64,
    }

    struct ListingDeposit has key {
        id: 0x2::object::UID,
        owner: address,
        listing_ref: vector<u8>,
        state: u8,
        deposit_in: u64,
        refunded_total: u64,
        forfeited_total: u64,
        forfeit_sink: address,
        locked: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ListingDepositBindingKey has copy, drop, store {
        owner: address,
        listing_ref: vector<u8>,
    }

    struct ListingDepositConfigInitialized has copy, drop {
        config_id: address,
        actor: address,
        deposit_amount_sui: u64,
        partial_refund_bps: u64,
        forfeit_sink: address,
        timelock_ms: u64,
    }

    struct ListingDepositPolicyUpdateQueued has copy, drop {
        config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct ListingDepositPolicyUpdateApproved has copy, drop {
        config_id: address,
        actor: address,
    }

    struct ListingDepositPolicyUpdateCanceled has copy, drop {
        config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct ListingDepositConfigUpdated has copy, drop {
        config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    struct ListingDepositCreated has copy, drop {
        deposit_object_id: address,
        owner: address,
        listing_ref: vector<u8>,
        deposit_amount: u64,
        forfeit_sink: address,
    }

    struct ListingDepositSettled has copy, drop {
        deposit_object_id: address,
        owner: address,
        actor: address,
        settlement_mode: u8,
        total_amount: u64,
        refunded_amount: u64,
        forfeited_amount: u64,
    }

    public fun active_state() : u8 {
        0
    }

    public fun apply_listing_deposit_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ListingDepositConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_listing_deposit_update());
        assert!(arg2.pending_treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_listing_deposit_update_not_approved());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.pending_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_listing_deposit_timelock_not_elapsed());
        arg2.deposit_amount_sui = arg2.pending_deposit_amount_sui;
        arg2.partial_refund_bps = arg2.pending_partial_refund_bps;
        arg2.forfeit_sink = arg2.pending_forfeit_sink;
        arg2.pending_deposit_amount_sui = 0;
        arg2.pending_partial_refund_bps = 0;
        arg2.pending_forfeit_sink = @0x0;
        arg2.pending_effective_at_ms = 0;
        arg2.has_pending_update = false;
        arg2.pending_treasury_approved = false;
        arg2.updated_at_ms = v0;
        let v1 = 0x2::object::id<ListingDepositConfig>(arg2);
        let v2 = ListingDepositConfigUpdated{
            config_id     : 0x2::object::id_to_address(&v1),
            actor         : 0x2::tx_context::sender(arg4),
            applied_at_ms : v0,
        };
        0x2::event::emit<ListingDepositConfigUpdated>(v2);
    }

    public fun approve_pending_listing_deposit_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ListingDepositConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_listing_deposit_update());
        arg2.pending_treasury_approved = true;
        let v0 = 0x2::object::id<ListingDepositConfig>(arg2);
        let v1 = ListingDepositPolicyUpdateApproved{
            config_id : 0x2::object::id_to_address(&v0),
            actor     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ListingDepositPolicyUpdateApproved>(v1);
    }

    fun assert_accounting_invariant(arg0: &ListingDeposit) {
        assert!(arg0.deposit_in == arg0.refunded_total + arg0.forfeited_total + 0x2::balance::value<0x2::sui::SUI>(&arg0.locked), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_settlement());
    }

    fun assert_valid_config(arg0: u64, arg1: u64, arg2: address) {
        assert!(arg0 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_config());
        assert!(arg1 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_config());
        assert!(arg2 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_config());
    }

    fun assert_valid_listing_ref(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 128, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_ref());
    }

    public fun bound_listing_deposit_id_for_view(arg0: &ListingDepositConfig, arg1: address, arg2: vector<u8>) : (bool, address) {
        if (0x2::dynamic_field::exists_<ListingDepositBindingKey>(&arg0.id, listing_deposit_binding_key(arg1, &arg2))) {
            (true, *0x2::dynamic_field::borrow<ListingDepositBindingKey, address>(&arg0.id, listing_deposit_binding_key(arg1, &arg2)))
        } else {
            (false, @0x0)
        }
    }

    public fun cancel_pending_listing_deposit_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut ListingDepositConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_listing_deposit_update());
        arg1.pending_deposit_amount_sui = 0;
        arg1.pending_partial_refund_bps = 0;
        arg1.pending_forfeit_sink = @0x0;
        arg1.pending_effective_at_ms = 0;
        arg1.has_pending_update = false;
        arg1.pending_treasury_approved = false;
        let v0 = 0x2::object::id<ListingDepositConfig>(arg1);
        let v1 = ListingDepositPolicyUpdateCanceled{
            config_id               : 0x2::object::id_to_address(&v0),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : arg1.pending_effective_at_ms,
        };
        0x2::event::emit<ListingDepositPolicyUpdateCanceled>(v1);
    }

    fun create_listing_deposit_sui(arg0: address, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut ListingDepositConfig, arg4: &mut 0x2::tx_context::TxContext) : ListingDeposit {
        assert!(0x2::tx_context::sender(arg4) == arg0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_not_authorized());
        assert_valid_listing_ref(&arg1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == arg3.deposit_amount_sui, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_amount());
        let v1 = ListingDeposit{
            id              : 0x2::object::new(arg4),
            owner           : arg0,
            listing_ref     : arg1,
            state           : 0,
            deposit_in      : v0,
            refunded_total  : 0,
            forfeited_total : 0,
            forfeit_sink    : arg3.forfeit_sink,
            locked          : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
        };
        let v2 = 0x2::object::id<ListingDeposit>(&v1);
        let v3 = ListingDepositCreated{
            deposit_object_id : 0x2::object::id_to_address(&v2),
            owner             : v1.owner,
            listing_ref       : v1.listing_ref,
            deposit_amount    : v1.deposit_in,
            forfeit_sink      : v1.forfeit_sink,
        };
        0x2::event::emit<ListingDepositCreated>(v3);
        let v4 = 0x2::object::id<ListingDeposit>(&v1);
        record_listing_deposit_binding(arg3, v1.owner, &v1.listing_ref, 0x2::object::id_to_address(&v4));
        v1
    }

    public fun create_listing_deposit_sui_entry(arg0: address, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut ListingDepositConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<ListingDeposit>(create_listing_deposit_sui(arg0, arg1, arg2, arg3, arg4), arg0);
    }

    public fun create_listing_deposit_sui_shared_entry(arg0: vector<u8>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut ListingDepositConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_listing_ref(&arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == arg2.deposit_amount_sui, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_amount());
        let v1 = ListingDeposit{
            id              : 0x2::object::new(arg3),
            owner           : 0x2::tx_context::sender(arg3),
            listing_ref     : arg0,
            state           : 0,
            deposit_in      : v0,
            refunded_total  : 0,
            forfeited_total : 0,
            forfeit_sink    : arg2.forfeit_sink,
            locked          : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
        };
        let v2 = 0x2::object::id<ListingDeposit>(&v1);
        let v3 = ListingDepositCreated{
            deposit_object_id : 0x2::object::id_to_address(&v2),
            owner             : v1.owner,
            listing_ref       : v1.listing_ref,
            deposit_amount    : v1.deposit_in,
            forfeit_sink      : v1.forfeit_sink,
        };
        0x2::event::emit<ListingDepositCreated>(v3);
        let v4 = 0x2::object::id<ListingDeposit>(&v1);
        record_listing_deposit_binding(arg2, v1.owner, &v1.listing_ref, 0x2::object::id_to_address(&v4));
        0x2::transfer::share_object<ListingDeposit>(v1);
    }

    public fun deposit_amount_sui(arg0: &ListingDepositConfig) : u64 {
        arg0.deposit_amount_sui
    }

    public fun forfeit_listing_deposit_by_policy_and_unbind(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ListingDepositConfig, arg3: &mut ListingDeposit, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        remove_listing_deposit_binding_if_current(arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        forfeit_listing_deposit_with_refund_bps_internal(arg3, v0, arg2.partial_refund_bps, arg4);
    }

    public fun forfeit_listing_deposit_with_refund_bps_and_unbind(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ListingDepositConfig, arg3: &mut ListingDeposit, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        remove_listing_deposit_binding_if_current(arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        forfeit_listing_deposit_with_refund_bps_internal(arg3, v0, arg4, arg5);
    }

    fun forfeit_listing_deposit_with_refund_bps_internal(arg0: &mut ListingDeposit, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_config());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.locked);
        let v1 = (((v0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        settle_terminal(arg0, arg1, 1, v1, v0 - v1, arg3);
    }

    public fun forfeit_sink(arg0: &ListingDepositConfig) : address {
        arg0.forfeit_sink
    }

    public fun forfeited_state() : u8 {
        2
    }

    public fun has_pending_update(arg0: &ListingDepositConfig) : bool {
        arg0.has_pending_update
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = new_config(1, 0, @0xa0d4c9a9f935dac9f9bee55ca0632c187077a04d0dffcc479402f2de9a82140, 86400000, 0, arg0);
        let v2 = 0x2::object::id<ListingDepositConfig>(&v1);
        let v3 = ListingDepositConfigInitialized{
            config_id          : 0x2::object::id_to_address(&v2),
            actor              : v0,
            deposit_amount_sui : v1.deposit_amount_sui,
            partial_refund_bps : v1.partial_refund_bps,
            forfeit_sink       : v1.forfeit_sink,
            timelock_ms        : v1.timelock_ms,
        };
        0x2::event::emit<ListingDepositConfigInitialized>(v3);
        0x2::transfer::share_object<ListingDepositConfig>(v1);
    }

    fun listing_deposit_binding_key(arg0: address, arg1: &vector<u8>) : ListingDepositBindingKey {
        ListingDepositBindingKey{
            owner       : arg0,
            listing_ref : *arg1,
        }
    }

    fun new_config(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : ListingDepositConfig {
        assert_valid_config(arg0, arg1, arg2);
        assert!(arg3 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_config());
        ListingDepositConfig{
            id                         : 0x2::object::new(arg5),
            deposit_amount_sui         : arg0,
            partial_refund_bps         : arg1,
            forfeit_sink               : arg2,
            pending_deposit_amount_sui : 0,
            pending_partial_refund_bps : 0,
            pending_forfeit_sink       : @0x0,
            pending_effective_at_ms    : 0,
            has_pending_update         : false,
            pending_treasury_approved  : false,
            timelock_ms                : arg3,
            updated_at_ms              : arg4,
        }
    }

    public fun partial_refund_bps(arg0: &ListingDepositConfig) : u64 {
        arg0.partial_refund_bps
    }

    fun payout_sui_to(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg2), arg3), arg1);
        };
    }

    public fun pending_deposit_amount_sui(arg0: &ListingDepositConfig) : u64 {
        arg0.pending_deposit_amount_sui
    }

    public fun pending_effective_at_ms(arg0: &ListingDepositConfig) : u64 {
        arg0.pending_effective_at_ms
    }

    public fun pending_forfeit_sink(arg0: &ListingDepositConfig) : address {
        arg0.pending_forfeit_sink
    }

    public fun pending_partial_refund_bps(arg0: &ListingDepositConfig) : u64 {
        arg0.pending_partial_refund_bps
    }

    public fun pending_treasury_approved(arg0: &ListingDepositConfig) : bool {
        arg0.pending_treasury_approved
    }

    public fun queue_listing_deposit_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ListingDepositConfig, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_config(arg3, arg4, arg5);
        assert!(!arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = 0x2::clock::timestamp_ms(arg6) + arg2.timelock_ms;
        arg2.pending_deposit_amount_sui = arg3;
        arg2.pending_partial_refund_bps = arg4;
        arg2.pending_forfeit_sink = arg5;
        arg2.pending_effective_at_ms = v0;
        arg2.has_pending_update = true;
        arg2.pending_treasury_approved = false;
        let v1 = 0x2::object::id<ListingDepositConfig>(arg2);
        let v2 = ListingDepositPolicyUpdateQueued{
            config_id       : 0x2::object::id_to_address(&v1),
            actor           : 0x2::tx_context::sender(arg7),
            effective_at_ms : v0,
        };
        0x2::event::emit<ListingDepositPolicyUpdateQueued>(v2);
    }

    fun record_listing_deposit_binding(arg0: &mut ListingDepositConfig, arg1: address, arg2: &vector<u8>, arg3: address) {
        assert!(!0x2::dynamic_field::exists_<ListingDepositBindingKey>(&arg0.id, listing_deposit_binding_key(arg1, arg2)), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_listing_deposit_already_bound());
        0x2::dynamic_field::add<ListingDepositBindingKey, address>(&mut arg0.id, listing_deposit_binding_key(arg1, arg2), arg3);
    }

    public fun refund_listing_deposit_full_and_unbind(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ListingDepositConfig, arg3: &mut ListingDeposit, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        remove_listing_deposit_binding_if_current(arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg3.locked);
        settle_terminal(arg3, v0, 0, v1, 0, arg4);
    }

    public fun refunded_state() : u8 {
        1
    }

    fun remove_listing_deposit_binding_if_current(arg0: &mut ListingDepositConfig, arg1: &ListingDeposit) {
        assert!(0x2::dynamic_field::exists_<ListingDepositBindingKey>(&arg0.id, listing_deposit_binding_key(arg1.owner, &arg1.listing_ref)), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = 0x2::object::id<ListingDeposit>(arg1);
        assert!(*0x2::dynamic_field::borrow<ListingDepositBindingKey, address>(&arg0.id, listing_deposit_binding_key(arg1.owner, &arg1.listing_ref)) == 0x2::object::id_to_address(&v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        0x2::dynamic_field::remove<ListingDepositBindingKey, address>(&mut arg0.id, listing_deposit_binding_key(arg1.owner, &arg1.listing_ref));
    }

    fun settle_terminal(arg0: &mut ListingDeposit, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_settlement());
        assert!(arg0.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert_accounting_invariant(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.locked);
        assert!(v0 == arg3 + arg4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_settlement());
        let v1 = &mut arg0.locked;
        payout_sui_to(v1, arg0.owner, arg3, arg5);
        let v2 = &mut arg0.locked;
        payout_sui_to(v2, arg0.forfeit_sink, arg4, arg5);
        arg0.refunded_total = arg0.refunded_total + arg3;
        arg0.forfeited_total = arg0.forfeited_total + arg4;
        if (arg2 == 0) {
            arg0.state = 1;
        } else {
            arg0.state = 2;
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.locked) == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_listing_deposit_settlement());
        assert_accounting_invariant(arg0);
        let v3 = 0x2::object::id<ListingDeposit>(arg0);
        let v4 = ListingDepositSettled{
            deposit_object_id : 0x2::object::id_to_address(&v3),
            owner             : arg0.owner,
            actor             : arg1,
            settlement_mode   : arg2,
            total_amount      : v0,
            refunded_amount   : arg3,
            forfeited_amount  : arg4,
        };
        0x2::event::emit<ListingDepositSettled>(v4);
    }

    public fun settlement_forfeit_partial_mode() : u8 {
        1
    }

    public fun settlement_refund_full_mode() : u8 {
        0
    }

    public fun timelock_ms(arg0: &ListingDepositConfig) : u64 {
        arg0.timelock_ms
    }

    // decompiled from Move bytecode v7
}

