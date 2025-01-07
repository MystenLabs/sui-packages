module 0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::swap {
    struct OrderService has store, key {
        id: 0x2::object::UID,
        balances: 0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::BalanceBag,
        coins: vector<0x1::type_name::TypeName>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinsResultEvent has copy, drop {
        coins: vector<0x1::ascii::String>,
    }

    struct BalanceResultEvent has copy, drop {
        balance: u64,
    }

    public entry fun centus_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::pool_script::swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun centus_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::pool_script::swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun check_admin(arg0: &OrderService, arg1: &AdminCap) {
    }

    public entry fun deposit<T0>(arg0: &mut OrderService, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        check_admin(arg0, arg1);
        if (!0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::contains<T0>(&arg0.balances)) {
            0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::init_balance<T0>(&mut arg0.balances);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.coins, 0x1::type_name::get<T0>());
        };
        0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::join<T0>(&mut arg0.balances, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun get_balance<T0>(arg0: &mut OrderService, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = BalanceResultEvent{balance: 0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::value<T0>(&arg0.balances)};
        0x2::event::emit<BalanceResultEvent>(v0);
        0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::value<T0>(&arg0.balances)
    }

    public entry fun get_coins(arg0: &mut OrderService, arg1: &mut 0x2::tx_context::TxContext) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.coins)) {
            let v2 = v1 + 1;
            v1 = v2;
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::type_name::into_string(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coins, v2)));
        };
        let v3 = CoinsResultEvent{coins: v0};
        0x2::event::emit<CoinsResultEvent>(v3);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderService{
            id       : 0x2::object::new(arg0),
            balances : 0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::new(arg0),
            coins    : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<OrderService>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun withdraw<T0>(arg0: &mut OrderService, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin(arg0, arg1);
        assert!(0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::value<T0>(&arg0.balances) >= arg2, 4);
        0x2::coin::from_balance<T0>(0x7c2b6fc3c8914625f1db90b52a3e48d4dd9341c1a91bfa18090fee447cd4b70a::balance_bag::split<T0>(&mut arg0.balances, arg2), arg3)
    }

    public entry fun withdraw_coin_to_coldwallet<T0>(arg0: &mut OrderService, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg2, arg3), @0x131e31b614bbda11a304d2f96dae7536e4f3ac4062553e22153f9a9935a2e2a0);
    }

    public entry fun withdraw_coin_to_gateway<T0>(arg0: &mut OrderService, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg2, arg3), @0x131e31b614bbda11a304d2f96dae7536e4f3ac4062553e22153f9a9935a2e2a0);
    }

    // decompiled from Move bytecode v6
}

