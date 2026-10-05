module 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::action_outcome {
    public(friend) fun decode_outcome_index(arg0: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 >= 6 + 1, 13906834311782793224);
        assert!(u16_be(arg0, 0) == 1, 13906834316077760520);
        assert!(u16_be(arg0, 2) == 1, 13906834320372727816);
        assert!(u16_be(arg0, 4) == 1, 13906834324667695112);
        let v1 = *0x1::vector::borrow<u8>(arg0, 6);
        let v2 = if (v1 == 0) {
            true
        } else if (v1 == 1) {
            true
        } else {
            v1 == 2
        };
        if (v2) {
            assert!(v0 == 6 + 1, 13906834337552597000);
            v1
        } else {
            assert!(v1 == 3, 13906834350437498888);
            assert!(v0 == 15, 13906834354732466184);
            let v4 = 0;
            let v5 = 0;
            while (v4 < 8) {
                let v6 = v5 << 8;
                v5 = v6 + (*0x1::vector::borrow<u8>(arg0, 6 + 1 + v4) as u64);
                v4 = v4 + 1;
            };
            assert!(v5 > 0, 13906834384797237256);
            3
        }
    }

    fun u16_be(arg0: &vector<u8>, arg1: u64) : u16 {
        ((*0x1::vector::borrow<u8>(arg0, arg1) as u16) << 8) + (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u16)
    }

    // decompiled from Move bytecode v7
}

