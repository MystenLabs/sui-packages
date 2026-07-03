module 0x2026cf5a5c3376840841018471b2a14013b7f6a7e37028fc975379d6a5af9428::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct MessageRegistry has key {
        id: 0x2::object::UID,
        messages: 0x2::table::Table<u64, MessageRecord>,
        next_id: u64,
    }

    struct MessageRecord has store {
        sender: address,
        recipient: address,
        blob_id: vector<u8>,
        allowlist_id: address,
        timestamp: u64,
        opened: bool,
    }

    struct MessageDeleted has copy, drop {
        message_id: u64,
        deleted_by: address,
        timestamp: u64,
    }

    struct MessageSent has copy, drop {
        message_id: u64,
        sender: address,
        recipient: address,
        blob_id: vector<u8>,
        allowlist_id: address,
        timestamp: u64,
    }

    struct MessageOpened has copy, drop {
        message_id: u64,
        recipient: address,
        timestamp: u64,
    }

    public entry fun delete_message(arg0: &mut MessageRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<u64, MessageRecord>(&arg0.messages, arg1), 7);
        let v1 = 0x2::table::borrow<u64, MessageRecord>(&arg0.messages, arg1);
        assert!(v1.sender == v0 || v1.recipient == v0, 0);
        assert!(v1.opened, 6);
        let MessageRecord {
            sender       : _,
            recipient    : _,
            blob_id      : _,
            allowlist_id : _,
            timestamp    : _,
            opened       : _,
        } = 0x2::table::remove<u64, MessageRecord>(&mut arg0.messages, arg1);
        let v8 = MessageDeleted{
            message_id : arg1,
            deleted_by : v0,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<MessageDeleted>(v8);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageRegistry{
            id       : 0x2::object::new(arg1),
            messages : 0x2::table::new<u64, MessageRecord>(arg1),
            next_id  : 0,
        };
        0x2::transfer::share_object<MessageRegistry>(v0);
    }

    public fun message_allowlist_id(arg0: &MessageRegistry, arg1: u64) : address {
        0x2::table::borrow<u64, MessageRecord>(&arg0.messages, arg1).allowlist_id
    }

    public fun message_blob_id(arg0: &MessageRegistry, arg1: u64) : vector<u8> {
        0x2::table::borrow<u64, MessageRecord>(&arg0.messages, arg1).blob_id
    }

    public fun message_exists(arg0: &MessageRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, MessageRecord>(&arg0.messages, arg1)
    }

    public fun message_opened(arg0: &MessageRegistry, arg1: u64) : bool {
        0x2::table::borrow<u64, MessageRecord>(&arg0.messages, arg1).opened
    }

    public fun message_recipient(arg0: &MessageRegistry, arg1: u64) : address {
        0x2::table::borrow<u64, MessageRecord>(&arg0.messages, arg1).recipient
    }

    public fun message_sender(arg0: &MessageRegistry, arg1: u64) : address {
        0x2::table::borrow<u64, MessageRecord>(&arg0.messages, arg1).sender
    }

    public entry fun open_message(arg0: &mut MessageRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<u64, MessageRecord>(&mut arg0.messages, arg1);
        assert!(v1.recipient == v0, 0);
        assert!(!v1.opened, 2);
        v1.opened = true;
        let v2 = MessageOpened{
            message_id : arg1,
            recipient  : v0,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<MessageOpened>(v2);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 5);
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::tx_context::sender(arg1) == 0x2::bcs::peel_address(&mut v0), 0);
    }

    public entry fun send_message(arg0: &mut MessageRegistry, arg1: address, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 1);
        assert!(0x1::vector::length<u8>(&arg2) <= 256, 3);
        assert!(arg1 != @0x0, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = arg0.next_id;
        let v3 = MessageRecord{
            sender       : v0,
            recipient    : arg1,
            blob_id      : arg2,
            allowlist_id : arg3,
            timestamp    : v1,
            opened       : false,
        };
        0x2::table::add<u64, MessageRecord>(&mut arg0.messages, v2, v3);
        arg0.next_id = v2 + 1;
        let v4 = MessageSent{
            message_id   : v2,
            sender       : v0,
            recipient    : arg1,
            blob_id      : arg2,
            allowlist_id : arg3,
            timestamp    : v1,
        };
        0x2::event::emit<MessageSent>(v4);
        v2
    }

    public fun total_messages(arg0: &MessageRegistry) : u64 {
        arg0.next_id
    }

    // decompiled from Move bytecode v7
}

