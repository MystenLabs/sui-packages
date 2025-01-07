module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::public_ {
    struct ProfileCapDropped has copy, drop {
        id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
    }

    public fun profile_cap_drop(arg0: 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::ProfileCap) {
        let v0 = ProfileCapDropped{
            id         : 0x2::object::id<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::ProfileCap>(&arg0),
            profile_id : *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::profile(&arg0),
        };
        0x2::event::emit<ProfileCapDropped>(v0);
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::drop(arg0);
    }

    // decompiled from Move bytecode v6
}

