module 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils {
    struct Marker<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct IsShared has copy, drop, store {
        dummy_field: bool,
    }

    public fun assert_package_publisher<T0>(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg0), 2);
    }

    public fun assert_publisher<T0>(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg0), 2);
    }

    public fun assert_same_module<T0, T1>() {
        let (v0, v1, _) = get_package_module_type<T0>();
        let (v3, v4, _) = get_package_module_type<T1>();
        assert!(v0 == v3, 3);
        assert!(v1 == v4, 4);
    }

    public fun assert_same_module_as_witness<T0, T1>() {
        let (v0, v1, _) = get_package_module_type<T0>();
        let (v3, v4, v5) = get_package_module_type<T1>();
        assert!(v0 == v3, 3);
        assert!(v1 == v4, 4);
        assert!(v5 == 0x1::string::utf8(b"Witness"), 5);
    }

    public fun bps() : u16 {
        10000
    }

    public fun from_vec_to_map<T0: copy + drop, T1: drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 1);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<T0, T1>();
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x2::vec_map::insert<T0, T1>(&mut v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_package_module_type<T0>() : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        get_package_module_type_raw(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))))
    }

    public fun get_package_module_type_raw(arg0: 0x1::string::String) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let v0 = 0x1::string::utf8(b"::");
        let v1 = 0x1::string::sub_string(&arg0, 0x1::string::index_of(&arg0, &v0) + 2, 0x1::string::length(&arg0));
        let v2 = 0x1::string::index_of(&v1, &v0);
        (0x1::string::sub_string(&arg0, 0, 0x1::string::index_of(&arg0, &v0)), 0x1::string::sub_string(&v1, 0, v2), 0x1::string::sub_string(&v1, v2 + 2, 0x1::string::length(&v1)))
    }

    public fun insert_vec_in_table<T0: store>(arg0: &mut 0x2::table_vec::TableVec<T0>, arg1: vector<T0>) {
        let v0 = 0x1::vector::length<T0>(&arg1);
        while (v0 > 0) {
            0x2::table_vec::push_back<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1));
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun insert_vec_in_vec_set<T0: copy + drop + store>(arg0: &mut 0x2::vec_set::VecSet<T0>, arg1: vector<T0>) {
        let v0 = 0x1::vector::length<T0>(&arg1);
        while (v0 > 0) {
            0x2::vec_set::insert<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1));
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun is_shared() : IsShared {
        IsShared{dummy_field: false}
    }

    public fun marker<T0>() : Marker<T0> {
        Marker<T0>{dummy_field: false}
    }

    public fun originbyte_docs_url() : 0x1::string::String {
        0x1::string::utf8(b"https://docs.originbyte.io")
    }

    public fun sum_vector(arg0: vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        let v1 = 0;
        while (v0 > 0) {
            v1 = v1 + 0x1::vector::pop_back<u64>(&mut arg0);
            v0 = v0 - 1;
        };
        v1
    }

    public fun table_from_vec_map<T0: copy + drop + store, T1: store>(arg0: 0x2::vec_map::VecMap<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<T0, T1> {
        let v0 = 0x2::table::new<T0, T1>(arg1);
        let (v1, v2) = 0x2::vec_map::into_keys_values<T0, T1>(arg0);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::vector::length<T1>(&v3);
        while (v5 > 0) {
            0x2::table::add<T0, T1>(&mut v0, 0x1::vector::pop_back<T0>(&mut v4), 0x1::vector::pop_back<T1>(&mut v3));
            v5 = v5 - 1;
        };
        0x1::vector::destroy_empty<T1>(v3);
        0x1::vector::destroy_empty<T0>(v4);
        v0
    }

    public fun table_vec_from_vec<T0: store>(arg0: vector<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::table_vec::TableVec<T0> {
        let v0 = 0x2::table_vec::empty<T0>(arg1);
        let v1 = 0x1::vector::length<T0>(&arg0);
        while (v1 > 0) {
            0x2::table_vec::push_back<T0>(&mut v0, 0x1::vector::pop_back<T0>(&mut arg0));
            v1 = v1 - 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
        v0
    }

    public fun vec_map_entries<T0: copy + drop, T1: copy>(arg0: &0x2::vec_map::VecMap<T0, T1>) : vector<T1> {
        let v0 = 0x2::vec_map::keys<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0x1::vector::empty<T1>();
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x1::vector::push_back<T1>(&mut v2, *0x2::vec_map::get<T0, T1>(arg0, 0x1::vector::borrow<T0>(&v0, v1)));
            v1 = v1 + 1;
        };
        v2
    }

    public fun vec_set_from_vec<T0: copy + drop + store>(arg0: &vector<T0>) : 0x2::vec_set::VecSet<T0> {
        let v0 = 0x2::vec_set::empty<T0>();
        let v1 = 0x1::vector::length<T0>(arg0);
        while (v1 > 0) {
            0x2::vec_set::insert<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, v1 - 1));
            v1 = v1 - 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

