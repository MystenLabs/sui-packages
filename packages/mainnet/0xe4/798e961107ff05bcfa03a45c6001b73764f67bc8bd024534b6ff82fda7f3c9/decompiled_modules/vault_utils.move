module 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault_utils {
    public fun clone_vecmap_table<T0: copy + drop + store, T1: copy + store>(arg0: &0x2::vec_map::VecMap<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<T0, T1> {
        let v0 = 0x2::table::new<T0, T1>(arg1);
        let v1 = 0x2::vec_map::keys<T0, T1>(arg0);
        let v2 = 0x1::vector::length<T0>(&v1);
        while (v2 > 0) {
            let v3 = 0x1::vector::borrow<T0>(&v1, v2 - 1);
            0x2::table::add<T0, T1>(&mut v0, *v3, *0x2::vec_map::get<T0, T1>(arg0, v3));
            v2 = v2 - 1;
        };
        v0
    }

    public fun decimals() : u256 {
        1000000000
    }

    public fun div_d(arg0: u256, arg1: u256) : u256 {
        arg0 * 1000000000 / arg1
    }

    public fun div_with_oracle_price(arg0: u256, arg1: u256) : u256 {
        arg0 * 1000000000000000000 / arg1
    }

    public fun from_decimals(arg0: u256) : u256 {
        arg0 / 1000000000
    }

    public fun from_oracle_price_decimals(arg0: u256) : u256 {
        arg0 / 1000000000000000000
    }

    public fun mul_d(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000
    }

    public fun mul_with_oracle_price(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    public fun parse_key<T0>(arg0: u8) : 0x1::ascii::String {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg0));
        0x1::string::to_ascii(v0)
    }

    public fun to_decimals(arg0: u256) : u256 {
        arg0 * 1000000000
    }

    public fun to_oracle_price_decimals(arg0: u256) : u256 {
        arg0 * 1000000000000000000
    }

    // decompiled from Move bytecode v6
}

