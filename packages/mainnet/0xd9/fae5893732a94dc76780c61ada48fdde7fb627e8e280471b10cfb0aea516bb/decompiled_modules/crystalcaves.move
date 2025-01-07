module 0xd9fae5893732a94dc76780c61ada48fdde7fb627e8e280471b10cfb0aea516bb::crystalcaves {
    struct BlockMined has copy, drop {
        numBlocks: u64,
    }

    entry fun mineBlocksOnly<T0>(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockMined{numBlocks: 0x1::vector::length<u256>(&arg0)};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

