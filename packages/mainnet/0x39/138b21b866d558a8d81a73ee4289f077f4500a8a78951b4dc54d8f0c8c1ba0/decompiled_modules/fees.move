module 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees {
    struct FeeBreakdown has copy, drop, store {
        total_fee: u64,
        sentinel_fee: u64,
        cctp_max_fee: u64,
        bean_min_fee: u64,
        threshold: u64,
        valid_dst_domain: bool,
        flush_threshold: u64,
    }

    public fun bean_min_fee(arg0: &FeeBreakdown) : u64 {
        arg0.bean_min_fee
    }

    public fun cctp_max_fee(arg0: &FeeBreakdown) : u64 {
        arg0.cctp_max_fee
    }

    public fun compute(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool) : FeeBreakdown {
        let v0 = if (arg6) {
            1000
        } else {
            2000
        };
        let v1 = arg0 * arg1 / 10000;
        let v2 = if (arg6) {
            let v3 = arg0 * arg2 / 10000;
            assert!(v1 >= v3 && v1 > 0, 1);
            v3
        } else {
            0
        };
        let v4 = min(arg3 * arg4, min(v1 * 3000 / 10000, v1 - v2));
        FeeBreakdown{
            total_fee        : v1,
            sentinel_fee     : v4,
            cctp_max_fee     : v2,
            bean_min_fee     : v1 - v2 - v4,
            threshold        : v0,
            valid_dst_domain : arg7,
            flush_threshold  : arg5,
        }
    }

    public fun flush_threshold(arg0: &FeeBreakdown) : u64 {
        arg0.flush_threshold
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun sentinel_fee(arg0: &FeeBreakdown) : u64 {
        arg0.sentinel_fee
    }

    public fun split_50_50(arg0: u64) : (u64, u64) {
        let v0 = arg0 / 2;
        (v0, arg0 - v0)
    }

    public fun threshold(arg0: &FeeBreakdown) : u64 {
        arg0.threshold
    }

    public fun total_fee(arg0: &FeeBreakdown) : u64 {
        arg0.total_fee
    }

    public fun valid_dst_domain(arg0: &FeeBreakdown) : bool {
        arg0.valid_dst_domain
    }

    public fun zero(arg0: u64, arg1: bool) : FeeBreakdown {
        let v0 = if (arg1) {
            1000
        } else {
            2000
        };
        FeeBreakdown{
            total_fee        : 0,
            sentinel_fee     : 0,
            cctp_max_fee     : 0,
            bean_min_fee     : 0,
            threshold        : v0,
            valid_dst_domain : true,
            flush_threshold  : arg0,
        }
    }

    // decompiled from Move bytecode v7
}

