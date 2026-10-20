module 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client {
    struct TelosClient has key {
        id: 0x2::object::UID,
        version: u64,
        keys: 0x2::table::Table<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>,
        points: 0x2::table::Table<vector<u8>, bool>,
        seats: 0x2::table::Table<vector<u8>, Seat>,
        generation: u32,
        threshold: u64,
        total_weight: u64,
        proven: 0x2::table::Table<u32, vector<u8>>,
        roots: 0x2::table::Table<vector<u8>, bool>,
    }

    struct Seat has drop, store {
        generation: u32,
        weight: u64,
    }

    struct ClientAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PolicySet has copy, drop {
        generation: u32,
        finalizers: u64,
        threshold: u64,
    }

    struct RootTrusted has copy, drop {
        finality_mroot: vector<u8>,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : TelosClient {
        TelosClient{
            id           : 0x2::object::new(arg0),
            version      : 2,
            keys         : 0x2::table::new<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>(arg0),
            points       : 0x2::table::new<vector<u8>, bool>(arg0),
            seats        : 0x2::table::new<vector<u8>, Seat>(arg0),
            generation   : 0,
            threshold    : 0,
            total_weight : 0,
            proven       : 0x2::table::new<u32, vector<u8>>(arg0),
            roots        : 0x2::table::new<vector<u8>, bool>(arg0),
        }
    }

    public fun generation(arg0: &TelosClient) : u32 {
        arg0.generation
    }

    public fun threshold(arg0: &TelosClient) : u64 {
        arg0.threshold
    }

    fun check_version(arg0: &TelosClient) {
        assert!(arg0.version == 2, 17);
    }

    fun finish(arg0: &mut TelosClient, arg1: u64, arg2: u32, arg3: u128, arg4: u64) {
        assert!(arg4 > 0, 8);
        assert!(arg2 > arg0.generation, 2);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::is_safe_threshold(arg1, arg3), 9);
        arg0.threshold = arg1;
        arg0.total_weight = (arg3 as u64);
        arg0.generation = arg2;
        let v0 = PolicySet{
            generation : arg2,
            finalizers : arg4,
            threshold  : arg1,
        };
        0x2::event::emit<PolicySet>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::share_object<TelosClient>(v0);
        let v1 = ClientAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ClientAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun install_policy(arg0: &mut TelosClient, arg1: vector<u8>) {
        check_version(arg0);
        let v0 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::parse_policy(arg1);
        let v1 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::generation(&v0);
        assert!(0x2::table::contains<u32, vector<u8>>(&arg0.proven, v1) && *0x2::table::borrow<u32, vector<u8>>(&arg0.proven, v1) == 0x1::hash::sha2_256(arg1), 16);
        assert!(v1 > arg0.generation, 2);
        let v2 = 0;
        let v3 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::seats(&v0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::Seat>(v3)) {
            let v5 = 0x1::vector::borrow<0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::Seat>(v3, v4);
            let v6 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::seat_raw(v5);
            let v7 = 0x2::hash::keccak256(&v6);
            remember(arg0, v7, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::compress_g1(&v6), 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::seat_key(v5));
            let v8 = seat(arg0, v7, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::seat_weight(v5), v1);
            v2 = v2 + (v8 as u128);
            v4 = v4 + 1;
        };
        finish(arg0, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::threshold(&v0), v1, v2, 0x1::vector::length<0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::Seat>(v3));
    }

    public fun is_trusted(arg0: &TelosClient, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.roots, *arg1)
    }

    public fun knows(arg0: &TelosClient, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>(&arg0.keys, 0x2::hash::keccak256(arg1))
    }

    fun learn(arg0: &mut TelosClient, arg1: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 96, 18);
        let v0 = 0x2::hash::keccak256(arg1);
        if (!0x2::table::contains<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>(&arg0.keys, v0)) {
            let v1 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::compress_g1(arg1);
            remember(arg0, v0, v1, 0x2::bls12381::g1_from_bytes(&v1));
        };
        v0
    }

    public fun migrate(arg0: &ClientAdminCap, arg1: &mut TelosClient) {
        assert!(arg1.version < 2, 17);
        arg1.version = 2;
    }

    public fun register_keys(arg0: &ClientAdminCap, arg1: &mut TelosClient, arg2: vector<vector<u8>>) {
        check_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            learn(arg1, 0x1::vector::borrow<vector<u8>>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    fun remember(arg0: &mut TelosClient, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::group_ops::Element<0x2::bls12381::G1>) {
        if (0x2::table::contains<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>(&arg0.keys, arg1)) {
            return
        };
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.points, arg2), 19);
        0x2::table::add<vector<u8>, bool>(&mut arg0.points, arg2, true);
        0x2::table::add<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>(&mut arg0.keys, arg1, arg3);
    }

    fun seat(arg0: &mut TelosClient, arg1: vector<u8>, arg2: u64, arg3: u32) : u64 {
        if (0x2::table::contains<vector<u8>, Seat>(&arg0.seats, arg1)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, Seat>(&mut arg0.seats, arg1);
            assert!(v0.generation != arg3, 10);
            v0.generation = arg3;
            v0.weight = arg2;
        } else {
            let v1 = Seat{
                generation : arg3,
                weight     : arg2,
            };
            0x2::table::add<vector<u8>, Seat>(&mut arg0.seats, arg1, v1);
        };
        arg2
    }

    public fun set_policy(arg0: &ClientAdminCap, arg1: &mut TelosClient, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: u64, arg5: u32) {
        check_version(arg1);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u64>(&arg3), 7);
        assert!(arg5 > arg1.generation, 2);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v2 = learn(arg1, 0x1::vector::borrow<vector<u8>>(&arg2, v1));
            let v3 = seat(arg1, v2, *0x1::vector::borrow<u64>(&arg3, v1), arg5);
            v0 = v0 + (v3 as u128);
            v1 = v1 + 1;
        };
        finish(arg1, arg4, arg5, v0, 0x1::vector::length<vector<u8>>(&arg2));
    }

    public fun submit_root(arg0: &mut TelosClient, arg1: 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::FinalityInputs, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        check_version(arg0);
        assert!(arg0.threshold != 0, 1);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::major_version(&arg1) == 1, 20);
        let v0 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::finality_digest(&arg1);
        verify_held(arg0, &arg2, &arg3, &arg4, &v0);
        if (0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::active_generation(&arg1) == 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::last_pending_generation(&arg1)) {
            let v1 = if (0x1::vector::is_empty<u8>(&arg5)) {
                if (0x1::vector::is_empty<u8>(&arg6)) {
                    0x1::vector::is_empty<u8>(&arg7)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 5);
        } else {
            assert!(0x1::hash::sha2_256(arg5) == 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::last_pending_policy_digest(&arg1), 6);
            let v2 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::parse_policy(arg5);
            assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::generation(&v2) == 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::last_pending_generation(&arg1), 6);
            assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::check_quorum(&v2, &arg6, &arg7, &v0), 4);
        };
        let v3 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::last_pending_generation(&arg1);
        if ((0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::active_generation(&arg1) == v3 || 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::qc_claim_timestamp(&arg1) >= 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::last_pending_policy_start(&arg1)) && !0x2::table::contains<u32, vector<u8>>(&arg0.proven, v3)) {
            0x2::table::add<u32, vector<u8>>(&mut arg0.proven, v3, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::last_pending_policy_digest(&arg1));
        };
        let v4 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::finality_mroot(&arg1);
        if (!0x2::table::contains<vector<u8>, bool>(&arg0.roots, v4)) {
            0x2::table::add<vector<u8>, bool>(&mut arg0.roots, v4, true);
            let v5 = RootTrusted{finality_mroot: v4};
            0x2::event::emit<RootTrusted>(v5);
        };
    }

    entry fun submit_root_entry(arg0: &mut TelosClient, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: vector<u8>, arg6: vector<u8>, arg7: u32, arg8: vector<u8>, arg9: u32, arg10: vector<u8>, arg11: u32, arg12: u32, arg13: vector<u8>, arg14: vector<u8>, arg15: vector<u8>, arg16: vector<vector<u8>>, arg17: vector<u8>, arg18: vector<u8>, arg19: vector<u8>) {
        submit_root(arg0, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::finality_inputs(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), arg14, arg15, arg16, arg17, arg18, arg19);
    }

    fun verify_held(arg0: &TelosClient, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<vector<u8>>, arg4: &vector<u8>) {
        let v0 = 0x2::bls12381::g1_identity();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(arg3)) {
            if (0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::bit(arg1, v3)) {
                let v4 = 0x1::vector::borrow<vector<u8>>(arg3, v3);
                let v5 = 0;
                while (v5 < v3) {
                    assert!(0x1::vector::borrow<vector<u8>>(arg3, v5) != v4, 13);
                    v5 = v5 + 1;
                };
                assert!(0x2::table::contains<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>(&arg0.keys, *v4), 12);
                let v6 = &v0;
                v0 = 0x2::bls12381::g1_add(v6, 0x2::table::borrow<vector<u8>, 0x2::group_ops::Element<0x2::bls12381::G1>>(&arg0.keys, *v4));
                v1 = v1 + weight_of(arg0, v4);
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 14);
        assert!(v1 >= arg0.threshold, 15);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna::verify_aggregate(&v0, arg2, arg4), 4);
    }

    fun weight_of(arg0: &TelosClient, arg1: &vector<u8>) : u64 {
        if (!0x2::table::contains<vector<u8>, Seat>(&arg0.seats, *arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<vector<u8>, Seat>(&arg0.seats, *arg1);
        if (v0.generation == arg0.generation) {
            v0.weight
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

