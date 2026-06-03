module 0xc8cd42bb010547a96436db9680576a3d112fdbc39e5016def3a97b9bbfb77317::feed {
    struct Profile has key {
        id: 0x2::object::UID,
        owner: address,
        handle: 0x1::string::String,
        display_name: 0x1::string::String,
        avatar_blob: 0x1::string::String,
        bio: 0x1::string::String,
        video_count: u64,
        total_tips_received: u64,
        total_likes_received: u64,
        created_at_ms: u64,
    }

    struct Video has store, key {
        id: 0x2::object::UID,
        creator: address,
        blob_id: 0x1::string::String,
        poster_blob: 0x1::string::String,
        caption: 0x1::string::String,
        duration_ms: u64,
        width: u16,
        height: u16,
        like_count: u64,
        view_count: u64,
        tip_total: u64,
        created_at_ms: u64,
    }

    struct Feed has key {
        id: 0x2::object::UID,
        video_count: u64,
    }

    struct Like has key {
        id: 0x2::object::UID,
        video_id: 0x2::object::ID,
        fan: address,
    }

    struct GiftReceipt has store, key {
        id: 0x2::object::UID,
        video_id: 0x2::object::ID,
        from: address,
        to: address,
        amount_mist: u64,
        tier: u8,
        sent_at_ms: u64,
    }

    struct VideoPosted has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        blob_id: 0x1::string::String,
        poster_blob: 0x1::string::String,
        caption: 0x1::string::String,
        created_at_ms: u64,
    }

    struct VideoLiked has copy, drop {
        video_id: 0x2::object::ID,
        fan: address,
        new_count: u64,
    }

    struct VideoUnliked has copy, drop {
        video_id: 0x2::object::ID,
        fan: address,
        new_count: u64,
    }

    struct VideoViewed has copy, drop {
        video_id: 0x2::object::ID,
        new_count: u64,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        handle: 0x1::string::String,
    }

    struct GiftSent has copy, drop {
        video_id: 0x2::object::ID,
        from: address,
        to: address,
        amount_mist: u64,
        tier: u8,
        video_tip_total: u64,
        creator_tip_total: u64,
        sent_at_ms: u64,
    }

    public entry fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Profile{
            id                   : 0x2::object::new(arg5),
            owner                : v0,
            handle               : arg0,
            display_name         : arg1,
            avatar_blob          : arg2,
            bio                  : arg3,
            video_count          : 0,
            total_tips_received  : 0,
            total_likes_received : 0,
            created_at_ms        : 0x2::clock::timestamp_ms(arg4),
        };
        let v2 = ProfileCreated{
            profile_id : 0x2::object::id<Profile>(&v1),
            owner      : v0,
            handle     : arg0,
        };
        0x2::event::emit<ProfileCreated>(v2);
        0x2::transfer::share_object<Profile>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Feed{
            id          : 0x2::object::new(arg0),
            video_count : 0,
        };
        0x2::transfer::share_object<Feed>(v0);
    }

    public entry fun like_video(arg0: &mut Video, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::id<Video>(arg0);
        arg0.like_count = arg0.like_count + 1;
        let v2 = Like{
            id       : 0x2::object::new(arg1),
            video_id : v1,
            fan      : v0,
        };
        let v3 = VideoLiked{
            video_id  : v1,
            fan       : v0,
            new_count : arg0.like_count,
        };
        0x2::event::emit<VideoLiked>(v3);
        0x2::transfer::transfer<Like>(v2, v0);
    }

    public entry fun post_video(arg0: &mut Feed, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u16, arg6: u16, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = Video{
            id            : 0x2::object::new(arg8),
            creator       : v0,
            blob_id       : arg1,
            poster_blob   : arg2,
            caption       : arg3,
            duration_ms   : arg4,
            width         : arg5,
            height        : arg6,
            like_count    : 0,
            view_count    : 0,
            tip_total     : 0,
            created_at_ms : v1,
        };
        arg0.video_count = arg0.video_count + 1;
        let v3 = VideoPosted{
            video_id      : 0x2::object::id<Video>(&v2),
            creator       : v0,
            blob_id       : arg1,
            poster_blob   : arg2,
            caption       : arg3,
            created_at_ms : v1,
        };
        0x2::event::emit<VideoPosted>(v3);
        0x2::transfer::share_object<Video>(v2);
    }

    public entry fun record_view(arg0: &mut Video) {
        arg0.view_count = arg0.view_count + 1;
        let v0 = VideoViewed{
            video_id  : 0x2::object::id<Video>(arg0),
            new_count : arg0.view_count,
        };
        0x2::event::emit<VideoViewed>(v0);
    }

    public entry fun send_gift(arg0: &mut Video, arg1: &mut Profile, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= tier_floor_mist(arg3), 0);
        assert!(arg1.owner == arg0.creator, 3);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = arg0.creator;
        let v3 = 0x2::object::id<Video>(arg0);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v2);
        arg0.tip_total = arg0.tip_total + v0;
        arg1.total_tips_received = arg1.total_tips_received + v0;
        let v5 = GiftReceipt{
            id          : 0x2::object::new(arg5),
            video_id    : v3,
            from        : v1,
            to          : v2,
            amount_mist : v0,
            tier        : arg3,
            sent_at_ms  : v4,
        };
        0x2::transfer::public_transfer<GiftReceipt>(v5, v1);
        let v6 = GiftSent{
            video_id          : v3,
            from              : v1,
            to                : v2,
            amount_mist       : v0,
            tier              : arg3,
            video_tip_total   : arg0.tip_total,
            creator_tip_total : arg1.total_tips_received,
            sent_at_ms        : v4,
        };
        0x2::event::emit<GiftSent>(v6);
    }

    fun tier_floor_mist(arg0: u8) : u64 {
        if (arg0 == 0) {
            10000000
        } else if (arg0 == 1) {
            100000000
        } else if (arg0 == 2) {
            500000000
        } else {
            assert!(arg0 == 3, 1);
            1000000000
        }
    }

    public entry fun unlike_video(arg0: &mut Video, arg1: Like, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Video>(arg0);
        assert!(arg1.video_id == v0, 4);
        let Like {
            id       : v1,
            video_id : _,
            fan      : _,
        } = arg1;
        0x2::object::delete(v1);
        arg0.like_count = arg0.like_count - 1;
        let v4 = VideoUnliked{
            video_id  : v0,
            fan       : 0x2::tx_context::sender(arg2),
            new_count : arg0.like_count,
        };
        0x2::event::emit<VideoUnliked>(v4);
    }

    public entry fun update_profile(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 2);
        arg0.display_name = arg1;
        arg0.avatar_blob = arg2;
        arg0.bio = arg3;
    }

    // decompiled from Move bytecode v7
}

