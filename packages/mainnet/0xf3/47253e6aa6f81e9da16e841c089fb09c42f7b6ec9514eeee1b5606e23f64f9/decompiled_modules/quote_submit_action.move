module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote_submit_action {
    struct OracleData has drop {
        secp_key: vector<u8>,
        oracle_id: 0x2::object::ID,
    }

    struct SignatureInvalid has copy, drop {
        signature: vector<u8>,
        oracle_id: 0x2::object::ID,
    }

    fun build_decimals(arg0: vector<u128>, arg1: vector<bool>) : vector<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal> {
        assert!(0x1::vector::length<u128>(&arg0) == 0x1::vector::length<bool>(&arg1), 13906836751324020741);
        let v0 = 0x1::vector::empty<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal>(&mut v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::new(*0x1::vector::borrow<u128>(&arg0, v1), *0x1::vector::borrow<bool>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun build_quotes(arg0: vector<0x2::object::ID>, arg1: vector<vector<u8>>, arg2: vector<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal>, arg3: u64, arg4: vector<u8>, arg5: 0x2::object::ID, arg6: u64) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        assert!(0x1::vector::length<vector<u8>>(&arg1) == 0x1::vector::length<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal>(&arg2), 13906836837223366661);
        let v0 = 0x1::vector::empty<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quote>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            if ((*0x1::vector::borrow<u8>(&arg4, v1) as u64) <= 0x1::vector::length<0x2::object::ID>(&arg0)) {
                0x1::vector::push_back<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quote>(&mut v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::new(*0x1::vector::borrow<vector<u8>>(&arg1, v1), *0x1::vector::borrow<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal>(&arg2, v1), arg3 * 1000, arg6));
            };
            v1 = v1 + 1;
        };
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::new_quotes(v0, arg0, arg5)
    }

    fun collect_fee<T0>(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::fee_recipient(arg0));
    }

    public fun run_1(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg9: &0x2::clock::Clock) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg8);
        validate_free_fee(arg8);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg8), arg7, arg9);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg8))
    }

    public fun run_1_with_fee<T0>(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg9: &0x2::clock::Clock, arg10: 0x2::coin::Coin<T0>) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg8);
        validate_paid_fee<T0>(arg8, &arg10);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg8), arg7, arg9);
        collect_fee<T0>(arg8, arg10);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg8))
    }

    public fun run_2(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg10: &0x2::clock::Clock) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg9);
        validate_free_fee(arg9);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg9), arg7, arg10);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg9), arg8, arg10);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg9))
    }

    public fun run_2_with_fee<T0>(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg10: &0x2::clock::Clock, arg11: 0x2::coin::Coin<T0>) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg9);
        validate_paid_fee<T0>(arg9, &arg11);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg9), arg7, arg10);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg9), arg8, arg10);
        collect_fee<T0>(arg9, arg11);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg9))
    }

    public fun run_3(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg11: &0x2::clock::Clock) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg10);
        validate_free_fee(arg10);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10), arg7, arg11);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10), arg8, arg11);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10), arg9, arg11);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10))
    }

    public fun run_3_with_fee<T0>(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg11: &0x2::clock::Clock, arg12: 0x2::coin::Coin<T0>) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg10);
        validate_paid_fee<T0>(arg10, &arg12);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10), arg7, arg11);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10), arg8, arg11);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10), arg9, arg11);
        collect_fee<T0>(arg10, arg12);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg10))
    }

    public fun run_4(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg12: &0x2::clock::Clock) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg11);
        validate_free_fee(arg11);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg7, arg12);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg8, arg12);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg9, arg12);
        let v4 = &mut v0;
        validate_oracle_and_add_secp_key(v4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg10, arg12);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11))
    }

    public fun run_4_with_fee<T0>(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg12: &0x2::clock::Clock, arg13: 0x2::coin::Coin<T0>) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg11);
        validate_paid_fee<T0>(arg11, &arg13);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg7, arg12);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg8, arg12);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg9, arg12);
        let v4 = &mut v0;
        validate_oracle_and_add_secp_key(v4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11), arg10, arg12);
        collect_fee<T0>(arg11, arg13);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg11))
    }

    public fun run_5(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg13: &0x2::clock::Clock) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg12);
        validate_free_fee(arg12);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg7, arg13);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg8, arg13);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg9, arg13);
        let v4 = &mut v0;
        validate_oracle_and_add_secp_key(v4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg10, arg13);
        let v5 = &mut v0;
        validate_oracle_and_add_secp_key(v5, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg11, arg13);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12))
    }

    public fun run_5_with_fee<T0>(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg13: &0x2::clock::Clock, arg14: 0x2::coin::Coin<T0>) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg12);
        validate_paid_fee<T0>(arg12, &arg14);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg7, arg13);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg8, arg13);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg9, arg13);
        let v4 = &mut v0;
        validate_oracle_and_add_secp_key(v4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg10, arg13);
        let v5 = &mut v0;
        validate_oracle_and_add_secp_key(v5, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12), arg11, arg13);
        collect_fee<T0>(arg12, arg14);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg12))
    }

    public fun run_6(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg13: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg14: &0x2::clock::Clock) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg13);
        validate_free_fee(arg13);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg7, arg14);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg8, arg14);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg9, arg14);
        let v4 = &mut v0;
        validate_oracle_and_add_secp_key(v4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg10, arg14);
        let v5 = &mut v0;
        validate_oracle_and_add_secp_key(v5, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg11, arg14);
        let v6 = &mut v0;
        validate_oracle_and_add_secp_key(v6, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg12, arg14);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13))
    }

    public fun run_6_with_fee<T0>(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg13: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg14: &0x2::clock::Clock, arg15: 0x2::coin::Coin<T0>) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        validate_queue_active(arg13);
        validate_paid_fee<T0>(arg13, &arg15);
        let v0 = 0x1::vector::empty<OracleData>();
        let v1 = &mut v0;
        validate_oracle_and_add_secp_key(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg7, arg14);
        let v2 = &mut v0;
        validate_oracle_and_add_secp_key(v2, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg8, arg14);
        let v3 = &mut v0;
        validate_oracle_and_add_secp_key(v3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg9, arg14);
        let v4 = &mut v0;
        validate_oracle_and_add_secp_key(v4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg10, arg14);
        let v5 = &mut v0;
        validate_oracle_and_add_secp_key(v5, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg11, arg14);
        let v6 = &mut v0;
        validate_oracle_and_add_secp_key(v6, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13), arg12, arg14);
        collect_fee<T0>(arg13, arg15);
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg13))
    }

    fun validate(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &vector<OracleData>, arg8: 0x2::object::ID) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes {
        let v0 = build_decimals(arg1, arg2);
        build_quotes(validate_signatures(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::hash::generate_consensus_msg(arg5, arg6, &arg0, &v0, arg3), arg4, arg7), arg0, v0, arg6, arg3, arg8, arg5)
    }

    fun validate_free_fee(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::fee(arg0) == 0, 13906836643949969415);
    }

    fun validate_oracle_and_add_secp_key(arg0: &mut vector<OracleData>, arg1: 0x2::object::ID, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg3: &0x2::clock::Clock) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::queue(arg2) == arg1, 13906836570935263235);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::expiration_time_ms(arg2) > 0x2::clock::timestamp_ms(arg3), 13906836575230099457);
        let v0 = OracleData{
            secp_key  : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::secp256k1_key(arg2),
            oracle_id : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::id(arg2),
        };
        0x1::vector::push_back<OracleData>(arg0, v0);
    }

    fun validate_paid_fee<T0>(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: &0x2::coin::Coin<T0>) {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::fee(arg0);
        assert!(v0 > 0, 13906836678309838857);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::has_fee_type<T0>(arg0), 13906836682604937227);
        assert!(0x2::coin::value<T0>(arg1) == v0, 13906836686900035597);
    }

    fun validate_queue_active(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue) {
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::is_paused(arg0), 13906836618180689935);
    }

    fun validate_signatures(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: &vector<OracleData>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = 0x2::ecdsa_k1::secp256k1_ecrecover(0x1::vector::borrow<vector<u8>>(&arg1, v1), &arg0, 1);
            let v3 = 0x2::ecdsa_k1::decompress_pubkey(&v2);
            if (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::hash::check_subvec(&v3, &0x1::vector::borrow<OracleData>(arg2, v1).secp_key, 1)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x1::vector::borrow<OracleData>(arg2, v1).oracle_id);
            } else {
                let v4 = SignatureInvalid{
                    signature : *0x1::vector::borrow<vector<u8>>(&arg1, v1),
                    oracle_id : 0x1::vector::borrow<OracleData>(arg2, v1).oracle_id,
                };
                0x2::event::emit<SignatureInvalid>(v4);
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

