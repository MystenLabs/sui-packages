module 0xa98f82adcdf25111d679cc95be5b7207b911b6e57afe88bee33a9b266367f462::board {
    struct Message has store, key {
        id: 0x2::object::UID,
        author: address,
        content_type: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        timestamp: u64,
    }

    struct MessageBoard has key {
        id: 0x2::object::UID,
        message_count: u64,
    }

    struct MessagePosted has copy, drop {
        message_id: address,
        author: address,
        content_type: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        timestamp: u64,
    }

    public fun delete_message(arg0: Message, arg1: &mut 0x2::tx_context::TxContext) {
        let Message {
            id             : v0,
            author         : _,
            content_type   : _,
            walrus_blob_id : _,
            timestamp      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_author(arg0: &Message) : address {
        arg0.author
    }

    public fun get_content_type(arg0: &Message) : 0x1::string::String {
        arg0.content_type
    }

    public fun get_message_count(arg0: &MessageBoard) : u64 {
        arg0.message_count
    }

    public fun get_timestamp(arg0: &Message) : u64 {
        arg0.timestamp
    }

    public fun get_walrus_blob_id(arg0: &Message) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageBoard{
            id            : 0x2::object::new(arg0),
            message_count : 0,
        };
        0x2::transfer::share_object<MessageBoard>(v0);
    }

    fun is_valid_content_type(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::utf8(b"text");
        let v1 = 0x1::string::utf8(b"image");
        arg0 == &v0 || arg0 == &v1
    }

    public fun post_message(arg0: &mut MessageBoard, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_content_type(&arg1), 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = Message{
            id             : 0x2::object::new(arg4),
            author         : v0,
            content_type   : arg1,
            walrus_blob_id : arg2,
            timestamp      : v1,
        };
        let v3 = MessagePosted{
            message_id     : 0x2::object::id_address<Message>(&v2),
            author         : v0,
            content_type   : v2.content_type,
            walrus_blob_id : v2.walrus_blob_id,
            timestamp      : v1,
        };
        0x2::event::emit<MessagePosted>(v3);
        arg0.message_count = arg0.message_count + 1;
        0x2::transfer::transfer<Message>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

