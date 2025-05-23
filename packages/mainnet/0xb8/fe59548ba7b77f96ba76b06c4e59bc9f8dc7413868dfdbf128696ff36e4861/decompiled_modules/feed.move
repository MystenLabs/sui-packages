module 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::feed {
    struct FEED has drop {
        dummy_field: bool,
    }

    struct PostStats has drop, store {
        likes: u64,
        dislikes: u64,
        reposts: u64,
        comments: u64,
    }

    struct PostLink has copy, drop, store {
        stream_id: 0x2::object::ID,
        index: u64,
    }

    struct Post has drop, store {
        sender: address,
        content: vector<u8>,
        content_type: u8,
        stats: PostStats,
        comments: vector<PostLink>,
        repost_from: 0x1::option::Option<PostLink>,
        timestamp: u64,
    }

    struct PostCreatedEvent has copy, drop {
        stream_id: 0x2::object::ID,
        index: u64,
        timestamp: u64,
    }

    struct FeedRegistry has store, key {
        id: 0x2::object::UID,
    }

    fun assert_content_valid(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors::EEmptyPost());
        assert!(0x1::vector::length<u8>(arg0) >= 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::constants::MIN_POST_LENGTH(), 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors::EPostTooShort());
        assert!(0x1::vector::length<u8>(arg0) <= 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::constants::MAX_POST_LENGTH(), 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors::EPostTooLong());
    }

    public fun create_feed<T0: drop + store>(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<FeedRegistry>(arg1);
        assert!(!has_user_feed(v1, v0, arg2), 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors::EFeedAlreadyExists());
        insert_user_feed(v1, v0, arg2);
        0x2::transfer::public_transfer<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::Stream<T0>>(0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::new_stream<T0>(arg0, 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::StreamRegistry>(arg1), v0, arg2, arg3), v0);
    }

    fun generate_feed_id(arg0: address, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::string::utf8(0x2::hex::encode(0x2::hash::blake2b256(&v0)))
    }

    public fun has_user_feed(arg0: &FeedRegistry, arg1: address, arg2: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_with_type<0x1::string::String, bool>(&arg0.id, generate_feed_id(arg1, arg2))
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeedRegistry{id: 0x2::object::new(arg1)};
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<FeedRegistry>(arg0, v0);
    }

    public fun insert_user_feed(arg0: &mut FeedRegistry, arg1: address, arg2: 0x1::string::String) {
        if (!has_user_feed(arg0, arg1, arg2)) {
            0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg0.id, generate_feed_id(arg1, arg2), true);
        };
    }

    public fun new_post(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: vector<u8>, arg3: u8, arg4: 0x1::option::Option<PostLink>, arg5: &mut 0x2::tx_context::TxContext) : Post {
        assert_content_valid(&arg2);
        let v0 = PostStats{
            likes    : 0,
            dislikes : 0,
            reposts  : 0,
            comments : 0,
        };
        Post{
            sender       : 0x2::tx_context::sender(arg5),
            content      : arg2,
            content_type : arg3,
            stats        : v0,
            comments     : 0x1::vector::empty<PostLink>(),
            repost_from  : arg4,
            timestamp    : 0x2::clock::timestamp_ms(arg0),
        }
    }

    public fun post_message<T0: drop + store>(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: &mut 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::Stream<T0>, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::can_write_in_stream<T0>(arg2, v0), 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors::EUnauthorized());
        assert!(has_user_feed(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow<FeedRegistry>(arg1), v0, 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::get_stream_name<T0>(arg2)), 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors::EFeedNotFound());
        0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::add<T0>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::StreamRegistry>(arg1), arg2, arg3, arg4);
        let v1 = PostCreatedEvent{
            stream_id : 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::get_stream_id<T0>(arg2),
            index     : 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream::get_next_id<T0>(arg2) - 1,
            timestamp : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<PostCreatedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

