module 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation {
    public fun validate_all_bytes_consumed(arg0: 0x2::bcs::BCS) {
        let v0 = 0x2::bcs::into_remainder_bytes(arg0);
        assert!(0x1::vector::is_empty<u8>(&v0), 0);
    }

    // decompiled from Move bytecode v6
}

