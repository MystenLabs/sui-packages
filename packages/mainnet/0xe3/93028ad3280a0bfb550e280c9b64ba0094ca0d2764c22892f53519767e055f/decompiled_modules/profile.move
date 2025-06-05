module 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::profile {
    struct Profile has key {
        id: 0x2::object::UID,
        user_id: 0x1::string::String,
        authorizations: 0x2::vec_map::VecMap<address, u8>,
        movies_watched: u64,
        verified_reviews: u64,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        user_id: 0x1::string::String,
        user_address: address,
    }

    struct UserAuthorized has copy, drop {
        profile_id: 0x2::object::ID,
        user_address: address,
        access: u8,
    }

    struct UserDeauthorized has copy, drop {
        profile_id: 0x2::object::ID,
        user_address: address,
    }

    public fun access_level(arg0: &Profile, arg1: address) : u8 {
        assert!(0x2::vec_map::contains<address, u8>(&arg0.authorizations, &arg1), 0);
        *0x2::vec_map::get<address, u8>(&arg0.authorizations, &arg1)
    }

    public fun authorize(arg0: &mut Profile, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: address, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg4));
        0x2::vec_map::insert<address, u8>(&mut arg0.authorizations, arg2, arg3);
        let v0 = UserAuthorized{
            profile_id   : 0x2::object::uid_to_inner(&arg0.id),
            user_address : arg2,
            access       : arg3,
        };
        0x2::event::emit<UserAuthorized>(v0);
    }

    public fun create(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg3));
        let v0 = Profile{
            id               : 0x2::object::new(arg3),
            user_id          : arg1,
            authorizations   : 0x2::vec_map::empty<address, u8>(),
            movies_watched   : 0,
            verified_reviews : 0,
        };
        let v1 = ProfileCreated{
            profile_id   : 0x2::object::uid_to_inner(&v0.id),
            user_id      : arg1,
            user_address : arg2,
        };
        0x2::vec_map::insert<address, u8>(&mut v0.authorizations, arg2, 1);
        0x2::event::emit<ProfileCreated>(v1);
        0x2::transfer::share_object<Profile>(v0);
    }

    public fun deauthorize(arg0: &mut Profile, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        let (_, _) = 0x2::vec_map::remove<address, u8>(&mut arg0.authorizations, &arg2);
        let v2 = UserDeauthorized{
            profile_id   : 0x2::object::uid_to_inner(&arg0.id),
            user_address : arg2,
        };
        0x2::event::emit<UserDeauthorized>(v2);
    }

    public(friend) fun has_user_access(arg0: &Profile, arg1: address) : bool {
        access_level(arg0, arg1) == 1
    }

    public(friend) fun increment_movies_watched_count(arg0: &mut Profile) {
        arg0.movies_watched = arg0.movies_watched + 1;
    }

    public fun movies_watched(arg0: &Profile) : u64 {
        arg0.movies_watched
    }

    public fun update_movies_watched(arg0: &mut Profile, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        arg0.movies_watched = arg2;
    }

    public fun update_user_id(arg0: &mut Profile, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        arg0.user_id = arg2;
    }

    public fun update_verified_reviews(arg0: &mut Profile, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        arg0.verified_reviews = arg2;
    }

    public fun user_id(arg0: &Profile) : 0x1::string::String {
        arg0.user_id
    }

    public fun verified_reviews(arg0: &Profile) : u64 {
        arg0.verified_reviews
    }

    // decompiled from Move bytecode v6
}

