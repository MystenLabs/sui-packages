module 0x3ffbf1ec82b239fe4f2a24b36609e466337c26ccda6ca2d71cf174abb06cd6fc::registry {
    public fun deposit<T0>(arg0: &0x304acc958b096d2b0c61e83e5d71f517147e0454ea5e048748b20a186b2314a1::registry::AccountCapRegistry, arg1: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v2::Incentive, arg2: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v3::Incentive, arg3: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::storage::Storage, arg4: &0x2::clock::Clock, arg5: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::Pool<T0>, arg6: u8, arg7: 0x2::coin::Coin<T0>) {
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::incentive_v3::deposit_with_account_cap<T0>(arg4, arg3, arg5, arg6, arg7, arg1, arg2, 0x304acc958b096d2b0c61e83e5d71f517147e0454ea5e048748b20a186b2314a1::registry::get_account_cap(arg0));
    }

    // decompiled from Move bytecode v6
}

