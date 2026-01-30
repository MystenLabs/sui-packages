module 0x36664dc377c1141b92ac05cefb1c86a9f5d9a0cfd25c96b7b3bac3f3487a7653::registry {
    public fun deposit<T0>(arg0: &0x304acc958b096d2b0c61e83e5d71f517147e0454ea5e048748b20a186b2314a1::registry::AccountCapRegistry, arg1: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v2::Incentive, arg2: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v3::Incentive, arg3: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::storage::Storage, arg4: &0x2::clock::Clock, arg5: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::Pool<T0>, arg6: u8, arg7: 0x2::coin::Coin<T0>) {
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v3::deposit_with_account_cap<T0>(arg4, arg3, arg5, arg6, arg7, arg1, arg2, 0x304acc958b096d2b0c61e83e5d71f517147e0454ea5e048748b20a186b2314a1::registry::get_account_cap(arg0));
    }

    public fun withdraw<T0>(arg0: &0x304acc958b096d2b0c61e83e5d71f517147e0454ea5e048748b20a186b2314a1::registry::AccountCapRegistry, arg1: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v2::Incentive, arg2: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v3::Incentive, arg3: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::storage::Storage, arg4: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg5: &0x2::clock::Clock, arg6: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::Pool<T0>, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v3::withdraw_with_account_cap<T0>(arg5, arg4, arg3, arg6, arg7, arg8, arg1, arg2, 0x304acc958b096d2b0c61e83e5d71f517147e0454ea5e048748b20a186b2314a1::registry::get_account_cap(arg0)), arg9), 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v6
}

