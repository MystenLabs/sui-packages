module 0x5dcba333e113b69f7e09b371e5ab895b593cf58474839679cce70fdc9e115b57::registry {
    struct MailMessage has key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        seal_id: vector<u8>,
        subject: vector<u8>,
        blob_ref: vector<u8>,
        blob_sha256: vector<u8>,
        sent_at_ms: u64,
    }

    struct MessageSent has copy, drop {
        message_object_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        seal_id: vector<u8>,
        subject: vector<u8>,
        blob_ref: vector<u8>,
        blob_sha256: vector<u8>,
        sent_at_ms: u64,
    }

    struct MessageDeleted has copy, drop {
        message_object_id: 0x2::object::ID,
        recipient: address,
    }

    entry fun delete_message(arg0: MailMessage, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.recipient, 1);
        let MailMessage {
            id          : v0,
            sender      : _,
            recipient   : v2,
            seal_id     : _,
            subject     : _,
            blob_ref    : _,
            blob_sha256 : _,
            sent_at_ms  : _,
        } = arg0;
        let v8 = v0;
        let v9 = MessageDeleted{
            message_object_id : 0x2::object::uid_to_inner(&v8),
            recipient         : v2,
        };
        0x2::event::emit<MessageDeleted>(v9);
        0x2::object::delete(v8);
    }

    fun is_valid_id_for(arg0: &vector<u8>, arg1: address) : bool {
        if (0x1::vector::length<u8>(arg0) != 32 + 32) {
            return false
        };
        let v0 = 0x2::address::to_bytes(arg1);
        let v1 = 0;
        while (v1 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(&v0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(is_valid_id_for(&arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    entry fun send(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 1024, 3);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 5);
        assert!(0x1::vector::length<u8>(&arg3) <= 160, 3);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 4);
        assert!(is_valid_id_for(&arg1, arg0), 2);
        let v0 = MailMessage{
            id          : 0x2::object::new(arg6),
            sender      : 0x2::tx_context::sender(arg6),
            recipient   : arg0,
            seal_id     : arg1,
            subject     : arg2,
            blob_ref    : arg3,
            blob_sha256 : arg4,
            sent_at_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = MessageSent{
            message_object_id : 0x2::object::id<MailMessage>(&v0),
            sender            : v0.sender,
            recipient         : arg0,
            seal_id           : v0.seal_id,
            subject           : v0.subject,
            blob_ref          : v0.blob_ref,
            blob_sha256       : v0.blob_sha256,
            sent_at_ms        : v0.sent_at_ms,
        };
        0x2::event::emit<MessageSent>(v1);
        0x2::transfer::transfer<MailMessage>(v0, arg0);
    }

    // decompiled from Move bytecode v7
}

