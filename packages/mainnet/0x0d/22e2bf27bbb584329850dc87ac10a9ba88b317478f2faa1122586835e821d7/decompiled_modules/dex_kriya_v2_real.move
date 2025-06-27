module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_v2_real {
    struct RealKriyaV2SwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        is_x_to_y: bool,
        success: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    public fun get_kriya_v2_pools() : (address, address, address) {
        (@0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, @0x18d871e3c3da99046dfc0d3de612c5d88859bc03b8f0568bd127d0e70dbc58be, @0x81ac578c80c8ea8ec811e5539b9864f7f4e32c1cf38174f8ac338dce87d4928d)
    }

    public fun get_quote_v2(arg0: address, arg1: u64, arg2: bool) : u64 {
        arg1 - arg1 * 30 / 10000
    }

    public fun is_kriya_v2_ready() : bool {
        false
    }

    public fun swap_simple<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        swap_v2_real<T0, T1>(@0x18d871e3c3da99046dfc0d3de612c5d88859bc03b8f0568bd127d0e70dbc58be, arg0, 0x2::coin::value<T0>(&arg0), arg1, true, arg2)
    }

    public fun swap_v2_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 602);
        let v0 = arg2 - arg2 * 30 / 10000;
        assert!(v0 >= arg3, 603);
        let v1 = RealKriyaV2SwapExecuted{
            pool       : arg0,
            amount_in  : arg2,
            amount_out : v0,
            is_x_to_y  : arg4,
            success    : false,
        };
        0x2::event::emit<RealKriyaV2SwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg5)
    }

    // decompiled from Move bytecode v6
}

