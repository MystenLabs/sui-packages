module 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::communityLib {
    struct Community has key {
        id: 0x2::object::UID,
        ipfsDoc: 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::IpfsHash,
        documentation: 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::IpfsHash,
        isFrozen: bool,
        tags: 0x2::table::Table<u64, Tag>,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct Tag has store, key {
        id: 0x2::object::UID,
        ipfsDoc: 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::IpfsHash,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct CreateCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    struct UpdateCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    struct SetDocumentationTree has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    struct CreateTagEvent has copy, drop {
        userId: 0x2::object::ID,
        tagKey: u64,
        communityId: 0x2::object::ID,
    }

    struct UpdateTagEvent has copy, drop {
        userId: 0x2::object::ID,
        tagKey: u64,
        communityId: 0x2::object::ID,
    }

    struct FreezeCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    struct UnfreezeCommunityEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
    }

    public fun checkTags(arg0: &Community, arg1: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&mut arg1)) {
            getTag(arg0, *0x1::vector::borrow<u64>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun createCommunity(arg0: &mut 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::UserRolesCollection, arg1: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User>(arg1);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::checkHasRole(arg0, v0, 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::get_action_role_admin(), 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getZeroId());
        let v1 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v1 >= 5, 200);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 1;
            while (v3 < v1) {
                if (v2 != v3) {
                    assert!(0x1::vector::borrow<vector<u8>>(&arg3, v2) != 0x1::vector::borrow<vector<u8>>(&arg3, v3), 201);
                };
                v3 = v3 + 5;
            };
            v2 = v2 + 1;
        };
        let v4 = 0x2::table::new<u64, Tag>(arg4);
        let v5 = 0;
        while (v5 < v1) {
            let v6 = Tag{
                id         : 0x2::object::new(arg4),
                ipfsDoc    : 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsDoc(*0x1::vector::borrow<vector<u8>>(&arg3, v5), 0x1::vector::empty<u8>()),
                properties : 0x2::vec_map::empty<u8, vector<u8>>(),
            };
            0x2::table::add<u64, Tag>(&mut v4, v5 + 1, v6);
            v5 = v5 + 1;
        };
        let v7 = Community{
            id            : 0x2::object::new(arg4),
            ipfsDoc       : 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsDoc(arg2, 0x1::vector::empty<u8>()),
            documentation : 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsDoc(0x1::vector::empty<u8>(), 0x1::vector::empty<u8>()),
            isFrozen      : false,
            tags          : v4,
            properties    : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        let v8 = 0x2::object::id<Community>(&v7);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::setCommunityPermission(arg0, v8, v0);
        let v9 = CreateCommunityEvent{
            userId      : v0,
            communityId : v8,
        };
        0x2::event::emit<CreateCommunityEvent>(v9);
        0x2::transfer::share_object<Community>(v7);
    }

    public entry fun createTag(arg0: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::UserRolesCollection, arg1: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User, arg2: &mut Community, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User>(arg1);
        let v1 = 0x2::object::id<Community>(arg2);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::checkHasRole(arg0, v0, 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::get_action_role_admin_or_community_admin(), v1);
        onlyNotFrozenCommunity(arg2);
        let v2 = 1;
        let v3 = 0x2::table::length<u64, Tag>(&arg2.tags);
        while (v2 <= v3) {
            assert!(0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsHash(0x2::table::borrow<u64, Tag>(&arg2.tags, v2).ipfsDoc) != arg3, 201);
            v2 = v2 + 1;
        };
        let v4 = CreateTagEvent{
            userId      : v0,
            tagKey      : v3 + 1,
            communityId : v1,
        };
        0x2::event::emit<CreateTagEvent>(v4);
        let v5 = Tag{
            id         : 0x2::object::new(arg4),
            ipfsDoc    : 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsDoc(arg3, 0x1::vector::empty<u8>()),
            properties : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::table::add<u64, Tag>(&mut arg2.tags, v3 + 1, v5);
    }

    public entry fun freezeCommunity(arg0: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::UserRolesCollection, arg1: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User, arg2: &mut Community) {
        let v0 = 0x2::object::id<0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User>(arg1);
        let v1 = 0x2::object::id<Community>(arg2);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::checkHasRole(arg0, v0, 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::get_action_role_admin_or_community_admin(), v1);
        onlyNotFrozenCommunity(arg2);
        arg2.isFrozen = true;
        let v2 = FreezeCommunityEvent{
            userId      : v0,
            communityId : v1,
        };
        0x2::event::emit<FreezeCommunityEvent>(v2);
    }

    public fun getMutableTag(arg0: &mut Community, arg1: u64) : &mut Tag {
        assert!(arg1 > 0, 205);
        assert!(0x2::table::length<u64, Tag>(&arg0.tags) >= arg1, 206);
        0x2::table::borrow_mut<u64, Tag>(&mut arg0.tags, arg1)
    }

    public fun getTag(arg0: &Community, arg1: u64) : &Tag {
        assert!(arg1 > 0, 205);
        assert!(0x2::table::length<u64, Tag>(&arg0.tags) >= arg1, 206);
        0x2::table::borrow<u64, Tag>(&arg0.tags, arg1)
    }

    public fun onlyNotFrozenCommunity(arg0: &Community) {
        assert!(!arg0.isFrozen, 202);
    }

    public entry fun unfreezeCommunity(arg0: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::UserRolesCollection, arg1: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User, arg2: &mut Community) {
        let v0 = 0x2::object::id<0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User>(arg1);
        let v1 = 0x2::object::id<Community>(arg2);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::checkHasRole(arg0, v0, 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::get_action_role_admin_or_community_admin(), v1);
        if (!arg2.isFrozen) {
            abort 207
        };
        arg2.isFrozen = false;
        let v2 = UnfreezeCommunityEvent{
            userId      : v0,
            communityId : v1,
        };
        0x2::event::emit<UnfreezeCommunityEvent>(v2);
    }

    public entry fun updateCommunity(arg0: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::UserRolesCollection, arg1: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User, arg2: &mut Community, arg3: vector<u8>) {
        let v0 = 0x2::object::id<0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User>(arg1);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::checkHasRole(arg0, v0, 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::get_action_role_admin_or_community_admin(), 0x2::object::id<Community>(arg2));
        onlyNotFrozenCommunity(arg2);
        arg2.ipfsDoc = 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsDoc(arg3, 0x1::vector::empty<u8>());
        let v1 = UpdateCommunityEvent{
            userId      : v0,
            communityId : 0x2::object::id<Community>(arg2),
        };
        0x2::event::emit<UpdateCommunityEvent>(v1);
    }

    public entry fun updateDocumentationTree(arg0: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::UserRolesCollection, arg1: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User, arg2: &mut Community, arg3: vector<u8>) {
        let v0 = 0x2::object::id<0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User>(arg1);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::checkHasRole(arg0, v0, 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::get_action_role_community_admin(), 0x2::object::id<Community>(arg2));
        onlyNotFrozenCommunity(arg2);
        arg2.documentation = 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsDoc(arg3, 0x1::vector::empty<u8>());
        let v1 = SetDocumentationTree{
            userId      : v0,
            communityId : 0x2::object::id<Community>(arg2),
        };
        0x2::event::emit<SetDocumentationTree>(v1);
    }

    public entry fun updateTag(arg0: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::UserRolesCollection, arg1: &0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User, arg2: &mut Community, arg3: u64, arg4: vector<u8>) {
        let v0 = 0x2::object::id<0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::userLib::User>(arg1);
        let v1 = 0x2::object::id<Community>(arg2);
        0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::checkHasRole(arg0, v0, 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::accessControlLib::get_action_role_admin_or_community_admin(), v1);
        onlyNotFrozenCommunity(arg2);
        getMutableTag(arg2, arg3).ipfsDoc = 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::commonLib::getIpfsDoc(arg4, 0x1::vector::empty<u8>());
        let v2 = UpdateTagEvent{
            userId      : v0,
            tagKey      : arg3,
            communityId : v1,
        };
        0x2::event::emit<UpdateTagEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

