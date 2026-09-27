module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminRotation has key {
        id: 0x2::object::UID,
        admin_cap: 0x2::object::ID,
        rotation_renounced: bool,
        pending: 0x1::option::Option<PendingRotation>,
    }

    struct PendingRotation has drop, store {
        new_admin: address,
        proposed_by: address,
        proposed_at_ms: u64,
        ready_at_ms: u64,
        expires_at_ms: u64,
        accepted: bool,
    }

    struct AdminRotationProposed has copy, drop {
        rotation_id: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        current_admin: address,
        new_admin: address,
        proposed_at_ms: u64,
        ready_at_ms: u64,
        expires_at_ms: u64,
    }

    struct AdminRotationAccepted has copy, drop {
        rotation_id: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        new_admin: address,
        accepted_at_ms: u64,
        ready_at_ms: u64,
        expires_at_ms: u64,
    }

    struct AdminRotationCancelled has copy, drop {
        rotation_id: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        cancelled_by: address,
        new_admin: address,
        was_accepted: bool,
    }

    struct AdminRotationExecuted has copy, drop {
        rotation_id: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        previous_admin: address,
        new_admin: address,
        executed_at_ms: u64,
    }

    struct AdminRotationExpiredCleared has copy, drop {
        rotation_id: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        new_admin: address,
        expires_at_ms: u64,
        cleared_at_ms: u64,
    }

    struct AdminRotationRenounced has copy, drop {
        rotation_id: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        admin: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun accept_admin_rotation(arg0: &mut AdminRotation, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingRotation>(&arg0.pending), 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x1::option::borrow_mut<PendingRotation>(&mut arg0.pending);
        assert!(0x2::tx_context::sender(arg2) == v1.new_admin, 7);
        assert!(!v1.accepted, 8);
        assert!(v0 < v1.expires_at_ms, 11);
        v1.accepted = true;
        let v2 = AdminRotationAccepted{
            rotation_id    : 0x2::object::id<AdminRotation>(arg0),
            admin_cap      : arg0.admin_cap,
            new_admin      : v1.new_admin,
            accepted_at_ms : v0,
            ready_at_ms    : v1.ready_at_ms,
            expires_at_ms  : v1.expires_at_ms,
        };
        0x2::event::emit<AdminRotationAccepted>(v2);
    }

    public fun admin_cap_id(arg0: &AdminRotation) : 0x2::object::ID {
        arg0.admin_cap
    }

    public fun admin_renounce_rotation(arg0: &AdminCap, arg1: &mut AdminRotation, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap, 6);
        assert!(!arg1.rotation_renounced, 2);
        assert!(0x1::option::is_none<PendingRotation>(&arg1.pending), 3);
        arg1.rotation_renounced = true;
        let v0 = AdminRotationRenounced{
            rotation_id : 0x2::object::id<AdminRotation>(arg1),
            admin_cap   : arg1.admin_cap,
            admin       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminRotationRenounced>(v0);
    }

    public fun admin_rotation_delay_ms() : u64 {
        259200000
    }

    public fun admin_rotation_window_ms() : u64 {
        604800000
    }

    public fun cancel_admin_rotation(arg0: &AdminCap, arg1: &mut AdminRotation, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap, 6);
        assert!(0x1::option::is_some<PendingRotation>(&arg1.pending), 4);
        let PendingRotation {
            new_admin      : v0,
            proposed_by    : _,
            proposed_at_ms : _,
            ready_at_ms    : _,
            expires_at_ms  : _,
            accepted       : v5,
        } = 0x1::option::extract<PendingRotation>(&mut arg1.pending);
        let v6 = AdminRotationCancelled{
            rotation_id  : 0x2::object::id<AdminRotation>(arg1),
            admin_cap    : arg1.admin_cap,
            cancelled_by : 0x2::tx_context::sender(arg2),
            new_admin    : v0,
            was_accepted : v5,
        };
        0x2::event::emit<AdminRotationCancelled>(v6);
    }

    public fun clear_expired_admin_rotation(arg0: &mut AdminRotation, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<PendingRotation>(&arg0.pending), 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= 0x1::option::borrow<PendingRotation>(&arg0.pending).expires_at_ms, 12);
        let PendingRotation {
            new_admin      : v1,
            proposed_by    : _,
            proposed_at_ms : _,
            ready_at_ms    : _,
            expires_at_ms  : v5,
            accepted       : _,
        } = 0x1::option::extract<PendingRotation>(&mut arg0.pending);
        let v7 = AdminRotationExpiredCleared{
            rotation_id   : 0x2::object::id<AdminRotation>(arg0),
            admin_cap     : arg0.admin_cap,
            new_admin     : v1,
            expires_at_ms : v5,
            cleared_at_ms : v0,
        };
        0x2::event::emit<AdminRotationExpiredCleared>(v7);
    }

    public fun execute_admin_rotation(arg0: AdminCap, arg1: &mut AdminRotation, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(&arg0) == arg1.admin_cap, 6);
        assert!(0x1::option::is_some<PendingRotation>(&arg1.pending), 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::option::borrow<PendingRotation>(&arg1.pending);
        assert!(v1.accepted, 9);
        assert!(v0 >= v1.ready_at_ms, 10);
        assert!(v0 < v1.expires_at_ms, 11);
        let PendingRotation {
            new_admin      : v2,
            proposed_by    : _,
            proposed_at_ms : _,
            ready_at_ms    : _,
            expires_at_ms  : _,
            accepted       : _,
        } = 0x1::option::extract<PendingRotation>(&mut arg1.pending);
        let v8 = AdminRotationExecuted{
            rotation_id    : 0x2::object::id<AdminRotation>(arg1),
            admin_cap      : arg1.admin_cap,
            previous_admin : 0x2::tx_context::sender(arg3),
            new_admin      : v2,
            executed_at_ms : v0,
        };
        0x2::event::emit<AdminRotationExecuted>(v8);
        0x2::transfer::transfer<AdminCap>(arg0, v2);
    }

    public fun has_pending_rotation(arg0: &AdminRotation) : bool {
        0x1::option::is_some<PendingRotation>(&arg0.pending)
    }

    public(friend) fun new_admin_rotation(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminRotation {
        AdminRotation{
            id                 : 0x2::object::new(arg1),
            admin_cap          : 0x2::object::id<AdminCap>(arg0),
            rotation_renounced : false,
            pending            : 0x1::option::none<PendingRotation>(),
        }
    }

    public fun pending_accepted(arg0: &AdminRotation) : bool {
        0x1::option::is_some<PendingRotation>(&arg0.pending) && 0x1::option::borrow<PendingRotation>(&arg0.pending).accepted
    }

    public fun pending_expires_at_ms(arg0: &AdminRotation) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            0x1::option::some<u64>(0x1::option::borrow<PendingRotation>(&arg0.pending).expires_at_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun pending_new_admin(arg0: &AdminRotation) : 0x1::option::Option<address> {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            0x1::option::some<address>(0x1::option::borrow<PendingRotation>(&arg0.pending).new_admin)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun pending_proposed_at_ms(arg0: &AdminRotation) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            0x1::option::some<u64>(0x1::option::borrow<PendingRotation>(&arg0.pending).proposed_at_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun pending_ready_at_ms(arg0: &AdminRotation) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            0x1::option::some<u64>(0x1::option::borrow<PendingRotation>(&arg0.pending).ready_at_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun propose_admin_rotation(arg0: &AdminCap, arg1: &mut AdminRotation, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap, 6);
        assert!(!arg1.rotation_renounced, 1);
        assert!(0x1::option::is_none<PendingRotation>(&arg1.pending), 3);
        assert!(arg2 != @0x0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0 + 259200000;
        let v2 = v1 + 604800000;
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = PendingRotation{
            new_admin      : arg2,
            proposed_by    : v3,
            proposed_at_ms : v0,
            ready_at_ms    : v1,
            expires_at_ms  : v2,
            accepted       : false,
        };
        0x1::option::fill<PendingRotation>(&mut arg1.pending, v4);
        let v5 = AdminRotationProposed{
            rotation_id    : 0x2::object::id<AdminRotation>(arg1),
            admin_cap      : arg1.admin_cap,
            current_admin  : v3,
            new_admin      : arg2,
            proposed_at_ms : v0,
            ready_at_ms    : v1,
            expires_at_ms  : v2,
        };
        0x2::event::emit<AdminRotationProposed>(v5);
    }

    public fun rotation_renounced(arg0: &AdminRotation) : bool {
        arg0.rotation_renounced
    }

    public(friend) fun share_admin_rotation(arg0: AdminRotation) {
        0x2::transfer::share_object<AdminRotation>(arg0);
    }

    public(friend) fun transfer_admin_to_sender(arg0: AdminCap, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

