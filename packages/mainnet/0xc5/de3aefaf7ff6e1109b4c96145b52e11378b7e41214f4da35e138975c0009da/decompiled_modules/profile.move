module 0xc5de3aefaf7ff6e1109b4c96145b52e11378b7e41214f4da35e138975c0009da::profile {
    struct ReferralRecord has store, key {
        id: 0x2::object::UID,
        referral: address,
        referree: address,
        code: 0x1::string::String,
        expire_at: u64,
    }

    struct ReferralPool has store, key {
        id: 0x2::object::UID,
        referal_list: vector<ReferralRecord>,
    }

    struct UserProfile has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        thumbnail_url: 0x2::url::Url,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        username: 0x1::string::String,
        owner: address,
        invites: u32,
        referral_counts: u32,
    }

    entry fun add_referral_to_record(arg0: &UserProfile, arg1: &UserProfile, arg2: &mut ReferralPool, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralRecord{
            id        : 0x2::object::new(arg5),
            referral  : arg0.owner,
            referree  : arg1.owner,
            code      : arg3,
            expire_at : one_week_from_now(arg4),
        };
        assert!(!0x1::vector::contains<ReferralRecord>(&arg2.referal_list, &v0), 0);
        0x1::vector::push_back<ReferralRecord>(&mut arg2.referal_list, v0);
    }

    entry fun assigning_point_to_referrer(arg0: &mut UserProfile, arg1: &UserProfile, arg2: &ReferralPool, arg3: &mut ReferralRecord, arg4: &0x2::clock::Clock) {
        assert!(arg3.referral == arg0.owner, 1);
        assert!(arg3.referree == arg1.owner, 2);
        assert!(0x1::vector::contains<ReferralRecord>(&arg2.referal_list, arg3), 3);
        assert!(arg3.expire_at > now_in_seconds(arg4), 4);
        arg0.referral_counts = arg0.referral_counts + 1;
        arg3.expire_at = 0;
    }

    entry fun create_profile(arg0: 0x1::ascii::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UserProfile{
            id              : 0x2::object::new(arg2),
            name            : 0x1::string::utf8(b"suiref_profile"),
            thumbnail_url   : 0x2::url::new_unsafe(arg0),
            description     : 0x1::string::utf8(b"this is an onchain badge for reffereal"),
            url             : 0x2::url::new_unsafe(arg0),
            username        : arg1,
            owner           : 0x2::tx_context::sender(arg2),
            invites         : 0,
            referral_counts : 0,
        };
        0x2::transfer::public_transfer<UserProfile>(v0, 0x2::tx_context::sender(arg2));
    }

    entry fun destroy_profile(arg0: UserProfile) {
        let UserProfile {
            id              : v0,
            name            : _,
            thumbnail_url   : _,
            description     : _,
            url             : _,
            username        : _,
            owner           : _,
            invites         : _,
            referral_counts : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralPool{
            id           : 0x2::object::new(arg0),
            referal_list : 0x1::vector::empty<ReferralRecord>(),
        };
        0x2::transfer::public_share_object<ReferralPool>(v0);
    }

    public fun now_in_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun one_week_from_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) + 604800
    }

    // decompiled from Move bytecode v6
}

