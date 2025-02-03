module 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::owner {
    struct OwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        of: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun destroy_empty<T0>(arg0: OwnerCap<T0>) {
        let OwnerCap {
            id : v0,
            of : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x1::vector::destroy_empty<0x2::object::ID>(0x2::vec_set::into_keys<0x2::object::ID>(v1));
    }

    public fun new<T0: drop>(arg0: T0, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) : OwnerCap<T0> {
        let v0 = 0x2::vec_set::empty<0x2::object::ID>();
        let v1 = 0;
        while (0x1::vector::length<0x2::object::ID>(&arg1) > v1) {
            0x2::vec_set::insert<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1));
            v1 = v1 + 1;
        };
        OwnerCap<T0>{
            id : 0x2::object::new(arg2),
            of : v0,
        }
    }

    public fun contains<T0: drop>(arg0: &OwnerCap<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.of, &arg1)
    }

    public fun remove<T0: drop>(arg0: &mut OwnerCap<T0>, arg1: T0, arg2: 0x2::object::ID) {
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.of, &arg2)) {
            return
        };
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.of, &arg2);
    }

    public fun add<T0: drop>(arg0: &mut OwnerCap<T0>, arg1: T0, arg2: 0x2::object::ID) {
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.of, &arg2)) {
            return
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.of, arg2);
    }

    public fun assert_ownership<T0: drop>(arg0: &OwnerCap<T0>, arg1: 0x2::object::ID) {
        assert!(contains<T0>(arg0, arg1), 0);
    }

    public fun destroy<T0: drop>(arg0: OwnerCap<T0>) {
        let OwnerCap {
            id : v0,
            of : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun of<T0: drop>(arg0: &OwnerCap<T0>) : vector<0x2::object::ID> {
        *0x2::vec_set::keys<0x2::object::ID>(&arg0.of)
    }

    // decompiled from Move bytecode v6
}

