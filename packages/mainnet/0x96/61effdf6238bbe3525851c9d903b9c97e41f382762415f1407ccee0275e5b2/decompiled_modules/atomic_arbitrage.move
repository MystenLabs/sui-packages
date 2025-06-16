module 0x9661effdf6238bbe3525851c9d903b9c97e41f382762415f1407ccee0275e5b2::atomic_arbitrage {
    struct SwapExecuted has copy, drop {
        sender: address,
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        is_a2b: bool,
    }

    public entry fun execute_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 700);
        assert!(arg1 > 0, 701);
        0x9661effdf6238bbe3525851c9d903b9c97e41f382762415f1407ccee0275e5b2::dex_bluefin::swap_sui_to_usdc(arg0, arg1, arg2, arg3);
    }

    public fun get_bluefin_package() : address {
        @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
    }

    public fun get_bluefin_pool() : address {
        @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa
    }

    public fun get_cetus_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun get_cetus_pool() : address {
        @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public entry fun swap_tokens_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x9661effdf6238bbe3525851c9d903b9c97e41f382762415f1407ccee0275e5b2::dex_bluefin::swap_sui_to_usdc(arg0, arg1, arg3, arg4);
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            pool_id    : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun swap_tokens_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x9661effdf6238bbe3525851c9d903b9c97e41f382762415f1407ccee0275e5b2::dex_cetus::swap_sui_to_usdc(arg0, arg1, arg3, arg4);
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            pool_id    : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun test_contract_deployment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

