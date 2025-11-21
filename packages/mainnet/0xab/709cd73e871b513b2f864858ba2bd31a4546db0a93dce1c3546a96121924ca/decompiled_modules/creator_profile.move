module 0xab709cd73e871b513b2f864858ba2bd31a4546db0a93dce1c3546a96121924ca::creator_profile {
    struct CreatorProfile has store, key {
        id: 0x2::object::UID,
        creator: address,
        user_profile_id: 0x2::object::ID,
        handle: 0x1::string::String,
        banner_url: 0x1::string::String,
        tier_ids: vector<0x2::object::ID>,
        total_subscribers: u64,
        total_earnings: u64,
        created_at: u64,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        creator: address,
        handle: 0x1::string::String,
        timestamp: u64,
    }

    struct ProfileUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        creator: address,
        timestamp: u64,
    }

    struct TierLinked has copy, drop {
        profile_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun add_earnings(arg0: &mut CreatorProfile, arg1: u64) {
        arg0.total_earnings = arg0.total_earnings + arg1;
    }

    public entry fun create_profile(arg0: &0xab709cd73e871b513b2f864858ba2bd31a4546db0a93dce1c3546a96121924ca::user_profile::UserProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0xab709cd73e871b513b2f864858ba2bd31a4546db0a93dce1c3546a96121924ca::user_profile::get_user(arg0) == v0, 1);
        assert!(0xab709cd73e871b513b2f864858ba2bd31a4546db0a93dce1c3546a96121924ca::user_profile::is_creator(arg0), 4);
        let v2 = CreatorProfile{
            id                : 0x2::object::new(arg4),
            creator           : v0,
            user_profile_id   : 0x2::object::id<0xab709cd73e871b513b2f864858ba2bd31a4546db0a93dce1c3546a96121924ca::user_profile::UserProfile>(arg0),
            handle            : arg1,
            banner_url        : arg2,
            tier_ids          : 0x1::vector::empty<0x2::object::ID>(),
            total_subscribers : 0,
            total_earnings    : 0,
            created_at        : v1,
        };
        let v3 = ProfileCreated{
            profile_id : 0x2::object::id<CreatorProfile>(&v2),
            creator    : v0,
            handle     : v2.handle,
            timestamp  : v1,
        };
        0x2::event::emit<ProfileCreated>(v3);
        0x2::transfer::public_transfer<CreatorProfile>(v2, v0);
        let v4 = CreatorCap{
            id      : 0x2::object::new(arg4),
            creator : v0,
        };
        0x2::transfer::transfer<CreatorCap>(v4, v0);
    }

    public fun get_banner_url(arg0: &CreatorProfile) : 0x1::string::String {
        arg0.banner_url
    }

    public fun get_creator(arg0: &CreatorProfile) : address {
        arg0.creator
    }

    public fun get_handle(arg0: &CreatorProfile) : 0x1::string::String {
        arg0.handle
    }

    public fun get_tier_ids(arg0: &CreatorProfile) : &vector<0x2::object::ID> {
        &arg0.tier_ids
    }

    public fun get_total_earnings(arg0: &CreatorProfile) : u64 {
        arg0.total_earnings
    }

    public fun get_total_subscribers(arg0: &CreatorProfile) : u64 {
        arg0.total_subscribers
    }

    public fun get_user_profile_id(arg0: &CreatorProfile) : 0x2::object::ID {
        arg0.user_profile_id
    }

    public fun increment_subscriber_count(arg0: &mut CreatorProfile) {
        arg0.total_subscribers = arg0.total_subscribers + 1;
    }

    public entry fun link_tier(arg0: &mut CreatorProfile, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.tier_ids, arg1);
        let v0 = TierLinked{
            profile_id : 0x2::object::id<CreatorProfile>(arg0),
            tier_id    : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TierLinked>(v0);
    }

    public entry fun update_profile(arg0: &mut CreatorProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.creator == v0, 1);
        arg0.handle = arg1;
        arg0.banner_url = arg2;
        let v1 = ProfileUpdated{
            profile_id : 0x2::object::id<CreatorProfile>(arg0),
            creator    : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProfileUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

