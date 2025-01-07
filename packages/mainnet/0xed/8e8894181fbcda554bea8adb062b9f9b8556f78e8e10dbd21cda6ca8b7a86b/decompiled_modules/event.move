module 0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::event {
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

