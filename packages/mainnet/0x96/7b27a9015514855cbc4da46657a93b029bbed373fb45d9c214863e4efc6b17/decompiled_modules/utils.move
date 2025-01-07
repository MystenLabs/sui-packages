module 0x967b27a9015514855cbc4da46657a93b029bbed373fb45d9c214863e4efc6b17::utils {
    public fun destroy_zero_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha2_256(arg0)
    }

    public fun handle_coin_vector<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            return v0
        };
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 > arg1) {
            0x2::pay::split_and_transfer<T0>(&mut v0, v1 - arg1, 0x2::tx_context::sender(arg2), arg2);
        };
        v0
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (lt(&arg0, &arg1)) {
            efficient_hash(arg0, arg1)
        } else {
            efficient_hash(arg1, arg0)
        }
    }

    fun lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 == 0x1::vector::length<u8>(arg1), 998);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v2 < v3) {
                return true
            };
            if (v2 > v3) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    fun process_proof(arg0: &vector<vector<u8>>, arg1: vector<u8>) : vector<u8> {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            v0 = hash_pair(v0, *0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun pseudo_random(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x2::object::new(arg2);
        0x2::object::delete(v1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::UID>(&v1));
        let v2 = 0x1::hash::sha2_256(v0);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 24;
        while (v4 < 32) {
            let v5 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v2, v4));
            0x1::vector::append<u8>(&mut v3, v5);
            v4 = v4 + 1;
        };
        assert!(arg1 > 0, 999);
        let v6 = 0x2::bcs::new(v3);
        let v7 = 0x2::bcs::peel_u64(&mut v6) % arg1 + 1;
        let v8 = v7;
        if (v7 == 0) {
            v8 = 1;
        };
        v8
    }

    public fun verify(arg0: &vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        process_proof(arg0, arg2) == arg1
    }

    // decompiled from Move bytecode v6
}

