module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        is_buy: bool,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 502);
        let v1 = if (arg0 == @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29) {
            25
        } else if (arg0 == @0xde705d4f3ded922b729d9b923be08e1391dd4caeff8496326123934d0fb1c312) {
            100
        } else {
            20
        };
        let v2 = v0 * v1 / 10000;
        let v3 = v0 - v2;
        let v4 = if (v0 > 1000000000) {
            50
        } else if (v0 > 100000000) {
            20
        } else {
            5
        };
        let v5 = v3 - v3 * v4 / 10000;
        assert!(v5 >= arg2, 503);
        let v6 = BluefinSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : v5,
            fee_amount : v2,
            is_buy     : arg3,
        };
        0x2::event::emit<BluefinSwapExecuted>(v6);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    public fun get_quote(arg0: address, arg1: u64, arg2: bool) : (u64, u64) {
        let v0 = if (arg0 == @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29) {
            25
        } else if (arg0 == @0xde705d4f3ded922b729d9b923be08e1391dd4caeff8496326123934d0fb1c312) {
            100
        } else {
            20
        };
        let v1 = arg1 * v0 / 10000;
        let v2 = arg1 - v1;
        let v3 = if (arg1 > 1000000000) {
            50
        } else if (arg1 > 100000000) {
            20
        } else {
            5
        };
        (v2 - v2 * v3 / 10000, v1)
    }

    public fun is_pool_valid(arg0: address) : bool {
        if (arg0 == @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29) {
            true
        } else if (arg0 == @0xde705d4f3ded922b729d9b923be08e1391dd4caeff8496326123934d0fb1c312) {
            true
        } else {
            arg0 == @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
        }
    }

    // decompiled from Move bytecode v6
}

