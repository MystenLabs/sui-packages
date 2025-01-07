module 0xdc7ef06e01e56d4e0ad65f2a0cd60e1b10095a57a4230dd56c5697a30090f81d::profile {
    struct InitData has store, key {
        id: 0x2::object::UID,
        uniqueId: u64,
        list_profile: 0x2::vec_map::VecMap<address, ProfileCreatedEvent>,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        account: address,
        code_invite: u64,
        parent_invite: u64,
        username: 0x1::string::String,
        email: 0x1::string::String,
        bio: 0x1::string::String,
        exp: u64,
        avatar: 0x1::string::String,
        banner: 0x1::string::String,
        socials: vector<0x1::string::String>,
        creator: address,
        create_date: u64,
        update_date: u64,
    }

    struct ProfileCreatedEvent has copy, drop, store {
        profile_id: 0x2::object::ID,
    }

    public entry fun create_profile(arg0: &mut InitData, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::string::String>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        arg0.uniqueId = arg0.uniqueId + 1;
        let v1 = Profile{
            id            : 0x2::object::new(arg9),
            account       : v0,
            code_invite   : arg0.uniqueId,
            parent_invite : arg1,
            username      : 0x1::string::utf8(arg2),
            email         : 0x1::string::utf8(arg3),
            bio           : 0x1::string::utf8(arg4),
            exp           : 0,
            avatar        : 0x1::string::utf8(arg5),
            banner        : 0x1::string::utf8(arg6),
            socials       : 0x1::vector::empty<0x1::string::String>(),
            creator       : v0,
            create_date   : 0x2::clock::timestamp_ms(arg8),
            update_date   : 0,
        };
        let v2 = ProfileCreatedEvent{profile_id: 0x2::object::id<Profile>(&v1)};
        0x2::vec_map::insert<address, ProfileCreatedEvent>(&mut arg0.list_profile, v0, v2);
        0x2::event::emit<ProfileCreatedEvent>(v2);
        0x2::transfer::transfer<Profile>(v1, v0);
    }

    public fun get_profile(arg0: &mut InitData, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_map::get_mut<address, ProfileCreatedEvent>(&mut arg0.list_profile, &v0).profile_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitData{
            id           : 0x2::object::new(arg0),
            uniqueId     : 0,
            list_profile : 0x2::vec_map::empty<address, ProfileCreatedEvent>(),
        };
        0x2::transfer::share_object<InitData>(v0);
    }

    public entry fun update(arg0: &mut Profile, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::string::String>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.creator, 1);
        arg0.parent_invite = arg2;
        arg0.username = 0x1::string::utf8(arg1);
        arg0.email = 0x1::string::utf8(arg3);
        arg0.bio = 0x1::string::utf8(arg4);
        arg0.avatar = 0x1::string::utf8(arg5);
        arg0.banner = 0x1::string::utf8(arg6);
        arg0.socials = arg7;
        arg0.update_date = 0x2::clock::timestamp_ms(arg8);
    }

    // decompiled from Move bytecode v6
}

