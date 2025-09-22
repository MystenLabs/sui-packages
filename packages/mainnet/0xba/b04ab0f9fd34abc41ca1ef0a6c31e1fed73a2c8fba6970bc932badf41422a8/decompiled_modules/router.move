module 0xbab04ab0f9fd34abc41ca1ef0a6c31e1fed73a2c8fba6970bc932badf41422a8::router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RouterConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        coin_whitelist: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        swap_cap: 0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::SwapCap,
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

    public fun swap<T0, T1, T2>(arg0: &RouterConfig, arg1: &mut 0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::State, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 3);
        assert!(arg3 > 0, 4);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 8);
        let v0 = 0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::swap<T0, T1, T2>(arg1, &arg0.swap_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
        let v1 = RouterSwap{
            coin_in         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_in_amount  : arg3,
            coin_out        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            coin_out_amount : 0x2::coin::value<T1>(&v0),
            swap_fee        : 0,
        };
        0x2::event::emit<RouterSwap>(v1);
    }

    public fun get_amount_out<T0, T1>(arg0: &0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::State, arg1: u64, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u64 {
        0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::get_amount_out<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun get_balance_amount<T0>(arg0: &0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::State) : u64 {
        0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::get_balance_amount<T0>(arg0)
    }

    public fun get_price(arg0: &0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u8) {
        0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::get_price(arg0, arg1, arg2)
    }

    public fun get_oracle_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert!(arg1 <= 18, 7);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg3, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1);
        let v3 = if (v2) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)
        };
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), 5);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4);
        assert!(v5 > 0, 6);
        if (v2) {
            if (arg1 >= v3) {
                scale_price(v5, arg1 - v3, true)
            } else {
                scale_price(v5, v3 - arg1, false)
            }
        } else {
            scale_price(v5, arg1 + v3, true)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_router(arg0: &AdminCap, arg1: 0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::SwapCap, arg2: &mut 0x2::tx_context::TxContext) {
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

    fun pow10(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    entry fun resume(arg0: &AdminCap, arg1: &mut RouterConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        arg1.enable = true;
        let v0 = Resume{dummy_field: false};
        0x2::event::emit<Resume>(v0);
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 7);
        (v0 as u64)
    }

    fun scale_price(arg0: u64, arg1: u64, arg2: bool) : u64 {
        assert!(arg1 <= 18, 7);
        if (arg2) {
            safe_mul(arg0, pow10((arg1 as u8)))
        } else {
            arg0 / pow10((arg1 as u8))
        }
    }

    entry fun set_coin_whitelist<T0>(arg0: &AdminCap, arg1: &mut RouterConfig, arg2: bool, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = false;
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg1.coin_whitelist, v0)) {
            if (arg2) {
                if (*0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg1.coin_whitelist, v0) != arg3) {
                    *0x2::table::borrow_mut<0x1::type_name::TypeName, u8>(&mut arg1.coin_whitelist, v0) = arg3;
                    v1 = true;
                };
            } else {
                0x2::table::remove<0x1::type_name::TypeName, u8>(&mut arg1.coin_whitelist, v0);
                v1 = true;
            };
        } else if (arg2) {
            0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg1.coin_whitelist, v0, arg3);
            v1 = true;
        };
        if (v1) {
            let v2 = SetCoinWhitelist{
                coin    : 0x1::type_name::into_string(v0),
                decimal : arg3,
                allow   : arg2,
            };
            0x2::event::emit<SetCoinWhitelist>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

