module 0xe7904b67f2cbdd1ead536c3a19771115642d02ba1c04ebe0cbab18f79b69cad3::quote_validator {
    struct QuoteValidator has store {
        default: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        entries: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>,
    }

    public(friend) fun default() : QuoteValidator {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"pyth"), 200);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"cetus-aggregator"), 100);
        QuoteValidator{
            default : v0,
            entries : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(),
        }
    }

    public fun get_quote_config<T0>(arg0: &QuoteValidator) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg0.entries, &v0)) {
            arg0.default
        } else {
            *0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg0.entries, &v0)
        }
    }

    public fun new_quote_config(arg0: vector<0x1::string::String>, arg1: vector<u64>) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<u64>(&arg1), 13906834616725471240);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<u64>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun remove_quote_config<T0>(arg0: &mut QuoteValidator) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg0.entries, &v0), 13906834453516320770);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg0.entries, &v0);
        v2
    }

    public(friend) fun set_default_quote_config(arg0: &mut QuoteValidator, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        arg0.default = arg1;
        arg0.default
    }

    public(friend) fun set_quote_config<T0>(arg0: &mut QuoteValidator, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>) : 0x1::option::Option<0x2::vec_map::VecMap<0x1::string::String, u64>> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg0.entries, &v0)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg0.entries, &v0);
            0x1::option::some<0x2::vec_map::VecMap<0x1::string::String, u64>>(v3)
        } else {
            0x1::option::none<0x2::vec_map::VecMap<0x1::string::String, u64>>()
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg0.entries, v0, arg1);
        v1
    }

    public fun validate_quote<T0, T1>(arg0: &QuoteValidator, arg1: 0x297caa74bf795f3e50e2209c4daa9adf2681dcb7026bfac5d4ae6f5461a52bd2::trust_quote::TrustQuote<T0, T1>, arg2: u64) : u64 {
        assert!(0x297caa74bf795f3e50e2209c4daa9adf2681dcb7026bfac5d4ae6f5461a52bd2::trust_quote::amount_in<T0, T1>(&arg1) == arg2, 13906834496466124804);
        let v0 = get_quote_config<T0>(arg0);
        let v1 = 0x297caa74bf795f3e50e2209c4daa9adf2681dcb7026bfac5d4ae6f5461a52bd2::trust_quote::provider<T0, T1>(&arg1);
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(&v0, &v1), 13906834505056190470);
        let v2 = 0x297caa74bf795f3e50e2209c4daa9adf2681dcb7026bfac5d4ae6f5461a52bd2::trust_quote::provider<T0, T1>(&arg1);
        0x297caa74bf795f3e50e2209c4daa9adf2681dcb7026bfac5d4ae6f5461a52bd2::trust_quote::destroy_trust_quote<T0, T1>(arg1);
        0xe7904b67f2cbdd1ead536c3a19771115642d02ba1c04ebe0cbab18f79b69cad3::full_math_u64::mul_div_ceil(0x297caa74bf795f3e50e2209c4daa9adf2681dcb7026bfac5d4ae6f5461a52bd2::trust_quote::amount_out<T0, T1>(&arg1), 10000 - *0x2::vec_map::get<0x1::string::String, u64>(&v0, &v2), 10000)
    }

    // decompiled from Move bytecode v6
}

