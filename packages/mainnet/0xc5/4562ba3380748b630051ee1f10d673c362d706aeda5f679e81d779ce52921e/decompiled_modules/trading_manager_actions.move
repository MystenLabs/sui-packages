module 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trading_manager_actions {
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

    public fun borrow_asset_for_trading<T0, T1>(arg0: &0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::config::TradingManagerCap, arg1: &mut 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::TradeAsset<T0>, arg2: u64, arg3: address, arg4: &0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::config::Config, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::Promise) {
        let (v0, v1) = 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::borrow_asset_for_trading<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = AssetBorrowedByTradingManagerEvent{
            asset_id : 0x2::object::id<0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::TradeAsset<T0>>(arg1),
            user     : arg3,
            amount   : arg2,
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetBorrowedByTradingManagerEvent>(v2);
        (v0, v1)
    }

    public fun deposit_existing_asset_as_trading_manager<T0>(arg0: &0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::config::TradingManagerCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::TradeAsset<T0>, arg3: address, arg4: &0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::config::Config, arg5: 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::Promise, arg6: &mut 0x2::tx_context::TxContext) {
        0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::deposit_existing_asset_as_trading_manager<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = AssetDepositedByTradingManager{
            asset_id : 0x2::object::id<0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::TradeAsset<T0>>(arg2),
            user     : arg3,
            amount   : 0x2::coin::value<T0>(&arg1),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedByTradingManager>(v0);
    }

    public fun deposit_new_asset_as_trading_manager<T0>(arg0: &0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::config::TradingManagerCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::config::Config, arg4: 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::Promise, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetDepositedByTradingManager{
            asset_id : 0xc54562ba3380748b630051ee1f10d673c362d706aeda5f679e81d779ce52921e::trade_account::deposit_new_asset_as_trading_manager<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
            user     : arg1,
            amount   : 0x2::coin::value<T0>(&arg2),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedByTradingManager>(v0);
    }

    // decompiled from Move bytecode v6
}

