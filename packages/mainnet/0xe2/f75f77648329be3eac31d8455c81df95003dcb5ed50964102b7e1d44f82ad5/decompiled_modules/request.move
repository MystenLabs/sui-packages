module 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request {
    struct Request<T0> {
        approvals: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        data: T0,
    }

    public fun approvals<T0>(arg0: &Request<T0>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.approvals
    }

    public fun approve<T0, T1: drop>(arg0: &mut Request<T0>, arg1: T1) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.approvals, 0x1::type_name::with_defining_ids<T1>());
    }

    public fun data<T0>(arg0: &Request<T0>) : &T0 {
        &arg0.data
    }

    public(friend) fun new<T0>(arg0: T0) : Request<T0> {
        Request<T0>{
            approvals : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            data      : arg0,
        }
    }

    public(friend) fun resolve<T0>(arg0: Request<T0>, arg1: 0x2::vec_set::VecSet<0x1::type_name::TypeName>) : T0 {
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.approvals) == 0x2::vec_set::length<0x1::type_name::TypeName>(&arg1), 13835339727827501059);
        let v0 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.approvals);
        let v1 = &v0;
        let v2 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg1);
        let v3 = &v2;
        let v4 = 0x1::vector::length<0x1::type_name::TypeName>(v1);
        assert!(v4 == 0x1::vector::length<0x1::type_name::TypeName>(v3), 13906834380501811199);
        let v5 = 0;
        while (v5 < v4) {
            assert!(0x1::vector::borrow<0x1::type_name::TypeName>(v1, v5) == 0x1::vector::borrow<0x1::type_name::TypeName>(v3, v5), 13835058261440593921);
            v5 = v5 + 1;
        };
        let Request {
            approvals : _,
            data      : v7,
        } = arg0;
        v7
    }

    // decompiled from Move bytecode v7
}

