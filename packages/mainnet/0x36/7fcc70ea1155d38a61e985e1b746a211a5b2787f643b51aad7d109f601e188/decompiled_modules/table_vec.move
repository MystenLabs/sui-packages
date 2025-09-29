module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec {
    struct TableVec<phantom T0: store> has drop, store {
        contents: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::Table<u64, T0>,
    }

    public fun empty<T0: store>(arg0: &address) : TableVec<T0> {
        TableVec<T0>{contents: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::new<u64, T0>(arg0)}
    }

    public fun length<T0: store>(arg0: &TableVec<T0>) : u64 {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::length<u64, T0>(&arg0.contents)
    }

    public fun borrow<T0: store>(arg0: &0x2::object::UID, arg1: &TableVec<T0>, arg2: u64) : &T0 {
        assert!(length<T0>(arg1) > arg2, (600 as u64));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<u64, T0>(arg0, &arg1.contents, arg2)
    }

    public fun push_back<T0: store>(arg0: &mut 0x2::object::UID, arg1: &mut TableVec<T0>, arg2: T0) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<u64, T0>(arg0, &mut arg1.contents, length<T0>(arg1), arg2);
    }

    public fun borrow_mut<T0: store>(arg0: &mut 0x2::object::UID, arg1: &mut TableVec<T0>, arg2: u64) : &mut T0 {
        assert!(length<T0>(arg1) > arg2, (600 as u64));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<u64, T0>(arg0, &mut arg1.contents, arg2)
    }

    public fun pop_back<T0: store>(arg0: &mut 0x2::object::UID, arg1: &mut TableVec<T0>) : T0 {
        let v0 = length<T0>(arg1);
        assert!(v0 > 0, (600 as u64));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::remove<u64, T0>(arg0, &mut arg1.contents, v0 - 1)
    }

    public fun swap<T0: store>(arg0: &mut 0x2::object::UID, arg1: &mut TableVec<T0>, arg2: u64, arg3: u64) {
        assert!(length<T0>(arg1) > arg2, (600 as u64));
        assert!(length<T0>(arg1) > arg3, (600 as u64));
        if (arg2 == arg3) {
            return
        };
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<u64, T0>(arg0, &mut arg1.contents, arg3, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::remove<u64, T0>(arg0, &mut arg1.contents, arg2));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<u64, T0>(arg0, &mut arg1.contents, arg2, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::remove<u64, T0>(arg0, &mut arg1.contents, arg3));
    }

    public fun is_empty<T0: store>(arg0: &TableVec<T0>) : bool {
        length<T0>(arg0) == 0
    }

    public fun singleton<T0: store>(arg0: &mut 0x2::object::UID, arg1: T0) : TableVec<T0> {
        let v0 = 0x2::object::uid_to_address(arg0);
        let v1 = empty<T0>(&v0);
        let v2 = &mut v1;
        push_back<T0>(arg0, v2, arg1);
        v1
    }

    public fun swap_remove<T0: store>(arg0: &mut 0x2::object::UID, arg1: &mut TableVec<T0>, arg2: u64) : T0 {
        assert!(length<T0>(arg1) > arg2, (600 as u64));
        let v0 = length<T0>(arg1) - 1;
        swap<T0>(arg0, arg1, arg2, v0);
        pop_back<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

