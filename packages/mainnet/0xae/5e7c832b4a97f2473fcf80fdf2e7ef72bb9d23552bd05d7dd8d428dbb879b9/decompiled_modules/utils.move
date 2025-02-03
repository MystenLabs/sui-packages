module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils {
    public fun coin_key<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::type_name::borrow_string(&v0)
    }

    public fun update_table<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::table::Table<T0, T1>, arg1: T0, arg2: T1) {
        if (0x2::table::contains<T0, T1>(arg0, arg1)) {
            *0x2::table::borrow_mut<T0, T1>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<T0, T1>(arg0, arg1, arg2);
        };
    }

    public fun update_vec_map<T0: copy, T1: drop>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: &T0, arg2: T1) {
        if (0x2::vec_map::contains<T0, T1>(arg0, arg1)) {
            *0x2::vec_map::get_mut<T0, T1>(arg0, arg1) = arg2;
        } else {
            0x2::vec_map::insert<T0, T1>(arg0, *arg1, arg2);
        };
    }

    public fun validate_coin_type(arg0: &0x1::ascii::String) {
        validate_string(arg0, 70, 4096);
    }

    public fun validate_name(arg0: &0x1::ascii::String) {
        validate_string(arg0, 1, 128);
    }

    public fun validate_string(arg0: &0x1::ascii::String, arg1: u64, arg2: u64) {
        assert!(0x1::ascii::length(arg0) >= arg1, 1001);
        assert!(0x1::ascii::length(arg0) <= arg2, 1002);
        assert!(0x1::ascii::all_characters_printable(arg0), 1000);
    }

    // decompiled from Move bytecode v6
}

