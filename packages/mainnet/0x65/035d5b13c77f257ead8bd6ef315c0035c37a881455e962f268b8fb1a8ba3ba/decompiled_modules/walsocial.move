module 0x65035d5b13c77f257ead8bd6ef315c0035c37a881455e962f268b8fb1a8ba3ba::walsocial {
    struct Registry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
        follow_map: 0x2::table::Table<address, vector<address>>,
        total_profiles: u64,
        total_posts: u64,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: 0x1::string::String,
        created_at: u64,
    }

    struct Post has store, key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: 0x1::string::String,
        likes: u64,
        liked_by: 0x2::vec_set::VecSet<address>,
        is_private: bool,
        created_at: u64,
    }

    struct ProfileCreated has copy, drop {
        owner: address,
        profile_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
    }

    struct PostCreated has copy, drop {
        owner: address,
        post_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        is_private: bool,
    }

    struct PostLiked has copy, drop {
        post_id: 0x2::object::ID,
        liker: address,
        total_likes: u64,
    }

    struct Followed has copy, drop {
        follower: address,
        followee: address,
    }

    struct Unfollowed has copy, drop {
        follower: address,
        followee: address,
    }

    public entry fun create_post(arg0: &mut Registry, arg1: vector<u8>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, v0), 2);
        let v1 = Post{
            id         : 0x2::object::new(arg4),
            owner      : v0,
            blob_id    : 0x1::string::utf8(arg1),
            likes      : 0,
            liked_by   : 0x2::vec_set::empty<address>(),
            is_private : arg2,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        arg0.total_posts = arg0.total_posts + 1;
        let v2 = PostCreated{
            owner      : v0,
            post_id    : 0x2::object::id<Post>(&v1),
            blob_id    : 0x1::string::utf8(arg1),
            is_private : arg2,
        };
        0x2::event::emit<PostCreated>(v2);
        0x2::transfer::public_transfer<Post>(v1, v0);
    }

    public entry fun create_profile(arg0: &mut Registry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, v0), 1);
        let v1 = Profile{
            id         : 0x2::object::new(arg3),
            owner      : v0,
            blob_id    : 0x1::string::utf8(arg1),
            created_at : 0x2::clock::timestamp_ms(arg2),
        };
        let v2 = 0x2::object::id<Profile>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.profiles, v0, v2);
        arg0.total_profiles = arg0.total_profiles + 1;
        if (!0x2::table::contains<address, vector<address>>(&arg0.follow_map, v0)) {
            0x2::table::add<address, vector<address>>(&mut arg0.follow_map, v0, 0x1::vector::empty<address>());
        };
        let v3 = ProfileCreated{
            owner      : v0,
            profile_id : v2,
            blob_id    : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<ProfileCreated>(v3);
        0x2::transfer::public_transfer<Profile>(v1, v0);
    }

    public entry fun delete_post(arg0: Post, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        let Post {
            id         : v0,
            owner      : _,
            blob_id    : _,
            likes      : _,
            liked_by   : _,
            is_private : _,
            created_at : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun follow(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 5);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1), 2);
        if (!0x2::table::contains<address, vector<address>>(&arg0.follow_map, v0)) {
            0x2::table::add<address, vector<address>>(&mut arg0.follow_map, v0, 0x1::vector::empty<address>());
        };
        let v1 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.follow_map, v0);
        assert!(!0x1::vector::contains<address>(v1, &arg1), 6);
        0x1::vector::push_back<address>(v1, arg1);
        let v2 = Followed{
            follower : v0,
            followee : arg1,
        };
        0x2::event::emit<Followed>(v2);
    }

    public fun get_following(arg0: &Registry, arg1: address) : &vector<address> {
        0x2::table::borrow<address, vector<address>>(&arg0.follow_map, arg1)
    }

    public fun get_post_likes(arg0: &Post) : u64 {
        arg0.likes
    }

    public fun get_profile_blob_id(arg0: &Profile) : &0x1::string::String {
        &arg0.blob_id
    }

    public fun get_profile_owner(arg0: &Profile) : address {
        arg0.owner
    }

    public fun has_liked(arg0: &Post, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.liked_by, &arg1)
    }

    public fun has_profile(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            profiles       : 0x2::table::new<address, 0x2::object::ID>(arg0),
            follow_map     : 0x2::table::new<address, vector<address>>(arg0),
            total_profiles : 0,
            total_posts    : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_following(arg0: &Registry, arg1: address, arg2: address) : bool {
        if (!0x2::table::contains<address, vector<address>>(&arg0.follow_map, arg1)) {
            return false
        };
        0x1::vector::contains<address>(0x2::table::borrow<address, vector<address>>(&arg0.follow_map, arg1), &arg2)
    }

    public fun is_post_private(arg0: &Post) : bool {
        arg0.is_private
    }

    public entry fun like_post(arg0: &mut Post, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::vec_set::contains<address>(&arg0.liked_by, &v0), 4);
        0x2::vec_set::insert<address>(&mut arg0.liked_by, v0);
        arg0.likes = arg0.likes + 1;
        let v1 = PostLiked{
            post_id     : 0x2::object::id<Post>(arg0),
            liker       : v0,
            total_likes : arg0.likes,
        };
        0x2::event::emit<PostLiked>(v1);
    }

    public fun total_posts(arg0: &Registry) : u64 {
        arg0.total_posts
    }

    public fun total_profiles(arg0: &Registry) : u64 {
        arg0.total_profiles
    }

    public entry fun unfollow(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<address>>(&arg0.follow_map, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.follow_map, v0);
        let (v2, v3) = 0x1::vector::index_of<address>(v1, &arg1);
        assert!(v2, 7);
        0x1::vector::remove<address>(v1, v3);
        let v4 = Unfollowed{
            follower : v0,
            followee : arg1,
        };
        0x2::event::emit<Unfollowed>(v4);
    }

    public entry fun unlike_post(arg0: &mut Post, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.liked_by, &v0), 4);
        0x2::vec_set::remove<address>(&mut arg0.liked_by, &v0);
        if (arg0.likes > 0) {
            arg0.likes = arg0.likes - 1;
        };
    }

    public entry fun update_profile(arg0: &mut Profile, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.blob_id = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v7
}

