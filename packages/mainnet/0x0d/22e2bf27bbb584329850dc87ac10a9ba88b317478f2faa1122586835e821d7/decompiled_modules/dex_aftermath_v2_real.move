module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_aftermath_v2_real {
    struct RealAftermathV2SwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        is_x_to_y: bool,
        success: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    struct LpRegistry has key {
        id: 0x2::object::UID,
    }

    public fun get_aftermath_v2_addresses() : (address, address, address) {
        (@0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c, @0x5bd91b7306fd4e250ee138b29eb4f2d68a67e69e34a00189e12da79790ac8a6a, @0xfcc774493db2c45c79f688f88d28023a3e7d98e4ee9f48bbf5c7990f651577ae)
    }

    public fun get_quote_v2(arg0: address, arg1: u64, arg2: bool) : u64 {
        arg1 - arg1 * 25 / 10000
    }

    public fun is_aftermath_v2_ready() : bool {
        false
    }

    public fun swap_simple<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg3);
        swap_v2_real<T0, T1>(@0x5bd91b7306fd4e250ee138b29eb4f2d68a67e69e34a00189e12da79790ac8a6a, @0xfcc774493db2c45c79f688f88d28023a3e7d98e4ee9f48bbf5c7990f651577ae, arg0, 0x2::coin::value<T0>(&arg0), arg1, true, v0, 0x2::clock::timestamp_ms(arg2) + 300000, arg2, arg3)
    }

    public fun swap_v2_real<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 702);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 704);
        let v0 = arg3 - arg3 * 25 / 10000;
        assert!(v0 >= arg4, 703);
        let v1 = RealAftermathV2SwapExecuted{
            pool       : arg0,
            amount_in  : arg3,
            amount_out : v0,
            is_x_to_y  : arg5,
            success    : false,
        };
        0x2::event::emit<RealAftermathV2SwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg2);
        0x2::coin::zero<T1>(arg9)
    }

    // decompiled from Move bytecode v6
}

