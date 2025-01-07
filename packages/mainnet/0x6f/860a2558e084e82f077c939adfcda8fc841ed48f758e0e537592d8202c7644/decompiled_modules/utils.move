module 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils {
    public(friend) fun BRIDGE_CHANNEL() : vector<u8> {
        b"BounceBit Token Bridge"
    }

    fun assertEthAddress(arg0: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) == 20, 103);
    }

    public fun assertEthAddressList(arg0: vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            assertEthAddress(*0x1::vector::borrow<vector<u8>>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    public fun ethAddressFromPubkey(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 64, 102);
        let v0 = 0x2::hash::keccak256(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 12;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun joinCoins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::bag::Bag, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
        if (0x2::bag::contains<u8>(arg2, arg3)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<u8, 0x2::coin::Coin<T0>>(arg2, arg3), 0x2::coin::split<T0>(&mut v0, arg1, arg4));
        } else {
            0x2::bag::add<u8, 0x2::coin::Coin<T0>>(arg2, arg3, 0x2::coin::split<T0>(&mut v0, arg1, arg4));
        };
    }

    public fun recoverEthAddress(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        *0x1::vector::borrow_mut<u8>(&mut arg2, 0) = *0x1::vector::borrow<u8>(&arg2, 0) & 127;
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, arg1);
        0x1::vector::push_back<vector<u8>>(v1, arg2);
        0x1::vector::push_back<vector<u8>>(v1, 0x1::vector::singleton<u8>(*0x1::vector::borrow<u8>(&arg2, 0) >> 7));
        let v2 = 0x1::vector::flatten<u8>(v0);
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v2, &arg0, 0);
        let v4 = 0x2::ecdsa_k1::decompress_pubkey(&v3);
        0x1::vector::remove<u8>(&mut v4, 0);
        ethAddressFromPubkey(v4)
    }

    public fun smallU64Log10(arg0: u64) : u64 {
        assert!(arg0 < 10000, 101);
        let v0 = 0;
        arg0 = arg0 / 10;
        while (arg0 != 0) {
            arg0 = arg0 / 10;
            v0 = v0 + 1;
        };
        v0
    }

    public fun smallU64ToString(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        assert!(arg0 < 10000000000, 100);
        if (arg0 >= 1000000000) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 1000000000) as u8) + 48);
        };
        if (arg0 >= 100000000) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 100000000 % 10) as u8) + 48);
        };
        if (arg0 >= 10000000) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 10000000 % 10) as u8) + 48);
        };
        if (arg0 >= 1000000) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 1000000 % 10) as u8) + 48);
        };
        if (arg0 >= 100000) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 100000 % 10) as u8) + 48);
        };
        if (arg0 >= 10000) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 10000 % 10) as u8) + 48);
        };
        if (arg0 >= 1000) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 1000 % 10) as u8) + 48);
        };
        if (arg0 >= 100) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 100 % 10) as u8) + 48);
        };
        if (arg0 >= 10) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 / 10 % 10) as u8) + 48);
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
        v0
    }

    // decompiled from Move bytecode v6
}

