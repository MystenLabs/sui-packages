module 0x4dd2708dd890475eb55bf0ba228d0e930b5a4ca29e478818ab82df5f8afa9a03::fee_payload {
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

