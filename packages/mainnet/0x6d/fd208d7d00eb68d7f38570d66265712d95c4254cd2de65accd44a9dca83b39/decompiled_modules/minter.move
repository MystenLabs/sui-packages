module 0x6dfd208d7d00eb68d7f38570d66265712d95c4254cd2de65accd44a9dca83b39::minter {
    public fun mint_and_transfer(arg0: vector<u64>, arg1: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg2: &mut vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            let v1 = 0x1::vector::pop_back<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>>(0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(&arg0, v0), arg1, &mut v1, arg3, arg4), 0x2::tx_context::sender(arg4));
            0x1::vector::push_back<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(arg2, v1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

