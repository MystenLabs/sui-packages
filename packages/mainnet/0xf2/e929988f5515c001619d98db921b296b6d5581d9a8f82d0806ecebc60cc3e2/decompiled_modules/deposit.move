module 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::deposit {
    struct DepositEvent has copy, drop {
        minter: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        ctoken_amount: u64,
        total_ctoken_amount: u64,
        time: u64,
    }

    public fun deposit<T0, T1>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg1: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg2: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ensure_version_matches(arg0);
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::validate_market<T0>(arg0, arg1);
        assert!(!0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::has_circuit_break_triggered<T0>(arg1), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let (v1, v2) = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::handle_mint<T0, T1>(arg1, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::id(arg2), arg3, v0);
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::borrow_liquidity_mining_mut<T0>(arg1), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::liquidity_miner::get_deposit_reward_type(), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::id(arg2), v2, arg4);
        let v3 = DepositEvent{
            minter              : 0x2::tx_context::sender(arg5),
            market              : 0x1::type_name::with_defining_ids<T0>(),
            obligation          : 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::id(arg2),
            deposit_asset       : 0x1::type_name::with_defining_ids<T1>(),
            deposit_amount      : 0x2::coin::value<T1>(&arg3),
            ctoken_amount       : v1,
            total_ctoken_amount : v2,
            time                : v0,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

