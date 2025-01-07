module 0x6a981dd7bab3bfc7c96c2c833c15f9b5b1ca0833c336378d90c5d774538880bf::mine {
    public fun mint(arg0: vector<u64>, arg1: &mut vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>, arg2: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>>(0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(&arg0, 0), arg2, 0x1::vector::borrow_mut<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(arg1, 0), arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

