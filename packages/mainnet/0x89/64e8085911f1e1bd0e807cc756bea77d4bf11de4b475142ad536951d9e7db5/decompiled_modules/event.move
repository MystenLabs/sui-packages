module 0x8964e8085911f1e1bd0e807cc756bea77d4bf11de4b475142ad536951d9e7db5::event {
    struct ProfileCreated has copy, drop {
        owner: address,
        profile: 0x2::object::ID,
    }

    struct ProfileDestroyed has copy, drop {
        owner: address,
        profile: 0x2::object::ID,
    }

    public fun profile_created(arg0: address, arg1: 0x2::object::ID) {
        let v0 = ProfileCreated{
            owner   : arg0,
            profile : arg1,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public fun profile_destroyed(arg0: address, arg1: 0x2::object::ID) {
        let v0 = ProfileDestroyed{
            owner   : arg0,
            profile : arg1,
        };
        0x2::event::emit<ProfileDestroyed>(v0);
    }

    // decompiled from Move bytecode v6
}

