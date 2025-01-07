module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ScaleAdminCap has store, key {
        id: 0x2::object::UID,
        object_id: 0x2::object::ID,
        admin: address,
        member: 0x2::vec_set::VecSet<address>,
    }

    public fun add_admin_member(arg0: &mut ScaleAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_a_super(arg0, &v0), 102);
        add_admin_member_(arg0, &arg1);
    }

    public fun add_admin_member_(arg0: &mut ScaleAdminCap, arg1: &address) {
        if (*arg1 == arg0.admin) {
            return
        };
        assert!(0x2::vec_set::size<address>(&arg0.member) < (5 as u64), 101);
        0x2::vec_set::insert<address>(&mut arg0.member, *arg1);
    }

    public fun create_scale_admin(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScaleAdminCap{
            id        : 0x2::object::new(arg1),
            object_id : arg0,
            admin     : 0x2::tx_context::sender(arg1),
            member    : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<ScaleAdminCap>(v0);
    }

    public fun get_scale_admin_mum(arg0: &ScaleAdminCap) : u64 {
        0x2::vec_set::size<address>(&arg0.member)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_a_super(arg0: &ScaleAdminCap, arg1: &address) : bool {
        arg0.admin == *arg1
    }

    public fun is_admin(arg0: &ScaleAdminCap, arg1: &address, arg2: 0x2::object::ID) : bool {
        arg0.object_id == arg2 && (arg0.admin == *arg1 || 0x2::vec_set::contains<address>(&arg0.member, arg1))
    }

    public fun is_admin_member(arg0: &ScaleAdminCap, arg1: &address, arg2: 0x2::object::ID) : bool {
        0x2::vec_set::contains<address>(&arg0.member, arg1) && arg0.object_id == arg2
    }

    public fun is_super_admin(arg0: &ScaleAdminCap, arg1: &address, arg2: 0x2::object::ID) : bool {
        arg0.admin == *arg1 && arg0.object_id == arg2
    }

    public fun remove_admin_member(arg0: &mut ScaleAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_a_super(arg0, &v0), 102);
        remove_admin_member_(arg0, &arg1);
    }

    public fun remove_admin_member_(arg0: &mut ScaleAdminCap, arg1: &address) {
        0x2::vec_set::remove<address>(&mut arg0.member, arg1);
    }

    // decompiled from Move bytecode v6
}

