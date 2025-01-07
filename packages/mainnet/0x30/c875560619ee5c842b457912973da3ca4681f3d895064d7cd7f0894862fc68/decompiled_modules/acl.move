module 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::acl {
    struct StartSuperAdminTransfer has copy, drop, store {
        new_admin: address,
        start: u64,
    }

    struct FinishSuperAdminTransfer has copy, drop, store {
        pos0: address,
    }

    struct NewAdmin has copy, drop, store {
        pos0: address,
    }

    struct RevokeAdmin has copy, drop, store {
        pos0: address,
    }

    struct AuthWitness has drop {
        dummy_field: bool,
    }

    struct SuperAdmin has key {
        id: 0x2::object::UID,
        new_admin: address,
        start: u64,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct ACL has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
    }

    public fun new(arg0: &mut ACL, arg1: &SuperAdmin, arg2: &mut 0x2::tx_context::TxContext) : Admin {
        let v0 = Admin{id: 0x2::object::new(arg2)};
        0x2::vec_set::insert<address>(&mut arg0.admins, 0x2::object::uid_to_address(&v0.id));
        let v1 = NewAdmin{pos0: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<NewAdmin>(v1);
        v0
    }

    public fun destroy_admin(arg0: Admin) {
        let Admin { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_super_admin(arg0: SuperAdmin) {
        let SuperAdmin {
            id        : v0,
            new_admin : _,
            start     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun finish_super_admin_transfer(arg0: SuperAdmin, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) > arg0.start + 3, 9223372620970459139);
        let v0 = arg0.new_admin;
        arg0.new_admin = @0x0;
        arg0.start = 18446744073709551615;
        0x2::transfer::transfer<SuperAdmin>(arg0, v0);
        let v1 = FinishSuperAdminTransfer{pos0: v0};
        0x2::event::emit<FinishSuperAdminTransfer>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdmin{
            id        : 0x2::object::new(arg0),
            new_admin : @0x0,
            start     : 18446744073709551615,
        };
        let v1 = ACL{
            id     : 0x2::object::new(arg0),
            admins : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<ACL>(v1);
        0x2::transfer::transfer<SuperAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_admin(arg0: &ACL, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun new_and_transfer(arg0: &mut ACL, arg1: &SuperAdmin, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Admin>(new(arg0, arg1, arg3), arg2);
    }

    public fun revoke(arg0: &mut ACL, arg1: &SuperAdmin, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        let v0 = RevokeAdmin{pos0: arg2};
        0x2::event::emit<RevokeAdmin>(v0);
    }

    public fun sign_in(arg0: &ACL, arg1: &Admin) : AuthWitness {
        assert!(is_admin(arg0, 0x2::object::uid_to_address(&arg1.id)), 9223372496416538629);
        AuthWitness{dummy_field: false}
    }

    public fun start_super_admin_transfer(arg0: &mut SuperAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 9223372565136146439);
        arg0.start = 0x2::tx_context::epoch(arg2);
        arg0.new_admin = arg1;
        let v0 = StartSuperAdminTransfer{
            new_admin : arg1,
            start     : arg0.start,
        };
        0x2::event::emit<StartSuperAdminTransfer>(v0);
    }

    // decompiled from Move bytecode v6
}

