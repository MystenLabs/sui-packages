module 0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::median {
    public fun calculate_median(arg0: &mut vector<u256>) : u256 {
        let v0 = 0x1::vector::length<u256>(arg0);
        assert!(v0 > 0, 0);
        sort(arg0);
        if (v0 % 2 == 1) {
            *0x1::vector::borrow<u256>(arg0, v0 / 2)
        } else {
            *0x1::vector::borrow<u256>(arg0, v0 / 2 - 1)
        }
    }

    public fun sort(arg0: &mut vector<u256>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u256>(arg0)) {
            let v1 = *0x1::vector::borrow<u256>(arg0, v0);
            let v2 = v0;
            while (v2 > 0 && *0x1::vector::borrow<u256>(arg0, v2 - 1) > v1) {
                *0x1::vector::borrow_mut<u256>(arg0, v2) = *0x1::vector::borrow<u256>(arg0, v2 - 1);
                v2 = v2 - 1;
            };
            *0x1::vector::borrow_mut<u256>(arg0, v2) = v1;
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

