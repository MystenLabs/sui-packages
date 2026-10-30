module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees {
    struct Collector has copy, drop, store {
        addr: address,
        pct: u64,
    }

    struct FeeParams has copy, drop {
        management_fee_bps: u64,
        performance_fee_rate: u64,
        instant_redemption_fee_bps: u64,
        watermark_window_ms: u64,
        fee_collectors: vector<Collector>,
        performance_fee_recipients: vector<Collector>,
    }

    struct FeeState has store {
        management_fee_bps: u64,
        fees_timestamp_ms: u64,
        management_fee_remainder: u128,
        performance_fee_rate: u64,
        high_watermark: u128,
        watermark_updated_ms: u64,
        watermark_window_ms: u64,
        instant_redemption_fee_bps: u64,
        fee_collectors: vector<Collector>,
        performance_fee_recipients: vector<Collector>,
    }

    public(friend) fun accrue_management_fee(arg0: &mut FeeState, arg1: u128, arg2: u64) : u64 {
        arg0.fees_timestamp_ms = arg2;
        let v0 = 31536000000 * (10000 as u128);
        let v1 = 0x1::u128::checked_add(mul(mul(arg1, (arg0.management_fee_bps as u128)), ((arg2 - arg0.fees_timestamp_ms) as u128)), arg0.management_fee_remainder);
        if (0x1::option::is_some<u128>(&v1)) {
            let v2 = 0x1::option::destroy_some<u128>(v1);
            let v3 = v2 / v0;
            if (v3 >= arg1) {
                arg0.management_fee_remainder = 0;
                return narrow(arg1)
            };
            arg0.management_fee_remainder = v2 % v0;
            return narrow(v3)
        } else {
            0x1::option::destroy_none<u128>(v1);
            abort 13836466503908458511
        };
    }

    public fun addr(arg0: &Collector) : address {
        arg0.addr
    }

    fun assert_instant_redemption_fee_bps(arg0: u64) {
        assert!(arg0 <= 10000, 13836185647406907405);
    }

    public(friend) fun assert_management_fee_bps(arg0: u64) {
        assert!(arg0 <= 10000, 13836184672449331213);
    }

    fun assert_performance_fee_payable(arg0: u64, arg1: &vector<Collector>) {
        assert!(arg0 == 0 || !0x1::vector::is_empty<Collector>(arg1), 13838155950769963035);
    }

    fun assert_performance_fee_rate(arg0: u64) {
        assert!(arg0 <= 1000000, 13836185604457234445);
    }

    public fun collector(arg0: address, arg1: u64) : Collector {
        assert!(arg0 != @0x0, 13835058459009351685);
        assert!(arg1 >= 1 && arg1 <= 1000000, 13835339938281160711);
        Collector{
            addr : arg0,
            pct  : arg1,
        }
    }

    public(friend) fun contains_address(arg0: &vector<Collector>, arg1: address) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<Collector>(arg0)) {
            if (0x1::vector::borrow<Collector>(arg0, v0).addr == arg1) {
                v1 = true;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = false;
        v1
    }

    public(friend) fun crystallize_performance_fee(arg0: &mut FeeState, arg1: u128, arg2: u64, arg3: u8, arg4: u64) : u64 {
        assert!(arg4 - arg0.watermark_updated_ms >= arg0.watermark_window_ms, 13836748081964515345);
        assert!(arg2 > 0, 13837592515484975127);
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math::share_price(arg1, arg2, arg3);
        assert!(v0 > arg0.high_watermark, 13837029574121226259);
        arg0.high_watermark = v0;
        arg0.watermark_updated_ms = arg4;
        performance_fee(arg1, arg2, arg0.high_watermark, arg3, arg0.performance_fee_rate)
    }

    public fun fee_collectors(arg0: &FeeState) : &vector<Collector> {
        &arg0.fee_collectors
    }

    public fun fees_timestamp_ms(arg0: &FeeState) : u64 {
        arg0.fees_timestamp_ms
    }

    public fun high_watermark(arg0: &FeeState) : u128 {
        arg0.high_watermark
    }

    public(friend) fun instant_redemption_fee(arg0: u64, arg1: u64) : u64 {
        narrow(0x1::u128::div_ceil((arg0 as u128) * (arg1 as u128), (10000 as u128)))
    }

    public fun instant_redemption_fee_bps(arg0: &FeeState) : u64 {
        arg0.instant_redemption_fee_bps
    }

    public fun management_fee_bps(arg0: &FeeState) : u64 {
        arg0.management_fee_bps
    }

    public fun management_fee_remainder(arg0: &FeeState) : u128 {
        arg0.management_fee_remainder
    }

    fun mul(arg0: u128, arg1: u128) : u128 {
        let v0 = 0x1::u128::checked_mul(arg0, arg1);
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 13836467139563618319
        };
    }

    fun narrow(arg0: u128) : u64 {
        let v0 = 0x1::u128::try_as_u64(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13836467156743487503
        };
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<Collector>, arg5: vector<Collector>) : FeeParams {
        assert_management_fee_bps(arg0);
        assert_performance_fee_rate(arg1);
        assert_instant_redemption_fee_bps(arg2);
        assert!(arg3 <= 31536000000, 13837310344723431445);
        if (!0x1::vector::is_empty<Collector>(&arg4)) {
            validate_collectors(&arg4);
        };
        if (!0x1::vector::is_empty<Collector>(&arg5)) {
            validate_collectors(&arg5);
        };
        assert_performance_fee_payable(arg1, &arg5);
        FeeParams{
            management_fee_bps         : arg0,
            performance_fee_rate       : arg1,
            instant_redemption_fee_bps : arg2,
            watermark_window_ms        : arg3,
            fee_collectors             : arg4,
            performance_fee_recipients : arg5,
        }
    }

    public(friend) fun new_state(arg0: FeeParams, arg1: u128, arg2: u64) : FeeState {
        let FeeParams {
            management_fee_bps         : v0,
            performance_fee_rate       : v1,
            instant_redemption_fee_bps : v2,
            watermark_window_ms        : v3,
            fee_collectors             : v4,
            performance_fee_recipients : v5,
        } = arg0;
        FeeState{
            management_fee_bps         : v0,
            fees_timestamp_ms          : arg2,
            management_fee_remainder   : 0,
            performance_fee_rate       : v1,
            high_watermark             : arg1,
            watermark_updated_ms       : arg2,
            watermark_window_ms        : v3,
            instant_redemption_fee_bps : v2,
            fee_collectors             : v4,
            performance_fee_recipients : v5,
        }
    }

    public fun pct(arg0: &Collector) : u64 {
        arg0.pct
    }

    public(friend) fun performance_fee(arg0: u128, arg1: u64, arg2: u128, arg3: u8, arg4: u64) : u64 {
        let v0 = mul(arg2, (arg1 as u128)) / 0x1::u128::pow(10, arg3);
        if (arg0 <= v0) {
            return 0
        };
        narrow(mul(arg0 - v0, (arg4 as u128)) / (1000000 as u128))
    }

    public fun performance_fee_rate(arg0: &FeeState) : u64 {
        arg0.performance_fee_rate
    }

    public fun performance_fee_recipients(arg0: &FeeState) : &vector<Collector> {
        &arg0.performance_fee_recipients
    }

    public(friend) fun reset_high_watermark(arg0: &mut FeeState, arg1: u128) {
        arg0.high_watermark = arg1;
    }

    public(friend) fun set_fee_collectors(arg0: &mut FeeState, arg1: vector<Collector>) : bool {
        validate_collectors(&arg1);
        arg0.fee_collectors = arg1;
        arg0.fee_collectors != arg1
    }

    public(friend) fun set_instant_redemption_fee_bps(arg0: &mut FeeState, arg1: u64) : bool {
        assert_instant_redemption_fee_bps(arg1);
        arg0.instant_redemption_fee_bps = arg1;
        arg0.instant_redemption_fee_bps != arg1
    }

    public(friend) fun set_management_fee_bps(arg0: &mut FeeState, arg1: u64) {
        assert_management_fee_bps(arg1);
        arg0.management_fee_bps = arg1;
    }

    public(friend) fun set_performance_fee_rate(arg0: &mut FeeState, arg1: u64) : bool {
        assert_performance_fee_rate(arg1);
        assert_performance_fee_payable(arg1, &arg0.performance_fee_recipients);
        arg0.performance_fee_rate = arg1;
        arg0.performance_fee_rate != arg1
    }

    public(friend) fun set_performance_fee_recipients(arg0: &mut FeeState, arg1: vector<Collector>) : bool {
        validate_collectors(&arg1);
        arg0.performance_fee_recipients = arg1;
        arg0.performance_fee_recipients != arg1
    }

    public(friend) fun split_fee(arg0: u64, arg1: &vector<Collector>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Collector>(arg1)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::u64::mul_div(arg0, 0x1::vector::borrow<Collector>(arg1, v1).pct, 1000000));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun split_performance_fee(arg0: u64, arg1: &vector<Collector>) : vector<u64> {
        let v0 = split_fee(arg0, arg1);
        let v1 = if (arg0 == 0) {
            true
        } else {
            let v2 = &v0;
            let v3 = 0;
            let v1;
            while (v3 < 0x1::vector::length<u64>(v2)) {
                if (!(*0x1::vector::borrow<u64>(v2, v3) > 0)) {
                    v1 = false;
                    /* goto 9 */
                } else {
                    /* goto 12 */
                };
            };
            v1
        };
        /* label 9 */
        assert!(v1, 13837873780008419353);
        v0
    }

    public(friend) fun total(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun validate_collectors(arg0: &vector<Collector>) {
        assert!(!0x1::vector::is_empty<Collector>(arg0), 13835621670956040201);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Collector>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<Collector>(arg0, v1).pct;
            v1 = v1 + 1;
        };
        assert!(v0 == 1000000, 13835903158817783819);
    }

    public fun watermark_updated_ms(arg0: &FeeState) : u64 {
        arg0.watermark_updated_ms
    }

    public fun watermark_window_ms(arg0: &FeeState) : u64 {
        arg0.watermark_window_ms
    }

    // decompiled from Move bytecode v7
}

