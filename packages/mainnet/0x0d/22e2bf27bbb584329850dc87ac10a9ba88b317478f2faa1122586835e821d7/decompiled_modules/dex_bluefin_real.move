module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real {
    struct RealBluefinSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        success: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    public fun get_bluefin_pool_address() : address {
        @0xe809689d7997a69b3d2596f7f2c5ab4069fd9b33030f79e0b30556b04e1c883
    }

    public fun is_real_integration_ready() : bool {
        false
    }

    public fun prepare_bluefin_swap<T0, T1>(arg0: address, arg1: u64, arg2: bool) : (address, address, u64) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, arg0, arg1)
    }

    public fun swap_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 502);
        let v1 = RealBluefinSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : arg2,
            success    : false,
        };
        0x2::event::emit<RealBluefinSwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg4)
    }

    // decompiled from Move bytecode v6
}

