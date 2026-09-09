module 0x9610f8627666979cbb63e6f28e1ae91ecef4f1cc0ff8f36df14d75cf629080a2::reader {
    public fun current<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: bool) : (u128, u128, u64, u64) {
        assert!(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::is_volatile<T0>(), 1);
        let (v0, v1, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<T0, T1, T2>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<T0, T1, T2>(arg0));
        let (v3, v4) = if (arg1) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        ((v3 as u128), (v4 as u128), 3, 1000)
    }

    // decompiled from Move bytecode v7
}

