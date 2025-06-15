module 0x4b7be64e7d606cf47a260676f236b1ff1965aa237fd6c28bb473286da471ca89::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        is_buy: bool,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 502);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        let v1 = BluefinSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : 0,
            is_buy     : arg3,
        };
        0x2::event::emit<BluefinSwapExecuted>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    public fun get_package() : address {
        @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
    }

    public fun get_sui_usdt_pool() : address {
        @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa
    }

    // decompiled from Move bytecode v6
}

