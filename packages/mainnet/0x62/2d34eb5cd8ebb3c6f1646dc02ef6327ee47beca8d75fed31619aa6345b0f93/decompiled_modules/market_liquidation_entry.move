module 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market_liquidation_entry {
    public entry fun liquidate<T0, T1>(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0xefa479281ee250c8a8eeac213648fd19c77e23d805d8b4ff618276aa628ce2be::pyth_oracle::Oracle, arg8: &0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::farming_core::Farming, arg9: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::farming_core::Pool<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, _, v3, _, v5) = 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        let v6 = v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::farming_core::stake_adjust<T0>(arg8, arg9, arg0, arg1, arg2, v3, false, arg6, arg10);
    }

    // decompiled from Move bytecode v6
}

