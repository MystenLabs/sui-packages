module 0x9fc5c55b8efc448a57d0d64a7c64c9d6e44bd5d576b17a48513be79322eb499c::single_wallet_add_liquidity {
    struct LiquidityState has drop {
        creator: address,
        completed: bool,
    }

    public entry fun execute_add_liquidity<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = init_state(arg7);
        assert!(0x2::tx_context::sender(arg7) == v0.creator, 1);
        assert!(!v0.completed, 0);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        v0.completed = true;
    }

    public fun init_state(arg0: &mut 0x2::tx_context::TxContext) : LiquidityState {
        LiquidityState{
            creator   : 0x2::tx_context::sender(arg0),
            completed : false,
        }
    }

    // decompiled from Move bytecode v6
}

