module 0xc49b57384fc8a5c5cf065f4e8464d3e4518f1fee2a134ce27e8bbab73f8ab006::dex_kriya {
    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        trader: address,
        pool_address: address,
    }

    public fun swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 - v0 * 30 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v2 = SwapExecuted{
            dex_name     : b"Kriya",
            amount_in    : v0,
            amount_out   : v1,
            trader       : arg1,
            pool_address : @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg2)
    }

    public fun get_dex_info() : 0xc49b57384fc8a5c5cf065f4e8464d3e4518f1fee2a134ce27e8bbab73f8ab006::dex_trait::DexInfo {
        0xc49b57384fc8a5c5cf065f4e8464d3e4518f1fee2a134ce27e8bbab73f8ab006::dex_trait::create_dex_info(b"Kriya", 30, @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66)
    }

    // decompiled from Move bytecode v6
}

