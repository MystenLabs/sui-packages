module 0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::vectors {
    public fun has_duplicates<T0>(arg0: &vector<T0>) : bool {
        let v0 = 0x1::vector::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<T0>(arg0, v1);
            let v3 = v1 + 1;
            while (v3 < v0) {
                if (v2 == 0x1::vector::borrow<T0>(arg0, v3)) {
                    return true
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun intersect<T0>(arg0: &vector<T0>, arg1: &vector<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(arg0)) {
            let v1 = 0x1::vector::borrow<T0>(arg0, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<T0>(arg1)) {
                if (v1 == 0x1::vector::borrow<T0>(arg1, v2)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

