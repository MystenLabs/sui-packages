module 0x66c3e6ecdb57b209b4b8c922c14136e70e096547c35b18ed966c6f383d373d28::crystalcaves {
    struct BlockMined has copy, drop {
        count: u64,
    }

    entry fun testFun<T0>(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock) {
        let v0 = BlockMined{count: 111};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

