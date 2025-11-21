module 0xf221ac22cab1c8d70b17c8ace7f5f6bf7408bfc332d717adc5a966b4f7f41b23::user_profile {
    struct UserProfile has store, key {
        id: 0x2::object::UID,
        user: address,
        role: u8,
        display_name: 0x1::string::String,
        avatar_url: 0x1::string::String,
        bio: 0x1::string::String,
        created_at: u64,
        is_verified: bool,
    }

    struct UserCap has key {
        id: 0x2::object::UID,
        user: address,
        profile_id: 0x2::object::ID,
    }

    struct UserRegistered has copy, drop {
        profile_id: 0x2::object::ID,
        user: address,
        role: u8,
        display_name: 0x1::string::String,
        timestamp: u64,
    }

    struct UserProfileUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        user: address,
        timestamp: u64,
    }

    struct UserRoleUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        user: address,
        old_role: u8,
        new_role: u8,
        timestamp: u64,
    }

    public fun get_avatar_url(arg0: &UserProfile) : 0x1::string::String {
        arg0.avatar_url
    }

    public fun get_bio(arg0: &UserProfile) : 0x1::string::String {
        arg0.bio
    }

    public fun get_created_at(arg0: &UserProfile) : u64 {
        arg0.created_at
    }

    public fun get_display_name(arg0: &UserProfile) : 0x1::string::String {
        arg0.display_name
    }

    public fun get_role(arg0: &UserProfile) : u8 {
        arg0.role
    }

    public fun get_user(arg0: &UserProfile) : address {
        arg0.user
    }

    public fun is_creator(arg0: &UserProfile) : bool {
        arg0.role == 1 || arg0.role == 2
    }

    public fun is_fan(arg0: &UserProfile) : bool {
        arg0.role == 0 || arg0.role == 2
    }

    public fun is_verified(arg0: &UserProfile) : bool {
        arg0.is_verified
    }

    public entry fun register_user(arg0: u8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v2, 2);
        let v3 = UserProfile{
            id           : 0x2::object::new(arg5),
            user         : v0,
            role         : arg0,
            display_name : arg1,
            avatar_url   : arg2,
            bio          : arg3,
            created_at   : v1,
            is_verified  : false,
        };
        let v4 = 0x2::object::id<UserProfile>(&v3);
        let v5 = UserRegistered{
            profile_id   : v4,
            user         : v0,
            role         : arg0,
            display_name : v3.display_name,
            timestamp    : v1,
        };
        0x2::event::emit<UserRegistered>(v5);
        0x2::transfer::public_transfer<UserProfile>(v3, v0);
        let v6 = UserCap{
            id         : 0x2::object::new(arg5),
            user       : v0,
            profile_id : v4,
        };
        0x2::transfer::transfer<UserCap>(v6, v0);
    }

    public fun role_both() : u8 {
        2
    }

    public fun role_creator() : u8 {
        1
    }

    public fun role_fan() : u8 {
        0
    }

    public entry fun set_verified(arg0: &mut UserProfile, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg2), 1);
        arg0.is_verified = arg1;
    }

    public entry fun update_profile(arg0: &mut UserProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.user == v0, 1);
        arg0.display_name = arg1;
        arg0.avatar_url = arg2;
        arg0.bio = arg3;
        let v1 = UserProfileUpdated{
            profile_id : 0x2::object::id<UserProfile>(arg0),
            user       : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<UserProfileUpdated>(v1);
    }

    public entry fun update_role(arg0: &mut UserProfile, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.user == v0, 1);
        let v1 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v1, 2);
        arg0.role = arg1;
        let v2 = UserRoleUpdated{
            profile_id : 0x2::object::id<UserProfile>(arg0),
            user       : v0,
            old_role   : arg0.role,
            new_role   : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UserRoleUpdated>(v2);
    }

    // decompiled from Move bytecode v6
}

