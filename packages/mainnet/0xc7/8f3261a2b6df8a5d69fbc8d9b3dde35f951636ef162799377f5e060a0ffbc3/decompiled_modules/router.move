module 0xc78f3261a2b6df8a5d69fbc8d9b3dde35f951636ef162799377f5e060a0ffbc3::router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RouterConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        coin_whitelist: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        swap_cap: 0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::SwapCap,
        swap_fee_bps: u64,
        enable: bool,
    }

    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Resume has copy, drop {
        dummy_field: bool,
    }

    struct RouterSwap has copy, drop {
        coin_in: 0x1::ascii::String,
        coin_in_amount: u64,
        coin_out: 0x1::ascii::String,
        coin_out_amount: u64,
        swap_fee: u64,
    }

    struct SetCoinWhitelist has copy, drop {
        coin: 0x1::ascii::String,
        decimal: u8,
        allow: bool,
    }

    public fun swap<T0, T1, T2>(arg0: &RouterConfig, arg1: &mut 0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::State, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 3);
        let v0 = 0x2::coin::value<T0>(arg2);
        assert!(v0 > 0, 4);
        let v1 = 0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::swap<T0, T1, T2>(arg1, &arg0.swap_cap, arg2, v0, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg6));
        let v2 = RouterSwap{
            coin_in         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_in_amount  : v0,
            coin_out        : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            coin_out_amount : 0x2::coin::value<T1>(&v1),
            swap_fee        : 0,
        };
        0x2::event::emit<RouterSwap>(v2);
    }

    public fun get_amount_out<T0, T1>(arg0: &0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::State, arg1: u64, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u64 {
        0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::get_amount_out<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun get_balance_amount<T0>(arg0: &0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::State) : u64 {
        0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::get_balance_amount<T0>(arg0)
    }

    public fun get_price(arg0: &0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u8) {
        0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::get_price(arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_router(arg0: &AdminCap, arg1: 0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::SwapCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RouterConfig{
            id             : 0x2::object::new(arg2),
            version        : 1,
            coin_whitelist : 0x2::table::new<0x1::type_name::TypeName, u8>(arg2),
            swap_cap       : arg1,
            swap_fee_bps   : 0,
            enable         : true,
        };
        0x2::transfer::share_object<RouterConfig>(v0);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut RouterConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    entry fun pause(arg0: &AdminCap, arg1: &mut RouterConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        arg1.enable = false;
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun resume(arg0: &AdminCap, arg1: &mut RouterConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        arg1.enable = true;
        let v0 = Resume{dummy_field: false};
        0x2::event::emit<Resume>(v0);
    }

    entry fun set_coin_whitelist<T0>(arg0: &AdminCap, arg1: &mut RouterConfig, arg2: bool, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg1.coin_whitelist, v0)) {
            if (!arg2) {
                0x2::table::remove<0x1::type_name::TypeName, u8>(&mut arg1.coin_whitelist, v0);
            };
        } else if (arg2) {
            0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg1.coin_whitelist, v0, arg3);
        };
        let v1 = SetCoinWhitelist{
            coin    : 0x1::type_name::into_string(v0),
            decimal : arg3,
            allow   : arg2,
        };
        0x2::event::emit<SetCoinWhitelist>(v1);
    }

    // decompiled from Move bytecode v6
}

