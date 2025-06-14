module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_aftermath_real {
    struct RealAftermathSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        success: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    struct LpRegistry has key {
        id: 0x2::object::UID,
    }

    public fun get_aftermath_addresses() : (address, address, address) {
        (@0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c, @0x5bd91b7306fd4e250ee138b29eb4f2d68a67e69e34a00189e12da79790ac8a6a, @0xfcc774493db2c45c79f688f88d28023a3e7d98e4ee9f48bbf5c7990f651577ae)
    }

    public fun get_quote_real(arg0: address, arg1: u64, arg2: bool) : u64 {
        arg1 - arg1 * 25 / 10000
    }

    public fun prepare_aftermath_swap<T0, T1>(arg0: u64, arg1: bool, arg2: u64) : (address, address, address, u64, bool, u64) {
        (@0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c, @0x5bd91b7306fd4e250ee138b29eb4f2d68a67e69e34a00189e12da79790ac8a6a, @0xfcc774493db2c45c79f688f88d28023a3e7d98e4ee9f48bbf5c7990f651577ae, arg0, arg1, arg2)
    }

    public fun swap_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 702);
        let v1 = RealAftermathSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : arg2,
            success    : false,
        };
        0x2::event::emit<RealAftermathSwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg6)
    }

    public fun swap_simple<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        swap_real<T0, T1>(@0x5bd91b7306fd4e250ee138b29eb4f2d68a67e69e34a00189e12da79790ac8a6a, arg0, arg1, true, 9999999999999, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

