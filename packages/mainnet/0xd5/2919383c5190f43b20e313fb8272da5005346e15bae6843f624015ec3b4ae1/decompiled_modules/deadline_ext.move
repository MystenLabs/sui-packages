module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::deadline_ext {
    struct DeadlineExtensionRegistry has key {
        id: 0x2::object::UID,
    }

    struct ExtensionCountKey has copy, drop, store {
        escrow_id: address,
    }

    struct PendingExtensionKey has copy, drop, store {
        escrow_id: address,
    }

    struct DeadlineExtension has key {
        id: 0x2::object::UID,
        order_ref: vector<u8>,
        escrow_id: address,
        buyer: address,
        seller: address,
        proposer: address,
        current_deadline_ms: u64,
        proposed_deadline_ms: u64,
        extension_count: u64,
        state: u8,
        created_at_ms: u64,
        expires_at_ms: u64,
    }

    struct DeadlineExtensionProposed has copy, drop {
        extension_id: address,
        order_ref: vector<u8>,
        escrow_id: address,
        proposer: address,
        current_deadline_ms: u64,
        proposed_deadline_ms: u64,
    }

    struct DeadlineExtended has copy, drop {
        extension_id: address,
        order_ref: vector<u8>,
        escrow_id: address,
        acceptor: address,
        new_deadline_ms: u64,
    }

    struct DeadlineExtensionSettled has copy, drop {
        extension_id: address,
        order_ref: vector<u8>,
        escrow_id: address,
        actor: address,
        final_state: u8,
    }

    public(friend) entry fun accept_extension_with_escrow_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut DeadlineExtensionRegistry, arg2: &mut DeadlineExtension, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::OrderEscrow<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        accept_extension_with_escrow_internal<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    fun accept_extension_with_escrow_internal<T0>(arg0: &mut DeadlineExtensionRegistry, arg1: &mut DeadlineExtension, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::OrderEscrow<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        assert!(arg1.proposer == arg1.buyer && v0 == arg1.seller || v0 == arg1.buyer, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_not_authorized());
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.expires_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::assert_matches_deadline_extension<T0>(arg2, arg1.escrow_id, arg1.buyer, arg1.seller, arg1.current_deadline_ms);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::apply_deadline_extension<T0>(arg2, arg1.proposed_deadline_ms, arg3);
        arg1.state = 1;
        clear_pending_extension_or_abort(arg0, arg1.escrow_id);
        set_extension_count(arg0, arg1.escrow_id, arg1.extension_count);
        let v1 = 0x2::object::id<DeadlineExtension>(arg1);
        let v2 = DeadlineExtended{
            extension_id    : 0x2::object::id_to_address(&v1),
            order_ref       : arg1.order_ref,
            escrow_id       : arg1.escrow_id,
            acceptor        : v0,
            new_deadline_ms : arg1.proposed_deadline_ms,
        };
        0x2::event::emit<DeadlineExtended>(v2);
    }

    fun assert_valid_order_ref(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 128, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
    }

    fun build_extension<T0>(arg0: &mut DeadlineExtensionRegistry, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::OrderEscrow<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : DeadlineExtension {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2, v3, v4, v5) = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::deadline_extension_snapshot<T0>(arg1);
        let v6 = v1;
        assert!(v0 == v3 || v0 == v4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_not_authorized());
        assert!(v3 != v4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        assert!(v3 != @0x0 && v4 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        assert_valid_order_ref(&v6);
        assert!(arg2 > v5, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        assert!(!has_pending_extension(arg0, v2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_pending());
        let v7 = extension_count_for_escrow(arg0, v2);
        assert!(v7 < 3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_max_reached());
        let v8 = 0x2::clock::timestamp_ms(arg3);
        let v9 = DeadlineExtension{
            id                   : 0x2::object::new(arg4),
            order_ref            : v6,
            escrow_id            : v2,
            buyer                : v3,
            seller               : v4,
            proposer             : v0,
            current_deadline_ms  : v5,
            proposed_deadline_ms : arg2,
            extension_count      : v7 + 1,
            state                : 0,
            created_at_ms        : v8,
            expires_at_ms        : v8 + 172800000,
        };
        let v10 = 0x2::object::id<DeadlineExtension>(&v9);
        let v11 = DeadlineExtensionProposed{
            extension_id         : 0x2::object::id_to_address(&v10),
            order_ref            : v9.order_ref,
            escrow_id            : v2,
            proposer             : v0,
            current_deadline_ms  : v5,
            proposed_deadline_ms : arg2,
        };
        0x2::event::emit<DeadlineExtensionProposed>(v11);
        let v12 = PendingExtensionKey{escrow_id: v2};
        0x2::dynamic_field::add<PendingExtensionKey, bool>(&mut arg0.id, v12, true);
        v9
    }

    fun clear_pending_extension_or_abort(arg0: &mut DeadlineExtensionRegistry, arg1: address) {
        assert!(has_pending_extension(arg0, arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        let v0 = PendingExtensionKey{escrow_id: arg1};
        0x2::dynamic_field::remove<PendingExtensionKey, bool>(&mut arg0.id, v0);
    }

    public(friend) entry fun delete_settled_extension(arg0: DeadlineExtension, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (arg0.state == 1) {
            true
        } else if (arg0.state == 2) {
            true
        } else {
            arg0.state == 3
        };
        assert!(v1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_not_authorized());
        destroy_extension(arg0);
    }

    fun destroy_extension(arg0: DeadlineExtension) {
        let DeadlineExtension {
            id                   : v0,
            order_ref            : _,
            escrow_id            : _,
            buyer                : _,
            seller               : _,
            proposer             : _,
            current_deadline_ms  : _,
            proposed_deadline_ms : _,
            extension_count      : _,
            state                : _,
            created_at_ms        : _,
            expires_at_ms        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) entry fun expire_extension(arg0: &mut DeadlineExtensionRegistry, arg1: &mut DeadlineExtension, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        arg1.state = 2;
        clear_pending_extension_or_abort(arg0, arg1.escrow_id);
        let v0 = 0x2::object::id<DeadlineExtension>(arg1);
        let v1 = DeadlineExtensionSettled{
            extension_id : 0x2::object::id_to_address(&v0),
            order_ref    : arg1.order_ref,
            escrow_id    : arg1.escrow_id,
            actor        : 0x2::tx_context::sender(arg3),
            final_state  : 2,
        };
        0x2::event::emit<DeadlineExtensionSettled>(v1);
    }

    fun extension_count_for_escrow(arg0: &DeadlineExtensionRegistry, arg1: address) : u64 {
        let v0 = ExtensionCountKey{escrow_id: arg1};
        if (0x2::dynamic_field::exists_<ExtensionCountKey>(&arg0.id, v0)) {
            let v2 = ExtensionCountKey{escrow_id: arg1};
            *0x2::dynamic_field::borrow<ExtensionCountKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    fun has_pending_extension(arg0: &DeadlineExtensionRegistry, arg1: address) : bool {
        let v0 = PendingExtensionKey{escrow_id: arg1};
        0x2::dynamic_field::exists_<PendingExtensionKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DeadlineExtensionRegistry>(new_registry(arg0));
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : DeadlineExtensionRegistry {
        DeadlineExtensionRegistry{id: 0x2::object::new(arg0)}
    }

    public(friend) entry fun propose_extension_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut DeadlineExtensionRegistry, arg2: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::OrderEscrow<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        0x2::transfer::share_object<DeadlineExtension>(build_extension<T0>(arg1, arg2, arg3, arg4, arg5));
    }

    public(friend) entry fun reject_extension(arg0: &mut DeadlineExtensionRegistry, arg1: &mut DeadlineExtension, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_invalid());
        assert!(v0 == arg1.buyer || v0 == arg1.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_ext_not_authorized());
        arg1.state = 3;
        clear_pending_extension_or_abort(arg0, arg1.escrow_id);
        let v1 = 0x2::object::id<DeadlineExtension>(arg1);
        let v2 = DeadlineExtensionSettled{
            extension_id : 0x2::object::id_to_address(&v1),
            order_ref    : arg1.order_ref,
            escrow_id    : arg1.escrow_id,
            actor        : v0,
            final_state  : 3,
        };
        0x2::event::emit<DeadlineExtensionSettled>(v2);
    }

    fun set_extension_count(arg0: &mut DeadlineExtensionRegistry, arg1: address, arg2: u64) {
        let v0 = ExtensionCountKey{escrow_id: arg1};
        if (0x2::dynamic_field::exists_<ExtensionCountKey>(&arg0.id, v0)) {
            let v1 = ExtensionCountKey{escrow_id: arg1};
            0x2::dynamic_field::remove<ExtensionCountKey, u64>(&mut arg0.id, v1);
        };
        let v2 = ExtensionCountKey{escrow_id: arg1};
        0x2::dynamic_field::add<ExtensionCountKey, u64>(&mut arg0.id, v2, arg2);
    }

    // decompiled from Move bytecode v7
}

