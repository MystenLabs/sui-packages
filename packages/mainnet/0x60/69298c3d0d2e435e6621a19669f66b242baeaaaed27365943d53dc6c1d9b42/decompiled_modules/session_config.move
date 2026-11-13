module 0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config {
    struct SessionsConfig has key {
        id: 0x2::object::UID,
        version_watermark: u64,
    }

    struct SessionsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AllowedPoolsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SessionPoolAllowed has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct SessionPoolDisallowed has copy, drop {
        pool_id: 0x2::object::ID,
    }

    public fun admin_allow_pool(arg0: &mut SessionsConfig, arg1: &SessionsAdminCap, arg2: 0x2::object::ID) {
        assert_version(arg0);
        let v0 = AllowedPoolsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AllowedPoolsKey>(&arg0.id, v0)) {
            let v1 = AllowedPoolsKey{dummy_field: false};
            0x2::dynamic_field::add<AllowedPoolsKey, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, v1, 0x2::vec_set::empty<0x2::object::ID>());
        };
        let v2 = AllowedPoolsKey{dummy_field: false};
        0x2::vec_set::insert<0x2::object::ID>(0x2::dynamic_field::borrow_mut<AllowedPoolsKey, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, v2), arg2);
        let v3 = SessionPoolAllowed{pool_id: arg2};
        0x2::event::emit<SessionPoolAllowed>(v3);
    }

    public fun admin_disallow_pool(arg0: &mut SessionsConfig, arg1: &SessionsAdminCap, arg2: 0x2::object::ID) {
        assert_version(arg0);
        assert_pool_allowed(arg0, arg2);
        let v0 = AllowedPoolsKey{dummy_field: false};
        0x2::vec_set::remove<0x2::object::ID>(0x2::dynamic_field::borrow_mut<AllowedPoolsKey, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, v0), &arg2);
        let v1 = SessionPoolDisallowed{pool_id: arg2};
        0x2::event::emit<SessionPoolDisallowed>(v1);
    }

    public fun allowed_pools(arg0: &SessionsConfig) : vector<0x2::object::ID> {
        let v0 = AllowedPoolsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AllowedPoolsKey>(&arg0.id, v0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v1 = AllowedPoolsKey{dummy_field: false};
        *0x2::vec_set::keys<0x2::object::ID>(0x2::dynamic_field::borrow<AllowedPoolsKey, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.id, v1))
    }

    public(friend) fun assert_pool_allowed(arg0: &SessionsConfig, arg1: 0x2::object::ID) {
        let v0 = AllowedPoolsKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<AllowedPoolsKey>(&arg0.id, v0)) {
            let v2 = AllowedPoolsKey{dummy_field: false};
            0x2::vec_set::contains<0x2::object::ID>(0x2::dynamic_field::borrow<AllowedPoolsKey, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.id, v2), &arg1)
        } else {
            false
        };
        assert!(v1, 2);
    }

    public(friend) fun assert_version(arg0: &SessionsConfig) {
        assert!(4 >= arg0.version_watermark, 0);
    }

    public fun bump_version_watermark(arg0: &mut SessionsConfig, arg1: &SessionsAdminCap) {
        let v0 = 4;
        assert!(v0 > arg0.version_watermark, 1);
        arg0.version_watermark = v0;
    }

    fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, SessionsAdminCap) {
        let v0 = SessionsConfig{
            id                : 0x2::object::new(arg0),
            version_watermark : 4,
        };
        0x2::transfer::share_object<SessionsConfig>(v0);
        let v1 = SessionsAdminCap{id: 0x2::object::new(arg0)};
        (id(&v0), v1)
    }

    public fun id(arg0: &SessionsConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = create_and_share(arg0);
        0x2::transfer::public_transfer<SessionsAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun version_watermark(arg0: &SessionsConfig) : u64 {
        arg0.version_watermark
    }

    // decompiled from Move bytecode v7
}

