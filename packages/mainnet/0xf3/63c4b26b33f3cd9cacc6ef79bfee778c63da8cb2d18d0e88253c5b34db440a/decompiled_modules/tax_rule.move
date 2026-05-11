module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::tax_rule {
    public fun apply_tax_bps(arg0: u64, arg1: u16) : (u64, u64) {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        (arg0 - v0, v0)
    }

    public fun assert_valid_tax_bps(arg0: u16) {
        assert!(arg0 >= 100, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_tax_invalid_bps());
        assert!(arg0 <= 1000, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_tax_invalid_bps());
    }

    public fun bps_denominator() : u16 {
        10000
    }

    public fun max_tax_bps() : u16 {
        1000
    }

    public fun min_tax_bps() : u16 {
        100
    }

    public fun post_graduation_tax_bps() : u16 {
        100
    }

    // decompiled from Move bytecode v6
}

