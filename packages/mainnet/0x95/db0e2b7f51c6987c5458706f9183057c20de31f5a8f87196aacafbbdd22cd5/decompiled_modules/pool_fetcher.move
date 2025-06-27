module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher {
    struct FetchTicksResultEvent has copy, drop {
        ticks: vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::TickInfo>,
        next_cursor: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>,
    }

    public entry fun compute_swap_result<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg6);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::compute_swap_result<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg7), arg1, arg2, arg3, arg4, true, 0, arg5, arg7);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::convert_state_v2_to_v1(&v0)
    }

    public entry fun fetch_ticks<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<u32>, arg2: bool, arg3: u64, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg4);
        let v0 = if (0x1::vector::is_empty<u32>(&arg1)) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(*0x1::vector::borrow<u32>(&arg1, 0), arg2)
        };
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::fetch_ticks<T0, T1, T2>(arg0, v0, arg3);
        let v3 = FetchTicksResultEvent{
            ticks       : v1,
            next_cursor : v2,
        };
        0x2::event::emit<FetchTicksResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

