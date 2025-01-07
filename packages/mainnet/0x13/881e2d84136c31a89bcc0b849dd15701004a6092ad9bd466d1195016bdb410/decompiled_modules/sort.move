module 0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::sort {
    public fun swap<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64, arg2: u64) {
        *0x1::vector::borrow_mut<T0>(arg0, arg1) = *0x1::vector::borrow<T0>(arg0, arg2);
        *0x1::vector::borrow_mut<T0>(arg0, arg2) = *0x1::vector::borrow<T0>(arg0, arg1);
    }

    public fun is_sorted(arg0: &vector<u64>) : bool {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) > *0x1::vector::borrow<u64>(arg0, v0 - 1)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun shell_sort_desc<T0: copy + drop + store>(arg0: &mut vector<u64>, arg1: &mut vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg1);
        assert!(0x1::vector::length<u64>(arg0) == v0, 1);
        if (v0 <= 1) {
            return
        };
        let v1 = 1;
        while (v1 < v0 / 3) {
            let v2 = 3 * v1;
            v1 = v2 + 1;
        };
        while (v1 >= 1) {
            let v3 = v1;
            while (v3 < v0) {
                while (v3 >= v1 && *0x1::vector::borrow<u64>(arg0, v3) > *0x1::vector::borrow<u64>(arg0, v3 - v1)) {
                    swap<u64>(arg0, v3, v3 - v1);
                    swap<T0>(arg1, v3, v3 - v1);
                    v3 = v3 - v1;
                };
                v3 = v3 + 1;
            };
            v1 = v1 / 3;
        };
    }

    // decompiled from Move bytecode v6
}

