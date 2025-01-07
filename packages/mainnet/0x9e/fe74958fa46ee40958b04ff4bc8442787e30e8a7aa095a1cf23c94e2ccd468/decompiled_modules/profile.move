module 0x9efe74958fa46ee40958b04ff4bc8442787e30e8a7aa095a1cf23c94e2ccd468::profile {
    struct ItemCounter has store, key {
        id: 0x2::object::UID,
        value: u64,
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
    }

    struct ProfileCreatedEvent has copy, drop {
        profile_id: 0x2::object::ID,
    }

    public entry fun create_profile(arg0: &mut ItemCounter, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        arg0.value = arg0.value + 1;
        let v1 = Profile{
            id            : 0x2::object::new(arg9),
            account       : v0,
            code_invite   : arg0.value,
            parent_invite : arg2,
            username      : 0x1::string::utf8(arg3),
            email         : 0x1::string::utf8(arg4),
            bio           : 0x1::string::utf8(arg5),
            exp           : 0,
            avatar        : 0x1::string::utf8(arg6),
            banner        : 0x1::string::utf8(arg7),
            socials       : 0x1::vector::empty<0x1::string::String>(),
            creator       : v0,
            create_date   : 0x2::tx_context::epoch_timestamp_ms(arg9),
        };
        let v2 = ProfileCreatedEvent{profile_id: 0x2::object::id<Profile>(&v1)};
        0x2::event::emit<ProfileCreatedEvent>(v2);
        0x2::transfer::transfer<Profile>(v1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ItemCounter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<ItemCounter>(v0);
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

