module 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt {
    struct StratsReceipt {
        issued_to: 0x2::object::ID,
        remove_access: 0x1::option::Option<0x2::object::ID>,
        data: 0x2::bag::Bag,
    }

    public fun add_data<T0: copy + drop + store, T1: store>(arg0: &mut StratsReceipt, arg1: T0, arg2: T1) {
        0x2::bag::add<T0, T1>(&mut arg0.data, arg1, arg2);
    }

    public fun borrow_data<T0: copy + drop + store, T1: store, T2: key>(arg0: &StratsReceipt, arg1: &T2, arg2: T0) : &T1 {
        let v0 = if (0x2::object::id<T2>(arg1) == arg0.issued_to) {
            true
        } else {
            let v1 = 0x2::object::id<T2>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.remove_access)
        };
        assert!(v0, 0);
        0x2::bag::borrow<T0, T1>(&arg0.data, arg2)
    }

    public fun borrow_data_mut<T0: copy + drop + store, T1: store, T2: key>(arg0: &mut StratsReceipt, arg1: &T2, arg2: T0) : &mut T1 {
        let v0 = if (0x2::object::id<T2>(arg1) == arg0.issued_to) {
            true
        } else {
            let v1 = 0x2::object::id<T2>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.remove_access)
        };
        assert!(v0, 0);
        0x2::bag::borrow_mut<T0, T1>(&mut arg0.data, arg2)
    }

    public fun burn(arg0: StratsReceipt) {
        let StratsReceipt {
            issued_to     : _,
            remove_access : _,
            data          : v2,
        } = arg0;
        0x2::bag::destroy_empty(v2);
    }

    public fun issue<T0: key>(arg0: &T0, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) : StratsReceipt {
        StratsReceipt{
            issued_to     : 0x2::object::id<T0>(arg0),
            remove_access : arg1,
            data          : 0x2::bag::new(arg2),
        }
    }

    public fun remove_data<T0: copy + drop + store, T1: store, T2: key>(arg0: &mut StratsReceipt, arg1: &T2, arg2: T0) : T1 {
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

