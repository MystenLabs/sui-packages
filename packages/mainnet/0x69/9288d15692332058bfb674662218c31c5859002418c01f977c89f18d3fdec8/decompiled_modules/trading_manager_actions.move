module 0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trading_manager_actions {
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

    public fun borrow_asset_for_trading<T0>(arg0: &mut 0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account::TradeAsset<T0>, arg1: u64, arg2: address, arg3: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = AssetBorrowedByTradingManagerEvent{
            asset_id : 0x2::object::id<0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account::TradeAsset<T0>>(arg0),
            user     : arg2,
            amount   : arg1,
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetBorrowedByTradingManagerEvent>(v0);
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account::borrow_asset_for_trading<T0>(arg0, arg1, arg3, arg4)
    }

    public entry fun deposit_new_asset_as_trading_manager<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetDepositedByTradingManager{
            asset_id : 0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account::deposit_new_asset_as_trading_manager<T0>(arg0, arg1, arg2, arg3, arg4),
            user     : arg0,
            amount   : 0x2::coin::value<T0>(&arg2),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedByTradingManager>(v0);
    }

    public entry fun deposit_existing_asset_as_trading_manager<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account::TradeAsset<T0>, arg2: address, arg3: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_address_is_trading_manager(0x2::tx_context::sender(arg4), arg3);
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account::deposit_existing_asset<T0>(arg0, arg1, arg3);
        let v0 = AssetDepositedByTradingManager{
            asset_id : 0x2::object::id<0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account::TradeAsset<T0>>(arg1),
            user     : arg2,
            amount   : 0x2::coin::value<T0>(&arg0),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedByTradingManager>(v0);
    }

    // decompiled from Move bytecode v6
}

