module 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::user_actions {
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

    public entry fun deposit_existing_asset_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account::TradeAsset<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account::deposit_existing_asset<T0>(arg0, arg1, arg2);
        let v0 = AssetDepositedEvent{
            asset_id : 0x2::object::id<0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account::TradeAsset<T0>>(arg1),
            amount   : 0x2::coin::value<T0>(&arg0),
            user     : 0x2::tx_context::sender(arg2),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedEvent>(v0);
    }

    public entry fun deposit_new_asset_entry<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: &0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetDepositedEvent{
            asset_id : 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account::deposit_new_asset<T0>(arg0, arg1, arg2, arg3),
            amount   : 0x2::coin::value<T0>(&arg1),
            user     : 0x2::tx_context::sender(arg3),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetDepositedEvent>(v0);
    }

    public entry fun withdraw_all_assets_entry<T0>(arg0: &mut 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account::TradeAsset<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetWithdrawnEvent{
            asset_id : 0x2::object::id<0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account::TradeAsset<T0>>(arg0),
            amount   : 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account::withdraw_all_asset<T0>(arg0, arg1),
            user     : 0x2::tx_context::sender(arg1),
            coin     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AssetWithdrawnEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

