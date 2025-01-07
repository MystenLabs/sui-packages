module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap {
    struct ProfileCap has key {
        id: 0x2::object::UID,
        profile: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : ProfileCap {
        ProfileCap{
            id      : 0x2::object::new(arg1),
            profile : arg0,
        }
    }

    public(friend) fun transfer(arg0: ProfileCap, arg1: address) {
        0x2::transfer::transfer<ProfileCap>(arg0, arg1);
    }

    public(friend) fun drop(arg0: ProfileCap) {
        let ProfileCap {
            id      : v0,
            profile : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun profile(arg0: &ProfileCap) : &0x2::object::ID {
        &arg0.profile
    }

    // decompiled from Move bytecode v6
}

