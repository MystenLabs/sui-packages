module 0x7bfe75f51565a2e03e169c85a50c490ee707692a14d5417e2b97740da0d48627::paginator {
    struct PAGINATOR has drop {
        dummy_field: bool,
    }

    public fun get_page<T0: copy + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: u64, arg2: u64, arg3: bool) : (vector<T0>, bool, u64) {
        if (0x2::table_vec::length<T0>(arg0) == 0) {
            (0x1::vector::empty<T0>(), false, 0)
        } else if (arg3) {
            get_page_ascending<T0>(arg0, arg1, arg2)
        } else {
            get_page_descending<T0>(arg0, arg1, arg2)
        }
    }

    fun get_page_ascending<T0: copy + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: u64, arg2: u64) : (vector<T0>, bool, u64) {
        let v0 = 0x2::table_vec::length<T0>(arg0);
        let v1 = 0x1::u64::min(v0, arg1 + arg2);
        let v2 = 0x1::vector::empty<T0>();
        while (arg1 < v1) {
            0x1::vector::push_back<T0>(&mut v2, *0x2::table_vec::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        (v2, v1 < v0, v1)
    }

    fun get_page_descending<T0: copy + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: u64, arg2: u64) : (vector<T0>, bool, u64) {
        let v0 = 0x2::table_vec::length<T0>(arg0);
        let v1 = if (arg1 >= v0) {
            v0 - 1
        } else {
            arg1
        };
        let v2 = if (arg2 > v1) {
            0
        } else {
            v1 - arg2 + 1
        };
        let v3 = 0x1::vector::empty<T0>();
        let v4 = v1;
        while (v4 >= v2) {
            0x1::vector::push_back<T0>(&mut v3, *0x2::table_vec::borrow<T0>(arg0, v4));
            if (v4 == 0) {
                break
            };
            v4 = v4 - 1;
        };
        let v5 = v1 > 0 && v2 > 0;
        let v6 = if (0x1::vector::is_empty<T0>(&v3)) {
            v1
        } else if (v2 == 0) {
            v2
        } else {
            v2 - 1
        };
        (v3, v5, v6)
    }

    fun init(arg0: PAGINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAGINATOR>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

