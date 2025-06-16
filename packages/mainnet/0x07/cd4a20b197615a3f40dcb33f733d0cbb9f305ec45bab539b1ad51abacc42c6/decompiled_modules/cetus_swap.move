module 0x7cd4a20b197615a3f40dcb33f733d0cbb9f305ec45bab539b1ad51abacc42c6::cetus_swap {
    struct SwapExecuted has copy, drop {
        amount_in: u64,
        amount_out: u64,
        user: address,
    }

    public fun estimate_swap_output(arg0: u64) : u64 {
        arg0 * 98 / 100
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = v0 * 98 / 100;
        assert!(v1 >= arg1, 601);
        let v2 = SwapExecuted{
            amount_in  : v0,
            amount_out : v1,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

