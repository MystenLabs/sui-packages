module 0x2e8b625b4803bdd5a9bbec2c8a4eac11780823e5c17ca08efb80636e94c029e4::atomic_arbitrage {
    struct SwapExecuted has copy, drop {
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        sender: address,
        is_a2b: bool,
    }

    struct ArbitrageExecuted has copy, drop {
        dex1: vector<u8>,
        dex2: vector<u8>,
        amount_in: u64,
        profit: u64,
        sender: address,
    }

    public entry fun execute_bluefin_arbitrage<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 501);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::coin::zero<T1>(arg3);
        let (v3, v4) = gateway_swap_assets<T0, T1>(arg2, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, arg0, v2, true, true, v0, 0, 79226673515401279992447579055, arg3);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::zero<T0>(arg3);
        let (v8, v9) = gateway_swap_assets<T1, T0>(arg2, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, v6, v7, false, true, 0x2::coin::value<T1>(&v6), 0, 79226673515401279992447579055, arg3);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0x2::coin::value<T0>(&v11);
        let v13 = if (v12 > v0) {
            v12 - v0
        } else {
            0
        };
        assert!(v13 >= arg1, 502);
        let v14 = ArbitrageExecuted{
            dex1      : b"bluefin",
            dex2      : b"bluefin",
            amount_in : v0,
            profit    : v13,
            sender    : v1,
        };
        0x2::event::emit<ArbitrageExecuted>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v1);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T1>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, v1);
        } else {
            0x2::coin::destroy_zero<T1>(v10);
        };
    }

    public entry fun execute_cross_dex_arbitrage<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 501);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::coin::zero<T1>(arg5);
        let (v3, v4) = gateway_swap_assets<T0, T1>(arg4, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158, arg2, arg0, v2, true, true, v0, 0, 79226673515401279992447579055, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::zero<T0>(arg5);
        let (v8, v9) = gateway_swap_assets<T1, T0>(arg4, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158, arg3, v6, v7, false, true, 0x2::coin::value<T1>(&v6), 0, 79226673515401279992447579055, arg5);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0x2::coin::value<T0>(&v11);
        let v13 = if (v12 > v0) {
            v12 - v0
        } else {
            0
        };
        assert!(v13 >= arg1, 502);
        let v14 = ArbitrageExecuted{
            dex1      : b"bluefin",
            dex2      : b"bluefin",
            amount_in : v0,
            profit    : v13,
            sender    : v1,
        };
        0x2::event::emit<ArbitrageExecuted>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v1);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T1>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, v1);
        } else {
            0x2::coin::destroy_zero<T1>(v10);
        };
    }

    fun gateway_swap_assets<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        (arg4, arg3)
    }

    public fun get_bluefin_config() : (address, address, address) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158)
    }

    public entry fun swap_tokens_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 501);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::zero<T1>(arg4);
        let (v3, v4) = gateway_swap_assets<T0, T1>(arg3, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, arg0, v2, arg2, true, v0, 0, 79226673515401279992447579055, arg4);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::value<T1>(&v6);
        assert!(v7 >= arg1, 502);
        let v8 = SwapExecuted{
            pool_id    : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            amount_in  : v0,
            amount_out : v7,
            sender     : v1,
            is_a2b     : arg2,
        };
        0x2::event::emit<SwapExecuted>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v1);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
    }

    public entry fun test_deployment(arg0: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _) = get_bluefin_config();
        let v3 = SwapExecuted{
            pool_id    : v1,
            amount_in  : 0,
            amount_out : 0,
            sender     : 0x2::tx_context::sender(arg0),
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v3);
    }

    // decompiled from Move bytecode v6
}

