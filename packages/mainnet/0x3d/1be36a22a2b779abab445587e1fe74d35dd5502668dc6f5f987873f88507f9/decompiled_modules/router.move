module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router {
    struct Fired has copy, drop {
        amount_in: u64,
        predicted_out: u64,
        profit: u64,
        hinted_in: u64,
        probes: u8,
        deadline_ms: u64,
    }

    struct FiredV2 has copy, drop {
        amount_in: u64,
        predicted_out: u64,
        profit: u64,
        hinted_in: u64,
        probes: u8,
        deadline_ms: u64,
        version: u64,
    }

    public fun assert_worth_firing(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::profit(arg0, arg1);
        assert!(v0 > 0, 20);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_min(v0, arg2);
    }

    public fun e_hint_required() : u64 {
        21
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_min(v0, arg6);
        let v1 = Fired{
            amount_in     : arg1,
            predicted_out : arg2,
            profit        : v0,
            hinted_in     : arg3,
            probes        : arg4,
            deadline_ms   : arg5,
        };
        0x2::event::emit<Fired>(v1);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg7));
    }

    public fun settle_versioned<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_min(v0, arg6);
        let v1 = FiredV2{
            amount_in     : arg1,
            predicted_out : arg2,
            profit        : v0,
            hinted_in     : arg3,
            probes        : arg4,
            deadline_ms   : arg5,
            version       : arg7,
        };
        0x2::event::emit<FiredV2>(v1);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v7
}

