module 0xa8a56d70440dbabfc28784934a128273059e95b8ed3e47a5f0bf5ad88c3552ac::send_nfts {
    public fun transfer_nft_batch<T0: store + key>(arg0: vector<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x1::vector::length<T0>(&arg0) == v0, 0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), *0x1::vector::borrow<address>(&arg1, v0 - v1 - 1));
            v1 = v1 + 1;
        };
        assert!(0x1::vector::is_empty<T0>(&arg0), 0);
        0x1::vector::destroy_empty<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

