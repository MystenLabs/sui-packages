module 0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::chat {
    struct MessageEvent has copy, drop {
        channel: 0x2::object::ID,
        sender: address,
        suins: 0x1::string::String,
        timestamp: u64,
        message: 0x1::string::String,
    }

    struct Channel has store, key {
        id: 0x2::object::UID,
        owner: address,
        message_queue: 0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::big_queue::BigQueue<Message>,
    }

    struct Message has drop, store {
        sender: address,
        suins: 0x1::option::Option<0x1::string::String>,
        timestamp: u64,
        message: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        channel_id: 0x2::object::ID,
    }

    public fun create_channel(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Channel{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            message_queue : 0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::big_queue::new<Message>(10000, arg0),
        };
        let v1 = AdminCap{
            id         : 0x2::object::new(arg0),
            channel_id : 0x2::object::id<Channel>(&v0),
        };
        0x2::transfer::share_object<Channel>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun delete_messages(arg0: &mut Channel, arg1: &AdminCap, arg2: 0x1::option::Option<u64>) {
        assert!(arg1.channel_id == 0x2::object::id<Channel>(arg0), 0);
        let v0 = 0;
        if (0x1::option::is_some<u64>(&arg2)) {
            v0 = 0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::big_queue::length<Message>(&arg0.message_queue) - *0x1::option::borrow<u64>(&arg2);
        };
        while (0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::big_queue::length<Message>(&arg0.message_queue) > v0) {
            0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::big_queue::pop_front<Message>(&mut arg0.message_queue);
        };
    }

    public fun mint_new_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id         : 0x2::object::new(arg1),
            channel_id : arg0.channel_id,
        }
    }

    public fun send_message(arg0: 0x1::string::String, arg1: &mut Channel, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::string::utf8(0x1::vector::empty<u8>());
        let v2 = MessageEvent{
            channel   : 0x2::object::id<Channel>(arg1),
            sender    : 0x2::tx_context::sender(arg4),
            suins     : *0x1::option::borrow_with_default<0x1::string::String>(&arg3, &v1),
            timestamp : v0,
            message   : arg0,
        };
        0x2::event::emit<MessageEvent>(v2);
        let v3 = Message{
            sender    : 0x2::tx_context::sender(arg4),
            suins     : arg3,
            timestamp : v0,
            message   : arg0,
        };
        0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::big_queue::push_back<Message>(&mut arg1.message_queue, v3);
    }

    // decompiled from Move bytecode v6
}

