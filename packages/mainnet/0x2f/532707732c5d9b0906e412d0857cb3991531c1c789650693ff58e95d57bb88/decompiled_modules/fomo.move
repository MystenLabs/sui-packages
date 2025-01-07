module 0x2f532707732c5d9b0906e412d0857cb3991531c1c789650693ff58e95d57bb88::fomo {
    struct MinerList has key {
        id: 0x2::object::UID,
        miners: vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>,
    }

    public fun bietounikanbudong(arg0: vector<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MinerList{
            id     : 0x2::object::new(arg1),
            miners : arg0,
        };
        0x2::transfer::transfer<MinerList>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mine(arg0: vector<u64>, arg1: &mut 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::Bus, arg2: &mut MinerList, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(&arg0, 0), arg1, 0x1::vector::borrow_mut<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&mut arg2.miners, 0), arg3, arg4);
        let v1 = 1;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x2::coin::join<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>(&mut v0, 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::mine(*0x1::vector::borrow<u64>(&arg0, v1), arg1, 0x1::vector::borrow_mut<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::miner::Miner>(&mut arg2.miners, v1), arg3, arg4));
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::fomo::FOMO>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

