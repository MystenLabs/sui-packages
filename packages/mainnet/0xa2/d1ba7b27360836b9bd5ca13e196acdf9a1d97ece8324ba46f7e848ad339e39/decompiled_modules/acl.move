module 0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::acl {
    struct AdminWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct SuperAdmin<phantom T0> has key {
        id: 0x2::object::UID,
        new_admin: address,
        start: u64,
    }

    struct Admin<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct ACL<phantom T0> has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdmin<T0>{
            id        : 0x2::object::new(arg0),
            new_admin : @0x0,
            start     : 18446744073709551615,
        };
        let v1 = ACL<T0>{
            id     : 0x2::object::new(arg0),
            admins : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<ACL<T0>>(v1);
        0x2::transfer::transfer<SuperAdmin<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun destroy<T0>(arg0: SuperAdmin<T0>) {
        let SuperAdmin {
            id        : v0,
            new_admin : _,
            start     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_admin<T0>(arg0: &mut ACL<T0>, arg1: Admin<T0>) {
        let Admin { id: v0 } = arg1;
        let v1 = 0x2::object::uid_to_address(&v0);
        if (0x2::vec_set::contains<address>(&arg0.admins, &v1)) {
            let v2 = 0x2::object::uid_to_address(&v0);
            0x2::vec_set::remove<address>(&mut arg0.admins, &v2);
        };
        0x2::object::delete(v0);
    }

    public fun finish_transfer<T0>(arg0: SuperAdmin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) > arg0.start + 3, 0);
        let v0 = arg0.new_admin;
        arg0.new_admin = @0x0;
        arg0.start = 18446744073709551615;
        0x2::transfer::transfer<SuperAdmin<T0>>(arg0, v0);
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::events::finish_super_admin_transfer(v0);
    }

    public fun is_admin<T0>(arg0: &ACL<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun new_admin<T0>(arg0: &mut ACL<T0>, arg1: &SuperAdmin<T0>, arg2: &mut 0x2::tx_context::TxContext) : Admin<T0> {
        let v0 = Admin<T0>{id: 0x2::object::new(arg2)};
        0x2::vec_set::insert<address>(&mut arg0.admins, 0x2::object::uid_to_address(&v0.id));
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::events::new_admin(0x2::object::uid_to_address(&v0.id));
        v0
    }

    public fun new_and_transfer<T0>(arg0: &mut ACL<T0>, arg1: &SuperAdmin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Admin<T0>>(new_admin<T0>(arg0, arg1, arg3), arg2);
    }

    public fun revoke<T0>(arg0: &mut ACL<T0>, arg1: &SuperAdmin<T0>, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::events::revoke_admin(arg2);
    }

    public fun sign_in<T0>(arg0: &ACL<T0>, arg1: &Admin<T0>) : AdminWitness<T0> {
        assert!(is_admin<T0>(arg0, 0x2::object::uid_to_address(&arg1.id)), 2);
        AdminWitness<T0>{dummy_field: false}
    }

    public fun start_transfer<T0>(arg0: &mut SuperAdmin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 1);
        arg0.start = 0x2::tx_context::epoch(arg2);
        arg0.new_admin = arg1;
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::events::start_super_admin_transfer(arg1, arg0.start);
    }

    // decompiled from Move bytecode v6
}

