module 0x96950ca80c4fcbaee10a6a1e3bc883e69d13d8016ed44d699444d28054a36b77::fee_payload {
    public fun decode(arg0: &vector<u8>) : (address, u64) {
        assert!(0x1::vector::length<u8>(arg0) == 64, 0);
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 0, 32);
        assert!(v0 != @0x0, 2);
        let v1 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 32, 32);
        assert!(v1 <= 18446744073709551615, 1);
        (v0, (v1 as u64))
    }

    // decompiled from Move bytecode v7
}

