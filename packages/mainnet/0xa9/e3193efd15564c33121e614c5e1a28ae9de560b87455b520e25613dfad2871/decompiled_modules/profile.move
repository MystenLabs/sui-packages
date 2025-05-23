module 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        website: 0x2::url::Url,
        image_url: 0x2::url::Url,
        cover_url: 0x2::url::Url,
        followers_count: u64,
        followings_count: u64,
        created_at: u64,
    }

    struct ProfileOwnerCap has store, key {
        id: 0x2::object::UID,
        profile: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct CreateProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct FollowEvent has copy, drop {
        follower: 0x2::object::ID,
        followee: 0x2::object::ID,
        followee_follower_count: u64,
        follower_following_count: u64,
    }

    public fun new(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, Profile, ProfileOwnerCap) {
        new_(parse_and_verifiy_profile_name(arg0), arg1, arg2)
    }

    public fun create_comment(arg0: &mut 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post, arg1: &Profile, arg2: &ProfileOwnerCap, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_profile_owner(arg1, arg2);
        create_comment_(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun create_post(arg0: &mut Profile, arg1: &ProfileOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_profile_owner(arg0, arg1);
        create_post_(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun like_post(arg0: &mut 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post, arg1: &Profile, arg2: &ProfileOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_profile_owner(arg1, arg2);
        0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::like_post(arg0, 0x2::object::id<Profile>(arg1));
    }

    public entry fun unlike_post(arg0: &mut 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post, arg1: &Profile, arg2: &ProfileOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_profile_owner(arg1, arg2);
        0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::unlike_post(arg0, 0x2::object::id<Profile>(arg1));
    }

    public(friend) fun add_profile_df_<T0: drop + store>(arg0: &mut Profile, arg1: 0x1::string::String, arg2: T0) {
        if (0x2::dynamic_field::exists_with_type<0x1::string::String, T0>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<0x1::string::String, T0>(&mut arg0.id, arg1);
        };
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun add_wallet_to_delegation_wallets(arg0: &mut Profile, arg1: &mut ProfileOwnerCap, arg2: address) {
        assert_profile_owner(arg0, arg1);
        add_wallet_to_delegation_wallets_(arg0, arg2);
    }

    fun add_wallet_to_delegation_wallets_(arg0: &mut Profile, arg1: address) {
        ensure_delegation_wallets_exist(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg0.id, delegated_wallets_key());
        if (!0x2::vec_set::contains<address>(v0, &arg1)) {
            0x2::vec_set::insert<address>(v0, arg1);
        };
    }

    public fun assert_delegated_wallet(arg0: &mut Profile, arg1: &address) {
        ensure_delegation_wallets_exist(arg0);
        assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg0.id, delegated_wallets_key()), arg1), 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::error::not_delegated());
    }

    public fun assert_profile_id_owner(arg0: 0x2::object::ID, arg1: &ProfileOwnerCap) {
        assert!(arg0 == arg1.profile, 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::error::not_owner());
    }

    public fun assert_profile_owner(arg0: &Profile, arg1: &ProfileOwnerCap) {
        assert!(0x2::object::id<Profile>(arg0) == arg1.profile, 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::error::not_owner());
    }

    public fun create_cap_display() : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        (v0, v2)
    }

    public(friend) fun create_comment_(arg0: &mut 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post, arg1: &Profile, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::create_comment(arg0, 0x2::object::id<Profile>(arg1), arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::PostOwnerCap>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post>(v0);
    }

    public fun create_comment_delegated(arg0: &mut 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post, arg1: &mut Profile, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_delegated_wallet(arg1, &v0);
        create_comment_(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun create_display() : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"website"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"followers_count"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"following_count"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{followers_count}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{following_count}"));
        (v0, v2)
    }

    public(friend) fun create_post_(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::create_post(0x2::object::id<Profile>(arg0), arg1, arg2, arg3, arg4, arg5);
        let v2 = v0;
        let v3 = 0x2::object::id<0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post>(&v2);
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.id, posts_key()), v3);
        0x2::transfer::public_transfer<0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::PostOwnerCap>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post>(v2);
        v3
    }

    public fun create_post_delegated(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_delegated_wallet(arg0, &v0);
        create_post_(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun delegated_wallets_key() : 0x1::string::String {
        0x1::string::utf8(b"delegated_wallet")
    }

    fun ensure_delegation_wallets_exist(arg0: &mut Profile) {
        if (!0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg0.id, delegated_wallets_key())) {
            0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg0.id, delegated_wallets_key(), 0x2::vec_set::empty<address>());
        };
    }

    fun followers_key() : 0x1::string::String {
        0x1::string::utf8(b"followers")
    }

    fun followings_key() : 0x1::string::String {
        0x1::string::utf8(b"followings")
    }

    public fun get_post(arg0: &Profile) : &vector<0x2::object::ID> {
        0x2::dynamic_field::borrow<0x1::string::String, vector<0x2::object::ID>>(&arg0.id, posts_key())
    }

    public fun get_profile_description(arg0: &Profile) : 0x1::string::String {
        arg0.description
    }

    public fun get_profile_followers_count(arg0: &Profile) : u64 {
        arg0.followers_count
    }

    public fun get_profile_followers_list(arg0: &Profile) : &0x2::vec_set::VecSet<0x2::object::ID> {
        0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.id, followers_key())
    }

    public fun get_profile_followings_count(arg0: &Profile) : u64 {
        arg0.followings_count
    }

    public fun get_profile_followings_list(arg0: &Profile) : &0x2::vec_set::VecSet<0x2::object::ID> {
        0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.id, followings_key())
    }

    public entry fun like_post_delegated(arg0: &mut 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post, arg1: &mut Profile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_delegated_wallet(arg1, &v0);
        0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::like_post(arg0, 0x2::object::id<Profile>(arg1));
    }

    public(friend) fun new_(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, Profile, ProfileOwnerCap) {
        let v0 = Profile{
            id               : 0x2::object::new(arg2),
            name             : arg0,
            description      : 0x1::string::utf8(b""),
            website          : 0x2::url::new_unsafe(0x1::ascii::string(b"")),
            image_url        : 0x2::url::new_unsafe(0x1::ascii::string(b"")),
            cover_url        : 0x2::url::new_unsafe(0x1::ascii::string(b"")),
            followers_count  : 0,
            followings_count : 0,
            created_at       : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = ProfileOwnerCap{
            id          : 0x2::object::new(arg2),
            profile     : 0x2::object::id<Profile>(&v0),
            name        : arg0,
            description : 0x1::string::utf8(b""),
            image_url   : 0x2::url::new_unsafe(0x1::ascii::string(b"")),
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v0.id, followers_key(), 0x2::vec_set::empty<0x2::object::ID>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v0.id, followings_key(), 0x2::vec_set::empty<0x2::object::ID>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut v0.id, delegated_wallets_key(), 0x2::vec_set::empty<address>());
        0x2::dynamic_field::add<0x1::string::String, vector<0x2::object::ID>>(&mut v0.id, posts_key(), 0x1::vector::empty<0x2::object::ID>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut v0.id, profile_cap_key(), 0x2::object::id<ProfileOwnerCap>(&v1));
        let v2 = &mut v0;
        add_wallet_to_delegation_wallets_(v2, 0x2::tx_context::sender(arg2));
        (arg0, v0, v1)
    }

    fun parse_and_verifiy_profile_name(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::to_ascii(arg0);
        let v1 = 0x1::ascii::length(&v0);
        let v2 = 0x1::ascii::into_bytes(v0);
        let v3 = &mut v2;
        assert!(0x1::ascii::all_characters_printable(&v0), 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::error::unexpected_char_in_profile_name());
        assert!(v1 >= 5, 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::error::profile_name_too_short());
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow_mut<u8>(v3, v4);
            if (*v5 >= 65 && *v5 <= 90) {
                *v5 = *v5 + 32;
            } else {
                let v6 = *v5;
                assert!(v6 >= 97 && v6 <= 122 || v6 >= 48 && v6 <= 57 || v6 == 32 || v6 == 45 || v6 == 95, 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::error::unexpected_char_in_profile_name());
            };
            v4 = v4 + 1;
        };
        0x1::string::from_ascii(0x1::ascii::string(*v3))
    }

    fun posts_key() : 0x1::string::String {
        0x1::string::utf8(b"posts")
    }

    fun profile_cap_key() : 0x1::string::String {
        0x1::string::utf8(b"profile_cap")
    }

    public fun profile_follow(arg0: &mut Profile, arg1: &mut Profile, arg2: &ProfileOwnerCap) {
        assert_profile_owner(arg1, arg2);
        profile_follow_(arg0, arg1);
    }

    public(friend) fun profile_follow_(arg0: &mut Profile, arg1: &mut Profile) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, followers_key());
        let v1 = 0x2::object::id<Profile>(arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(v0, &v1)) {
            0x2::vec_set::insert<0x2::object::ID>(v0, v1);
            0x2::vec_set::insert<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg1.id, followings_key()), 0x2::object::id<Profile>(arg0));
            arg0.followers_count = arg0.followers_count + 1;
            arg1.followings_count = arg1.followings_count + 1;
            let v2 = FollowEvent{
                follower                 : 0x2::object::id<Profile>(arg1),
                followee                 : 0x2::object::id<Profile>(arg0),
                followee_follower_count  : arg0.followers_count,
                follower_following_count : arg1.followings_count,
            };
            0x2::event::emit<FollowEvent>(v2);
        };
    }

    public fun profile_follow_delegated(arg0: &mut Profile, arg1: &mut Profile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_delegated_wallet(arg1, &v0);
        profile_follow_(arg0, arg1);
    }

    public fun profile_unfollow(arg0: &mut Profile, arg1: &mut Profile, arg2: &ProfileOwnerCap) {
        assert_profile_owner(arg1, arg2);
        profile_unfollow_(arg0, arg1);
    }

    public(friend) fun profile_unfollow_(arg0: &mut Profile, arg1: &mut Profile) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, followers_key());
        let v1 = 0x2::object::id<Profile>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(v0, &v1)) {
            let v2 = 0x2::object::id<Profile>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(v0, &v2);
            let v3 = 0x2::object::id<Profile>(arg0);
            0x2::vec_set::remove<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg1.id, followings_key()), &v3);
            arg0.followers_count = arg0.followers_count - 1;
            arg1.followings_count = arg1.followings_count - 1;
        };
    }

    public fun profile_unfollow_delegated(arg0: &mut Profile, arg1: &mut Profile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_delegated_wallet(arg1, &v0);
        profile_unfollow_(arg0, arg1);
    }

    public fun remove_wallet_from_delegation_wallets(arg0: &mut Profile, arg1: &mut ProfileOwnerCap, arg2: address) {
        assert_profile_owner(arg0, arg1);
        remove_wallet_to_delegation_wallets_(arg0, arg2);
    }

    fun remove_wallet_to_delegation_wallets_(arg0: &mut Profile, arg1: address) {
        ensure_delegation_wallets_exist(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg0.id, delegated_wallets_key());
        if (0x2::vec_set::contains<address>(v0, &arg1)) {
            0x2::vec_set::remove<address>(v0, &arg1);
        };
    }

    public entry fun unlike_post_delegated(arg0: &mut 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::Post, arg1: &mut Profile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_delegated_wallet(arg1, &v0);
        0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post::unlike_post(arg0, 0x2::object::id<Profile>(arg1));
    }

    public entry fun update_cover_image(arg0: &mut Profile, arg1: &mut ProfileOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_profile_owner(arg0, arg1);
        arg0.cover_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg2));
    }

    public entry fun update_cover_image_delegated(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_delegated_wallet(arg0, &v0);
        arg0.cover_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg1));
    }

    public entry fun update_profile_description(arg0: &mut Profile, arg1: &mut ProfileOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_profile_owner(arg0, arg1);
        arg0.description = arg2;
        arg1.description = arg2;
    }

    public entry fun update_profile_description_delegated(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_delegated_wallet(arg0, &v0);
        arg0.description = arg1;
    }

    public entry fun update_profile_image(arg0: &mut Profile, arg1: &mut ProfileOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_profile_owner(arg0, arg1);
        arg0.image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg2));
        arg1.image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg2));
    }

    public entry fun update_profile_image_delegated(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_delegated_wallet(arg0, &v0);
        arg0.image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg1));
    }

    // decompiled from Move bytecode v6
}

