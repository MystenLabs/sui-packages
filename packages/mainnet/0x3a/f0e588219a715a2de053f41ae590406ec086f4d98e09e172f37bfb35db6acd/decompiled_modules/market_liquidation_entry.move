module 0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::market_liquidation_entry {
    public entry fun liquidate<T0, T1>(arg0: &mut 0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::market::Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0xb8a91f598042af173069df31c79e0614f51684a97d55f29151eb2ff8daf6af62::pyth_oracle::Oracle, arg8: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg9: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, _, v3, _, v5) = 0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::market::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        let v6 = v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::stake_adjust<T0>(arg8, arg9, 0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::market::hearn_address(arg0), arg1, arg2, v3, false, arg6, arg10);
    }

    // decompiled from Move bytecode v7
}

