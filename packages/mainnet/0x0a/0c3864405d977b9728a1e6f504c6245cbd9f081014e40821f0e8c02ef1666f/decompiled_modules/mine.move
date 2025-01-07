module 0xa0c3864405d977b9728a1e6f504c6245cbd9f081014e40821f0e8c02ef1666f::mine {
    public fun mint(arg0: vector<u64>, arg1: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner, arg2: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO> {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(&arg0, 0), arg2, arg1, arg3, arg5)
    }

    // decompiled from Move bytecode v6
}

