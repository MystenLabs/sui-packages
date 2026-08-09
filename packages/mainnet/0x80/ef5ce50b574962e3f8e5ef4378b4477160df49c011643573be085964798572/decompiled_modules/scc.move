module 0x80ef5ce50b574962e3f8e5ef4378b4477160df49c011643573be085964798572::scc {
    public fun scc<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: u64, arg2: u64) {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::with_defining_ids<T0>());
        assert!(v0 == arg1, 6);
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, 0x1::type_name::with_defining_ids<T1>()) == arg2, 6);
    }

    // decompiled from Move bytecode v7
}

