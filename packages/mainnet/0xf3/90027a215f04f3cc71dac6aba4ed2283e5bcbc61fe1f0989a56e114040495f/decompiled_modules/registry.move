module 0xf390027a215f04f3cc71dac6aba4ed2283e5bcbc61fe1f0989a56e114040495f::registry {
    struct Mailbox has store, key {
        id: 0x2::object::UID,
        owner: address,
        min_postage_mist: u64,
        created_at_ms: u64,
    }

    struct MailMessage has key {
        id: 0x2::object::UID,
        recipient: address,
        sender: address,
        message_id: vector<u8>,
        subject: vector<u8>,
        blob_id: vector<u8>,
        sent_at_ms: u64,
        postage_mist: u64,
    }

    struct MailboxCreated has copy, drop {
        mailbox_id: 0x2::object::ID,
        owner: address,
        created_at_ms: u64,
    }

    struct MessageRegistered has copy, drop {
        message_object_id: 0x2::object::ID,
        recipient: address,
        sender: address,
        message_id: vector<u8>,
        subject: vector<u8>,
        blob_id: vector<u8>,
        sent_at_ms: u64,
        postage_mist: u64,
    }

    public entry fun create_mailbox(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Mailbox{
            id               : 0x2::object::new(arg1),
            owner            : 0x2::tx_context::sender(arg1),
            min_postage_mist : 0,
            created_at_ms    : 0x2::clock::timestamp_ms(arg0),
        };
        let v1 = MailboxCreated{
            mailbox_id    : 0x2::object::id<Mailbox>(&v0),
            owner         : 0x2::tx_context::sender(arg1),
            created_at_ms : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<MailboxCreated>(v1);
        0x2::transfer::transfer<Mailbox>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun register_message(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == 0, 3);
        let v0 = MailMessage{
            id           : 0x2::object::new(arg6),
            recipient    : arg0,
            sender       : 0x2::tx_context::sender(arg6),
            message_id   : arg1,
            subject      : arg2,
            blob_id      : arg3,
            sent_at_ms   : 0x2::clock::timestamp_ms(arg5),
            postage_mist : arg4,
        };
        let v1 = MessageRegistered{
            message_object_id : 0x2::object::id<MailMessage>(&v0),
            recipient         : arg0,
            sender            : 0x2::tx_context::sender(arg6),
            message_id        : arg1,
            subject           : arg2,
            blob_id           : arg3,
            sent_at_ms        : 0x2::clock::timestamp_ms(arg5),
            postage_mist      : arg4,
        };
        0x2::event::emit<MessageRegistered>(v1);
        0x2::transfer::share_object<MailMessage>(v0);
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &MailMessage, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == arg1.message_id, 2);
        assert!(0x2::tx_context::sender(arg2) == arg1.recipient, 1);
    }

    public entry fun set_min_postage(arg0: &mut Mailbox, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.min_postage_mist = arg1;
    }

    // decompiled from Move bytecode v7
}

