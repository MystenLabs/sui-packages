module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile {
    struct Profile has key {
        id: 0x2::object::UID,
        cap_id: 0x2::object::ID,
        points: u64,
        username: 0x1::string::String,
    }

    public(friend) fun new(arg0: u64, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : (Profile, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::ProfileCap) {
        let v0 = Profile{
            id       : 0x2::object::new(arg2),
            cap_id   : 0x2::object::id_from_address(@0x0),
            points   : arg0,
            username : arg1,
        };
        let v1 = 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::new(0x2::object::id<Profile>(&v0), arg2);
        v0.cap_id = 0x2::object::id<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::ProfileCap>(&v1);
        (v0, v1)
    }

    public(friend) fun cap_id(arg0: &Profile) : &0x2::object::ID {
        &arg0.cap_id
    }

    public(friend) fun drop(arg0: Profile) {
        let Profile {
            id       : v0,
            cap_id   : _,
            points   : _,
            username : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun points(arg0: &Profile) : &u64 {
        &arg0.points
    }

    public(friend) fun points_mut(arg0: &mut Profile) : &mut u64 {
        &mut arg0.points
    }

    public(friend) fun share(arg0: Profile) {
        0x2::transfer::share_object<Profile>(arg0);
    }

    // decompiled from Move bytecode v6
}

