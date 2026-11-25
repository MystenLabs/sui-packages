module 0xe96cb3dc949cf7637cc7e0cca519edfd5920efaca78bdbc0dc2497a5b2c38b3c::party_link_instagram {
    struct Instagram has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = 0x1::string::into_bytes(arg1);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 >= 1 && v1 <= 30, 0);
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
                /* label 18 */
                assert!(v6, 2);
                let v7 = Instagram{dummy_field: false};
                0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Instagram>(arg0, v7, v0);
                return
            };
            v5 = v5 + 1;
        };
        v6 = false;
        /* goto 18 */
    }

    fun is_allowed(arg0: u8) : bool {
        let v0 = b"._";
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

