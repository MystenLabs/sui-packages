module 0x17a2ac6f13c7e6c767319175b4141536dcd74552282b52b0d4faff7921412eb6::minter {
    struct MinerList has key {
        id: 0x2::object::UID,
        miners: 0x2::vec_map::VecMap<u64, 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>,
        current_index: u64,
    }

    public fun add_miner(arg0: &mut MinerList, arg1: 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner) {
        0x2::vec_map::insert<u64, 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&mut arg0.miners, 0x2::vec_map::size<u64, 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&arg0.miners), arg1);
    }

    public fun create_miner_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MinerList{
            id            : 0x2::object::new(arg0),
            miners        : 0x2::vec_map::empty<u64, 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(),
            current_index : 0,
        };
        0x2::transfer::transfer<MinerList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_and_transfer(arg0: u64, arg1: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg2: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>>(0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

