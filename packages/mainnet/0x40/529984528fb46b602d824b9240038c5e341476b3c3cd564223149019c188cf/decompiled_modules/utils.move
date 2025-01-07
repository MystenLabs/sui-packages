module 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils {
    public(friend) fun clear_table_vec<T0: drop + store>(arg0: &mut 0x2::table_vec::TableVec<T0>) {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<T0>(arg0)) {
            0x2::table_vec::pop_back<T0>(arg0);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

