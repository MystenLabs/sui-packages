module 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community {
    struct Community has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    struct CommunityCap has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
    }

    struct PermissionType<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        addr_set: 0x2::vec_set::VecSet<address>,
    }

    struct PermissionTypeKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
    }

    struct CommunityManager has copy, drop, store {
        dummy_field: bool,
    }

    struct ItemManager has copy, drop, store {
        dummy_field: bool,
    }

    struct MembershipManager has copy, drop, store {
        dummy_field: bool,
    }

    struct MissionManager has copy, drop, store {
        dummy_field: bool,
    }

    struct MarketManager has copy, drop, store {
        dummy_field: bool,
    }

    struct TypeKey<phantom T0: copy + drop + store> has copy, drop, store {
        type_name: 0x1::string::String,
    }

    struct ConfigType has copy, drop, store {
        content: 0x1::string::String,
    }

    entry fun create_community(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_community(arg0);
        0x2::transfer::share_object<Community>(v0);
        0x2::transfer::transfer<CommunityCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun get_mut_uid(arg0: &mut Community) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun get_uid(arg0: &Community) : &0x2::object::UID {
        &arg0.id
    }

    public fun grant_permission<T0: copy + drop + store>(arg0: &mut Community, arg1: &mut CommunityCap, arg2: address) {
        let v0 = 0x2::object::id<Community>(arg0);
        assert!(v0 == arg1.community_id, 13906834457811222527);
        let v1 = PermissionTypeKey<T0>{community_id: v0};
        if (!0x2::dynamic_field::exists_<PermissionTypeKey<T0>>(&arg0.id, v1)) {
            let v2 = 0x2::vec_set::empty<address>();
            0x2::vec_set::insert<address>(&mut v2, arg2);
            let v3 = PermissionTypeKey<T0>{community_id: v0};
            let v4 = PermissionType<T0>{
                community_id : v0,
                addr_set     : v2,
            };
            0x2::dynamic_field::add<PermissionTypeKey<T0>, PermissionType<T0>>(&mut arg0.id, v3, v4);
        } else {
            let v5 = PermissionTypeKey<T0>{community_id: v0};
            0x2::vec_set::insert<address>(&mut 0x2::dynamic_field::borrow_mut<PermissionTypeKey<T0>, PermissionType<T0>>(&mut arg0.id, v5).addr_set, arg2);
        };
    }

    public fun has_permission<T0: copy + drop + store>(arg0: &Community, arg1: address) : bool {
        let v0 = 0x2::object::id<Community>(arg0);
        let v1 = PermissionTypeKey<T0>{community_id: v0};
        if (!0x2::dynamic_field::exists_<PermissionTypeKey<T0>>(&arg0.id, v1)) {
            return false
        };
        let v2 = PermissionTypeKey<T0>{community_id: v0};
        0x2::vec_set::contains<address>(&0x2::dynamic_field::borrow<PermissionTypeKey<T0>, PermissionType<T0>>(&arg0.id, v2).addr_set, &arg1)
    }

    public fun new_community(arg0: &mut 0x2::tx_context::TxContext) : (Community, CommunityCap) {
        let v0 = Community{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            version : 0,
        };
        let v1 = CommunityCap{
            id           : 0x2::object::new(arg0),
            community_id : 0x2::object::id<Community>(&v0),
        };
        (v0, v1)
    }

    public fun new_config_type(arg0: &mut Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission<CommunityManager>(arg0, 0x2::tx_context::sender(arg3)), 2);
        let v0 = TypeKey<ConfigType>{type_name: arg1};
        assert!(!0x2::dynamic_field::exists_<TypeKey<ConfigType>>(&arg0.id, v0), 13906834930257625087);
        let v1 = TypeKey<ConfigType>{type_name: arg1};
        let v2 = ConfigType{content: arg2};
        0x2::dynamic_field::add<TypeKey<ConfigType>, ConfigType>(&mut arg0.id, v1, v2);
        update_version(arg0);
    }

    public fun revoke_permission<T0: copy + drop + store>(arg0: &mut Community, arg1: &mut CommunityCap, arg2: address) {
        let v0 = 0x2::object::id<Community>(arg0);
        assert!(v0 == arg1.community_id, 13906834590955208703);
        let v1 = PermissionTypeKey<T0>{community_id: v0};
        if (!0x2::dynamic_field::exists_<PermissionTypeKey<T0>>(&arg0.id, v1)) {
            return
        };
        let v2 = PermissionTypeKey<T0>{community_id: v0};
        let v3 = 0x2::dynamic_field::borrow_mut<PermissionTypeKey<T0>, PermissionType<T0>>(&mut arg0.id, v2);
        if (0x2::vec_set::contains<address>(&v3.addr_set, &arg2)) {
            0x2::vec_set::remove<address>(&mut v3.addr_set, &arg2);
        };
        let v4 = PermissionTypeKey<T0>{community_id: v0};
        if (0x2::vec_set::is_empty<address>(&0x2::dynamic_field::borrow<PermissionTypeKey<T0>, PermissionType<T0>>(&arg0.id, v4).addr_set)) {
            let v5 = PermissionTypeKey<T0>{community_id: v0};
            0x2::dynamic_field::remove<PermissionTypeKey<T0>, PermissionType<T0>>(&mut arg0.id, v5);
        };
    }

    public fun update_config_type(arg0: &mut Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission<CommunityManager>(arg0, 0x2::tx_context::sender(arg3)), 2);
        let v0 = TypeKey<ConfigType>{type_name: arg1};
        assert!(0x2::dynamic_field::exists_<TypeKey<ConfigType>>(&arg0.id, v0), 13906834998977101823);
        let v1 = TypeKey<ConfigType>{type_name: arg1};
        0x2::dynamic_field::borrow_mut<TypeKey<ConfigType>, ConfigType>(&mut arg0.id, v1).content = arg2;
    }

    public(friend) fun update_version(arg0: &mut Community) {
        arg0.version = arg0.version + 1;
    }

    // decompiled from Move bytecode v6
}

