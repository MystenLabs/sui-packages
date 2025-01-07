module 0x884c2cfc2978518f0cd3f805cdbaa5e9acdbbef224d968c6a5e8e77bad51e04f::random_utils {
    public(friend) fun weighted_random_choice<T0: copy + drop>(arg0: vector<u64>, arg1: vector<T0>, arg2: &mut 0x2::random::RandomGenerator) : T0 {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<T0>(&arg1), 1);
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg0);
        while (!0x1::vector::is_empty<u64>(&arg0)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg0);
        };
        0x1::vector::destroy_empty<u64>(arg0);
        let v1 = 0;
        let v2 = 0;
        loop {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg0, v2);
            if (0x2::random::generate_u64_in_range(arg2, 0, v0 - 1) < v1) {
                break
            };
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<T0>(&arg1, v2)
    }

    // decompiled from Move bytecode v6
}

