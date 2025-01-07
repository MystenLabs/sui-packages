module 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin {
    struct Manage has key {
        id: 0x2::object::UID,
        supper: address,
        admin: 0x2::vec_set::VecSet<address>,
    }

    public entry fun remove(arg0: &mut Manage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 0);
        if (!0x2::vec_set::contains<address>(&arg0.admin, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.admin, &arg1);
        };
    }

    public entry fun add(arg0: &mut Manage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 0);
        if (!0x2::vec_set::contains<address>(&arg0.admin, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.admin, arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Manage{
            id     : 0x2::object::new(arg0),
            supper : 0x2::tx_context::sender(arg0),
            admin  : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Manage>(v0);
    }

    public fun is_admin(arg0: &mut Manage, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        v0 == arg0.supper || 0x2::vec_set::contains<address>(&arg0.admin, &v0)
    }

    // decompiled from Move bytecode v6
}

