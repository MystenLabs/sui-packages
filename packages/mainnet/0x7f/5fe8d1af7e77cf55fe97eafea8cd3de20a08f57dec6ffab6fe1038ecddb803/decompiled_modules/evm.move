module 0x7f5fe8d1af7e77cf55fe97eafea8cd3de20a08f57dec6ffab6fe1038ecddb803::evm {
    struct SignedReport has drop {
        report_context: vector<vector<u8>>,
        report_data: vector<u8>,
        rs: vector<vector<u8>>,
        ss: vector<vector<u8>>,
        raw_vs: vector<u8>,
    }

    struct Report has drop {
        feed_id: vector<u8>,
        report_timestamp: u32,
    }

    public fun get_feed_id(arg0: &Report) : &vector<u8> {
        &arg0.feed_id
    }

    public fun get_raw_vs(arg0: &SignedReport) : &vector<u8> {
        &arg0.raw_vs
    }

    public fun get_report_context(arg0: &SignedReport) : &vector<vector<u8>> {
        &arg0.report_context
    }

    public fun get_report_data(arg0: &SignedReport) : &vector<u8> {
        &arg0.report_data
    }

    public fun get_report_timestamp(arg0: &Report) : u32 {
        arg0.report_timestamp
    }

    public fun get_rs(arg0: &SignedReport) : &vector<vector<u8>> {
        &arg0.rs
    }

    public fun get_ss(arg0: &SignedReport) : &vector<vector<u8>> {
        &arg0.ss
    }

    public fun parse_report_details_from_report(arg0: &vector<u8>) : Report {
        assert!(0x1::vector::length<u8>(arg0) >= 96, 1);
        let v0 = slice<u8>(arg0, 92, 96);
        Report{
            feed_id          : slice<u8>(arg0, 0, 32),
            report_timestamp : (*0x1::vector::borrow<u8>(&v0, 0) as u32) << 24 | (*0x1::vector::borrow<u8>(&v0, 1) as u32) << 16 | (*0x1::vector::borrow<u8>(&v0, 2) as u32) << 8 | (*0x1::vector::borrow<u8>(&v0, 3) as u32),
        }
    }

    public fun parse_signed_report(arg0: &vector<u8>) : SignedReport {
        let v0 = 7 * 32;
        assert!(0x1::vector::length<u8>(arg0) >= v0, 1);
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < 3) {
            let v3 = v2 * 32;
            0x1::vector::push_back<vector<u8>>(&mut v1, slice<u8>(arg0, v3, v3 + 32));
            v2 = v2 + 1;
        };
        let v4 = read_u256_as_u64(arg0, 3 * 32, 4 * 32);
        let v5 = read_u256_as_u64(arg0, 4 * 32, 5 * 32);
        let v6 = read_u256_as_u64(arg0, 5 * 32, 6 * 32);
        let v7 = if (v4 >= v0) {
            if (v5 >= v0) {
                v6 >= v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 1);
        let v8 = if (v5 != v6) {
            if (v5 != v4) {
                v6 != v4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 1);
        SignedReport{
            report_context : v1,
            report_data    : read_bytes(arg0, v4),
            rs             : read_bytes32_array(arg0, v5),
            ss             : read_bytes32_array(arg0, v6),
            raw_vs         : slice<u8>(arg0, 6 * 32, 7 * 32),
        }
    }

    fun read_bytes(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        assert!(arg1 + 32 <= 0x1::vector::length<u8>(arg0), 1);
        let v0 = read_u256_as_u64(arg0, arg1, arg1 + 32);
        let v1 = arg1 + 32;
        assert!(v1 + v0 <= 0x1::vector::length<u8>(arg0), 1);
        slice<u8>(arg0, v1, v1 + v0)
    }

    fun read_bytes32_array(arg0: &vector<u8>, arg1: u64) : vector<vector<u8>> {
        assert!(arg1 + 32 <= 0x1::vector::length<u8>(arg0), 1);
        let v0 = read_u256_as_u64(arg0, arg1, arg1 + 32);
        let v1 = arg1 + 32;
        assert!(v1 + v0 * 32 <= 0x1::vector::length<u8>(arg0), 1);
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v1 + v3 * 32;
            0x1::vector::push_back<vector<u8>>(&mut v2, slice<u8>(arg0, v4, v4 + 32));
            v3 = v3 + 1;
        };
        v2
    }

    fun read_u256_as_u64(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 - arg1 == 32, 1);
        let v0 = 0;
        let v1 = arg1 + 24;
        while (v1 < arg2) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

