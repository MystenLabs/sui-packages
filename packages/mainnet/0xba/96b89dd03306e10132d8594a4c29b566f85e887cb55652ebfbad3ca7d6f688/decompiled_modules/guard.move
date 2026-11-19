module 0xba96b89dd03306e10132d8594a4c29b566f85e887cb55652ebfbad3ca7d6f688::guard {
    public fun scallop_debt<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: u64) {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::with_original_ids<T0>());
        assert!(v0 >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

