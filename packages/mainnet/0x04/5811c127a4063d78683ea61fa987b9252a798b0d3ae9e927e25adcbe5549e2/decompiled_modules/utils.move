module 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::utils {
    public fun merge_vec_set<T0: copy + drop>(arg0: &mut 0x2::vec_set::VecSet<T0>, arg1: 0x2::vec_set::VecSet<T0>) {
        let v0 = *0x2::vec_set::keys<T0>(&arg1);
        while (!0x1::vector::is_empty<T0>(&v0)) {
            let v1 = 0x1::vector::pop_back<T0>(&mut v0);
            if (!0x2::vec_set::contains<T0>(arg0, &v1)) {
                0x2::vec_set::insert<T0>(arg0, 0x1::vector::pop_back<T0>(&mut v0));
            };
        };
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = u128_mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun u128_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(arg2 > 0, 0);
        v0 / arg2 * v1 + v0 % arg2 * v1 / arg2
    }

    // decompiled from Move bytecode v6
}

