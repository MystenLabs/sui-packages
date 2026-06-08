module 0xb31de7432eaa5384ca9e1ff59644b69138beaaf297c6c5b6553b2e8017d7a0a::arb_flash {
    struct ArbFlashDiag has copy, drop {
        flash_amount: u64,
        total_repay_needed: u64,
        pot_value: u64,
        profit: u64,
    }

    public fun flash_begin<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg1, arg2, arg3, arg4);
        (0x2::coin::from_balance<T0>(v0, arg4), v1)
    }

    public fun flash_repay_plus<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, _, v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&arg3);
        let v6 = v2 + v4 + v5;
        let v7 = 0x2::coin::into_balance<T0>(arg4);
        let v8 = 0x2::balance::value<T0>(&v7);
        assert!(v8 >= v6, 0);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg0, arg1, arg2, arg3, v7, arg6);
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = ArbFlashDiag{
            flash_amount       : v2,
            total_repay_needed : v6,
            pot_value          : v8,
            profit             : v10,
        };
        0x2::event::emit<ArbFlashDiag>(v11);
        assert!(v10 >= arg5, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

