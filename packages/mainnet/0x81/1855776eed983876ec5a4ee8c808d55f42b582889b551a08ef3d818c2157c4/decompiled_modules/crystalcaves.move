module 0x811855776eed983876ec5a4ee8c808d55f42b582889b551a08ef3d818c2157c4::crystalcaves {
    struct BlockMined has copy, drop {
        numBlocks: u64,
    }

    entry fun mineBlocksOnly<T0>(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockMined{numBlocks: 0x1::vector::length<u256>(&arg0)};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

