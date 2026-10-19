module 0xe96ad48baa84b9dd1b87973001cdfef0b409b4a8f9493b04db5dcd5de72cb23::guard {
    public fun scallop_debt<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: u64) {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::with_original_ids<T0>());
        assert!(v0 >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

