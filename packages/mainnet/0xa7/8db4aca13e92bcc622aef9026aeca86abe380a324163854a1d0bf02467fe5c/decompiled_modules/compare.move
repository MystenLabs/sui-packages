module 0xa78db4aca13e92bcc622aef9026aeca86abe380a324163854a1d0bf02467fe5c::compare {
    public fun cmp_bcs_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        while (v0 > 0 && v1 > 0) {
            let v2 = v0 - 1;
            v0 = v2;
            let v3 = v1 - 1;
            v1 = v3;
            let v4 = cmp_u8(*0x1::vector::borrow<u8>(arg0, v2), *0x1::vector::borrow<u8>(arg1, v3));
            if (v4 != 0) {
                return v4
            };
        };
        cmp_u64(v0, v1)
    }

    fun cmp_u64(arg0: u64, arg1: u64) : u8 {
        if (arg0 == arg1) {
            0
        } else if (arg0 < arg1) {
            1
        } else {
            2
        }
    }

    fun cmp_u8(arg0: u8, arg1: u8) : u8 {
        if (arg0 == arg1) {
            0
        } else if (arg0 < arg1) {
            1
        } else {
            2
        }
    }

    // decompiled from Move bytecode v6
}

