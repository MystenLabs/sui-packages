module 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::message {
    struct Message has copy, drop, store {
        index: u64,
        sender: address,
        sender_agent_id: vector<u8>,
        message_type: u8,
        content: vector<u8>,
        nonce: vector<u8>,
        dek_version: u64,
        attachment_blob_id: vector<u8>,
        created_at: u64,
    }

    public fun attachment_blob_id(arg0: &Message) : vector<u8> {
        arg0.attachment_blob_id
    }

    public fun content(arg0: &Message) : vector<u8> {
        arg0.content
    }

    public fun created_at(arg0: &Message) : u64 {
        arg0.created_at
    }

    public fun dek_version(arg0: &Message) : u64 {
        arg0.dek_version
    }

    public fun index(arg0: &Message) : u64 {
        arg0.index
    }

    public fun message_type(arg0: &Message) : u8 {
        arg0.message_type
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: u64) : Message {
        assert!(0x1::vector::length<u8>(&arg4) <= 65536, 1);
        assert!(0x1::vector::length<u8>(&arg5) <= 12, 2);
        assert!(0x1::vector::length<u8>(&arg2) <= 256, 3);
        assert!(arg3 <= 3, 4);
        Message{
            index              : arg0,
            sender             : arg1,
            sender_agent_id    : arg2,
            message_type       : arg3,
            content            : arg4,
            nonce              : arg5,
            dek_version        : arg6,
            attachment_blob_id : arg7,
            created_at         : arg8,
        }
    }

    public fun nonce(arg0: &Message) : vector<u8> {
        arg0.nonce
    }

    public fun sender(arg0: &Message) : address {
        arg0.sender
    }

    public fun sender_agent_id(arg0: &Message) : vector<u8> {
        arg0.sender_agent_id
    }

    public fun type_file() : u8 {
        3
    }

    public fun type_json() : u8 {
        1
    }

    public fun type_system() : u8 {
        2
    }

    public fun type_text() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

