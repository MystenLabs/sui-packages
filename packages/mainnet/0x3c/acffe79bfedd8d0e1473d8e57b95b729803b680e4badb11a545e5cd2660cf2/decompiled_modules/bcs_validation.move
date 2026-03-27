module 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::bcs_validation {
    public fun validate_all_bytes_consumed(arg0: 0x2::bcs::BCS) {
        let v0 = 0x2::bcs::into_remainder_bytes(arg0);
        assert!(0x1::vector::is_empty<u8>(&v0), 0);
    }

    // decompiled from Move bytecode v6
}

