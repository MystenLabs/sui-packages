module 0xe477dff03e5fd52edabfd0d0cb3c7a2cde77f9dbcfc2e38a24d9d917e9828c89::cetus_invest {
    struct CetusInfo has key {
        id: 0x2::object::UID,
        global_config: 0x2::object::ID,
        supported_coins: vector<0x1::string::String>,
        coin_icon_table: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        coin_symb_table: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct InvestmentManagedCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_investment<T0: drop>(arg0: &InvestmentManagedCap, arg1: &mut CetusInfo, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(!0x1::vector::contains<0x1::string::String>(&arg1.supported_coins, &v0), 1);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.supported_coins, v0);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.coin_symb_table, v0, arg2);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.coin_icon_table, v0, arg3);
    }

    public(friend) fun arbitrage<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::value<T1>(&v4);
        0x2::balance::join<T0>(arg2, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusInfo{
            id              : 0x2::object::new(arg0),
            global_config   : 0x2::object::id_from_address(@0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f),
            supported_coins : 0x1::vector::empty<0x1::string::String>(),
            coin_icon_table : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
            coin_symb_table : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
        };
        let v1 = InvestmentManagedCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CetusInfo>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<InvestmentManagedCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun invest<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, arg4, arg5);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::value<T0>(&v4);
        0x2::balance::join<T1>(arg2, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        v4
    }

    public entry fun modify_coin_icon<T0: drop>(arg0: &InvestmentManagedCap, arg1: &mut CetusInfo, arg2: 0x1::string::String) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.supported_coins, &v0), 0);
        0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg1.coin_icon_table, v0);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.coin_icon_table, v0, arg2);
    }

    public entry fun modify_coin_symb<T0: drop>(arg0: &InvestmentManagedCap, arg1: &mut CetusInfo, arg2: 0x1::string::String) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.supported_coins, &v0), 0);
        0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg1.coin_symb_table, v0);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.coin_symb_table, v0, arg2);
    }

    public entry fun modify_global_config(arg0: &InvestmentManagedCap, arg1: &mut CetusInfo, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.global_config = arg2;
    }

    public entry fun remove_coin<T0: drop>(arg0: &InvestmentManagedCap, arg1: &mut CetusInfo) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&arg1.supported_coins, &v0);
        assert!(v1, 1);
        0x1::vector::swap_remove<0x1::string::String>(&mut arg1.supported_coins, v2);
        0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg1.coin_icon_table, v0);
        0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg1.coin_symb_table, v0);
    }

    // decompiled from Move bytecode v6
}

