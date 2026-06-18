module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest {
    struct RateCurve has store, key {
        id: 0x2::object::UID,
        kind: u8,
        base_bps: u64,
        slope1_bps: u64,
        slope2_bps: u64,
        u_opt_bps: u64,
    }

    public fun borrow_apr(arg0: &RateCurve, arg1: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        assert!(arg0.kind == 0, 1);
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_bps(arg0.u_opt_bps);
        if (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::le(arg1, v0)) {
            0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_bps(arg0.base_bps), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_bps(arg0.slope1_bps), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(arg1, v0)))
        } else {
            0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_bps(arg0.base_bps), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_bps(arg0.slope1_bps)), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_bps(arg0.slope2_bps), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub(arg1, v0), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::one(), v0))))
        }
    }

    public fun compound_factor(arg0: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg1: u64) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        let v0 = if (arg1 > 604800) {
            604800
        } else {
            arg1
        };
        if (v0 == 0) {
            return 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::one()
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::pow(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::one(), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(arg0, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_u256(31536000))), v0)
    }

    public fun create_curve(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg3 > 0 && arg3 < 10000, 0);
        let v0 = if (arg0 <= 1000000) {
            if (arg1 <= 1000000) {
                arg2 <= 1000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = RateCurve{
            id         : 0x2::object::new(arg4),
            kind       : 0,
            base_bps   : arg0,
            slope1_bps : arg1,
            slope2_bps : arg2,
            u_opt_bps  : arg3,
        };
        0x2::transfer::share_object<RateCurve>(v1);
        0x2::object::id<RateCurve>(&v1)
    }

    public(friend) fun kind(arg0: &RateCurve) : u8 {
        arg0.kind
    }

    public fun supply_apr(arg0: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg1: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg2: u64) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(arg0, arg1), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::one(), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_bps(arg2)))
    }

    public(friend) fun u_opt_bps(arg0: &RateCurve) : u64 {
        arg0.u_opt_bps
    }

    public fun utilization(arg0: u256, arg1: u256, arg2: u256) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        if (arg1 == 0) {
            return 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero()
        };
        let v0 = arg0 + arg1;
        let v1 = if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_u256(arg1), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_u256(v1))
    }

    // decompiled from Move bytecode v7
}

