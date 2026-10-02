module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::entries_dev {
    public entry fun cancel_quota_decrease_entry<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::cancel_quota_decrease<T0>(arg0, arg1);
    }

    public entry fun create_account_entry<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::create_account<T0>(arg0, arg1);
    }

    public entry fun create_market_flat_entry<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::AdminCap<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::registry::MarketRegistry<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::create_market<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::new_market_config(arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::new_optimistic_oracle_spec(arg4, arg19, arg20), arg21);
    }

    public entry fun create_protocol_entry<T0>(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::create_protocol<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun deposit_coin_entry<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::deposit<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    public entry fun execute_quota_decrease_entry<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::execute_quota_decrease<T0>(arg0, arg1, arg2);
    }

    public entry fun lock_quota_coin_entry<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::lock_quota_coin<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_quota_from_collateral_entry<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::lock_quota_from_collateral<T0>(arg0, arg1, arg2);
    }

    public entry fun request_quota_decrease_entry<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::request_quota_decrease<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

