module 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message {
    struct Message has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        walrus_blob_id: 0x1::string::String,
        encrypted_metadata: vector<u8>,
        created_at: u64,
        is_read: bool,
    }

    public fun created_at(arg0: &Message) : u64 {
        arg0.created_at
    }

    public(friend) fun destroy(arg0: Message) {
        let Message {
            id                 : v0,
            sender             : _,
            recipient          : _,
            walrus_blob_id     : _,
            encrypted_metadata : _,
            created_at         : _,
            is_read            : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun encrypted_metadata(arg0: &Message) : vector<u8> {
        arg0.encrypted_metadata
    }

    public fun get_full_info(arg0: &Message) : (address, address, 0x1::string::String, vector<u8>, u64, bool) {
        (arg0.sender, arg0.recipient, arg0.walrus_blob_id, arg0.encrypted_metadata, arg0.created_at, arg0.is_read)
    }

    public fun id(arg0: &Message) : &0x2::object::UID {
        &arg0.id
    }

    public fun is_read(arg0: &Message) : bool {
        arg0.is_read
    }

    public(friend) fun mark_as_read(arg0: &mut Message) {
        arg0.is_read = true;
    }

    public(friend) fun new_message(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Message {
        Message{
            id                 : 0x2::object::new(arg5),
            sender             : arg0,
            recipient          : arg1,
            walrus_blob_id     : arg2,
            encrypted_metadata : arg3,
            created_at         : arg4,
            is_read            : false,
        }
    }

    public fun recipient(arg0: &Message) : address {
        arg0.recipient
    }

    public fun sender(arg0: &Message) : address {
        arg0.sender
    }

    public fun walrus_blob_id(arg0: &Message) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    // decompiled from Move bytecode v6
}

