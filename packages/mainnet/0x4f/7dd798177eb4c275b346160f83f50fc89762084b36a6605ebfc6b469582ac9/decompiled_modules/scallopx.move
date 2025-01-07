module 0x4f7dd798177eb4c275b346160f83f50fc89762084b36a6605ebfc6b469582ac9::scallopx {
    fun init_module(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun long<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<0x2::sui::SUI>(arg0, arg1, arg3, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T0>(arg0, arg1, arg2, arg3, arg4, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg1, arg3, arg4, arg5, arg6), arg5, arg6, arg8), 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

