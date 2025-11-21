module 0xdaf4bee4cf52ef466b8046f1b40b20033946354d9a5d60e116807209d980830d::creator_channel {
    struct CreatorChannel has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        subscribers: 0x2::vec_set::VecSet<address>,
        subscription_price: u64,
        created_at: u64,
        total_videos: u64,
    }

    struct ChannelCap has key {
        id: 0x2::object::UID,
        channel_id: 0x2::object::ID,
    }

    struct ChannelCreated has copy, drop {
        channel_id: address,
        creator: address,
        name: 0x1::string::String,
        subscription_price: u64,
        timestamp: u64,
    }

    struct SubscriberAdded has copy, drop {
        channel_id: address,
        subscriber: address,
        payment_amount: u64,
        timestamp: u64,
    }

    struct SubscriberRemoved has copy, drop {
        channel_id: address,
        subscriber: address,
        removed_by: address,
        timestamp: u64,
    }

    struct VideoAccessGranted has copy, drop {
        channel_id: address,
        video_id: vector<u8>,
        accessed_by: address,
        timestamp: u64,
    }

    public fun add_subscriber(arg0: &mut CreatorChannel, arg1: &ChannelCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<CreatorChannel>(arg0), 3);
        assert!(!0x2::vec_set::contains<address>(&arg0.subscribers, &arg2), 2);
        0x2::vec_set::insert<address>(&mut arg0.subscribers, arg2);
        let v0 = SubscriberAdded{
            channel_id     : 0x2::object::uid_to_address(&arg0.id),
            subscriber     : arg2,
            payment_amount : 0,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SubscriberAdded>(v0);
    }

    public fun create_channel(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : ChannelCap {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = CreatorChannel{
            id                 : 0x2::object::new(arg4),
            creator            : v0,
            name               : arg0,
            description        : arg1,
            subscribers        : v1,
            subscription_price : arg2,
            created_at         : v2,
            total_videos       : 0,
        };
        let v4 = ChannelCap{
            id         : 0x2::object::new(arg4),
            channel_id : 0x2::object::id<CreatorChannel>(&v3),
        };
        let v5 = ChannelCreated{
            channel_id         : 0x2::object::uid_to_address(&v3.id),
            creator            : v0,
            name               : v3.name,
            subscription_price : arg2,
            timestamp          : v2,
        };
        0x2::event::emit<ChannelCreated>(v5);
        0x2::transfer::share_object<CreatorChannel>(v3);
        v4
    }

    entry fun create_channel_entry(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_channel(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<ChannelCap>(v0, 0x2::tx_context::sender(arg4));
    }

    fun extract_video_id(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > arg1 + 16, 7);
        let v1 = 0x1::vector::empty<u8>();
        while (arg1 < v0 - 16) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v1
    }

    public fun get_creator(arg0: &CreatorChannel) : address {
        arg0.creator
    }

    public fun get_description(arg0: &CreatorChannel) : 0x1::string::String {
        arg0.description
    }

    public fun get_name(arg0: &CreatorChannel) : 0x1::string::String {
        arg0.name
    }

    public fun get_subscriber_count(arg0: &CreatorChannel) : u64 {
        0x2::vec_set::size<address>(&arg0.subscribers)
    }

    public fun get_subscribers(arg0: &CreatorChannel) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.subscribers)
    }

    public fun get_subscription_price(arg0: &CreatorChannel) : u64 {
        arg0.subscription_price
    }

    public fun get_total_videos(arg0: &CreatorChannel) : u64 {
        arg0.total_videos
    }

    public fun increment_video_count(arg0: &mut CreatorChannel, arg1: &ChannelCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<CreatorChannel>(arg0), 3);
        arg0.total_videos = arg0.total_videos + 1;
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v1) != *0x1::vector::borrow<u8>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun is_subscribed(arg0: &CreatorChannel, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.subscribers, &arg1)
    }

    public fun namespace(arg0: &CreatorChannel) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun remove_subscriber(arg0: &mut CreatorChannel, arg1: &ChannelCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<CreatorChannel>(arg0), 3);
        0x2::vec_set::remove<address>(&mut arg0.subscribers, &arg2);
        let v0 = SubscriberRemoved{
            channel_id : 0x2::object::uid_to_address(&arg0.id),
            subscriber : arg2,
            removed_by : 0x2::tx_context::sender(arg4),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SubscriberRemoved>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &CreatorChannel, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = namespace(arg1);
        assert!(is_prefix(v1, arg0), 4);
        assert!(0x2::vec_set::contains<address>(&arg1.subscribers, &v0), 6);
        let v2 = VideoAccessGranted{
            channel_id  : 0x2::object::uid_to_address(&arg1.id),
            video_id    : extract_video_id(&arg0, 0x1::vector::length<u8>(&v1)),
            accessed_by : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VideoAccessGranted>(v2);
    }

    entry fun subscribe_entry(arg0: &mut CreatorChannel, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        subscribe_with_sui(arg0, arg1, arg2, arg3);
    }

    public fun subscribe_with_sui(arg0: &mut CreatorChannel, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_set::contains<address>(&arg0.subscribers, &v0), 2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.subscription_price, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.creator);
        0x2::vec_set::insert<address>(&mut arg0.subscribers, v0);
        let v2 = SubscriberAdded{
            channel_id     : 0x2::object::uid_to_address(&arg0.id),
            subscriber     : v0,
            payment_amount : v1,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SubscriberAdded>(v2);
    }

    public fun update_description(arg0: &mut CreatorChannel, arg1: &ChannelCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<CreatorChannel>(arg0), 3);
        arg0.description = arg2;
    }

    public fun update_price(arg0: &mut CreatorChannel, arg1: &ChannelCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<CreatorChannel>(arg0), 3);
        arg0.subscription_price = arg2;
    }

    // decompiled from Move bytecode v6
}

