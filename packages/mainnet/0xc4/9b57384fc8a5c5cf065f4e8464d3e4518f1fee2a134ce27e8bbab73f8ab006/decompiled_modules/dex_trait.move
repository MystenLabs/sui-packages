module 0xc49b57384fc8a5c5cf065f4e8464d3e4518f1fee2a134ce27e8bbab73f8ab006::dex_trait {
    struct DexInfo has copy, drop, store {
        name: vector<u8>,
        fee_bps: u64,
        pool_address: address,
    }

    public fun create_dex_info(arg0: vector<u8>, arg1: u64, arg2: address) : DexInfo {
        DexInfo{
            name         : arg0,
            fee_bps      : arg1,
            pool_address : arg2,
        }
    }

    public fun get_fee_bps(arg0: &DexInfo) : u64 {
        arg0.fee_bps
    }

    public fun get_name(arg0: &DexInfo) : vector<u8> {
        arg0.name
    }

    public fun get_pool_address(arg0: &DexInfo) : address {
        arg0.pool_address
    }

    // decompiled from Move bytecode v6
}

