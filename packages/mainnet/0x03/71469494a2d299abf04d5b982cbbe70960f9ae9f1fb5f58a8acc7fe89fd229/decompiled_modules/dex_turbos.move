module 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::dex_turbos {
    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        trader: address,
        pool_address: address,
    }

    public fun swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 - v0 * 25 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v2 = SwapExecuted{
            dex_name     : b"Turbos",
            amount_in    : v0,
            amount_out   : v1,
            trader       : arg1,
            pool_address : @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg2)
    }

    public fun get_dex_info() : 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::dex_trait::DexInfo {
        0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::dex_trait::create_dex_info(b"Turbos", 25, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1)
    }

    public fun swap_cross<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_zero_amount_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
        let v1 = SwapExecuted{
            dex_name     : b"Turbos-Cross",
            amount_in    : v0,
            amount_out   : v0 - v0 * 25 / 10000,
            trader       : arg1,
            pool_address : 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_turbos_sui_usdc_pool(),
        };
        0x2::event::emit<SwapExecuted>(v1);
        0x2::coin::zero<T1>(arg2)
    }

    public fun swap_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 - v0 * 25 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
        let v2 = SwapExecuted{
            dex_name     : b"Turbos",
            amount_in    : v0,
            amount_out   : v1,
            trader       : arg1,
            pool_address : @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::split<T0>(&mut arg0, v1, arg2)
    }

    // decompiled from Move bytecode v6
}

