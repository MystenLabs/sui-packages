module 0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_entry {
    struct ScallopLegAuth has drop {
        dummy_field: bool,
    }

    public fun deposit_to_scallop<T0, T1>(arg0: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::DepositReceipt<T0>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3));
        let v0 = ScallopLegAuth{dummy_field: false};
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::sync_for_deposit<T0, T1, ScallopLegAuth>(arg0, arg1, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::get_underlying_balance<T0>(arg4, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP())), arg5, &v0);
        let (v1, v2) = 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::begin_deposit_leg<T0, T1, ScallopLegAuth>(arg1, arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP(), arg2, &v0);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::store_deposit_holding<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopLegAuth>(arg1, arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::deposit<T0>(arg3, arg4, 0x2::coin::from_balance<T0>(v1, arg6), arg5, arg6)), &v0);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::finish_deposit_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v2, 0x2::balance::zero<T0>(), &v0);
    }

    public fun register_scallop_leg_auth<T0, T1>(arg0: &0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::LLVGlobal, arg1: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<T0, T1>, arg2: &0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::LLVPoolAdminCap) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::assert_version(arg0);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::register_protocol_leg_auth<T0, T1, ScallopLegAuth>(arg1, arg2, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP());
    }

    public fun sync_scallop<T0, T1>(arg0: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_validation::validate_scallop_market<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1));
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::keeper_sync_protocol_balance<T0, T1>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::get_underlying_balance<T0>(arg1, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP())), arg2, arg3);
    }

    public fun withdraw_from_scallop<T0, T1>(arg0: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::WithdrawReceipt<T0, T1>, arg2: u128, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3));
        let v0 = 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP());
        let v1 = ScallopLegAuth{dummy_field: false};
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::sync_for_withdraw<T0, T1, ScallopLegAuth>(arg0, arg1, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::get_underlying_balance<T0>(arg4, v0), arg5, &v1);
        let (v2, v3) = 0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::get_exchange_rate<T0>(arg4);
        let v4 = 0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::select_scoin_withdraw_amount(arg2, v0, v2, v3, 0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::get_available_liquidity<T0>(arg4));
        if (v4 == 0) {
            return
        };
        let (v5, v6) = 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::begin_withdraw_leg<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopLegAuth>(arg1, arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_SCALLOP(), v4, &v1);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::finish_withdraw_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v6, 0x2::coin::into_balance<T0>(0x3e21d959a3addab5cdb558d762566e1164f6f45e16faf7a2648aad2b63abe2c7::scallop_adapter::withdraw<T0>(arg3, arg4, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v5, arg6), arg5, arg6)), &v1);
    }

    // decompiled from Move bytecode v6
}

