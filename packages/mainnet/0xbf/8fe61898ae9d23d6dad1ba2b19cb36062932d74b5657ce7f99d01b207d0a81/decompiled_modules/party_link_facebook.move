module 0xbf8fe61898ae9d23d6dad1ba2b19cb36062932d74b5657ce7f99d01b207d0a81::party_link_facebook {
    struct Facebook has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = 0x1::string::into_bytes(arg1);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 >= 1 && v1 <= 50, 0);
        let v2 = &v0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            assert!(is_allowed(*0x1::vector::borrow<u8>(v2, v3)), 1);
            v3 = v3 + 1;
        };
        let v4 = &v0;
        let v5 = 0;
        let v6;
        while (v5 < 0x1::vector::length<u8>(v4)) {
            if (*0x1::vector::borrow<u8>(v4, v5) != 46) {
                v6 = true;
                /* label 19 */
                assert!(v6, 2);
                let v7 = Facebook{dummy_field: false};
                0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Facebook>(arg0, v7, v0);
                return
            };
            v5 = v5 + 1;
        };
        v6 = false;
        /* goto 19 */
    }

    fun is_allowed(arg0: u8) : bool {
        let v0 = b".";
        if (arg0 >= 48 && arg0 <= 57) {
            true
        } else if (arg0 >= 97 && arg0 <= 122) {
            true
        } else if (arg0 >= 65 && arg0 <= 90) {
            true
        } else {
            0x1::vector::contains<u8>(&v0, &arg0)
        }
    }

    // decompiled from Move bytecode v7
}

