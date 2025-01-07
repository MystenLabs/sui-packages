module 0x871615593cc19d1b314ea82519ae8f2bb35a808991cc2b4423961369c4c4eac1::mine {
    public fun mine_swap(arg0: u64, arg1: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg2: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO> {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

