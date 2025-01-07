module 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::vector {
    public fun add_vectors(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(arg0, v2) + *0x1::vector::borrow<u64>(arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun add_vectors_128(arg0: &vector<u128>, arg1: &vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::length<u128>(arg0);
        assert!(v0 == 0x1::vector::length<u128>(arg1), 0);
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u128>(&mut v1, *0x1::vector::borrow<u128>(arg0, v2) + *0x1::vector::borrow<u128>(arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun empty_vector(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun empty_vector_128(arg0: u64) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u128>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun scale_fixed_vector_128_by_128(arg0: u128, arg1: &vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(arg1)) {
            0x1::vector::push_back<u128>(&mut v0, 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::mul_down_128(*0x1::vector::borrow<u128>(arg1, v1), arg0));
            v1 = v1 + 1;
        };
        v0
    }

    public fun scale_fixed_vector_128_by_64(arg0: u64, arg1: &vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(arg1)) {
            0x1::vector::push_back<u128>(&mut v0, (0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::mul_down((*0x1::vector::borrow<u128>(arg1, v1) as u256), (arg0 as u256)) as u128));
            v1 = v1 + 1;
        };
        v0
    }

    public fun scale_fixed_vector_64(arg0: u64, arg1: &vector<u64>) : vector<u64> {
        scale_fixed_vector_64_by_128((arg0 as u128), arg1)
    }

    public fun scale_fixed_vector_64_by_128(arg0: u128, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::convert_fixed_to_int(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::mul_down(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::convert_int_to_fixed(*0x1::vector::borrow<u64>(arg1, v1)), (arg0 as u256))));
            v1 = v1 + 1;
        };
        v0
    }

    public fun scale_mut_vector_128_128(arg0: &mut vector<u128>, arg1: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg0)) {
            *0x1::vector::borrow_mut<u128>(arg0, v0) = 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::mul_down_128(*0x1::vector::borrow<u128>(arg0, v0), arg1);
            v0 = v0 + 1;
        };
    }

    public fun scale_mut_vector_128_64(arg0: &mut vector<u128>, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg0)) {
            *0x1::vector::borrow_mut<u128>(arg0, v0) = 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::mul_by_fraction_128_64(*0x1::vector::borrow<u128>(arg0, v0), arg1);
            v0 = v0 + 1;
        };
    }

    public fun scale_mut_vector_64_128(arg0: &mut vector<u64>, arg1: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            *0x1::vector::borrow_mut<u64>(arg0, v0) = 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::mul_by_fraction_64_128(*0x1::vector::borrow<u64>(arg0, v0), arg1);
            v0 = v0 + 1;
        };
    }

    public fun scale_mut_vector_64_64(arg0: &mut vector<u64>, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            *0x1::vector::borrow_mut<u64>(arg0, v0) = 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::fixed::mul_by_fraction(*0x1::vector::borrow<u64>(arg0, v0), arg1);
            v0 = v0 + 1;
        };
    }

    public fun subtract_vectors(arg0: &vector<u64>, arg1: &vector<u64>) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(arg0, v3);
            let v5 = *0x1::vector::borrow<u64>(arg1, v3);
            if (v4 >= v5) {
                0x1::vector::push_back<u64>(&mut v1, v4 - v5);
                0x1::vector::push_back<u64>(&mut v2, 0);
            } else {
                0x1::vector::push_back<u64>(&mut v1, 0);
                0x1::vector::push_back<u64>(&mut v2, v5 - v4);
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun subtract_vectors_128(arg0: &vector<u128>, arg1: &vector<u128>) : (vector<u128>, vector<u128>) {
        let v0 = 0x1::vector::length<u128>(arg0);
        assert!(v0 == 0x1::vector::length<u128>(arg1), 0);
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u128>(arg0, v3);
            let v5 = *0x1::vector::borrow<u128>(arg1, v3);
            if (v4 >= v5) {
                0x1::vector::push_back<u128>(&mut v1, v4 - v5);
                0x1::vector::push_back<u128>(&mut v2, 0);
            } else {
                0x1::vector::push_back<u128>(&mut v1, 0);
                0x1::vector::push_back<u128>(&mut v2, v5 - v4);
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun sum_u64(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun vectors_disjoint_u128(arg0: &vector<u128>, arg1: &vector<u128>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg0)) {
            if (*0x1::vector::borrow<u128>(arg0, v0) != 0 && *0x1::vector::borrow<u128>(arg1, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun vectors_disjoint_u64(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) != 0 && *0x1::vector::borrow<u64>(arg1, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

