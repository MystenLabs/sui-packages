module 0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::guard {
    public fun assert_amount(arg0: u64, arg1: u64) {
        assert!(arg1 > 0 && arg0 >= arg1, 901);
    }

    public fun assert_debt_at_least<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg0);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1, &v0), 901);
        let (v2, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, v0);
        assert_amount(v2, arg1);
    }

    // decompiled from Move bytecode v7
}

