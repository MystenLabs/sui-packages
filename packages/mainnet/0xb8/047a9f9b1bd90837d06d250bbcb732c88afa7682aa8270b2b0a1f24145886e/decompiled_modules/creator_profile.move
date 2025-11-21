module 0xb8047a9f9b1bd90837d06d250bbcb732c88afa7682aa8270b2b0a1f24145886e::creator_profile {
    struct CreatorProfile has store, key {
        id: 0x2::object::UID,
        creator: address,
        handle: 0x1::string::String,
        display_name: 0x1::string::String,
        bio: 0x1::string::String,
        avatar_url: 0x1::string::String,
        banner_url: 0x1::string::String,
        tier_ids: vector<0x2::object::ID>,
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

    public entry fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = CreatorProfile{
            id           : 0x2::object::new(arg6),
            creator      : v0,
            handle       : arg0,
            display_name : arg1,
            bio          : arg2,
            avatar_url   : arg3,
            banner_url   : arg4,
            tier_ids     : 0x1::vector::empty<0x2::object::ID>(),
            created_at   : v1,
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
            id      : 0x2::object::new(arg6),
            creator : v0,
        };
        0x2::transfer::transfer<CreatorCap>(v4, v0);
    }

    public fun get_creator(arg0: &CreatorProfile) : address {
        arg0.creator
    }

    public fun get_display_name(arg0: &CreatorProfile) : 0x1::string::String {
        arg0.display_name
    }

    public fun get_handle(arg0: &CreatorProfile) : 0x1::string::String {
        arg0.handle
    }

    public fun get_tier_ids(arg0: &CreatorProfile) : &vector<0x2::object::ID> {
        &arg0.tier_ids
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

    public entry fun update_profile(arg0: &mut CreatorProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.creator == v0, 1);
        arg0.display_name = arg1;
        arg0.bio = arg2;
        arg0.avatar_url = arg3;
        arg0.banner_url = arg4;
        let v1 = ProfileUpdated{
            profile_id : 0x2::object::id<CreatorProfile>(arg0),
            creator    : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ProfileUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

