module 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::utils {
    public(friend) fun extract_balance<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            if (arg1 > 0) {
                let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
                if (0x2::coin::value<T0>(&v1) >= arg1) {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v1), arg1));
                    0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg0, v1);
                    arg1 = 0;
                    break
                };
                arg1 = arg1 - 0x2::coin::value<T0>(&v1);
                0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v1));
            } else {
                break
            };
        };
        assert!(arg1 == 0, 0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0), 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public(friend) fun from_vec_to_map<T0: copy + drop, T1: drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 2);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<T0, T1>();
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x2::vec_map::insert<T0, T1>(&mut v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun rand(arg0: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        0x2::object::delete(v0);
        let v2 = 0x2::tx_context::epoch(arg0);
        let v3 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v3));
        let v4 = 0x1::hash::sha3_256(v1);
        u256_from_bytes(&v4)
    }

    public(friend) fun u256_from_bytes(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 <= 32, 1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 << 8;
            v0 = v3 + (*0x1::vector::borrow<u8>(arg0, v2) as u256);
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun u64_from_bytes(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 <= 8, 1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 * 10 + (*0x1::vector::borrow<u8>(arg0, v2) as u64);
            v0 = v3 - 48;
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

