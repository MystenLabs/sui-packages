module 0xb936ae8317c279f0ca442ee89a9036ca90a6d45833dfe134210ab3bc1c09e613::warehouse_utils {
    public fun redeem_random_nft<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::supply<T0>(arg1);
        assert!(v0 != 0, 1);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v0));
        let v2 = 0x2::clock::timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        let v3 = 0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::rand_no_counter(v1, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::redeem_nft_at_index<T0>(arg1, ((0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::u256_from_bytes(&v3) % (v0 as u256)) as u64))
    }

    // decompiled from Move bytecode v6
}

