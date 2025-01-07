module 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::user_info {
    struct UserInfoStore has store {
        usernames: 0x2::table::Table<0x1::ascii::String, address>,
        users_info: 0x2::table::Table<address, UserInfo>,
        claimed_sign_up_reward: 0x2::table::Table<address, bool>,
    }

    struct UserInfo has store {
        avatar: 0x2::url::Url,
        cover_image: 0x2::url::Url,
        name: 0x1::ascii::String,
        display_name: 0x1::string::String,
        email: 0x1::string::String,
        bio: 0x1::string::String,
        nation: 0x1::string::String,
        language: 0x1::string::String,
        website: 0x1::string::String,
        social_links: 0x1::string::String,
        joined_at: u64,
        active: bool,
        metadata: 0x2::table::Table<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>,
    }

    struct UserInfoEvent has copy, drop {
        user_id: address,
        avatar: 0x2::url::Url,
        cover_image: 0x2::url::Url,
        name: 0x1::ascii::String,
        display_name: 0x1::string::String,
        email: 0x1::string::String,
        bio: 0x1::string::String,
        nation: 0x1::string::String,
        language: 0x1::string::String,
        website: 0x1::string::String,
        social_links: 0x1::string::String,
        joined_at: u64,
        active: bool,
    }

    struct UserInfoMetadataEvent has copy, drop {
        user_address: address,
        metadata_kind: 0x1::string::String,
        metadata_address: address,
        metadata_data: 0x1::ascii::String,
        action: 0x1::string::String,
    }

    public fun new(arg0: &0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : UserInfoStore {
        UserInfoStore{
            usernames              : 0x2::table::new<0x1::ascii::String, address>(arg1),
            users_info             : 0x2::table::new<address, UserInfo>(arg1),
            claimed_sign_up_reward : 0x2::table::new<address, bool>(arg1),
        }
    }

    public fun add_metadata(arg0: UserInfo, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (UserInfo, address) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::ascii::string(arg2);
        if (!0x2::table::contains<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(&arg0.metadata, v0)) {
            0x2::table::add<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(&mut arg0.metadata, v0, 0x2::table::new<address, 0x1::ascii::String>(arg3));
        };
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::object::uid_to_address(&v2);
        0x2::table::add<address, 0x1::ascii::String>(0x2::table::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(&mut arg0.metadata, v0), v3, v1);
        0x2::object::delete(v2);
        let v4 = UserInfoMetadataEvent{
            user_address     : 0x2::tx_context::sender(arg3),
            metadata_kind    : v0,
            metadata_address : v3,
            metadata_data    : v1,
            action           : 0x1::string::utf8(b"add"),
        };
        0x2::event::emit<UserInfoMetadataEvent>(v4);
        (arg0, v3)
    }

    public fun address_by_username(arg0: &0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: vector<u8>) : 0x1::option::Option<address> {
        let v0 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::object<UserInfoStore>(arg0);
        if (0x2::table::contains<0x1::ascii::String, address>(&v0.usernames, 0x1::ascii::string(arg1))) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::ascii::String, address>(&v0.usernames, 0x1::ascii::string(arg1)))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun claim_sign_up_reward(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::UserInfoV1, UserInfoStore>(arg0);
        let v2 = 0x2::table::borrow<address, UserInfo>(&v1.users_info, v0);
        let v3 = &v2.display_name;
        let v4 = &v2.email;
        let v5 = &v2.bio;
        let v6 = &v2.nation;
        let v7 = &v2.language;
        let v8 = &v2.website;
        let v9 = &v2.social_links;
        let v10 = &v2.metadata;
        let v11 = 0x1::vector::empty<0x2::url::Url>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x2::url::Url>(v12, v2.avatar);
        0x1::vector::push_back<0x2::url::Url>(v12, v2.cover_image);
        let v13 = &v11;
        let v14 = 0;
        let v15;
        while (v14 < 0x1::vector::length<0x2::url::Url>(v13)) {
            let v16 = 0x2::url::inner_url(0x1::vector::borrow<0x2::url::Url>(v13, v14));
            if (!!0x1::ascii::is_empty(&v16)) {
                v15 = false;
                /* label 6 */
                assert!(v15, 102);
                let v17 = 0x1::vector::empty<0x1::string::String>();
                let v18 = &mut v17;
                0x1::vector::push_back<0x1::string::String>(v18, *v3);
                0x1::vector::push_back<0x1::string::String>(v18, *v4);
                0x1::vector::push_back<0x1::string::String>(v18, *v5);
                0x1::vector::push_back<0x1::string::String>(v18, *v6);
                0x1::vector::push_back<0x1::string::String>(v18, *v7);
                0x1::vector::push_back<0x1::string::String>(v18, *v8);
                0x1::vector::push_back<0x1::string::String>(v18, *v9);
                let v19 = &v17;
                let v20 = 0;
                let v21;
                while (v20 < 0x1::vector::length<0x1::string::String>(v19)) {
                    if (!!0x1::string::is_empty(0x1::vector::borrow<0x1::string::String>(v19, v20))) {
                        v21 = false;
                        /* label 15 */
                        assert!(v21, 102);
                        let v22 = 0x1::vector::empty<0x1::string::String>();
                        let v23 = vector[b"gaming-setup", b"play-time-schedule", b"profile-gamer-tags"];
                        0x1::vector::reverse<vector<u8>>(&mut v23);
                        while (!0x1::vector::is_empty<vector<u8>>(&v23)) {
                            0x1::vector::push_back<0x1::string::String>(&mut v22, 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut v23)));
                        };
                        0x1::vector::destroy_empty<vector<u8>>(v23);
                        let v24 = &v22;
                        let v25 = 0;
                        let v26;
                        while (v25 < 0x1::vector::length<0x1::string::String>(v24)) {
                            let v27 = 0x1::vector::borrow<0x1::string::String>(v24, v25);
                            let v28 = 0x2::table::contains<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(v10, *v27) && !0x2::table::is_empty<address, 0x1::ascii::String>(0x2::table::borrow<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(v10, *v27));
                            if (!v28) {
                                v26 = false;
                                /* label 31 */
                                assert!(v26, 102);
                                assert!(!0x2::table::contains<address, bool>(&v1.claimed_sign_up_reward, v0), 101);
                                0x2::table::add<address, bool>(&mut v1.claimed_sign_up_reward, v0, true);
                                0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::point::mint_points_for_user_completing_sign_up(arg0, v0, arg1);
                                return
                            };
                            v25 = v25 + 1;
                        };
                        v26 = true;
                        /* goto 31 */
                    } else {
                        v20 = v20 + 1;
                    };
                };
                v21 = true;
                /* goto 15 */
            } else {
                v14 = v14 + 1;
            };
        };
        v15 = true;
        /* goto 6 */
    }

    fun clean_username(arg0: vector<u8>) : 0x1::ascii::String {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 > 2 && v0 < 31, 100);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            let v3 = if (v2 == 46) {
                true
            } else if (v2 > 47 && v2 < 58) {
                true
            } else if (v2 == 95) {
                true
            } else {
                v2 > 96 && v2 < 123
            };
            assert!(v3, 100);
            v1 = v1 + 1;
        };
        0x1::ascii::string(arg0)
    }

    public fun edit_active(arg0: UserInfo, arg1: bool) : UserInfo {
        arg0.active = arg1;
        arg0
    }

    public fun edit_avatar(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.avatar = 0x2::url::new_unsafe_from_bytes(arg1);
        arg0
    }

    public fun edit_bio(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.bio = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_cover_image(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.cover_image = 0x2::url::new_unsafe_from_bytes(arg1);
        arg0
    }

    public fun edit_display_name(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.display_name = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_email(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.email = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_language(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.language = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_metadata(arg0: UserInfo, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : UserInfo {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::ascii::string(arg3);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(&mut arg0.metadata, v0);
        0x2::table::remove<address, 0x1::ascii::String>(v2, arg2);
        0x2::table::add<address, 0x1::ascii::String>(v2, arg2, v1);
        let v3 = UserInfoMetadataEvent{
            user_address     : 0x2::tx_context::sender(arg4),
            metadata_kind    : v0,
            metadata_address : arg2,
            metadata_data    : v1,
            action           : 0x1::string::utf8(b"edit"),
        };
        0x2::event::emit<UserInfoMetadataEvent>(v3);
        arg0
    }

    public fun edit_nation(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.nation = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_social_links(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.social_links = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_website(arg0: UserInfo, arg1: vector<u8>) : UserInfo {
        arg0.website = 0x1::string::utf8(arg1);
        arg0
    }

    public fun new_info(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : UserInfo {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 900);
        let v0 = clean_username(arg1);
        0x2::table::add<0x1::ascii::String, address>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::UserInfoV1, UserInfoStore>(arg0).usernames, v0, 0x2::tx_context::sender(arg3));
        UserInfo{
            avatar       : 0x2::url::new_unsafe_from_bytes(b""),
            cover_image  : 0x2::url::new_unsafe_from_bytes(b""),
            name         : v0,
            display_name : 0x1::string::utf8(b""),
            email        : 0x1::string::utf8(b""),
            bio          : 0x1::string::utf8(b""),
            nation       : 0x1::string::utf8(b""),
            language     : 0x1::string::utf8(b""),
            website      : 0x1::string::utf8(b""),
            social_links : 0x1::string::utf8(b""),
            joined_at    : 0x2::clock::timestamp_ms(arg2),
            active       : true,
            metadata     : 0x2::table::new<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(arg3),
        }
    }

    public fun remove_metadata(arg0: UserInfo, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : UserInfo {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = UserInfoMetadataEvent{
            user_address     : 0x2::tx_context::sender(arg3),
            metadata_kind    : v0,
            metadata_address : arg2,
            metadata_data    : 0x2::table::remove<address, 0x1::ascii::String>(0x2::table::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(&mut arg0.metadata, v0), arg2),
            action           : 0x1::string::utf8(b"remove"),
        };
        0x2::event::emit<UserInfoMetadataEvent>(v1);
        arg0
    }

    public fun save(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: UserInfo, arg2: &0x2::tx_context::TxContext) {
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = UserInfoEvent{
            user_id      : v0,
            avatar       : arg1.avatar,
            cover_image  : arg1.cover_image,
            name         : arg1.name,
            display_name : arg1.display_name,
            email        : arg1.email,
            bio          : arg1.bio,
            nation       : arg1.nation,
            language     : arg1.language,
            website      : arg1.website,
            social_links : arg1.social_links,
            joined_at    : arg1.joined_at,
            active       : arg1.active,
        };
        0x2::event::emit<UserInfoEvent>(v1);
        0x2::table::add<address, UserInfo>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::UserInfoV1, UserInfoStore>(arg0).users_info, v0, arg1);
    }

    public fun take(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: &0x2::tx_context::TxContext) : UserInfo {
        0x2::table::remove<address, UserInfo>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::UserInfoV1, UserInfoStore>(arg0).users_info, 0x2::tx_context::sender(arg1))
    }

    // decompiled from Move bytecode v6
}

