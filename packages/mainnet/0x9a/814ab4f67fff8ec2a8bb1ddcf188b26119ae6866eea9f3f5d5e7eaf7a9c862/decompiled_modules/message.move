module 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message {
    struct Message has drop, store {
        sender: address,
        ciphertext: vector<u8>,
        nonce: vector<u8>,
        key_version: u32,
        attachments: vector<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>,
        created_at_ms: u64,
    }

    struct MessageAddedEvent has copy, drop {
        channel_id: 0x2::object::ID,
        message_index: u64,
        sender: address,
        ciphertext: vector<u8>,
        nonce: vector<u8>,
        key_version: u32,
        attachment_refs: vector<0x1::string::String>,
        attachment_nonces: vector<vector<u8>>,
        created_at_ms: u64,
    }

    public(friend) fun emit_event(arg0: &Message, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = arg0.attachments;
        0x1::vector::reverse<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(&mut v1);
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::blob_ref(&v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(v1);
        let v4 = vector[];
        let v5 = arg0.attachments;
        0x1::vector::reverse<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(&v5)) {
            let v7 = 0x1::vector::pop_back<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(&mut v5);
            0x1::vector::push_back<vector<u8>>(&mut v4, 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::data_nonce(&v7));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(v5);
        let v8 = MessageAddedEvent{
            channel_id        : arg1,
            message_index     : arg2,
            sender            : arg0.sender,
            ciphertext        : arg0.ciphertext,
            nonce             : arg0.nonce,
            key_version       : arg0.key_version,
            attachment_refs   : v0,
            attachment_nonces : v4,
            created_at_ms     : arg0.created_at_ms,
        };
        0x2::event::emit<MessageAddedEvent>(v8);
    }

    public fun new(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u32, arg4: vector<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>, arg5: &0x2::clock::Clock) : Message {
        Message{
            sender        : arg0,
            ciphertext    : arg1,
            nonce         : arg2,
            key_version   : arg3,
            attachments   : arg4,
            created_at_ms : 0x2::clock::timestamp_ms(arg5),
        }
    }

    // decompiled from Move bytecode v6
}

