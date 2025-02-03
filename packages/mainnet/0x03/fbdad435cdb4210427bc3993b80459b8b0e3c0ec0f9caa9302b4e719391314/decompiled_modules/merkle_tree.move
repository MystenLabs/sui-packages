module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::merkle_tree {
    fun hash(arg0: &vector<u8>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20 {
        let v0 = 0x2::hash::keccak256(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 20) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::new(v1)
    }

    public fun construct_proofs(arg0: &vector<vector<u8>>, arg1: u8) : (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20, vector<u8>) {
        if (1 << arg1 < 0x1::vector::length<vector<u8>>(arg0)) {
            abort 1212121
        };
        let v0 = 0x1::vector::empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>();
        let v1 = 0;
        while (v1 < (1 << arg1 + 1) + 1) {
            0x1::vector::push_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>(&mut v0, empty_leaf_hash());
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v3 = &mut v0;
            set_element<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>(v3, leaf_hash(0x1::vector::borrow<vector<u8>>(arg0, v2)), (1 << arg1) + v2);
            v2 = v2 + 1;
        };
        while (arg1 > 0) {
            let v4 = arg1 - 1;
            let v5 = 0;
            while (v5 < 1 << v4) {
                let v6 = (1 << v4) + v5;
                let v7 = &mut v0;
                set_element<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>(v7, node_hash(*0x1::vector::borrow<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>(&v0, v6 * 2), *0x1::vector::borrow<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>(&v0, v6 * 2 + 1)), v6);
                v5 = v5 + 1;
            };
            arg1 = arg1 - 1;
        };
        let v8 = 0x1::vector::empty<u8>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v10 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v10, arg1);
            let v11 = (1 << arg1) + v9;
            while (v11 > 1) {
                0x1::vector::append<u8>(&mut v10, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::data(0x1::vector::borrow<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>(&v0, v11 ^ 1)));
                v11 = v11 / 2;
            };
            0x1::vector::append<u8>(&mut v8, v10);
            v9 = v9 + 1;
        };
        (*0x1::vector::borrow<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20>(&v0, 1), v8)
    }

    fun empty_leaf_hash() : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 2);
        hash(&v0)
    }

    fun greater_than(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20) : bool {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::data(arg0);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::data(arg1);
        let v2 = 0;
        while (v2 < 20) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            let v4 = *0x1::vector::borrow<u8>(&v1, v2);
            if (v3 > v4) {
                return true
            };
            if (v4 > v3) {
                return false
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun is_proof_valid(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20, arg2: vector<u8>) : bool {
        let v0 = leaf_hash(&arg2);
        let v1 = 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(arg0);
        while (v1 > 0) {
            let v2 = v0;
            v0 = node_hash(v2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::new(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_vector(arg0, 20)));
            v1 = v1 - 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::data(&v0) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::data(&arg1)
    }

    fun leaf_hash(arg0: &vector<u8>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        hash(&v0)
    }

    fun node_hash(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20 {
        if (greater_than(&arg0, &arg1)) {
            let v0 = arg1;
            arg1 = arg0;
            arg0 = v0;
        };
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::data(&arg0);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::data(&arg1);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v3, 1);
        let v4 = 0;
        while (v4 < 20) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v1, v4));
            v4 = v4 + 1;
        };
        let v5 = 0;
        while (v5 < 20) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v5));
            v5 = v5 + 1;
        };
        hash(&v3)
    }

    fun set_element<T0: drop>(arg0: &mut vector<T0>, arg1: T0, arg2: u64) {
        0x1::vector::push_back<T0>(arg0, arg1);
        0x1::vector::swap_remove<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

