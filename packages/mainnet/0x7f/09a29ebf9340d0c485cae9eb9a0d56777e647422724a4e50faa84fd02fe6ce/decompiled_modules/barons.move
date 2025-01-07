module 0x7f09a29ebf9340d0c485cae9eb9a0d56777e647422724a4e50faa84fd02fe6ce::barons {
    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: 0x2::vec_set::VecSet<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        checkList(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.list, arg1);
    }

    fun checkList(arg0: &mut AccessList, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&mut arg0.list, &v0), 69);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<AccessList>(new_access_list(arg0));
    }

    fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) : AccessList {
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v0.list, 0x2::tx_context::sender(arg0));
        v0
    }

    // decompiled from Move bytecode v6
}

