module 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::user_actions {
    struct AssetDepositedEvent has copy, drop {
        asset_id: 0x2::object::ID,
        amount: u64,
        user: address,
        coin: 0x1::type_name::TypeName,
    }

    struct AssetWithdrawnEvent has copy, drop {
        asset_id: 0x2::object::ID,
        amount: u64,
        user: address,
        coin: 0x1::type_name::TypeName,
    }

    public entry fun deposit_existing_asset_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::TradeAsset<T0>, arg2: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_not_trading_manager(0x2::tx_context::sender(arg3), arg2);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::assert_trade_asset_belongs_to_user<T0>(0x2::tx_context::sender(arg3), arg1);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::deposit_existing_asset<T0>(arg0, arg1, arg2);
        let v0 = AssetDepositedEvent{
            asset_id : 0x2::object::id<0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::TradeAsset<T0>>(arg1),
            amount   : 0x2::coin::value<T0>(&arg0),
            user     : 0x2::tx_context::sender(arg3),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedEvent>(v0);
    }

    public entry fun deposit_new_asset_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetDepositedEvent{
            asset_id : 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::deposit_new_asset<T0>(arg0, arg1, arg2),
            amount   : 0x2::coin::value<T0>(&arg0),
            user     : 0x2::tx_context::sender(arg2),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedEvent>(v0);
    }

    public entry fun withdraw_asset_entry<T0>(arg0: &mut 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::TradeAsset<T0>, arg1: u64, arg2: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::withdraw_asset<T0>(arg0, arg1, arg2, arg3);
        let v0 = AssetWithdrawnEvent{
            asset_id : 0x2::object::id<0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::TradeAsset<T0>>(arg0),
            amount   : arg1,
            user     : 0x2::tx_context::sender(arg3),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetWithdrawnEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

