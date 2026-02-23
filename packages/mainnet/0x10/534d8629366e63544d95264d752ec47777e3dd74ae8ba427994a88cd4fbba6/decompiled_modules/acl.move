module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl {
    struct AuthWitness has drop {
        dummy_field: bool,
    }

    struct InterestStableSwapSuperAdmin has key {
        id: 0x2::object::UID,
        new_admin: address,
        deadline: u64,
    }

    struct InterestStableSwapAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct InterestStableSwapACL has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
    }

    public fun destroy(arg0: InterestStableSwapSuperAdmin) {
        let InterestStableSwapSuperAdmin {
            id        : v0,
            new_admin : _,
            deadline  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_admin(arg0: &mut InterestStableSwapACL, arg1: InterestStableSwapAdmin) {
        let InterestStableSwapAdmin { id: v0 } = arg1;
        let v1 = 0x2::object::uid_to_address(&v0);
        if (0x2::vec_set::contains<address>(&arg0.admins, &v1)) {
            let v2 = 0x2::object::uid_to_address(&v0);
            0x2::vec_set::remove<address>(&mut arg0.admins, &v2);
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::remove_admin(0x2::object::uid_to_address(&v0));
        0x2::object::delete(v0);
    }

    public fun finish_transfer(arg0: InterestStableSwapSuperAdmin, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) > arg0.deadline, 6);
        let v0 = arg0.new_admin;
        arg0.new_admin = @0x0;
        arg0.deadline = 18446744073709551615;
        0x2::transfer::transfer<InterestStableSwapSuperAdmin>(arg0, v0);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::finish_super_admin_transfer(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InterestStableSwapSuperAdmin{
            id        : 0x2::object::new(arg0),
            new_admin : @0x0,
            deadline  : 18446744073709551615,
        };
        let v1 = InterestStableSwapACL{
            id     : 0x2::object::new(arg0),
            admins : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<InterestStableSwapACL>(v1);
        0x2::transfer::transfer<InterestStableSwapSuperAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_admin(arg0: &InterestStableSwapACL, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun new_admin(arg0: &mut InterestStableSwapACL, arg1: &InterestStableSwapSuperAdmin, arg2: &mut 0x2::tx_context::TxContext) : InterestStableSwapAdmin {
        let v0 = InterestStableSwapAdmin{id: 0x2::object::new(arg2)};
        0x2::vec_set::insert<address>(&mut arg0.admins, 0x2::object::uid_to_address(&v0.id));
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::new_admin(0x2::object::uid_to_address(&v0.id));
        v0
    }

    public fun revoke(arg0: &mut InterestStableSwapACL, arg1: &InterestStableSwapSuperAdmin, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::remove_admin(arg2);
    }

    public fun sign_in(arg0: &InterestStableSwapACL, arg1: &InterestStableSwapAdmin) : AuthWitness {
        assert!(is_admin(arg0, 0x2::object::uid_to_address(&arg1.id)), 7);
        AuthWitness{dummy_field: false}
    }

    public fun start_transfer(arg0: &mut InterestStableSwapSuperAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 8);
        arg0.deadline = 0x2::tx_context::epoch(arg2) + 3;
        arg0.new_admin = arg1;
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::start_super_admin_transfer(arg1, arg0.deadline);
    }

    // decompiled from Move bytecode v6
}

