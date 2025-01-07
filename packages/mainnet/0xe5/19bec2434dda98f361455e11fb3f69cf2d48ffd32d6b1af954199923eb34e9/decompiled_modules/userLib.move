module 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::userLib {
    struct UsersRatingCollection has key {
        id: 0x2::object::UID,
        usersCommunityRating: 0x2::table::Table<0x2::object::ID, UserCommunityRating>,
    }

    struct User has key {
        id: 0x2::object::UID,
        ipfsDoc: 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::IpfsHash,
        followedCommunities: vector<0x2::object::ID>,
        userRatingId: 0x2::object::ID,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct UserCommunityRating has store, key {
        id: 0x2::object::UID,
        userRating: 0x2::vec_map::VecMap<0x2::object::ID, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64>,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct CreateUserEvent has copy, drop {
        userId: 0x2::object::ID,
    }

    struct UpdateUserEvent has copy, drop {
        userId: 0x2::object::ID,
    }

    public entry fun grantRole(arg0: &mut 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::UserRolesCollection, arg1: &User, arg2: 0x2::object::ID, arg3: vector<u8>) {
        0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::grantRole(arg0, 0x2::object::id<User>(arg1), arg2, arg3);
    }

    public entry fun revokeRole(arg0: &mut 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::UserRolesCollection, arg1: &User, arg2: 0x2::object::ID, arg3: vector<u8>) {
        0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::revokeRole(arg0, 0x2::object::id<User>(arg1), arg2, arg3);
    }

    public fun checkActionRole(arg0: &UsersRatingCollection, arg1: &0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::UserRolesCollection, arg2: &User, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u8, arg6: u8) {
        let v0 = 0x2::object::id<User>(arg2);
        if (hasModeratorRole(arg1, v0, arg4)) {
            return
        };
        0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::checkHasRole(arg1, v0, arg6, arg4);
        checkRating(arg0, v0, arg3, arg4, arg5);
    }

    public fun checkRating(arg0: &UsersRatingCollection, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8) {
        let v0 = getUserRating(getUserCommunityRating(arg0, arg1), arg3);
        let (v1, v2) = getRatingForAction(arg1, arg2, arg4);
        let v3 = v1;
        assert!(0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::compare(&v0, &v3) != 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::getLessThan(), v2);
    }

    public entry fun createUser(arg0: &mut UsersRatingCollection, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::isEmptyIpfs(arg1), 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::getErrorInvalidIpfsHash());
        let v0 = UserCommunityRating{
            id         : 0x2::object::new(arg2),
            userRating : 0x2::vec_map::empty<0x2::object::ID, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64>(),
            properties : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        let v1 = User{
            id                  : 0x2::object::new(arg2),
            ipfsDoc             : 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::getIpfsDoc(arg1, 0x1::vector::empty<u8>()),
            followedCommunities : 0x1::vector::empty<0x2::object::ID>(),
            userRatingId        : 0x2::object::id<UserCommunityRating>(&v0),
            properties          : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::table::add<0x2::object::ID, UserCommunityRating>(&mut arg0.usersCommunityRating, 0x2::object::id<User>(&v1), v0);
        let v2 = CreateUserEvent{userId: 0x2::object::id<User>(&v1)};
        0x2::event::emit<CreateUserEvent>(v2);
        0x2::transfer::transfer<User>(v1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun followCommunity(arg0: &mut User, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.followedCommunities, arg1);
    }

    public fun getMutableUserCommunityRating(arg0: &mut UsersRatingCollection, arg1: 0x2::object::ID) : &mut UserCommunityRating {
        0x2::table::borrow_mut<0x2::object::ID, UserCommunityRating>(&mut arg0.usersCommunityRating, arg1)
    }

    fun getRatingForAction(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) : (0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64, u64) {
        let v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::neg_from(300);
        let v1 = if (arg2 == 0) {
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::zero();
            10
        } else if (arg2 == 1) {
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(0);
            11
        } else if (arg2 == 2) {
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(0);
            12
        } else if (arg2 == 3) {
            if (arg0 == arg1) {
                v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(0);
            } else {
                v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(35);
            };
            13
        } else if (arg2 == 4) {
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::neg_from(300);
            14
        } else if (arg2 == 5) {
            assert!(arg0 == arg1, 4);
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::zero();
            15
        } else if (arg2 == 6) {
            assert!(arg0 != arg1, 5);
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(35);
            16
        } else if (arg2 == 8) {
            assert!(arg0 != arg1, 6);
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(35);
            17
        } else if (arg2 == 10) {
            assert!(arg0 != arg1, 7);
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(0);
            18
        } else if (arg2 == 7) {
            assert!(arg0 != arg1, 5);
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(100);
            19
        } else if (arg2 == 9) {
            assert!(arg0 != arg1, 100);
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(100);
            20
        } else if (arg2 == 11) {
            v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(0);
            21
        } else {
            assert!(arg2 == 12, 8);
            22
        };
        (v0, v1)
    }

    public fun getUserCommunityRating(arg0: &UsersRatingCollection, arg1: 0x2::object::ID) : &UserCommunityRating {
        0x2::table::borrow<0x2::object::ID, UserCommunityRating>(&arg0.usersCommunityRating, arg1)
    }

    public(friend) fun getUserFollowedCommunities(arg0: &User) : &vector<0x2::object::ID> {
        &arg0.followedCommunities
    }

    public fun getUserRating(arg0: &UserCommunityRating, arg1: 0x2::object::ID) : 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64 {
        let v0 = 0x2::vec_map::get_idx_opt<0x2::object::ID, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64>(&arg0.userRating, &arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(0)
        } else {
            *0x2::vec_map::get<0x2::object::ID, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64>(&arg0.userRating, &arg1)
        }
    }

    public fun getUserRatingId(arg0: &User) : 0x2::object::ID {
        arg0.userRatingId
    }

    public fun get_action_best_reply() : u8 {
        12
    }

    public fun get_action_cancel_vote() : u8 {
        11
    }

    public fun get_action_delete_item() : u8 {
        5
    }

    public fun get_action_downvote_post() : u8 {
        7
    }

    public fun get_action_downvote_reply() : u8 {
        9
    }

    public fun get_action_edit_item() : u8 {
        4
    }

    public fun get_action_none() : u8 {
        0
    }

    public fun get_action_publication_comment() : u8 {
        3
    }

    public fun get_action_publication_post() : u8 {
        1
    }

    public fun get_action_publication_reply() : u8 {
        2
    }

    public fun get_action_upvote_post() : u8 {
        6
    }

    public fun get_action_upvote_reply() : u8 {
        8
    }

    public fun get_action_vote_comment() : u8 {
        10
    }

    public fun hasModeratorRole(arg0: &0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::UserRolesCollection, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::hasRole(arg0, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::getCommunityRole(0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::get_community_moderator_role(), arg2), arg1) || 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::hasRole(arg0, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::accessControlLib::get_protocol_admin_role(), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UsersRatingCollection{
            id                   : 0x2::object::new(arg0),
            usersCommunityRating : 0x2::table::new<0x2::object::ID, UserCommunityRating>(arg0),
        };
        0x2::transfer::share_object<UsersRatingCollection>(v0);
    }

    public(friend) fun unfollowCommunity(arg0: &mut User, arg1: u64) {
        0x1::vector::remove<0x2::object::ID>(&mut arg0.followedCommunities, arg1);
    }

    public(friend) fun updateRating(arg0: &mut UsersRatingCollection, arg1: 0x2::object::ID, arg2: &mut 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::nftLib::AchievementCollection, arg3: 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::get_bot_id()) {
            return
        };
        let v0 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::zero();
        if (0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::compare(&arg3, &v0) == 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::getEual()) {
            return
        };
        let v1 = getMutableUserCommunityRating(arg0, arg1);
        let v2 = 0x2::vec_map::get_idx_opt<0x2::object::ID, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64>(&mut v1.userRating, &arg4);
        if (0x1::option::is_none<u64>(&v2)) {
            0x2::vec_map::insert<0x2::object::ID, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64>(&mut v1.userRating, arg4, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::from(10));
        };
        let v3 = 0x2::vec_map::get_mut<0x2::object::ID, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::I64>(&mut v1.userRating, &arg4);
        let v4 = *v3;
        *v3 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::add(&v4, &arg3);
        let v5 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::zero();
        let v6 = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::zero();
        if (0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::compare(&arg3, &v5) == 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::getGreaterThan() && 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::compare(v3, &v6) == 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::getGreaterThan()) {
            let v7 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v7, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::nftLib::getAchievementTypeRating());
            0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::nftLib::unlockAchievements(arg2, arg1, arg4, 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::i64Lib::as_u64(v3), v7, arg5);
        };
    }

    public entry fun updateUser(arg0: &mut User, arg1: vector<u8>) {
        assert!(!0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::isEmptyIpfs(arg1), 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::getErrorInvalidIpfsHash());
        arg0.ipfsDoc = 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib::getIpfsDoc(arg1, 0x1::vector::empty<u8>());
        let v0 = UpdateUserEvent{userId: 0x2::object::id<User>(arg0)};
        0x2::event::emit<UpdateUserEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

