module 0xbb3ad29d65cefa2d9a9381f4170b33cb9fb267f6119443524dc7f85a1ad3a0d6::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        swap_type: u8,
    }

    public fun swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 902);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        let v1 = if (arg2) {
            0
        } else {
            1
        };
        let v2 = AftermathSwapExecuted{
            pool_id    : @0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c,
            amount_in  : v0,
            amount_out : 0,
            swap_type  : v1,
        };
        0x2::event::emit<AftermathSwapExecuted>(v2);
        0x2::coin::zero<T1>(arg3)
    }

    public fun get_amm_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_package() : address {
        @0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c
    }

    public entry fun swap_entry<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap<T0, T1>(arg0, arg1, true, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

