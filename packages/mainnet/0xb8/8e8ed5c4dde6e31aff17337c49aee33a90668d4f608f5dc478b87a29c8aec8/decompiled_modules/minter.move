module 0xb88e8ed5c4dde6e31aff17337c49aee33a90668d4f608f5dc478b87a29c8aec8::minter {
    public fun mint_and_transfer(arg0: &vector<u64>, arg1: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg2: vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0) && v0 < 0x1::vector::length<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>>(0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(arg0, v0), arg1, 0x1::vector::borrow_mut<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&mut arg2, v0), arg3, arg4), 0x2::tx_context::sender(arg4));
            v0 = v0 + 1;
        };
        arg2
    }

    // decompiled from Move bytecode v6
}

