module 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::followCommunityLib {
    struct FollowCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    struct UnfollowCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    public entry fun followCommunity(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community) {
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::onlyNotFrozenCommunity(arg1);
        let v0 = 0;
        let v1 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community>(arg1);
        let v2 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::getUserFollowedCommunities(arg0);
        while (v0 < 0x1::vector::length<0x2::object::ID>(v2)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(v2, v0) != v1, 11);
            v0 = v0 + 1;
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::followCommunity(arg0, v1);
        let v3 = FollowCommunityEvent{
            userId      : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg0),
            communityId : v1,
        };
        0x2::event::emit<FollowCommunityEvent>(v3);
    }

    public entry fun unfollowCommunity(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community) {
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::onlyNotFrozenCommunity(arg1);
        let v0 = 0;
        let v1 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community>(arg1);
        let v2 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::getUserFollowedCommunities(arg0);
        while (v0 < 0x1::vector::length<0x2::object::ID>(v2)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v2, v0) == v1) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::unfollowCommunity(arg0, v0);
                let v3 = UnfollowCommunityEvent{
                    userId      : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg0),
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

