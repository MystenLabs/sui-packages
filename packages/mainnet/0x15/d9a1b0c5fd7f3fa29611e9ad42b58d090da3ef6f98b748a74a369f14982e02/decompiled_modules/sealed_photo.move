module 0x15d9a1b0c5fd7f3fa29611e9ad42b58d090da3ef6f98b748a74a369f14982e02::sealed_photo {
    struct Photo has key {
        id: 0x2::object::UID,
        creator: address,
        blob_id: vector<u8>,
        text_blob_id: vector<u8>,
        is_sealed: bool,
        bottle_id: 0x1::option::Option<vector<u8>>,
        likes: u64,
        epoch: u64,
        content_type: 0x1::string::String,
        created_at: u64,
    }

    struct Follow has key {
        id: 0x2::object::UID,
        follower: address,
        following: address,
    }

    struct FollowSlot has key {
        id: 0x2::object::UID,
        owner: address,
        follow_count: u64,
        max_follow: u64,
    }

    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        profile_blob_id: vector<u8>,
        updated_at: u64,
    }

    struct PostCreated has copy, drop {
        photo_id: 0x2::object::ID,
        creator: address,
        is_sealed: bool,
        content_type: 0x1::string::String,
        timestamp: u64,
    }

    struct PostLiked has copy, drop {
        photo_id: 0x2::object::ID,
        liker: address,
        new_count: u64,
    }

    struct Followed has copy, drop {
        follower: address,
        following: address,
        timestamp: u64,
    }

    struct TipSent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        photo_id: 0x1::option::Option<0x2::object::ID>,
    }

    public entry fun create_photo(arg0: vector<u8>, arg1: vector<u8>, arg2: bool, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = if (0x1::vector::length<u8>(&arg3) > 0) {
            0x1::option::some<vector<u8>>(arg3)
        } else {
            0x1::option::none<vector<u8>>()
        };
        let v3 = Photo{
            id           : 0x2::object::new(arg6),
            creator      : v0,
            blob_id      : arg0,
            text_blob_id : arg1,
            is_sealed    : arg2,
            bottle_id    : v2,
            likes        : 0,
            epoch        : 0x2::tx_context::epoch(arg6),
            content_type : 0x1::string::utf8(arg4),
            created_at   : v1,
        };
        0x2::transfer::share_object<Photo>(v3);
        let v4 = PostCreated{
            photo_id     : 0x2::object::id<Photo>(&v3),
            creator      : v0,
            is_sealed    : arg2,
            content_type : 0x1::string::utf8(arg4),
            timestamp    : v1,
        };
        0x2::event::emit<PostCreated>(v4);
    }

    public fun follow_follower(arg0: &Follow) : address {
        arg0.follower
    }

    public fun follow_following(arg0: &Follow) : address {
        arg0.following
    }

    public entry fun follow_user(arg0: &mut FollowSlot, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg1, 4);
        assert!(arg0.owner == v0, 1);
        assert!(arg0.follow_count < arg0.max_follow, 2);
        arg0.follow_count = arg0.follow_count + 1;
        let v1 = Follow{
            id        : 0x2::object::new(arg3),
            follower  : v0,
            following : arg1,
        };
        0x2::transfer::transfer<Follow>(v1, v0);
        let v2 = Followed{
            follower  : v0,
            following : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Followed>(v2);
    }

    public entry fun increase_follow_slot(arg0: &mut FollowSlot, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x0);
        arg0.max_follow = arg0.max_follow + 10;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun init_follow_slot(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = FollowSlot{
            id           : 0x2::object::new(arg0),
            owner        : v0,
            follow_count : 0,
            max_follow   : 10,
        };
        0x2::transfer::transfer<FollowSlot>(v1, v0);
    }

    public entry fun like_photo(arg0: &mut Photo, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.likes = arg0.likes + 1;
        let v0 = PostLiked{
            photo_id  : 0x2::object::id<Photo>(arg0),
            liker     : 0x2::tx_context::sender(arg1),
            new_count : arg0.likes,
        };
        0x2::event::emit<PostLiked>(v0);
    }

    public fun photo_blob_id(arg0: &Photo) : &vector<u8> {
        &arg0.blob_id
    }

    public fun photo_content_type(arg0: &Photo) : &0x1::string::String {
        &arg0.content_type
    }

    public fun photo_creator(arg0: &Photo) : address {
        arg0.creator
    }

    public fun photo_is_sealed(arg0: &Photo) : bool {
        arg0.is_sealed
    }

    public fun photo_likes(arg0: &Photo) : u64 {
        arg0.likes
    }

    public entry fun renew_photo_blob(arg0: &Photo, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::clock::timestamp_ms(arg1);
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &Photo, arg2: &0x2::tx_context::TxContext) {
    }

    public fun slot_follow_count(arg0: &FollowSlot) : u64 {
        arg0.follow_count
    }

    public fun slot_max_follow(arg0: &FollowSlot) : u64 {
        arg0.max_follow
    }

    public entry fun update_profile(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = ProfileRegistry{
            id              : 0x2::object::new(arg2),
            owner           : v0,
            profile_blob_id : arg0,
            updated_at      : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::transfer<ProfileRegistry>(v1, v0);
    }

    // decompiled from Move bytecode v7
}

