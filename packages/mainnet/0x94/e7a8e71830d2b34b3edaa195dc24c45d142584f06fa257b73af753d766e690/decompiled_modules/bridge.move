module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge {
    struct SignersUpdatedEvent has copy, drop {
        signers: vector<vector<u8>>,
        powers: vector<u128>,
    }

    struct ResetNotificationEvent has copy, drop {
        reset_time: u64,
    }

    struct BridgeState has store, key {
        id: 0x2::object::UID,
        ss_hash: vector<u8>,
        trigger_time: u64,
        reset_time: u64,
        notice_period: u64,
        domain_prefix: vector<u8>,
    }

    struct BridgeAdmin has store, key {
        id: 0x2::object::UID,
    }

    fun encode_signers_powers_data(arg0: vector<vector<u8>>, arg1: vector<u128>) : vector<u8> {
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<u128>(&arg1), 1002);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg0, v0)) == 20, 1015);
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg0, v0);
            let v4 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::compare_u8_vector(v3, x"0000000000000000000000000000000000000000");
            assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::is_greater_than(&v4), 1014);
            0x1::vector::append<u8>(&mut v1, x"000000000000000000000000");
            0x1::vector::append<u8>(&mut v1, v3);
            0x1::vector::append<u8>(&mut v2, x"00000000000000000000000000000000");
            let v5 = 0x1::bcs::to_bytes<u128>(0x1::vector::borrow<u128>(&arg1, v0));
            0x1::vector::reverse<u8>(&mut v5);
            0x1::vector::append<u8>(&mut v2, v5);
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(&mut v1, v2);
        v1
    }

    fun encode_trigger_time_signers_powers_data(arg0: u64, arg1: vector<vector<u8>>, arg2: vector<u128>) : vector<u8> {
        let v0 = x"000000000000000000000000000000000000000000000000";
        let v1 = 0x1::bcs::to_bytes<u64>(&arg0);
        0x1::vector::reverse<u8>(&mut v1);
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, encode_signers_powers_data(arg1, arg2));
        v0
    }

    public fun get_chain_id() : u64 {
        12370001
    }

    public fun get_coin_id<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_sign_data(arg0: vector<u8>) : vector<u8> {
        let v0 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
        0x1::vector::append<u8>(&mut v0, 0x2::hash::keccak256(&arg0));
        v0
    }

    public entry fun increase_notice_period(arg0: u64, arg1: &mut BridgeState, arg2: &BridgeAdmin) {
        assert!(arg0 > arg1.notice_period, 1020);
        arg1.notice_period = arg0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 12370001;
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0x1::type_name::get<BridgeState>();
        let v3 = 0x1::type_name::get_address(&v2);
        let v4 = 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v3)));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&v4));
        let v5 = 0x1::type_name::get<BridgeState>();
        0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::get_module(&v5)));
        let v6 = BridgeState{
            id            : 0x2::object::new(arg0),
            ss_hash       : 0x1::vector::empty<u8>(),
            trigger_time  : 0,
            reset_time    : 0,
            notice_period : 0,
            domain_prefix : v1,
        };
        0x2::transfer::share_object<BridgeState>(v6);
        let v7 = BridgeAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BridgeAdmin>(v7, 0x2::tx_context::sender(arg0));
    }

    public entry fun notify_reset_signers(arg0: &0x2::clock::Clock, arg1: &mut BridgeState, arg2: &BridgeAdmin) {
        arg1.reset_time = 0x2::clock::timestamp_ms(arg0) / 1000 + arg1.notice_period;
        let v0 = ResetNotificationEvent{reset_time: arg1.reset_time};
        0x2::event::emit<ResetNotificationEvent>(v0);
    }

    fun recover_signer_addr(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 0);
        let v1 = 0x2::ecdsa_k1::decompress_pubkey(&v0);
        0x1::vector::remove<u8>(&mut v1, 0);
        let v2 = 0x2::hash::keccak256(&v1);
        assert!(0x1::vector::length<u8>(&v2) == 32, 1016);
        let v3 = 12;
        let v4 = 0x1::vector::empty<u8>();
        while (v3 < 32) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, v3));
            v3 = v3 + 1;
        };
        v4
    }

    public entry fun reset_signers(arg0: &0x2::clock::Clock, arg1: vector<vector<u8>>, arg2: vector<u128>, arg3: &mut BridgeState, arg4: &BridgeAdmin) {
        assert!(0x2::clock::timestamp_ms(arg0) / 1000 > arg3.reset_time, 1018);
        arg3.reset_time = 18446744073709551615;
        update_signers_internal(arg1, arg2, arg3);
    }

    public entry fun update_signers(arg0: u64, arg1: vector<vector<u8>>, arg2: vector<u128>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<u128>, arg6: &0x2::clock::Clock, arg7: &mut BridgeState) {
        assert!(arg0 > arg7.trigger_time, 1008);
        assert!(arg0 < 0x2::clock::timestamp_ms(arg6) / 1000 + 3600, 1009);
        let v0 = arg7.domain_prefix;
        0x1::vector::append<u8>(&mut v0, b".UpdateSigners");
        0x1::vector::append<u8>(&mut v0, encode_trigger_time_signers_powers_data(arg0, arg1, arg2));
        assert!(verify_signed_powers_internal(arg7.ss_hash, v0, arg3, arg4, arg5), 1010);
        update_signers_internal(arg1, arg2, arg7);
        arg7.trigger_time = arg0;
    }

    fun update_signers_internal(arg0: vector<vector<u8>>, arg1: vector<u128>, arg2: &mut BridgeState) {
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<u128>(&arg1), 1002);
        let v0 = encode_signers_powers_data(arg0, arg1);
        arg2.ss_hash = 0x2::hash::keccak256(&v0);
        let v1 = SignersUpdatedEvent{
            signers : arg0,
            powers  : arg1,
        };
        0x2::event::emit<SignersUpdatedEvent>(v1);
    }

    fun verify_signed_powers_internal(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<u128>) : bool {
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<u128>(&arg4), 1002);
        let v0 = encode_signers_powers_data(arg3, arg4);
        assert!(0x2::hash::keccak256(&v0) == arg0, 1019);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg3)) {
            v1 = v1 + *0x1::vector::borrow<u128>(&arg4, v2);
            v2 = v2 + 1;
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v6 = recover_signer_addr(get_sign_data(arg1), *0x1::vector::borrow_mut<vector<u8>>(&mut arg2, v4));
            let v7 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::compare_u8_vector(v6, x"0000000000000000000000000000000000000000");
            assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::is_greater_than(&v7), 1021);
            let v8 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::compare_u8_vector(v6, *0x1::vector::borrow<vector<u8>>(&arg3, v5));
            while (0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::is_greater_than(&v8)) {
                let v9 = v5 + 1;
                v5 = v9;
                assert!(v9 < 0x1::vector::length<vector<u8>>(&arg3), 1017);
            };
            let v10 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::compare_u8_vector(v6, *0x1::vector::borrow<vector<u8>>(&arg3, v5));
            if (0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::comparator::is_equal(&v10)) {
                v3 = v3 + *0x1::vector::borrow<u128>(&arg4, v5);
            };
            if (v3 >= v1 * 2 / 3 + 1) {
                return true
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun verify_sigs(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<u128>, arg4: &BridgeState) : bool {
        verify_signed_powers_internal(arg4.ss_hash, arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

