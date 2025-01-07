module 0x49b3c24138b61c1ae0f543e23c59e04a9b96c3f98055c48262a2ffb71880d0a3::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        account: address,
        code_invite: 0x1::string::String,
        username: 0x1::string::String,
        email: 0x1::string::String,
        bio: 0x1::string::String,
        exp: u64,
        avatar: 0x1::string::String,
        banner: 0x1::string::String,
        socials: vector<0x1::string::String>,
        creator: address,
        create_date: u64,
    }

    struct ProfileCreatedEvent has copy, drop {
        profile_id: 0x2::object::ID,
    }

    public entry fun create_profile(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = Profile{
            id          : 0x2::object::new(arg7),
            account     : v0,
            code_invite : 0x1::string::utf8(arg0),
            username    : 0x1::string::utf8(arg1),
            email       : 0x1::string::utf8(arg2),
            bio         : 0x1::string::utf8(arg3),
            exp         : 0,
            avatar      : 0x1::string::utf8(arg4),
            banner      : 0x1::string::utf8(arg5),
            socials     : 0x1::vector::empty<0x1::string::String>(),
            creator     : v0,
            create_date : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        let v2 = ProfileCreatedEvent{profile_id: 0x2::object::id<Profile>(&v1)};
        0x2::event::emit<ProfileCreatedEvent>(v2);
        0x2::transfer::share_object<Profile>(v1);
    }

    public entry fun create_profile_from_community(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Profile{
            id          : 0x2::object::new(arg2),
            account     : v0,
            code_invite : 0x1::string::utf8(arg1),
            username    : 0x1::string::utf8(b""),
            email       : 0x1::string::utf8(b""),
            bio         : 0x1::string::utf8(b""),
            exp         : 0,
            avatar      : 0x1::string::utf8(arg0),
            banner      : 0x1::string::utf8(b""),
            socials     : 0x1::vector::empty<0x1::string::String>(),
            creator     : v0,
            create_date : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        let v2 = ProfileCreatedEvent{profile_id: 0x2::object::id<Profile>(&v1)};
        0x2::event::emit<ProfileCreatedEvent>(v2);
        0x2::transfer::share_object<Profile>(v1);
    }

    public entry fun update(arg0: &mut Profile, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.creator, 1);
        arg0.username = 0x1::string::utf8(arg1);
        arg0.email = 0x1::string::utf8(arg2);
        arg0.bio = 0x1::string::utf8(arg3);
        arg0.avatar = 0x1::string::utf8(arg4);
        arg0.banner = 0x1::string::utf8(arg5);
        arg0.socials = arg6;
    }

    // decompiled from Move bytecode v6
}

