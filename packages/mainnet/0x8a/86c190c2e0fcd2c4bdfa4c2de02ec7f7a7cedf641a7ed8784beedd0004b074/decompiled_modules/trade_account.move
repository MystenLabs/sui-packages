module 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::trade_account {
    struct TradeAsset<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Promise {
        user: address,
        borrowed_for: 0x1::type_name::TypeName,
    }

    public(friend) fun assert_trade_asset_belongs_to_user<T0>(arg0: address, arg1: &TradeAsset<T0>) {
        assert!(arg1.user == arg0, 5);
    }

    public(friend) fun borrow_asset_for_trading<T0, T1>(arg0: &mut TradeAsset<T0>, arg1: u64, arg2: address, arg3: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Promise) {
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_interacting_with_most_up_to_date_package(arg3);
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_address_is_trading_manager(0x2::tx_context::sender(arg4), arg3);
        assert_trade_asset_belongs_to_user<T0>(arg2, arg0);
        let v0 = &mut arg0.balance;
        assert!(arg1 <= 0x2::balance::value<T0>(v0), 4);
        let v1 = Promise{
            user         : arg2,
            borrowed_for : 0x1::type_name::get<T1>(),
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg4), v1)
    }

    public(friend) fun deposit_existing_asset<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut TradeAsset<T0>, arg2: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        assert_trade_asset_belongs_to_user<T0>(0x2::tx_context::sender(arg3), arg1);
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public(friend) fun deposit_existing_asset_as_trading_manager<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut TradeAsset<T0>, arg2: address, arg3: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg4: Promise, arg5: &mut 0x2::tx_context::TxContext) {
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_interacting_with_most_up_to_date_package(arg3);
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_address_is_trading_manager(0x2::tx_context::sender(arg5), arg3);
        assert_trade_asset_belongs_to_user<T0>(arg2, arg1);
        let Promise {
            user         : v0,
            borrowed_for : v1,
        } = arg4;
        assert!(v0 == arg2, 6);
        assert!(v1 == 0x1::type_name::get<T0>(), 7);
        deposit_existing_asset<T0>(arg0, arg1, arg3, arg5);
    }

    public(friend) fun deposit_new_asset<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = TradeAsset<T0>{
            id      : 0x2::object::new(arg2),
            user    : 0x2::tx_context::sender(arg2),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<TradeAsset<T0>>(v0);
        0x2::object::id<TradeAsset<T0>>(&v0)
    }

    public(friend) fun deposit_new_asset_as_trading_manager<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg3: Promise, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_address_is_trading_manager(0x2::tx_context::sender(arg4), arg2);
        let Promise {
            user         : v0,
            borrowed_for : v1,
        } = arg3;
        assert!(v0 == arg0, 6);
        assert!(v1 == 0x1::type_name::get<T0>(), 7);
        let v2 = TradeAsset<T0>{
            id      : 0x2::object::new(arg4),
            user    : arg0,
            balance : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<TradeAsset<T0>>(v2);
        0x2::object::id<TradeAsset<T0>>(&v2)
    }

    public(friend) fun withdraw_all_asset<T0>(arg0: &mut TradeAsset<T0>, arg1: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_address_is_not_trading_manager(0x2::tx_context::sender(arg2), arg1);
        assert_trade_asset_belongs_to_user<T0>(0x2::tx_context::sender(arg2), arg0);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::value<T0>(&v0)
    }

    public(friend) fun withdraw_asset<T0>(arg0: &mut TradeAsset<T0>, arg1: u64, arg2: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config::assert_address_is_not_trading_manager(0x2::tx_context::sender(arg3), arg2);
        assert_trade_asset_belongs_to_user<T0>(0x2::tx_context::sender(arg3), arg0);
        let v0 = &mut arg0.balance;
        assert!(arg1 <= 0x2::balance::value<T0>(v0), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

