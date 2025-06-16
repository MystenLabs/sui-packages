module 0xfc05949bdff2f0b3c2f050892edb876984b3d51beb10ff31c6cd4c325967ebf7::multi_dex_swaps {
    struct SwapExecuted has copy, drop {
        dex: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        user: address,
    }

    struct MultiDexSwapCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun aftermath_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = v0 * 94 / 100;
        assert!(v1 >= arg1, 601);
        let v2 = SwapExecuted{
            dex        : b"AFTERMATH",
            amount_in  : v0,
            amount_out : v1,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public entry fun bluefin_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = v0 * 96 / 100;
        assert!(v1 >= arg1, 601);
        let v2 = SwapExecuted{
            dex        : b"BLUEFIN",
            amount_in  : v0,
            amount_out : v1,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public entry fun cetus_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = v0 * 98 / 100;
        assert!(v1 >= arg1, 601);
        let v2 = SwapExecuted{
            dex        : b"CETUS",
            amount_in  : v0,
            amount_out : v1,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public entry fun deepbook_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = v0 * 93 / 100;
        assert!(v1 >= arg1, 601);
        let v2 = SwapExecuted{
            dex        : b"DEEPBOOK",
            amount_in  : v0,
            amount_out : v1,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun estimate_swap_output(arg0: vector<u8>, arg1: u64) : u64 {
        if (arg0 == b"CETUS") {
            arg1 * 98 / 100
        } else if (arg0 == b"TURBOS") {
            arg1 * 97 / 100
        } else if (arg0 == b"BLUEFIN") {
            arg1 * 96 / 100
        } else if (arg0 == b"KRIYA") {
            arg1 * 95 / 100
        } else if (arg0 == b"AFTERMATH") {
            arg1 * 94 / 100
        } else if (arg0 == b"DEEPBOOK") {
            arg1 * 93 / 100
        } else {
            arg1 * 98 / 100
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MultiDexSwapCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MultiDexSwapCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun kriya_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = v0 * 95 / 100;
        assert!(v1 >= arg1, 601);
        let v2 = SwapExecuted{
            dex        : b"KRIYA",
            amount_in  : v0,
            amount_out : v1,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public entry fun turbos_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = v0 * 97 / 100;
        assert!(v1 >= arg1, 601);
        let v2 = SwapExecuted{
            dex        : b"TURBOS",
            amount_in  : v0,
            amount_out : v1,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

