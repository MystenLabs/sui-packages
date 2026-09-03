module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::profile {
    struct Profile has key {
        id: 0x2::object::UID,
        metadata_uri: 0x1::string::String,
        created_ms: u64,
    }

    struct ProfileCreated has copy, drop {
        profile: 0x2::object::ID,
        owner: address,
    }

    public fun create(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Profile{
            id           : 0x2::object::new(arg2),
            metadata_uri : arg0,
            created_ms   : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = ProfileCreated{
            profile : 0x2::object::id<Profile>(&v0),
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfileCreated>(v1);
        0x2::transfer::transfer<Profile>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun created_ms(arg0: &Profile) : u64 {
        arg0.created_ms
    }

    public fun metadata_uri(arg0: &Profile) : 0x1::string::String {
        arg0.metadata_uri
    }

    public fun set_metadata_uri(arg0: &mut Profile, arg1: 0x1::string::String) {
        arg0.metadata_uri = arg1;
    }

    // decompiled from Move bytecode v7
}

