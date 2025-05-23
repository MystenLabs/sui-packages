module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection {
    struct AvatarCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        project_url: 0x1::string::String,
        avatar_count: u64,
    }

    public fun get_avatar_count(arg0: &AvatarCollection) : u64 {
        arg0.avatar_count
    }

    public fun get_description(arg0: &AvatarCollection) : 0x1::string::String {
        arg0.description
    }

    public fun get_id(arg0: &AvatarCollection) : 0x2::object::ID {
        0x2::object::id<AvatarCollection>(arg0)
    }

    public fun get_name(arg0: &AvatarCollection) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun increment_avatar_count(arg0: &mut AvatarCollection) {
        arg0.avatar_count = arg0.avatar_count + 1;
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AvatarCollection{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"Privasui Avatars"),
            description  : 0x1::string::utf8(b"Unique avatar NFTs for Privasui users"),
            creator      : 0x1::string::utf8(b"Privasui"),
            project_url  : 0x1::string::utf8(b"https://privasui.xyz"),
            avatar_count : 0,
        };
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<AvatarCollection>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

