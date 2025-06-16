module 0xc32bb73717c704d1d9f5c93789a0d69680fa077ba494f7261c389d27a7024b86::atomic_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        sender: address,
        dex_route: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        timestamp: u64,
    }

    struct SwapExecuted has copy, drop {
        sender: address,
        dex_name: vector<u8>,
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        is_a2b: bool,
    }

    public entry fun arb_aftermath_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(arg1 > 0, 701);
        let v1 = v0 * 95 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            sender     : 0x2::tx_context::sender(arg3),
            dex_route  : b"Aftermath->Turbos",
            amount_in  : v0,
            amount_out : v1,
            profit     : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
    }

    public entry fun arb_bluefin_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(arg1 > 0, 701);
        let v1 = v0 * 99 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            sender     : 0x2::tx_context::sender(arg3),
            dex_route  : b"Bluefin->Cetus",
            amount_in  : v0,
            amount_out : v1,
            profit     : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
    }

    public entry fun arb_cetus_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(arg1 > 0, 701);
        let v1 = v0 * 98 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            sender     : 0x2::tx_context::sender(arg3),
            dex_route  : b"Cetus->DeepBook",
            amount_in  : v0,
            amount_out : v1,
            profit     : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
    }

    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * arg1 / 100 * arg2 / 100;
        if (v0 > arg0) {
            v0 - arg0
        } else {
            0
        }
    }

    public entry fun cetus_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg3),
            dex_name   : b"CETUS",
            pool_id    : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun deepbook_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg3),
            dex_name   : b"DEEPBOOK",
            pool_id    : @0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun execute_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 700);
        assert!(arg1 > 0, 701);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun get_all_dex_packages() : (address, address, address, address, address, address) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0xcaf6ba059d539a97646d47f0b9ddf843e138d215e2a12ca1f4585d386f7aec3a, @0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c)
    }

    public fun get_all_dex_pools() : (address, address, address, address, address, address) {
        (@0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, @0x4e0d2e39f53c1269b8cecef99ae08a477e387c9a03065d2914b0f3e384b4f6a7, @0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33, @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f47dc)
    }

    public fun get_deployment_status() : (bool, bool, bool, bool, bool, bool) {
        (true, true, true, true, true, false)
    }

    public fun get_dex_efficiency_ratings() : (u64, u64, u64, u64, u64, u64) {
        (99, 98, 97, 95, 93, 95)
    }

    public fun get_optimal_arbitrage_route() : vector<u8> {
        b"Bluefin->Cetus"
    }

    public entry fun swap_tokens_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            dex_name   : b"Aftermath",
            pool_id    : @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f47dc,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun swap_tokens_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            dex_name   : b"Bluefin",
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            dex_name   : b"Cetus",
            pool_id    : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun swap_tokens_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            dex_name   : b"DeepBook",
            pool_id    : @0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun swap_tokens_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            dex_name   : b"Kriya",
            pool_id    : @0x4e0d2e39f53c1269b8cecef99ae08a477e387c9a03065d2914b0f3e384b4f6a7,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun swap_tokens_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            dex_name   : b"Turbos",
            pool_id    : @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78,
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

