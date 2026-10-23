module 0x30c250f44392b0e7c386c084a0e4320884f9688661b05e13e9421b363b5c38ac::reader {
    public fun current<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: bool) : (u128, u128, u64, u64) {
        let (v0, v1, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<T0, T1, T2>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<T0, T1, T2>(arg0));
        let (v3, v4) = if (arg1) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        ((v3 as u128), (v4 as u128), 3, 1000)
    }

    public fun current_stable<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: bool) : (u64, u64, u64, u64, u64, u64, u64, bool) {
        stable_values(0x1::bcs::to_bytes<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::Pool<T0, T1, T2>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<T0, T1, T2>(arg0)), arg1)
    }

    public fun current_stable_unless_selected<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: bool, arg2: &vector<bool>) : (u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = true;
        if (0x1::vector::contains<bool>(arg2, &v0)) {
            return (1, 1, 1, 1, 1, 1, 1, false)
        };
        current_stable<T0, T1, T2>(arg0, arg1)
    }

    public fun current_unless_selected<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: bool, arg2: &vector<bool>) : (u128, u128, u64, u64) {
        let v0 = true;
        if (0x1::vector::contains<bool>(arg2, &v0)) {
            return (1, 1, 1, 1)
        };
        current<T0, T1, T2>(arg0, arg1)
    }

    fun stable_values(arg0: vector<u8>, arg1: bool) : (u64, u64, u64, u64, u64, u64, u64, bool) {
        let (v0, v1, v2, v3) = if (arg1) {
            (u64_at(&arg0, 72), u64_at(&arg0, 80), u64_at(&arg0, 88), u64_at(&arg0, 96))
        } else {
            (u64_at(&arg0, 80), u64_at(&arg0, 72), u64_at(&arg0, 96), u64_at(&arg0, 88))
        };
        (v0, v1, v2, v3, 1000000000000000000, 5, 10000, *0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) == 1)
    }

    fun u64_at(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << ((v1 * 8) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

