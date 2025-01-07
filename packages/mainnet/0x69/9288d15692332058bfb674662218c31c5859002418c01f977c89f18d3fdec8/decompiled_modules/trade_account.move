module 0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::trade_account {
    struct TradeAsset<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun borrow_asset_for_trading<T0>(arg0: &mut TradeAsset<T0>, arg1: u64, arg2: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_address_is_trading_manager(0x2::tx_context::sender(arg3), arg2);
        let v0 = &mut arg0.balance;
        assert!(arg1 <= 0x2::balance::value<T0>(v0), 4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg3)
    }

    public(friend) fun deposit_existing_asset<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut TradeAsset<T0>, arg2: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config) {
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public(friend) fun deposit_new_asset<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_interacting_with_most_up_to_date_package(arg2);
        let v0 = TradeAsset<T0>{
            id      : 0x2::object::new(arg3),
            user    : 0x2::tx_context::sender(arg3),
            balance : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::transfer<TradeAsset<T0>>(v0, arg0);
        0x2::object::id<TradeAsset<T0>>(&v0)
    }

    public(friend) fun deposit_new_asset_as_trading_manager<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_interacting_with_most_up_to_date_package(arg3);
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_address_is_trading_manager(0x2::tx_context::sender(arg4), arg3);
        let v0 = TradeAsset<T0>{
            id      : 0x2::object::new(arg4),
            user    : arg0,
            balance : 0x2::coin::into_balance<T0>(arg2),
        };
        0x2::transfer::transfer<TradeAsset<T0>>(v0, arg1);
        0x2::object::id<TradeAsset<T0>>(&v0)
    }

    public(friend) fun withdraw_all_asset<T0>(arg0: &mut TradeAsset<T0>, arg1: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_address_is_not_trading_manager(0x2::tx_context::sender(arg2), arg1);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::value<T0>(&v0)
    }

    public(friend) fun withdraw_asset<T0>(arg0: &mut TradeAsset<T0>, arg1: u64, arg2: &0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x699288d15692332058bfb674662218c31c5859002418c01f977c89f18d3fdec8::config::assert_address_is_not_trading_manager(0x2::tx_context::sender(arg3), arg2);
        let v0 = &mut arg0.balance;
        assert!(arg1 <= 0x2::balance::value<T0>(v0), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

