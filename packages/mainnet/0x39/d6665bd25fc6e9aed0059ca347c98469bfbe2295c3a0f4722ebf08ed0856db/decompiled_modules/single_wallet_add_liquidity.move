module 0x39d6665bd25fc6e9aed0059ca347c98469bfbe2295c3a0f4722ebf08ed0856db::single_wallet_add_liquidity {
    struct LiquidityState has drop {
        creator: address,
        completed: bool,
    }

    public fun create_state(arg0: &mut 0x2::tx_context::TxContext) : LiquidityState {
        LiquidityState{
            creator   : 0x2::tx_context::sender(arg0),
            completed : false,
        }
    }

    public entry fun execute_add_liquidity<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = create_state(arg7);
        assert!(0x2::tx_context::sender(arg7) == v0.creator, 1);
        assert!(!v0.completed, 0);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        v0.completed = true;
        store_state(&v0, arg7);
    }

    public fun store_state(arg0: &LiquidityState, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

