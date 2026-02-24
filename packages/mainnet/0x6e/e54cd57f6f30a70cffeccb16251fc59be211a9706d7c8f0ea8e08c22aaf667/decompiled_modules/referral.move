module 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral {
    struct ReferralCreatedEvent has copy, drop {
        referrer: address,
        referee: address,
        timestamp_ms: u64,
        expired_at: u64,
    }

    struct ReferralConfig has store {
        share_percentage_bps: u64,
        program_duration: u64,
        max_cap: u64,
    }

    struct Referral has store {
        referrer_earning: u64,
        referrer: address,
        expired_at: u64,
    }

    public fun referral(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio) : &Referral {
        0x2::dynamic_field::borrow<vector<u8>, Referral>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::uid_borrow(arg0), b"referral")
    }

    public fun add_referral_to_config(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        let v0 = ReferralConfig{
            share_percentage_bps : 500,
            program_duration     : 3144960000,
            max_cap              : 50000000000,
        };
        0x2::dynamic_field::add<vector<u8>, ReferralConfig>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_mut(arg0), b"referral", v0);
    }

    public fun add_referral_to_studio(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: address, arg3: &0x2::clock::Clock) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg1);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg1);
        let v0 = if (!is_referral_exists(arg0)) {
            if (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::start_at(arg0) == 0) {
                0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::end_at(arg0) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 101);
        assert!(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg0) != arg2, 102);
        let v1 = 0x2::clock::timestamp_ms(arg3) + program_duration(arg1);
        let v2 = Referral{
            referrer_earning : 0,
            referrer         : arg2,
            expired_at       : v1,
        };
        0x2::dynamic_field::add<vector<u8>, Referral>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::uid_mut(arg0), b"referral", v2);
        let v3 = ReferralCreatedEvent{
            referrer     : arg2,
            referee      : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            expired_at   : v1,
        };
        0x2::event::emit<ReferralCreatedEvent>(v3);
    }

    public(friend) fun add_referrer_earning(arg0: &mut Referral, arg1: u64) {
        arg0.referrer_earning = arg0.referrer_earning + arg1;
    }

    public fun expired_at(arg0: &Referral) : u64 {
        arg0.expired_at
    }

    public fun is_referral_exists(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::uid_borrow(arg0), b"referral")
    }

    public fun max_cap(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config) : u64 {
        0x2::dynamic_field::borrow<vector<u8>, ReferralConfig>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_borrow(arg0), b"referral").max_cap
    }

    public fun program_duration(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config) : u64 {
        0x2::dynamic_field::borrow<vector<u8>, ReferralConfig>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_borrow(arg0), b"referral").program_duration
    }

    public(friend) fun referral_mut(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio) : &mut Referral {
        0x2::dynamic_field::borrow_mut<vector<u8>, Referral>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::uid_mut(arg0), b"referral")
    }

    public fun referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public fun referrer_earning(arg0: &Referral) : u64 {
        arg0.referrer_earning
    }

    public fun share_percentage_bps(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config) : u64 {
        0x2::dynamic_field::borrow<vector<u8>, ReferralConfig>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_borrow(arg0), b"referral").share_percentage_bps
    }

    public fun update_max_cap(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u64) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x2::dynamic_field::borrow_mut<vector<u8>, ReferralConfig>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_mut(arg0), b"referral").max_cap = arg2;
    }

    public fun update_program_duration(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u64) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x2::dynamic_field::borrow_mut<vector<u8>, ReferralConfig>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_mut(arg0), b"referral").program_duration = arg2;
    }

    public fun update_share_percentage_bps(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u64) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x2::dynamic_field::borrow_mut<vector<u8>, ReferralConfig>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_mut(arg0), b"referral").share_percentage_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

