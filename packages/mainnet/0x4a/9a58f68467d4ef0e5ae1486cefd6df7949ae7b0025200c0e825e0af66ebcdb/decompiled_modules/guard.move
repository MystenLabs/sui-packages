module 0xad68f9ed18db8c69c48343d33a7e7e528ddb1d05fcd03786e50cdc44597470fe::guard {
    public fun assert_scallop_debt<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: u64) {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::get<T0>());
        assert!(v0 >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

