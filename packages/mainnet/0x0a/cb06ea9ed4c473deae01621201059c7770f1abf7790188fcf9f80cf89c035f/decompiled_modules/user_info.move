module 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::user_info {
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

    public fun new(arg0: &0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : UserInfoStore {
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

    public fun address_by_username(arg0: &0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::GilderApp, arg1: vector<u8>) : 0x1::option::Option<address> {
        let v0 = 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::object<UserInfoStore>(arg0);
        if (0x2::table::contains<0x1::ascii::String, address>(&v0.usernames, 0x1::ascii::string(arg1))) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::ascii::String, address>(&v0.usernames, 0x1::ascii::string(arg1)))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun claim_sign_up_reward(arg0: &mut 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::GilderApp, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::app_object_mut<0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::version::UserInfoV3, UserInfoStore>(arg0);
        let v2 = 0x2::table::borrow<address, UserInfo>(&v1.users_info, v0);
        let v3 = &v2.display_name;
        let v4 = &v2.email;
        let v5 = &v2.bio;
        let v6 = &v2.nation;
        let v7 = &v2.social_links;
        let v8 = &v2.metadata;
        let v9 = 0x1::vector::empty<0x2::url::Url>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x2::url::Url>(v10, v2.avatar);
        0x1::vector::push_back<0x2::url::Url>(v10, v2.cover_image);
        let v11 = &v9;
        let v12 = 0;
        let v13;
        while (v12 < 0x1::vector::length<0x2::url::Url>(v11)) {
            let v14 = 0x2::url::inner_url(0x1::vector::borrow<0x2::url::Url>(v11, v12));
            if (!!0x1::ascii::is_empty(&v14)) {
                v13 = false;
                /* label 6 */
                assert!(v13, 102);
                let v15 = 0x1::vector::empty<0x1::string::String>();
                let v16 = &mut v15;
                0x1::vector::push_back<0x1::string::String>(v16, *v3);
                0x1::vector::push_back<0x1::string::String>(v16, *v4);
                0x1::vector::push_back<0x1::string::String>(v16, *v5);
                0x1::vector::push_back<0x1::string::String>(v16, *v6);
                0x1::vector::push_back<0x1::string::String>(v16, *v7);
                let v17 = &v15;
                let v18 = 0;
                let v19;
                while (v18 < 0x1::vector::length<0x1::string::String>(v17)) {
                    if (!!0x1::string::is_empty(0x1::vector::borrow<0x1::string::String>(v17, v18))) {
                        v19 = false;
                        /* label 15 */
                        assert!(v19, 102);
                        let v20 = 0x1::vector::empty<0x1::string::String>();
                        let v21 = vector[b"gaming-setup", b"play-time-schedule", b"profile-gamer-tags", b"profile-timezone", b"voice-chat-languages"];
                        0x1::vector::reverse<vector<u8>>(&mut v21);
                        let v22 = 0;
                        while (v22 < 0x1::vector::length<vector<u8>>(&v21)) {
                            0x1::vector::push_back<0x1::string::String>(&mut v20, 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut v21)));
                            v22 = v22 + 1;
                        };
                        0x1::vector::destroy_empty<vector<u8>>(v21);
                        let v23 = &v20;
                        let v24 = 0;
                        let v25;
                        while (v24 < 0x1::vector::length<0x1::string::String>(v23)) {
                            let v26 = 0x1::vector::borrow<0x1::string::String>(v23, v24);
                            let v27 = 0x2::table::contains<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(v8, *v26) && !0x2::table::is_empty<address, 0x1::ascii::String>(0x2::table::borrow<0x1::string::String, 0x2::table::Table<address, 0x1::ascii::String>>(v8, *v26));
                            if (!v27) {
                                v25 = false;
                                /* label 31 */
                                assert!(v25, 102);
                                assert!(!0x2::table::contains<address, bool>(&v1.claimed_sign_up_reward, v0), 101);
                                0x2::table::add<address, bool>(&mut v1.claimed_sign_up_reward, v0, true);
                                0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::point::mint_points_for_user_completing_sign_up(arg0, v0, arg1);
                                return
                            };
                            v24 = v24 + 1;
                        };
                        v25 = true;
                        /* goto 31 */
                    } else {
                        v18 = v18 + 1;
                    };
                };
                v19 = true;
                /* goto 15 */
            } else {
                v12 = v12 + 1;
            };
        };
        v13 = true;
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

    public fun has_claimed_sign_up_reward(arg0: &0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::GilderApp, arg1: address) : bool {
        0x2::table::contains<address, bool>(&0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::object<UserInfoStore>(arg0).claimed_sign_up_reward, arg1)
    }

    public fun new_info(arg0: &mut 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::GilderApp, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : UserInfo {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 900);
        let v0 = clean_username(arg1);
        0x2::table::add<0x1::ascii::String, address>(&mut 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::app_object_mut<0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::version::UserInfoV3, UserInfoStore>(arg0).usernames, v0, 0x2::tx_context::sender(arg3));
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

    public fun save(arg0: &mut 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::GilderApp, arg1: UserInfo, arg2: &0x2::tx_context::TxContext) {
        0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
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
        0x2::table::add<address, UserInfo>(&mut 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::app_object_mut<0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::version::UserInfoV3, UserInfoStore>(arg0).users_info, v0, arg1);
    }

    public fun take(arg0: &mut 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::GilderApp, arg1: &0x2::tx_context::TxContext) : UserInfo {
        0x2::table::remove<address, UserInfo>(&mut 0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::app::app_object_mut<0xacb06ea9ed4c473deae01621201059c7770f1abf7790188fcf9f80cf89c035f::version::UserInfoV3, UserInfoStore>(arg0).users_info, 0x2::tx_context::sender(arg1))
    }

    // decompiled from Move bytecode v6
}

