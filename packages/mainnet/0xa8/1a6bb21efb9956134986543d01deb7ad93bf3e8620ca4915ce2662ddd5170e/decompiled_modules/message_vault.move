module 0xa81a6bb21efb9956134986543d01deb7ad93bf3e8620ca4915ce2662ddd5170e::message_vault {
    struct MESSAGE_VAULT has drop {
        dummy_field: bool,
    }

    struct MessageRegistry has key {
        id: 0x2::object::UID,
        total_messages: u64,
        messages_by_recipient: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct EncryptedMessage has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        created_at: u64,
        unlock_conditions: UnlockConditions,
        metadata: MessageMetadata,
        is_read: bool,
    }

    struct MessageMetadata has drop, store {
        message_type: u8,
        subject: 0x1::string::String,
        preview: 0x1::string::String,
        size: u64,
        ipfs_hash: 0x1::string::String,
        encryption_params: 0x1::string::String,
    }

    struct UnlockConditions has copy, drop, store {
        unlock_type: u8,
        time_lock: u64,
        required_signatures: vector<address>,
        nft_collection: 0x2::object::ID,
        custom_data: vector<u8>,
    }

    struct UserProfile has key {
        id: 0x2::object::UID,
        address: address,
        messages_sent: u64,
        messages_received: u64,
        reputation_score: u64,
        premium_until: u64,
        created_at: u64,
    }

    struct MessageCreated has copy, drop {
        message_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        unlock_type: u8,
        created_at: u64,
    }

    struct MessageAccessed has copy, drop {
        message_id: 0x2::object::ID,
        recipient: address,
        accessed_at: u64,
    }

    public entry fun create_direct_message(arg0: &mut MessageRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = UnlockConditions{
            unlock_type         : 0,
            time_lock           : 0,
            required_signatures : 0x1::vector::empty<address>(),
            nft_collection      : 0x2::object::id_from_address(@0x0),
            custom_data         : 0x1::vector::empty<u8>(),
        };
        create_message_internal(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun create_message_internal(arg0: &mut MessageRegistry, arg1: address, arg2: UnlockConditions, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 2);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = MessageMetadata{
            message_type      : arg7,
            subject           : arg3,
            preview           : arg4,
            size              : arg8,
            ipfs_hash         : arg5,
            encryption_params : arg6,
        };
        let v3 = EncryptedMessage{
            id                : 0x2::object::new(arg10),
            sender            : v0,
            recipient         : arg1,
            created_at        : v1,
            unlock_conditions : arg2,
            metadata          : v2,
            is_read           : false,
        };
        let v4 = 0x2::object::id<EncryptedMessage>(&v3);
        arg0.total_messages = arg0.total_messages + 1;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.messages_by_recipient, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.messages_by_recipient, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.messages_by_recipient, arg1), v4);
        update_sender_profile(v0, arg9, arg10);
        let v5 = MessageCreated{
            message_id  : v4,
            sender      : v0,
            recipient   : arg1,
            unlock_type : arg2.unlock_type,
            created_at  : v1,
        };
        0x2::event::emit<MessageCreated>(v5);
        0x2::transfer::transfer<EncryptedMessage>(v3, arg1);
    }

    public entry fun create_nft_gated_message(arg0: &mut MessageRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UnlockConditions{
            unlock_type         : 3,
            time_lock           : 0,
            required_signatures : 0x1::vector::empty<address>(),
            nft_collection      : arg2,
            custom_data         : 0x1::vector::empty<u8>(),
        };
        create_message_internal(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun create_time_locked_message(arg0: &mut MessageRegistry, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UnlockConditions{
            unlock_type         : 1,
            time_lock           : arg2,
            required_signatures : 0x1::vector::empty<address>(),
            nft_collection      : 0x2::object::id_from_address(@0x0),
            custom_data         : 0x1::vector::empty<u8>(),
        };
        create_message_internal(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun get_message_count(arg0: &MessageRegistry) : u64 {
        arg0.total_messages
    }

    public fun get_message_metadata(arg0: &EncryptedMessage) : (0x1::string::String, 0x1::string::String, u64, u8) {
        (arg0.metadata.subject, arg0.metadata.preview, arg0.metadata.size, arg0.metadata.message_type)
    }

    public(friend) fun get_recipient_address(arg0: &EncryptedMessage) : address {
        arg0.recipient
    }

    public fun get_recipient_messages(arg0: &MessageRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.messages_by_recipient, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.messages_by_recipient, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public(friend) fun get_sender_address(arg0: &EncryptedMessage) : address {
        arg0.sender
    }

    fun init(arg0: MESSAGE_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageRegistry{
            id                    : 0x2::object::new(arg1),
            total_messages        : 0,
            messages_by_recipient : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
        };
        0x2::transfer::share_object<MessageRegistry>(v0);
    }

    public fun is_message_accessible(arg0: &EncryptedMessage, arg1: &0x2::clock::Clock, arg2: address) : bool {
        if (arg0.recipient != arg2) {
            return false
        };
        let v0 = arg0.unlock_conditions.unlock_type;
        let v1 = &v0;
        let v2 = 0;
        if (v1 == &v2) {
            true
        } else {
            let v4 = 1;
            v1 == &v4 && 0x2::clock::timestamp_ms(arg1) >= arg0.unlock_conditions.time_lock
        }
    }

    public entry fun mark_as_read(arg0: &mut EncryptedMessage, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.recipient == 0x2::tx_context::sender(arg2), 1);
        arg0.is_read = true;
        let v0 = MessageAccessed{
            message_id  : 0x2::object::id<EncryptedMessage>(arg0),
            recipient   : arg0.recipient,
            accessed_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<MessageAccessed>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: &MessageRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
    }

    entry fun seal_approve_direct(arg0: vector<u8>, arg1: &EncryptedMessage, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.unlock_conditions.unlock_type == 0, 6);
        assert!(arg1.recipient == 0x2::tx_context::sender(arg2), 1);
    }

    entry fun seal_approve_nft_gated<T0: store + key>(arg0: vector<u8>, arg1: &EncryptedMessage, arg2: &T0, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.unlock_conditions.unlock_type == 3, 6);
        assert!(arg1.recipient == 0x2::tx_context::sender(arg3), 1);
    }

    entry fun seal_approve_time_lock(arg0: vector<u8>, arg1: &EncryptedMessage, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.unlock_conditions.unlock_type == 1, 6);
        assert!(arg1.recipient == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_conditions.time_lock, 3);
    }

    fun update_sender_profile(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

