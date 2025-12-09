module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::address {
    public fun assert_non_zero_address(arg0: address) {
        assert!(arg0 != @0x0, 1);
    }

    public fun assert_non_zero_address_vector(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 1);
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (!(*0x1::vector::borrow<u8>(arg0, v0) == 0)) {
                v1 = false;
                /* label 9 */
                assert!(!v1, 1);
                return
            };
            v0 = v0 + 1;
        };
        v1 = true;
        /* goto 9 */
    }

    // decompiled from Move bytecode v6
}

