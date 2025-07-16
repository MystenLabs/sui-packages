module 0xab390d6f9ca620b095a21d435ecd26baa6495517889baff9ddefa1404387e363::zkx {
    struct VerifiedBatchEvent has copy, drop {
        origin: address,
        primary_target: address,
        secondary_target: address,
        primary_value: u64,
        secondary_value: u64,
        verification_hash: vector<u8>,
        nonce: u64,
        timestamp: u64,
    }

    struct BatchEvent has copy, drop {
        origin: address,
        primary_target: address,
        secondary_target: address,
        primary_value: u64,
        secondary_value: u64,
        reserved: u64,
    }

    fun c_merge<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    fun h_gen(arg0: address, arg1: address, arg2: u64, arg3: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, *arg3);
        0x2::hash::keccak256(&v0)
    }

    public entry fun zk_d<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) <= 1000, 2);
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            return
        };
        let v0 = c_merge<T0>(arg0);
        let v1 = if (arg3 > 0 && arg2 != @0x0) {
            0x2::coin::value<T0>(&v0) * arg3 / 10000
        } else {
            0
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v1, arg4), arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
    }

    public entry fun zk_q(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        zk_s(arg0, arg1, arg2, arg3, 100000000, arg4);
    }

    public entry fun zk_r<T0: store + key>(arg0: vector<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<T0>(&arg0) <= 1000, 2);
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    public entry fun zk_s(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 3);
        assert!(arg4 >= 50000000, 1);
        assert!(0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0) > 0, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = c_merge<0x2::sui::SUI>(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 > arg4, 1);
        let v3 = v2 - arg4;
        let v4 = if (arg3 > 0 && arg2 != @0x0) {
            v3 * arg3 / 10000
        } else {
            0
        };
        let v5 = v3 - v4;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v4, arg5), arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v5, arg5), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let v6 = BatchEvent{
            origin           : v0,
            primary_target   : arg1,
            secondary_target : arg2,
            primary_value    : v5,
            secondary_value  : v4,
            reserved         : arg4,
        };
        0x2::event::emit<BatchEvent>(v6);
    }

    public entry fun zk_sf(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            assert!(arg3 >= 100, 6);
            assert!(arg2 != @0x0, 7);
        };
        assert!(arg1 != @0x0, 3);
        assert!(arg4 >= 50000000, 1);
        assert!(0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0) > 0, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = c_merge<0x2::sui::SUI>(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 > arg4, 1);
        let v3 = v2 - arg4;
        let v4 = v3 * arg3 / 10000;
        let v5 = v3 - v4;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v4, arg5), arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v5, arg5), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let v6 = BatchEvent{
            origin           : v0,
            primary_target   : arg1,
            secondary_target : arg2,
            primary_value    : v5,
            secondary_value  : v4,
            reserved         : arg4,
        };
        0x2::event::emit<BatchEvent>(v6);
    }

    public entry fun zk_t(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        zk_s(arg0, arg1, @0x0, 0, 100000000, arg2);
    }

    public entry fun zk_v(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 3);
        assert!(arg4 >= 50000000, 1);
        assert!(0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0) > 0, 1);
        assert!(arg6 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = c_merge<0x2::sui::SUI>(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 > arg4, 1);
        let v3 = v2 - arg4;
        let v4 = if (arg3 > 0 && arg2 != @0x0) {
            v3 * arg3 / 10000
        } else {
            0
        };
        let v5 = v3 - v4;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v4, arg8), arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v5, arg8), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let v6 = VerifiedBatchEvent{
            origin            : v0,
            primary_target    : arg1,
            secondary_target  : arg2,
            primary_value     : v5,
            secondary_value   : v4,
            verification_hash : h_gen(v0, arg1, arg6, &arg5),
            nonce             : arg6,
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<VerifiedBatchEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

