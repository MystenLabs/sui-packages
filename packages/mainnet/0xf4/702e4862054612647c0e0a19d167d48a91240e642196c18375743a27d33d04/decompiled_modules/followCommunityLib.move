module 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::followCommunityLib {
    struct FollowCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    struct UnfollowCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    public entry fun followCommunity(arg0: &mut 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User, arg1: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::Community) {
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::onlyNotFrozenCommunity(arg1);
        let v0 = 0;
        let v1 = 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::Community>(arg1);
        let v2 = 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::getUserFollowedCommunities(arg0);
        while (v0 < 0x1::vector::length<0x2::object::ID>(v2)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(v2, v0) != v1, 11);
            v0 = v0 + 1;
        };
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::followCommunity(arg0, v1);
        let v3 = FollowCommunityEvent{
            userId      : 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User>(arg0),
            communityId : v1,
        };
        0x2::event::emit<FollowCommunityEvent>(v3);
    }

    public entry fun unfollowCommunity(arg0: &mut 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User, arg1: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::Community) {
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::onlyNotFrozenCommunity(arg1);
        let v0 = 0;
        let v1 = 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::Community>(arg1);
        let v2 = 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::getUserFollowedCommunities(arg0);
        while (v0 < 0x1::vector::length<0x2::object::ID>(v2)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v2, v0) == v1) {
                0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::unfollowCommunity(arg0, v0);
                let v3 = UnfollowCommunityEvent{
                    userId      : 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User>(arg0),
                    communityId : v1,
                };
                0x2::event::emit<UnfollowCommunityEvent>(v3);
                return
            };
            v0 = v0 + 1;
        };
        abort 12
    }

    // decompiled from Move bytecode v6
}

