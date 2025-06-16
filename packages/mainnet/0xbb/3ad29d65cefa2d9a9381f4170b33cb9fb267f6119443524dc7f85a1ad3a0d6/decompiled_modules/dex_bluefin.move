module 0xbb3ad29d65cefa2d9a9381f4170b33cb9fb267f6119443524dc7f85a1ad3a0d6::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        is_a2b: bool,
    }

    public fun swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 502);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        let v1 = BluefinSwapExecuted{
            pool_id    : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            amount_in  : v0,
            amount_out : 0,
            is_a2b     : arg3,
        };
        0x2::event::emit<BluefinSwapExecuted>(v1);
        0x2::coin::zero<T1>(arg4)
    }

    public fun get_package() : address {
        @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
    }

    public fun get_sui_usdt_pool() : address {
        @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa
    }

    public entry fun swap_entry<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = swap<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

