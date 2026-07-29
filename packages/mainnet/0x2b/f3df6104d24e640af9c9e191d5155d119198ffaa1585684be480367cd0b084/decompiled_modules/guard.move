module 0x2bf3df6104d24e640af9c9e191d5155d119198ffaa1585684be480367cd0b084::guard {
    public fun assert_debt_at_least<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg0);
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&v1, &v0)) {
            abort 901
        };
        let (v2, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, v0);
        assert!(v2 >= arg1, 901);
    }

    // decompiled from Move bytecode v7
}

