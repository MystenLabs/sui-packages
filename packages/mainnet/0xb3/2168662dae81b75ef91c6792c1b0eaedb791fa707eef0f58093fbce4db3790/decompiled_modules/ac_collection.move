module 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::ac_collection {
    struct AcCollection<T0> has store, key {
        id: 0x2::object::UID,
        collection: T0,
    }

    struct AcCollectionWitness has drop {
        dummy_field: bool,
    }

    public fun borrow<T0: store>(arg0: &AcCollection<T0>) : &T0 {
        &arg0.collection
    }

    public fun borrow_mut<T0: store>(arg0: &mut AcCollection<T0>, arg1: &0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::OwnerCap<AcCollectionWitness>) : &mut T0 {
        0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::assert_ownership<AcCollectionWitness>(arg1, 0x2::object::id<AcCollection<T0>>(arg0));
        &mut arg0.collection
    }

    public fun new<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::OwnerCap<AcCollectionWitness>, AcCollection<T0>) {
        let v0 = AcCollection<T0>{
            id         : 0x2::object::new(arg1),
            collection : arg0,
        };
        let v1 = AcCollectionWitness{dummy_field: false};
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<AcCollection<T0>>(&v0));
        (0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::new<AcCollectionWitness>(v1, v2, arg1), v0)
    }

    public fun borrow_mut_uid<T0: store>(arg0: &mut AcCollection<T0>, arg1: &0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::OwnerCap<AcCollectionWitness>) : &mut 0x2::object::UID {
        0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::assert_ownership<AcCollectionWitness>(arg1, 0x2::object::id<AcCollection<T0>>(arg0));
        &mut arg0.id
    }

    public fun destroy<T0: store>(arg0: AcCollection<T0>, arg1: &0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::OwnerCap<AcCollectionWitness>) : T0 {
        0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::assert_ownership<AcCollectionWitness>(arg1, 0x2::object::id<AcCollection<T0>>(&arg0));
        let AcCollection {
            id         : v0,
            collection : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun drop<T0: drop + store>(arg0: AcCollection<T0>, arg1: &0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::OwnerCap<AcCollectionWitness>) {
        0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::assert_ownership<AcCollectionWitness>(arg1, 0x2::object::id<AcCollection<T0>>(&arg0));
        let AcCollection {
            id         : v0,
            collection : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::OwnerCap<AcCollectionWitness> {
        let v0 = AcCollectionWitness{dummy_field: false};
        0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::new<AcCollectionWitness>(v0, 0x1::vector::empty<0x2::object::ID>(), arg0)
    }

    public fun new_with_cap<T0: store>(arg0: T0, arg1: &mut 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::OwnerCap<AcCollectionWitness>, arg2: &mut 0x2::tx_context::TxContext) : AcCollection<T0> {
        let v0 = AcCollection<T0>{
            id         : 0x2::object::new(arg2),
            collection : arg0,
        };
        let v1 = AcCollectionWitness{dummy_field: false};
        0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::owner::add<AcCollectionWitness>(arg1, v1, 0x2::object::id<AcCollection<T0>>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

