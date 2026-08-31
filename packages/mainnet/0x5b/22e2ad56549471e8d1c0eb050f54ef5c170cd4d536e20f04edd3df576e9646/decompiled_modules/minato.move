module 0x5b22e2ad56549471e8d1c0eb050f54ef5c170cd4d536e20f04edd3df576e9646::minato {
    public fun disperse<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: vector<address>, arg2: vector<u8>) {
        assert!(!0x1::vector::is_empty<address>(&arg1) && !0x1::vector::is_empty<u8>(&arg2), 13835058175541248001);
        let v0 = 0;
        let v1 = &mut v0;
        let v2 = read_uleb128(&arg2, v1);
        assert!(v2 > 0, 13835339667697958915);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v2) {
            let v6 = &mut v0;
            let v7 = read_uleb128(&arg2, v6);
            let v8 = &mut v0;
            let v9 = read_uleb128(&arg2, v8);
            assert!(v7 > 0 && v9 > 0, 13835339697762729987);
            assert!(v4 <= 18446744073709551615 - v7, 13835339702057697283);
            assert!(v9 <= 0x1::vector::length<address>(&arg1) - v3, 13835339706352664579);
            let v10 = v4 + v7;
            v4 = v10;
            let v11 = 0;
            while (v11 < v9) {
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(arg0, v10), *0x1::vector::borrow<address>(&arg1, v3));
                v3 = v3 + 1;
                v11 = v11 + 1;
            };
            v5 = v5 + 1;
        };
        assert!(v3 == 0x1::vector::length<address>(&arg1), 13835339745007370243);
        assert!(v0 == 0x1::vector::length<u8>(&arg2), 13835339749302337539);
    }

    fun disperse_if_present<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: vector<address>, arg2: vector<u8>) {
        if (0x1::vector::is_empty<address>(&arg1)) {
            0x1::vector::destroy_empty<address>(arg1);
            0x1::vector::destroy_empty<u8>(arg2);
        } else {
            disperse<T0>(arg0, arg1, arg2);
        };
    }

    public fun disperse_withdrawal<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: vector<address>, arg2: vector<u8>, arg3: vector<address>, arg4: vector<u8>, arg5: vector<address>, arg6: vector<u8>, arg7: vector<address>, arg8: vector<u8>, arg9: vector<address>, arg10: vector<u8>, arg11: vector<address>, arg12: vector<u8>, arg13: vector<address>, arg14: vector<u8>, arg15: vector<address>, arg16: vector<u8>) {
        let v0 = false;
        assert!(!0x1::vector::is_empty<address>(&arg1) && !0x1::vector::is_empty<u8>(&arg2), 13835902815220137991);
        let v1 = &mut v0;
        validate_pair(&arg1, &arg2, v1);
        let v2 = &mut v0;
        validate_pair(&arg3, &arg4, v2);
        let v3 = &mut v0;
        validate_pair(&arg5, &arg6, v3);
        let v4 = &mut v0;
        validate_pair(&arg7, &arg8, v4);
        let v5 = &mut v0;
        validate_pair(&arg9, &arg10, v5);
        let v6 = &mut v0;
        validate_pair(&arg11, &arg12, v6);
        let v7 = &mut v0;
        validate_pair(&arg13, &arg14, v7);
        let v8 = &mut v0;
        validate_pair(&arg15, &arg16, v8);
        let v9 = 0x2::balance::redeem_funds<T0>(arg0);
        let v10 = &mut v9;
        disperse<T0>(v10, arg1, arg2);
        let v11 = &mut v9;
        disperse_if_present<T0>(v11, arg3, arg4);
        let v12 = &mut v9;
        disperse_if_present<T0>(v12, arg5, arg6);
        let v13 = &mut v9;
        disperse_if_present<T0>(v13, arg7, arg8);
        let v14 = &mut v9;
        disperse_if_present<T0>(v14, arg9, arg10);
        let v15 = &mut v9;
        disperse_if_present<T0>(v15, arg11, arg12);
        let v16 = &mut v9;
        disperse_if_present<T0>(v16, arg13, arg14);
        let v17 = &mut v9;
        disperse_if_present<T0>(v17, arg15, arg16);
        0x2::balance::destroy_zero<T0>(v9);
    }

    fun read_uleb128(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        loop {
            assert!(*arg1 < 0x1::vector::length<u8>(arg0) && v2 < 10, 13835340105784623107);
            let v3 = *0x1::vector::borrow<u8>(arg0, *arg1);
            *arg1 = *arg1 + 1;
            let v4 = ((v3 & 127) as u64);
            if (v2 == 9) {
                assert!(v4 <= 1, 13835340131554426883);
            };
            v0 = v0 | v4 << v1;
            v2 = v2 + 1;
            if (v3 & 128 == 0) {
                assert!(v2 == 1 || v4 != 0, 13835340157324230659);
                return v0
            };
            if (v2 < 10) {
                v1 = v1 + 7;
            } else {
                break
            };
        };
        abort 13835340170209132547
    }

    fun validate_pair(arg0: &vector<address>, arg1: &vector<u8>, arg2: &mut bool) {
        let v0 = 0x1::vector::is_empty<address>(arg0);
        assert!(v0 == 0x1::vector::is_empty<u8>(arg1), 13835621520631922693);
        if (v0) {
            *arg2 = true;
        } else {
            assert!(!*arg2, 13835621537811791877);
        };
    }

    // decompiled from Move bytecode v7
}

