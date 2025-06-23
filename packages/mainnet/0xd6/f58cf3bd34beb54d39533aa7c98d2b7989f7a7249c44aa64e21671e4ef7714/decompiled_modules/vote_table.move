module 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::vote_table {
    struct VoteTable has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add<T0: copy + drop + store>(arg0: &mut VoteTable, arg1: T0, arg2: u64) {
        assert!(!contains<T0>(arg0, arg1), 7);
        0x2::dynamic_field::add<T0, u64>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : VoteTable {
        VoteTable{id: 0x2::object::new(arg0)}
    }

    public(friend) fun contains<T0: copy + drop + store>(arg0: &VoteTable, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    public(friend) fun destruct(arg0: VoteTable) {
        let VoteTable { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun get<T0: copy + drop + store>(arg0: &VoteTable, arg1: T0) : u64 {
        *0x2::dynamic_field::borrow<T0, u64>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

