module 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account {
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

    public(friend) fun borrow_asset_for_trading<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: &mut TradeAsset<T0>, arg2: u64, arg3: address, arg4: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Promise) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg4);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_trading_manager(arg0, arg4, arg5);
        assert_trade_asset_belongs_to_user<T0>(arg3, arg1);
        let v0 = &mut arg1.balance;
        assert!(arg2 <= 0x2::balance::value<T0>(v0), 4);
        let v1 = Promise{
            user         : arg3,
            borrowed_for : 0x1::type_name::get<T1>(),
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg5), v1)
    }

    public(friend) fun deposit_existing_asset<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut TradeAsset<T0>, arg2: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public(friend) fun deposit_existing_asset_as_trading_manager<T0>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut TradeAsset<T0>, arg3: address, arg4: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg5: Promise, arg6: &mut 0x2::tx_context::TxContext) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg4);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_trading_manager(arg0, arg4, arg6);
        assert_trade_asset_belongs_to_user<T0>(arg3, arg2);
        let Promise {
            user         : v0,
            borrowed_for : v1,
        } = arg5;
        assert!(v0 == arg3, 6);
        assert!(v1 == 0x1::type_name::get<T0>(), 7);
        deposit_existing_asset<T0>(arg1, arg2, arg4);
    }

    public(friend) fun deposit_new_asset<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = TradeAsset<T0>{
            id      : 0x2::object::new(arg2),
            user    : 0x2::tx_context::sender(arg2),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<TradeAsset<T0>>(v0);
        0x2::object::id<TradeAsset<T0>>(&v0)
    }

    public(friend) fun deposit_new_asset_as_trading_manager<T0>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg4: Promise, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg3);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_trading_manager(arg0, arg3, arg5);
        let Promise {
            user         : v0,
            borrowed_for : v1,
        } = arg4;
        assert!(v0 == arg1, 6);
        assert!(v1 == 0x1::type_name::get<T0>(), 7);
        let v2 = TradeAsset<T0>{
            id      : 0x2::object::new(arg5),
            user    : arg1,
            balance : 0x2::coin::into_balance<T0>(arg2),
        };
        0x2::transfer::share_object<TradeAsset<T0>>(v2);
        0x2::object::id<TradeAsset<T0>>(&v2)
    }

    public(friend) fun withdraw_asset<T0>(arg0: &mut TradeAsset<T0>, arg1: u64, arg2: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg2);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_not_trading_manager(0x2::tx_context::sender(arg3), arg2);
        assert_trade_asset_belongs_to_user<T0>(0x2::tx_context::sender(arg3), arg0);
        let v0 = &mut arg0.balance;
        assert!(arg1 <= 0x2::balance::value<T0>(v0), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

