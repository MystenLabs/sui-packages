module 0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::meta_oracle {
    struct MetaOracle<T0> {
        oracle_datas: vector<0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>>,
        threshole: u64,
        time_window_ms: u64,
        ticker: 0x1::string::String,
        max_timestamp: u64,
    }

    struct TrustedData<T0> has copy, drop {
        value: T0,
        oracles: vector<address>,
    }

    public fun new<T0: copy + drop>(arg0: u64, arg1: u64, arg2: 0x1::string::String) : MetaOracle<T0> {
        MetaOracle<T0>{
            oracle_datas   : 0x1::vector::empty<0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>>(),
            threshole      : arg0,
            time_window_ms : arg1,
            ticker         : arg2,
            max_timestamp  : 0,
        }
    }

    public fun data<T0>(arg0: &MetaOracle<T0>) : &vector<0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>> {
        &arg0.oracle_datas
    }

    public fun value<T0>(arg0: &TrustedData<T0>) : &T0 {
        &arg0.value
    }

    public fun add_simple_oracle<T0: copy + drop + store>(arg0: &mut MetaOracle<T0>, arg1: &0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::simple_oracle::SimpleOracle) {
        let v0 = 0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::simple_oracle::get_latest_data<T0>(arg1, arg0.ticker);
        if (0x1::option::is_some<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>(&v0)) {
            arg0.max_timestamp = 0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::timestamp<T0>(0x1::option::borrow<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>(&v0));
        };
        0x1::vector::push_back<0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>>(&mut arg0.oracle_datas, v0);
    }

    fun cmp<T0: copy + drop>(arg0: &T0, arg1: &T0) : u8 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::bcs::new(0x2::bcs::to_bytes<T0>(arg0));
        let v2 = 0x2::bcs::new(0x2::bcs::to_bytes<T0>(arg1));
        if (v0 == 0x1::type_name::get<u64>()) {
            let v3 = 0x2::bcs::peel_u64(&mut v1);
            let v4 = 0x2::bcs::peel_u64(&mut v2);
            if (v3 > v4) {
                return 1
            };
            if (v3 == v4) {
                return 0
            };
            return 2
        };
        if (v0 == 0x1::type_name::get<u128>()) {
            let v5 = 0x2::bcs::peel_u128(&mut v1);
            let v6 = 0x2::bcs::peel_u128(&mut v2);
            if (v5 > v6) {
                return 1
            };
            if (v5 == v6) {
                return 0
            };
            return 2
        };
        if (v0 == 0x1::type_name::get<u8>()) {
            let v7 = 0x2::bcs::peel_u8(&mut v1);
            let v8 = 0x2::bcs::peel_u8(&mut v2);
            if (v7 > v8) {
                return 1
            };
            if (v7 == v8) {
                return 0
            };
            return 2
        };
        assert!(v0 == 0x1::type_name::get<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::decimal_value::DecimalValue>(), 1);
        let v9 = (0x2::bcs::peel_u64(&mut v1) as u128) * (0x2::math::pow(10, 0x2::bcs::peel_u8(&mut v2)) as u128);
        let v10 = (0x2::bcs::peel_u64(&mut v2) as u128) * (0x2::math::pow(10, 0x2::bcs::peel_u8(&mut v1)) as u128);
        if (v9 > v10) {
            return 1
        };
        if (v9 == v10) {
            return 0
        };
        2
    }

    fun combind<T0: copy + drop>(arg0: MetaOracle<T0>) : (vector<T0>, vector<address>) {
        let MetaOracle {
            oracle_datas   : v0,
            threshole      : v1,
            time_window_ms : v2,
            ticker         : _,
            max_timestamp  : v4,
        } = arg0;
        let v5 = v0;
        let v6 = 0x1::vector::empty<T0>();
        let v7 = vector[];
        while (0x1::vector::length<0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>>(&v5) > 0) {
            let v8 = 0x1::vector::remove<0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>>(&mut v5, 0);
            if (0x1::option::is_some<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>(&v8)) {
                let v9 = 0x1::option::destroy_some<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>(v8);
                if (0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::timestamp<T0>(&v9) > v4 - v2) {
                    0x1::vector::push_back<T0>(&mut v6, *0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::value<T0>(&v9));
                    0x1::vector::push_back<address>(&mut v7, *0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::oracle_address<T0>(&v9));
                };
            };
        };
        assert!(0x1::vector::length<T0>(&v6) >= v1, 0);
        (v6, v7)
    }

    public fun max_timestamp<T0>(arg0: &MetaOracle<T0>) : u64 {
        arg0.max_timestamp
    }

    public fun median<T0: copy + drop>(arg0: MetaOracle<T0>) : TrustedData<T0> {
        let (v0, v1) = combind<T0>(arg0);
        let v2 = quick_sort<T0>(v0);
        TrustedData<T0>{
            value   : 0x1::vector::remove<T0>(&mut v2, 0x1::vector::length<T0>(&v2) / 2),
            oracles : v1,
        }
    }

    public fun oracles<T0>(arg0: &TrustedData<T0>) : vector<address> {
        arg0.oracles
    }

    fun quick_sort<T0: copy + drop>(arg0: vector<T0>) : vector<T0> {
        if (0x1::vector::length<T0>(&arg0) <= 1) {
            return arg0
        };
        let v0 = *0x1::vector::borrow<T0>(&arg0, 0);
        let v1 = 0x1::vector::empty<T0>();
        let v2 = 0x1::vector::empty<T0>();
        let v3 = 0x1::vector::empty<T0>();
        while (0x1::vector::length<T0>(&arg0) > 0) {
            let v4 = 0x1::vector::remove<T0>(&mut arg0, 0);
            let v5 = cmp<T0>(&v4, &v0);
            if (v5 == 2) {
                0x1::vector::push_back<T0>(&mut v1, v4);
                continue
            };
            if (v5 == 0) {
                0x1::vector::push_back<T0>(&mut v2, v4);
                continue
            };
            0x1::vector::push_back<T0>(&mut v3, v4);
        };
        let v6 = 0x1::vector::empty<T0>();
        0x1::vector::append<T0>(&mut v6, quick_sort<T0>(v1));
        0x1::vector::append<T0>(&mut v6, v2);
        0x1::vector::append<T0>(&mut v6, quick_sort<T0>(v3));
        v6
    }

    public fun threshold<T0>(arg0: &MetaOracle<T0>) : u64 {
        arg0.threshole
    }

    public fun ticker<T0>(arg0: &MetaOracle<T0>) : 0x1::string::String {
        arg0.ticker
    }

    public fun time_window_ms<T0>(arg0: &MetaOracle<T0>) : u64 {
        arg0.time_window_ms
    }

    // decompiled from Move bytecode v6
}

