module 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set {
    fun borrow<T0: copy + drop + store, T1: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : &0x2::vec_set::VecSet<T1> {
        0x2::dynamic_field::borrow<T0, 0x2::vec_set::VecSet<T1>>(arg0, arg1)
    }

    fun borrow_mut<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) : &mut 0x2::vec_set::VecSet<T1> {
        0x2::dynamic_field::borrow_mut<T0, 0x2::vec_set::VecSet<T1>>(arg0, arg1)
    }

    public fun add<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1, arg3: u64) {
        if (!0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            0x2::dynamic_field::add<T0, 0x2::vec_set::VecSet<T1>>(arg0, arg1, 0x2::vec_set::empty<T1>());
        };
        let v0 = borrow_mut<T0, T1>(arg0, arg1);
        assert!(!0x2::vec_set::contains<T1>(v0, &arg2), 0);
        assert!(0x2::vec_set::length<T1>(v0) < arg3, 2);
        0x2::vec_set::insert<T1>(v0, arg2);
    }

    public fun exists<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : bool {
        0x2::dynamic_field::exists<T0>(arg0, arg1)
    }

    public fun remove<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        assert!(0x2::dynamic_field::exists<T0>(arg0, arg1), 1);
        let v0 = borrow_mut<T0, T1>(arg0, arg1);
        assert!(0x2::vec_set::contains<T1>(v0, &arg2), 1);
        0x2::vec_set::remove<T1>(v0, &arg2);
        if (0x2::vec_set::is_empty<T1>(v0)) {
            0x2::dynamic_field::remove<T0, 0x2::vec_set::VecSet<T1>>(arg0, arg1);
        };
    }

    public fun contains<T0: copy + drop + store, T1: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0, arg2: &T1) : bool {
        if (!0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            return false
        };
        0x2::vec_set::contains<T1>(borrow<T0, T1>(arg0, arg1), arg2)
    }

    public fun keys<T0: copy + drop + store, T1: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : vector<T1> {
        if (!0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            return 0x1::vector::empty<T1>()
        };
        *0x2::vec_set::keys<T1>(borrow<T0, T1>(arg0, arg1))
    }

    public fun clear<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) {
        if (0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            0x2::dynamic_field::remove<T0, 0x2::vec_set::VecSet<T1>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

