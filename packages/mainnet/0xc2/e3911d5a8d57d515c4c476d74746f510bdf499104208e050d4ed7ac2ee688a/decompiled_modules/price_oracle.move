module 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::price_oracle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ExchangeRate has key {
        id: 0x2::object::UID,
        inner: 0x2::vec_map::VecMap<vector<u8>, u64>,
    }

    public fun exchange_value(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u64, arg3: &ExchangeRate) : u64 {
        arg2 * get_exchange_rate(arg0, arg1, arg3) / 10000
    }

    public fun get_exchange_rate(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &ExchangeRate) : u64 {
        if (arg0 == arg1) {
            return 10000
        };
        let v0 = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::collection_utils::get_composite_key(arg0, arg1);
        *0x2::vec_map::get<vector<u8>, u64>(&arg2.inner, &v0)
    }

    fun get_reverse_rate(arg0: u64) : u64 {
        10000 / arg0 * 10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ExchangeRate{
            id    : 0x2::object::new(arg0),
            inner : 0x2::vec_map::empty<vector<u8>, u64>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ExchangeRate>(v1);
    }

    public fun update_exchange_rates(arg0: vector<vector<0x1::ascii::String>>, arg1: vector<u64>, arg2: &AdminCap, arg3: &mut ExchangeRate) {
        let v0 = 0x1::vector::length<vector<0x1::ascii::String>>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<0x1::ascii::String>>(&arg0, v1);
            let v3 = 0x1::vector::borrow<0x1::ascii::String>(v2, 0);
            let v4 = 0x1::vector::borrow<0x1::ascii::String>(v2, 1);
            let v5 = 0x1::vector::borrow_mut<u64>(&mut arg1, v1);
            let (v6, v7) = if (0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::collection_utils::compare_ascii_strings(v3, v4) == 1) {
                (v3, v4)
            } else {
                *v5 = get_reverse_rate(*v5);
                (v4, v3)
            };
            let v8 = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::collection_utils::get_composite_key(*v6, *v7);
            if (0x2::vec_map::contains<vector<u8>, u64>(&arg3.inner, &v8)) {
                *0x2::vec_map::get_mut<vector<u8>, u64>(&mut arg3.inner, &v8) = *v5;
            } else {
                0x2::vec_map::insert<vector<u8>, u64>(&mut arg3.inner, v8, *v5);
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

