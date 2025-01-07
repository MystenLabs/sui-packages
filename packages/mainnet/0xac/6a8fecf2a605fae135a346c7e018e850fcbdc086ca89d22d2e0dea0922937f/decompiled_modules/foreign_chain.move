module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain {
    struct ForeignChainKey has copy, drop, store {
        chain_id: u16,
    }

    struct ForeignChain has drop, store {
        chain_address: vector<u8>,
        emitter_address: vector<u8>,
        cross_chain_fee: u64,
    }

    public fun chain_address(arg0: &ForeignChain) : vector<u8> {
        arg0.chain_address
    }

    public fun cross_chain_fee(arg0: &ForeignChain) : u64 {
        arg0.cross_chain_fee
    }

    public fun emitter_address(arg0: &ForeignChain) : vector<u8> {
        arg0.emitter_address
    }

    public(friend) fun new_foreign_chain(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : ForeignChain {
        ForeignChain{
            chain_address   : arg0,
            emitter_address : arg1,
            cross_chain_fee : arg2,
        }
    }

    public fun new_foreign_chain_key(arg0: u16) : ForeignChainKey {
        ForeignChainKey{chain_id: arg0}
    }

    public(friend) fun update_foreign_chain(arg0: &mut ForeignChain, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        arg0.chain_address = arg1;
        arg0.emitter_address = arg2;
        arg0.cross_chain_fee = arg3;
    }

    // decompiled from Move bytecode v6
}

