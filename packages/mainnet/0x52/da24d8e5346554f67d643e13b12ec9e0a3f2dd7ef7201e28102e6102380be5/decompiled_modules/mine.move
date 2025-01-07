module 0x52da24d8e5346554f67d643e13b12ec9e0a3f2dd7ef7201e28102e6102380be5::mine {
    public fun mint(arg0: vector<u64>, arg1: &mut vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>, arg2: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>>(0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(&arg0, v0), arg2, 0x1::vector::borrow_mut<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(arg1, v0), arg3, arg5), arg4);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

