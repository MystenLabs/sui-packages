module 0xe704fba00bb725145328b5e25ba20dd2b3f53a45029a3e4ad1c2dad83b743ef0::airdrop {
    public fun airdrop<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 9223372122754121727);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::coin::mint_and_transfer<T0>(arg0, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<address>(&mut arg1), arg3);
        };
    }

    // decompiled from Move bytecode v6
}

