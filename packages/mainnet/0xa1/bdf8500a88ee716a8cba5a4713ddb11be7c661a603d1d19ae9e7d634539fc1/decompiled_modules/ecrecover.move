module 0xa1bdf8500a88ee716a8cba5a4713ddb11be7c661a603d1d19ae9e7d634539fc1::ecrecover {
    struct EcrecoverDebugEvent has copy, drop {
        msg: vector<u8>,
        final_msg: vector<u8>,
        struct_hash: vector<u8>,
        compressed_pubkey: vector<u8>,
        uncompressed_pubkey: vector<u8>,
        pubkey_wo_prefix: vector<u8>,
        evm_addr: vector<u8>,
    }

    fun reverse_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(&arg0);
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
        };
        v0
    }

    fun sub_range(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun test_ecrecover(arg0: address, arg1: u64, arg2: &mut vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg1, 12);
        assert!(0x1::vector::length<u8>(arg2) == 65, 13);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, x"c0badfdeb4a0dfe2dc31d578b5df74f7e294f9617bc9d459ca2f9af5c4844251");
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(784));
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, x"19457468657265756d205369676e6564204d6573736167653a0a3332");
        0x1::vector::append<u8>(&mut v2, v1);
        let v3 = 0x1::vector::borrow_mut<u8>(arg2, 64);
        if (*v3 == 27) {
            *v3 = 0;
        } else {
            assert!(*v3 == 28, 14);
            *v3 = 1;
        };
        let v4 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg2, &v2, 0);
        let v5 = 0x2::ecdsa_k1::decompress_pubkey(&v4);
        let v6 = sub_range(&v5, 1, 65);
        let v7 = 0x2::hash::keccak256(&v6);
        let v8 = EcrecoverDebugEvent{
            msg                 : v0,
            final_msg           : v2,
            struct_hash         : v1,
            compressed_pubkey   : v4,
            uncompressed_pubkey : v5,
            pubkey_wo_prefix    : v6,
            evm_addr            : sub_range(&v7, 12, 32),
        };
        0x2::event::emit<EcrecoverDebugEvent>(v8);
    }

    public entry fun test_ecrecover_entry(arg0: u64, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        test_ecrecover(0x2::tx_context::sender(arg3), arg0, v0, arg2);
    }

    public fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        reverse_bytes(0x1::bcs::to_bytes<u64>(&arg0))
    }

    // decompiled from Move bytecode v6
}

