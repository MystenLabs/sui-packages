module 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        pool_type: u8,
    }

    public fun swap<T0, T1>(arg0: address, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 902);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        let v1 = AftermathSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : 0,
            pool_type  : arg1,
        };
        0x2::event::emit<AftermathSwapExecuted>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    public fun get_package() : address {
        @0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c
    }

    public fun get_sui_usdt_pool() : address {
        @0xa0
    }

    // decompiled from Move bytecode v6
}

