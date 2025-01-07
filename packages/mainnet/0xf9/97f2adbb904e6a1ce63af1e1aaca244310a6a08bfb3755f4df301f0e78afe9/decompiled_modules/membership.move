module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership {
    struct Membership has key {
        id: 0x2::object::UID,
        owner_profile: 0x2::object::ID,
        space_id: 0x2::object::ID,
        space: 0x1::string::String,
        tier: 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier,
        start_date: 0x1::string::String,
        active: bool,
        status: 0x1::string::String,
        points: u64,
        metadata_uri: 0x1::string::String,
        visuals_uri: 0x1::string::String,
    }

    public(friend) fun new(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::Profile, arg1: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::Space, arg2: 0x1::string::String, arg3: bool, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Membership {
        assert!(0x2::linked_table::contains<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::tiers(arg1), arg2), 0);
        Membership{
            id            : 0x2::object::new(arg9),
            owner_profile : 0x2::object::id<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::Profile>(arg0),
            space_id      : 0x2::object::id<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::Space>(arg1),
            space         : *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::name(arg1),
            tier          : *0x2::linked_table::borrow<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::tiers(arg1), arg2),
            start_date    : arg4,
            active        : arg3,
            status        : arg5,
            points        : arg6,
            metadata_uri  : arg7,
            visuals_uri   : arg8,
        }
    }

    public(friend) fun active_mut(arg0: &mut Membership) : &mut bool {
        &mut arg0.active
    }

    public(friend) fun drop(arg0: Membership) {
        let Membership {
            id            : v0,
            owner_profile : _,
            space_id      : _,
            space         : _,
            tier          : _,
            start_date    : _,
            active        : _,
            status        : _,
            points        : _,
            metadata_uri  : _,
            visuals_uri   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun points_mut(arg0: &mut Membership) : &mut u64 {
        &mut arg0.points
    }

    public(friend) fun share(arg0: Membership) {
        0x2::transfer::share_object<Membership>(arg0);
    }

    public(friend) fun status_mut(arg0: &mut Membership) : &mut 0x1::string::String {
        &mut arg0.status
    }

    public(friend) fun tier_mut(arg0: &mut Membership) : &mut 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier {
        &mut arg0.tier
    }

    // decompiled from Move bytecode v6
}

