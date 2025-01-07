module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    public fun admin_cap_new(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap {
        assert!(0x2::package::from_package<ADMIN>(arg0), 0);
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::new(arg1)
    }

    public fun benefit_new(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: 0x1::string::String, arg2: 0x1::option::Option<bool>, arg3: 0x1::option::Option<u64>) : 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::new(arg1, arg2, arg3)
    }

    public fun benefit_vec(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: vector<0x1::string::String>, arg2: vector<0x1::option::Option<bool>>, arg3: vector<0x1::option::Option<u64>>) : vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        let v1 = 0;
        assert!(v0 == 0x1::vector::length<0x1::option::Option<u64>>(&arg3), 1);
        assert!(v0 == 0x1::vector::length<0x1::option::Option<bool>>(&arg2), 1);
        let v2 = 0x1::vector::empty<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>();
        while (v1 < v0) {
            0x1::vector::push_back<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>(&mut v2, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::new(*0x1::vector::borrow<0x1::string::String>(&arg1, v1), *0x1::vector::borrow<0x1::option::Option<bool>>(&arg2, v1), *0x1::vector::borrow<0x1::option::Option<u64>>(&arg3, v1)));
            v1 = v1 + 1;
        };
        v2
    }

    public fun drop(arg0: 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap) {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::drop(arg0);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ADMIN>(arg0, arg1);
    }

    public fun membership_create_and_share(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::Profile, arg2: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::Space, arg3: 0x1::string::String, arg4: bool, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::share(0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun membership_drop(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::Membership) {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::drop(arg1);
    }

    public fun membership_update_active(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: &mut 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::Membership, arg2: bool) {
        *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::active_mut(arg1) = arg2;
    }

    public fun membership_update_points(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: &mut 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::Membership, arg2: u64) {
        *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::points_mut(arg1) = arg2;
    }

    public fun membership_update_status(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: &mut 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::Membership, arg2: 0x1::string::String) {
        *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::status_mut(arg1) = arg2;
    }

    public fun membership_update_tier(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: &mut 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::Membership, arg2: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::Space, arg3: 0x1::string::String) {
        assert!(0x2::linked_table::contains<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::tiers(arg2), arg3), 2);
        *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::membership::tier_mut(arg1) = *0x2::linked_table::borrow<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::tiers(arg2), arg3);
    }

    public fun profile_create_share_and_transfer_cap(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::new(arg2, arg3, arg4);
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::share(v0);
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile_cap::transfer(v1, arg1);
    }

    public fun profile_drop(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::Profile) {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::drop(arg1);
    }

    public fun profile_update_points(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: &mut 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::Profile, arg2: u64) {
        *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::profile::points_mut(arg1) = arg2;
    }

    public fun space_create_and_share(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: 0x1::string::String, arg2: vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::share(0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::new(arg1, arg2, arg3));
    }

    public fun space_drop(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::Space) {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space::drop(arg1);
    }

    public fun tier_new(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>) : 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier {
        0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::new(arg1, arg2, arg3)
    }

    public fun tier_vec(arg0: &0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::admin_cap::AdminCap, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>>) : vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        let v1 = 0;
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 1);
        assert!(v0 == 0x1::vector::length<vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>>(&arg3), 1);
        let v2 = 0x1::vector::empty<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>();
        while (v1 < v0) {
            0x1::vector::push_back<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(&mut v2, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::new(*0x1::vector::borrow<0x1::string::String>(&arg1, v1), *0x1::vector::borrow<0x1::string::String>(&arg2, v1), *0x1::vector::borrow<vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>>(&arg3, v1)));
            v1 = v1 + 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

