module 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trading_manager_actions {
    struct AssetBorrowedByTradingManagerEvent has copy, drop {
        asset_id: 0x2::object::ID,
        user: address,
        amount: u64,
        coin: 0x1::type_name::TypeName,
    }

    struct AssetDepositedByTradingManager has copy, drop {
        asset_id: 0x2::object::ID,
        user: address,
        amount: u64,
        coin: 0x1::type_name::TypeName,
    }

    public fun borrow_asset_for_trading<T0, T1>(arg0: &mut 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::TradeAsset<T0>, arg1: u64, arg2: address, arg3: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::Promise) {
        let (v0, v1) = 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::borrow_asset_for_trading<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = AssetBorrowedByTradingManagerEvent{
            asset_id : 0x2::object::id<0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::TradeAsset<T0>>(arg0),
            user     : arg2,
            amount   : arg1,
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetBorrowedByTradingManagerEvent>(v2);
        (v0, v1)
    }

    public fun deposit_existing_asset_as_trading_manager<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::TradeAsset<T0>, arg2: address, arg3: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg4: 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::Promise, arg5: &mut 0x2::tx_context::TxContext) {
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::deposit_existing_asset_as_trading_manager<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = AssetDepositedByTradingManager{
            asset_id : 0x2::object::id<0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::TradeAsset<T0>>(arg1),
            user     : arg2,
            amount   : 0x2::coin::value<T0>(&arg0),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedByTradingManager>(v0);
    }

    public fun deposit_new_asset_as_trading_manager<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg3: 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::Promise, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetDepositedByTradingManager{
            asset_id : 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account::deposit_new_asset_as_trading_manager<T0>(arg0, arg1, arg2, arg3, arg4),
            user     : arg0,
            amount   : 0x2::coin::value<T0>(&arg1),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedByTradingManager>(v0);
    }

    // decompiled from Move bytecode v6
}

