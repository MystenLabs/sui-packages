module 0x573efd84dc663c6834a24be4298eb3bf73ff59dbf98abfe639b82886ef28edab::utils {
    struct Marker<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun marker<T0>() : Marker<T0> {
        Marker<T0>{dummy_field: false}
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1002);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 1003);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

