module 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::trade_account {
    struct TradeAsset<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun borrow_asset_for_trading<T0>(arg0: &mut TradeAsset<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &mut arg0.balance;
        assert!(arg1 <= 0x2::balance::value<T0>(v0), 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2)
    }

    public fun deposit_existing_asset<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut TradeAsset<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public fun deposit_new_asset<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: &0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = TradeAsset<T0>{
            id      : 0x2::object::new(arg3),
            user    : 0x2::tx_context::sender(arg3),
            balance : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::transfer<TradeAsset<T0>>(v0, 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::config::derive_multisig_address(arg2, arg0));
        0x2::object::id<TradeAsset<T0>>(&v0)
    }

    public fun deposit_new_asset_as_trading_manager<T0>(arg0: address, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::config::Config, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = TradeAsset<T0>{
            id      : 0x2::object::new(arg4),
            user    : arg0,
            balance : 0x2::coin::into_balance<T0>(arg2),
        };
        0x2::transfer::transfer<TradeAsset<T0>>(v0, 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::config::derive_multisig_address(arg3, arg1));
        0x2::object::id<TradeAsset<T0>>(&v0)
    }

    public fun withdraw_all_asset<T0>(arg0: &mut TradeAsset<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::coin::value<T0>(&v0)
    }

    // decompiled from Move bytecode v6
}

