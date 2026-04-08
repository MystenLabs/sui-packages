module 0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::adapter_bucket {
    public fun deposit<T0>(arg0: &0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::vault::Vault<T0>, arg1: &0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::strategy::StrategyRegistry, arg2: &0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::crank::CrankConfig, arg3: &mut 0x2::object::UID, arg4: &mut 0x2::object::UID, arg5: 0x2::coin::Coin<0x2::object::UID>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::crank::get_access_cap(arg2, arg1);
        let v0 = 0x2::object::id<0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::vault::Vault<T0>>(arg0);
        0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::saving::check_deposit_response<T0>(0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::saving::deposit<T0>(arg3, arg4, 0x2::object::id_to_address(&v0), arg5, arg6, arg7), arg3, arg4);
    }

    public fun withdraw<T0>(arg0: &0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::vault::Vault<T0>, arg1: &0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::strategy::StrategyRegistry, arg2: &0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::crank::CrankConfig, arg3: &mut 0x2::object::UID, arg4: &mut 0x2::object::UID, arg5: 0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::account::Request, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::object::UID> {
        0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::crank::get_access_cap(arg2, arg1);
        let (v0, v1) = 0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::saving::withdraw<T0>(arg3, arg4, arg5, arg6, arg7, arg8);
        0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::saving::check_withdraw_response<T0>(v1, arg3, arg4);
        v0
    }

    // decompiled from Move bytecode v6
}

