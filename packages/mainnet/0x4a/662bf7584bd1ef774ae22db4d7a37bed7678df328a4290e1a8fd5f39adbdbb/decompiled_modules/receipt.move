module 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt {
    struct PermissionedReceipt {
        issued_to: 0x2::object::ID,
        remove_access: 0x1::option::Option<0x2::object::ID>,
        data: 0x2::bag::Bag,
    }

    public fun add_data<T0: copy + drop + store, T1: store, T2: key>(arg0: &mut PermissionedReceipt, arg1: &T2, arg2: T0, arg3: T1) {
        let v0 = if (0x2::object::id<T2>(arg1) == arg0.issued_to) {
            true
        } else {
            let v1 = 0x2::object::id<T2>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.remove_access)
        };
        assert!(v0, 0);
        0x2::bag::add<T0, T1>(&mut arg0.data, arg2, arg3);
    }

    public fun borrow_data<T0: copy + drop + store, T1: store, T2: key>(arg0: &PermissionedReceipt, arg1: &T2, arg2: T0) : &T1 {
        let v0 = if (0x2::object::id<T2>(arg1) == arg0.issued_to) {
            true
        } else {
            let v1 = 0x2::object::id<T2>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.remove_access)
        };
        assert!(v0, 0);
        0x2::bag::borrow<T0, T1>(&arg0.data, arg2)
    }

    public fun borrow_data_mut<T0: copy + drop + store, T1: store, T2: key>(arg0: &mut PermissionedReceipt, arg1: &T2, arg2: T0) : &mut T1 {
        let v0 = if (0x2::object::id<T2>(arg1) == arg0.issued_to) {
            true
        } else {
            let v1 = 0x2::object::id<T2>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.remove_access)
        };
        assert!(v0, 0);
        0x2::bag::borrow_mut<T0, T1>(&mut arg0.data, arg2)
    }

    public fun burn(arg0: PermissionedReceipt) {
        let PermissionedReceipt {
            issued_to     : _,
            remove_access : _,
            data          : v2,
        } = arg0;
        0x2::bag::destroy_empty(v2);
    }

    public fun issue<T0: key>(arg0: &T0, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) : PermissionedReceipt {
        PermissionedReceipt{
            issued_to     : 0x2::object::id<T0>(arg0),
            remove_access : arg1,
            data          : 0x2::bag::new(arg2),
        }
    }

    public fun remove_data<T0: copy + drop + store, T1: store, T2: key>(arg0: &mut PermissionedReceipt, arg1: &T2, arg2: T0) : T1 {
        let v0 = if (0x2::object::id<T2>(arg1) == arg0.issued_to) {
            true
        } else {
            let v1 = 0x2::object::id<T2>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.remove_access)
        };
        assert!(v0, 0);
        0x2::bag::remove<T0, T1>(&mut arg0.data, arg2)
    }

    // decompiled from Move bytecode v6
}

