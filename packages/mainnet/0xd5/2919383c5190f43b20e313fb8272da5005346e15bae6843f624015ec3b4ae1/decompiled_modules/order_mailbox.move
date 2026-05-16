module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_mailbox {
    struct OrderMailbox has key {
        id: 0x2::object::UID,
        order_id: 0x1::string::String,
        buyer: address,
        seller: address,
        next_seq: u64,
        last_buyer_ack_seq: u64,
        last_seller_ack_seq: u64,
        close_approved_by_buyer: bool,
        close_approved_by_seller: bool,
        closed: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct MailboxBindingKey has copy, drop, store {
        order_id: vector<u8>,
        buyer: address,
        seller: address,
    }

    struct MailboxBinding has drop, store {
        mailbox_id: address,
    }

    struct OrderMailboxCreated has copy, drop {
        mailbox_id: address,
        order_id: 0x1::string::String,
        buyer: address,
        seller: address,
        created_at_ms: u64,
    }

    struct SignalPosted has copy, drop {
        mailbox_id: address,
        order_id: 0x1::string::String,
        seq: u64,
        signal_type: u8,
        sender: address,
        sender_role: u8,
        ciphertext_hash: 0x1::string::String,
        payload_ref: 0x1::string::String,
        created_at_ms: u64,
    }

    struct SignalAcked has copy, drop {
        mailbox_id: address,
        order_id: 0x1::string::String,
        acker: address,
        acker_role: u8,
        acked_seq: u64,
        acked_at_ms: u64,
    }

    struct OrderMailboxClosed has copy, drop {
        mailbox_id: address,
        order_id: 0x1::string::String,
        actor: address,
        closed_at_ms: u64,
    }

    public fun ack_signal(arg0: &mut OrderMailbox, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = sender_role_or_abort(arg0, v0);
        assert_mailbox_open(arg0);
        assert!(arg1 > 0 && arg1 < arg0.next_seq, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_ack_seq());
        if (v1 == 0) {
            assert!(arg1 > arg0.last_buyer_ack_seq, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_ack_not_monotonic());
            arg0.last_buyer_ack_seq = arg1;
        } else {
            assert!(arg1 > arg0.last_seller_ack_seq, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_ack_not_monotonic());
            arg0.last_seller_ack_seq = arg1;
        };
        let v2 = 0x2::clock::timestamp_ms(arg2);
        arg0.updated_at_ms = v2;
        let v3 = 0x2::object::id<OrderMailbox>(arg0);
        let v4 = SignalAcked{
            mailbox_id  : 0x2::object::id_to_address(&v3),
            order_id    : arg0.order_id,
            acker       : v0,
            acker_role  : v1,
            acked_seq   : arg1,
            acked_at_ms : v2,
        };
        0x2::event::emit<SignalAcked>(v4);
    }

    fun assert_lower_hex_sha256(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(0x1::vector::length<u8>(v0) == 64 && is_lower_hex_ascii(v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_hash());
    }

    fun assert_mailbox_open(arg0: &OrderMailbox) {
        assert!(!arg0.closed, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_closed());
    }

    fun assert_non_empty_with_max(arg0: &0x1::string::String, arg1: u64, arg2: u64) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 > 0 && v0 <= arg1, arg2);
    }

    fun assert_signal_type(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_signal_type());
    }

    public fun close_order_mailbox(arg0: &mut OrderMailbox, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_mailbox_open(arg0);
        if (sender_role_or_abort(arg0, v0) == 0) {
            arg0.close_approved_by_buyer = true;
        } else {
            arg0.close_approved_by_seller = true;
        };
        let v1 = 0x2::clock::timestamp_ms(arg1);
        arg0.updated_at_ms = v1;
        if (arg0.close_approved_by_buyer && arg0.close_approved_by_seller) {
            arg0.closed = true;
            let v2 = 0x2::object::id<OrderMailbox>(arg0);
            let v3 = OrderMailboxClosed{
                mailbox_id   : 0x2::object::id_to_address(&v2),
                order_id     : arg0.order_id,
                actor        : v0,
                closed_at_ms : v1,
            };
            0x2::event::emit<OrderMailboxClosed>(v3);
        };
    }

    public(friend) fun create_order_mailbox(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : OrderMailbox {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg1 || v0 == arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_not_authorized());
        assert!(arg1 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_input());
        assert!(arg2 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_input());
        assert!(arg1 != arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_input());
        assert_non_empty_with_max(&arg0, 128, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_input());
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = OrderMailbox{
            id                       : 0x2::object::new(arg5),
            order_id                 : arg0,
            buyer                    : arg1,
            seller                   : arg2,
            next_seq                 : 1,
            last_buyer_ack_seq       : 0,
            last_seller_ack_seq      : 0,
            close_approved_by_buyer  : false,
            close_approved_by_seller : false,
            closed                   : false,
            created_at_ms            : v1,
            updated_at_ms            : v1,
        };
        let v3 = 0x2::object::id<OrderMailbox>(&v2);
        let v4 = 0x2::object::id_to_address(&v3);
        record_mailbox_binding(arg3, &v2.order_id, arg1, arg2, v4);
        let v5 = OrderMailboxCreated{
            mailbox_id    : v4,
            order_id      : v2.order_id,
            buyer         : arg1,
            seller        : arg2,
            created_at_ms : v1,
        };
        0x2::event::emit<OrderMailboxCreated>(v5);
        v2
    }

    public fun delete_closed_mailbox_guarded(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: OrderMailbox, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.buyer || v0 == arg1.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_not_authorized());
        assert!(arg1.closed, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        remove_mailbox_binding_if_current(arg0, &arg1);
        let OrderMailbox {
            id                       : v1,
            order_id                 : _,
            buyer                    : _,
            seller                   : _,
            next_seq                 : _,
            last_buyer_ack_seq       : _,
            last_seller_ack_seq      : _,
            close_approved_by_buyer  : _,
            close_approved_by_seller : _,
            closed                   : _,
            created_at_ms            : _,
            updated_at_ms            : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun init_order_mailbox(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OrderMailbox>(create_order_mailbox(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    fun is_lower_hex_ascii(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = v1 >= 48 && v1 <= 57;
            let v3 = v1 >= 97 && v1 <= 102;
            if (!v2 && !v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun mailbox_binding_for_view(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: 0x1::string::String, arg2: address, arg3: address) : (bool, address) {
        if (0x2::dynamic_field::exists_<MailboxBindingKey>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::governance_uid(arg0), mailbox_binding_key(&arg1, arg2, arg3))) {
            (true, 0x2::dynamic_field::borrow<MailboxBindingKey, MailboxBinding>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::governance_uid(arg0), mailbox_binding_key(&arg1, arg2, arg3)).mailbox_id)
        } else {
            (false, @0x0)
        }
    }

    fun mailbox_binding_key(arg0: &0x1::string::String, arg1: address, arg2: address) : MailboxBindingKey {
        MailboxBindingKey{
            order_id : *0x1::string::as_bytes(arg0),
            buyer    : arg1,
            seller   : arg2,
        }
    }

    public fun post_signal(arg0: &mut OrderMailbox, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_mailbox_open(arg0);
        assert_signal_type(arg1);
        assert_lower_hex_sha256(&arg2);
        assert!(0x1::string::length(&arg3) <= 256, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_input());
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = arg0.next_seq;
        arg0.next_seq = v2 + 1;
        arg0.close_approved_by_buyer = false;
        arg0.close_approved_by_seller = false;
        arg0.updated_at_ms = v1;
        let v3 = 0x2::object::id<OrderMailbox>(arg0);
        let v4 = SignalPosted{
            mailbox_id      : 0x2::object::id_to_address(&v3),
            order_id        : arg0.order_id,
            seq             : v2,
            signal_type     : arg1,
            sender          : v0,
            sender_role     : sender_role_or_abort(arg0, v0),
            ciphertext_hash : arg2,
            payload_ref     : arg3,
            created_at_ms   : v1,
        };
        0x2::event::emit<SignalPosted>(v4);
    }

    fun record_mailbox_binding(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0x1::string::String, arg2: address, arg3: address, arg4: address) {
        assert!(!0x2::dynamic_field::exists_<MailboxBindingKey>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::governance_uid(arg0), mailbox_binding_key(arg1, arg2, arg3)), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_already_bound());
        let v0 = MailboxBinding{mailbox_id: arg4};
        0x2::dynamic_field::add<MailboxBindingKey, MailboxBinding>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::governance_uid_mut(arg0), mailbox_binding_key(arg1, arg2, arg3), v0);
    }

    fun remove_mailbox_binding_if_current(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &OrderMailbox) {
        assert!(0x2::dynamic_field::exists_<MailboxBindingKey>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::governance_uid(arg0), mailbox_binding_key(&arg1.order_id, arg1.buyer, arg1.seller)), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_input());
        let v0 = 0x2::object::id<OrderMailbox>(arg1);
        assert!(0x2::dynamic_field::borrow<MailboxBindingKey, MailboxBinding>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::governance_uid(arg0), mailbox_binding_key(&arg1.order_id, arg1.buyer, arg1.seller)).mailbox_id == 0x2::object::id_to_address(&v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_invalid_input());
        0x2::dynamic_field::remove<MailboxBindingKey, MailboxBinding>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::governance_uid_mut(arg0), mailbox_binding_key(&arg1.order_id, arg1.buyer, arg1.seller));
    }

    fun sender_role_or_abort(arg0: &OrderMailbox, arg1: address) : u8 {
        if (arg1 == arg0.buyer) {
            0
        } else {
            assert!(arg1 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_mailbox_not_authorized());
            1
        }
    }

    // decompiled from Move bytecode v7
}

