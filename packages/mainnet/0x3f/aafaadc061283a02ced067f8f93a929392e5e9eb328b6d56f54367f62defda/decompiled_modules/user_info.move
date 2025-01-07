module 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::user_info {
    struct UserInfoStore has store {
        usernames: 0x2::table::Table<0x1::ascii::String, address>,
        users_info: 0x2::table::Table<address, UserInfo>,
    }

    struct UserInfo has copy, store {
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

    public fun new(arg0: &0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : UserInfoStore {
        UserInfoStore{
            usernames  : 0x2::table::new<0x1::ascii::String, address>(arg1),
            users_info : 0x2::table::new<address, UserInfo>(arg1),
        }
    }

    public fun address_by_username(arg0: &0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: vector<u8>) : 0x1::option::Option<address> {
        let v0 = 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::object<UserInfoStore>(arg0);
        if (0x2::table::contains<0x1::ascii::String, address>(&v0.usernames, 0x1::ascii::string(arg1))) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::ascii::String, address>(&v0.usernames, 0x1::ascii::string(arg1)))
        } else {
            0x1::option::none<address>()
        }
    }

    fun clean_username(arg0: vector<u8>) : 0x1::ascii::String {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 > 2 && v0 < 31, 100);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            assert!(v2 == 46 || v2 > 47 && v2 < 58 || v2 == 95 || v2 > 96 && v2 < 123, 100);
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

    public fun new_info(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : UserInfo {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 900);
        let v0 = clean_username(arg1);
        0x2::table::add<0x1::ascii::String, address>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::UserInfoV1, UserInfoStore>(arg0).usernames, v0, 0x2::tx_context::sender(arg3));
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
        }
    }

    public fun save(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: UserInfo, arg2: &0x2::tx_context::TxContext) {
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
        0x2::table::add<address, UserInfo>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::UserInfoV1, UserInfoStore>(arg0).users_info, v0, arg1);
    }

    public fun take(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: &0x2::tx_context::TxContext) : UserInfo {
        0x2::table::remove<address, UserInfo>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::UserInfoV1, UserInfoStore>(arg0).users_info, 0x2::tx_context::sender(arg1))
    }

    // decompiled from Move bytecode v6
}

