module 0x8852d5859bb803ff5ba28b5c5301d825b6384b53acdebee157fa4bf137556cb5::user_profile {
    struct UserProfile has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        age: u8,
        email: 0x1::string::String,
        created_at: u64,
    }

    struct ProfileCreated has copy, drop {
        profile_id: address,
        owner: address,
        name: 0x1::string::String,
    }

    public fun create_profile(arg0: vector<u8>, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = UserProfile{
            id         : 0x2::object::new(arg3),
            name       : 0x1::string::utf8(arg0),
            age        : arg1,
            email      : 0x1::string::utf8(arg2),
            created_at : 0x2::tx_context::epoch(arg3),
        };
        let v1 = 0x2::object::id<UserProfile>(&v0);
        let v2 = ProfileCreated{
            profile_id : 0x2::object::id_to_address(&v1),
            owner      : 0x2::tx_context::sender(arg3),
            name       : v0.name,
        };
        0x2::event::emit<ProfileCreated>(v2);
        0x2::transfer::transfer<UserProfile>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_age(arg0: &UserProfile) : u8 {
        arg0.age
    }

    public fun get_email(arg0: &UserProfile) : 0x1::string::String {
        arg0.email
    }

    public fun get_name(arg0: &UserProfile) : 0x1::string::String {
        arg0.name
    }

    public fun update_age(arg0: &mut UserProfile, arg1: u8) {
        arg0.age = arg1;
    }

    // decompiled from Move bytecode v6
}

