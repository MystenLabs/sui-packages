module 0xbde7834237e8b3c4fa069f9a4168679e3780cf1c29f44e8e083cb2d4cb5021a7::minter {
    struct MinerList has key {
        id: 0x2::object::UID,
        miners: vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>,
        current_index: u64,
        recipient: address,
    }

    public fun add_miner(arg0: &mut MinerList, arg1: vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>) {
        0x1::vector::append<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&mut arg0.miners, arg1);
    }

    public fun create_miner_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MinerList{
            id            : 0x2::object::new(arg0),
            miners        : 0x1::vector::empty<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(),
            current_index : 0,
            recipient     : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<MinerList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_and_transfer(arg0: vector<u64>, arg1: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg2: &mut MinerList, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>>(0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(&arg0, v0), arg1, 0x1::vector::borrow_mut<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&mut arg2.miners, v0), arg3, arg4), arg2.recipient);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
    }

    // decompiled from Move bytecode v6
}

