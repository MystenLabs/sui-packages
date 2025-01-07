module 0x2ba9b4505523d8ae7bd6d046d38ff670b18e2a9e6f54be0d8740491f95793ddf::messenger {
    struct EncryptedMessage has copy, drop, store {
        encrypted_text: vector<u8>,
        timestamp: u64,
        encrypted_from: vector<u8>,
        sender: address,
    }

    struct Dialog has store, key {
        id: 0x2::object::UID,
        messages: 0x2::table::Table<u64, EncryptedMessage>,
        message_count: u64,
    }

    public fun create_dialog(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dialog{
            id            : 0x2::object::new(arg0),
            messages      : 0x2::table::new<u64, EncryptedMessage>(arg0),
            message_count : 0,
        };
        0x2::transfer::share_object<Dialog>(v0);
    }

    public fun get_messages(arg0: &Dialog, arg1: vector<u8>) : vector<EncryptedMessage> {
        let v0 = 0x1::vector::empty<EncryptedMessage>();
        let v1 = 0;
        while (v1 < arg0.message_count) {
            0x1::vector::push_back<EncryptedMessage>(&mut v0, *0x2::table::borrow<u64, EncryptedMessage>(&arg0.messages, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun send_message(arg0: &mut Dialog, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = EncryptedMessage{
            encrypted_text : arg2,
            timestamp      : 0x2::tx_context::epoch(arg4),
            encrypted_from : arg3,
            sender         : 0x2::tx_context::sender(arg4),
        };
        0x2::table::add<u64, EncryptedMessage>(&mut arg0.messages, arg0.message_count, v0);
        arg0.message_count = arg0.message_count + 1;
    }

    // decompiled from Move bytecode v6
}

