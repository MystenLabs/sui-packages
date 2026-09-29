module 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::action_outcome {
    public(friend) fun decode_outcome_index(arg0: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 >= 6 + 1, 13906834307487825928);
        assert!(u16_be(arg0, 0) == 1, 13906834311782793224);
        assert!(u16_be(arg0, 2) == 1, 13906834316077760520);
        assert!(u16_be(arg0, 4) == 1, 13906834320372727816);
        let v1 = *0x1::vector::borrow<u8>(arg0, 6);
        let v2 = if (v1 == 0) {
            true
        } else if (v1 == 1) {
            true
        } else {
            v1 == 2
        };
        if (v2) {
            assert!(v0 == 6 + 1, 13906834333257629704);
            v1
        } else {
            assert!(v1 == 3, 13906834346142531592);
            assert!(v0 == 15, 13906834350437498888);
            let v4 = 0;
            let v5 = 0;
            while (v4 < 8) {
                let v6 = v5 << 8;
                v5 = v6 + (*0x1::vector::borrow<u8>(arg0, 6 + 1 + v4) as u64);
                v4 = v4 + 1;
            };
            assert!(v5 > 0, 13906834380502269960);
            3
        }
    }

    fun u16_be(arg0: &vector<u8>, arg1: u64) : u16 {
        ((*0x1::vector::borrow<u8>(arg0, arg1) as u16) << 8) + (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u16)
    }

    // decompiled from Move bytecode v7
}

