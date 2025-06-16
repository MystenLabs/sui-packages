module 0x2e8b625b4803bdd5a9bbec2c8a4eac11780823e5c17ca08efb80636e94c029e4::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        is_a2b: bool,
        sender: address,
    }

    public fun swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 502);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::zero<T1>(arg4);
        let (v3, v4) = bluefin_gateway_swap_assets<T0, T1>(arg3, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, arg0, v2, arg2, true, v0, 0, 79226673515401279992447579055, arg4);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::value<T1>(&v6);
        assert!(v7 >= arg1, 503);
        let v8 = BluefinSwapExecuted{
            pool_id    : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            amount_in  : v0,
            amount_out : v7,
            is_a2b     : arg2,
            sender     : v1,
        };
        0x2::event::emit<BluefinSwapExecuted>(v8);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        v6
    }

    fun bluefin_gateway_swap_assets<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        (arg4, arg3)
    }

    fun bluefin_pool_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        (arg4, arg3)
    }

    public fun get_bluefin_config() : (address, address, address) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158)
    }

    public entry fun swap_tokens<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 502);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::zero<T1>(arg4);
        let (v3, v4) = bluefin_gateway_swap_assets<T0, T1>(arg3, @0xf1cf79fb923f656209a7b6dd88f5d7e30bbf9a62fa88827bb9d2c359ce3cf158, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, arg0, v2, arg2, true, v0, 0, 79226673515401279992447579055, arg4);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::value<T1>(&v6);
        assert!(v7 >= arg1, 503);
        let v8 = BluefinSwapExecuted{
            pool_id    : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            amount_in  : v0,
            amount_out : v7,
            is_a2b     : arg2,
            sender     : v1,
        };
        0x2::event::emit<BluefinSwapExecuted>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v1);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
    }

    public entry fun test_bluefin_config(arg0: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _) = get_bluefin_config();
        let v3 = BluefinSwapExecuted{
            pool_id    : v1,
            amount_in  : 0,
            amount_out : 0,
            is_a2b     : true,
            sender     : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<BluefinSwapExecuted>(v3);
    }

    // decompiled from Move bytecode v6
}

