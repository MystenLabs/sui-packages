module 0xef27d1588f4ec525b7687334870dc08f49fa725c50bb6748951664bd7f7efb39::suipump {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin_addr: address,
        platform_fee: u64,
        graduated_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        img_url: 0x1::ascii::String,
        real_sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        real_token_reserves: 0x2::balance::Balance<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::balance::Balance<T0>,
        is_completed: bool,
    }

    struct AdminConfigChanged has copy, drop {
        old_admin_addr: address,
        new_admin_addr: address,
        ts: u64,
    }

    struct ConfigChanged has copy, drop {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_graduated_fee: u64,
        new_graduated_fee: u64,
        old_initial_virtual_sui_reserves: u64,
        new_initial_virtual_sui_reserves: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        ts: u64,
    }

    struct Created has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::string::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        metadata: address,
        bonding_curve: address,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        ts: u64,
    }

    struct Traded has copy, drop {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        pool_id: 0x2::object::ID,
        ts: u64,
    }

    struct PoolCompleted has copy, drop {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
    }

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(0x2::balance::value<T0>(&arg1) > 0 || 0x2::balance::value<0x2::sui::SUI>(&arg2) > 0, 69011);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::balance::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::balance::value<0x2::sui::SUI>(&arg2);
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::balance::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::balance::split<T0>(&mut arg0.real_token_reserves, arg3), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4))
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 69012);
    }

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: &mut Pool<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 69000);
        assert!(!arg1.is_completed, 69006);
        assert!(arg4 > 0, 69007);
        let v0 = arg1.virtual_token_reserves - 0x2::balance::value<T0>(&arg1.remain_token_reserves);
        let v1 = 0x1::u64::min(arg4, v0);
        let v2 = get_amount_in(v1, arg1.virtual_sui_reserves, arg1.virtual_token_reserves);
        let v3 = v2 / arg0.platform_fee;
        assert!(arg3 >= v2 + v3, 69008);
        let (v4, v5) = swap<T0>(arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg10)), v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v3, arg10), arg0.admin_addr);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg10), 0x2::tx_context::sender(arg10));
        if (v0 == v1) {
            transfer_pool<T0>(arg1, arg6, arg5, arg0.graduated_fee, arg0.admin_addr, arg7, arg8, arg9, arg10);
        };
        let v6 = Traded{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg10),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v2,
            token_amount           : v1,
            virtual_sui_reserves   : arg1.virtual_sui_reserves,
            virtual_token_reserves : arg1.virtual_token_reserves,
            pool_id                : 0x2::object::id<Pool<T0>>(arg1),
            ts                     : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<Traded>(v6);
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 69000);
        0x2::transfer::public_share_object<Pool<T0>>(internal_create<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun create_and_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 69000);
        let v0 = internal_create<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg13);
        let v1 = &mut v0;
        buy<T0>(arg0, v1, arg7, arg8, arg9, arg10, arg11, arg2, arg12, arg3, arg13);
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg1, arg0, arg2 - arg0) + 1
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg2, arg0, arg1 + arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Configuration{
            id                             : 0x2::object::new(arg0),
            version                        : 1,
            admin_addr                     : 0x2::tx_context::sender(arg0),
            platform_fee                   : 100,
            graduated_fee                  : 500000000,
            initial_virtual_sui_reserves   : 1500000000,
            initial_virtual_token_reserves : 1000000000000000,
            remain_token_reserves          : 200000000000000,
        };
        0x2::transfer::share_object<Configuration>(v1);
    }

    fun internal_create<T0>(arg0: &Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert!(0x1::ascii::length(&arg4) <= 500, 69002);
        assert!(0x1::ascii::length(&arg5) <= 500, 69003);
        assert!(0x1::ascii::length(&arg6) <= 500, 69004);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 69015);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v0 = 0x1::option::destroy_some<0x2::url::Url>(0x2::coin::get_icon_url<T0>(arg2));
        let v1 = Pool<T0>{
            id                     : 0x2::object::new(arg7),
            img_url                : 0x2::url::inner_url(&v0),
            real_sui_reserves      : 0x2::balance::zero<0x2::sui::SUI>(),
            real_token_reserves    : 0x2::coin::mint_balance<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint_balance<T0>(&mut arg1, arg0.remain_token_reserves),
            is_completed           : false,
        };
        let v2 = Created{
            name                   : 0x2::coin::get_name<T0>(arg2),
            symbol                 : 0x2::coin::get_symbol<T0>(arg2),
            uri                    : v1.img_url,
            description            : 0x2::coin::get_description<T0>(arg2),
            twitter                : arg4,
            telegram               : arg5,
            website                : arg6,
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            metadata               : 0x2::object::id_to_address(0x2::object::borrow_id<0x2::coin::CoinMetadata<T0>>(arg2)),
            bonding_curve          : 0x2::object::uid_to_address(&v1.id),
            created_by             : 0x2::tx_context::sender(arg7),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Created>(v2);
        v1
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Configuration) {
        assert!(arg1.version < 1, 69001);
        arg1.version = 1;
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun price_to_sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        0x1::u128::sqrt((arg1 as u128) * 1000000000000000000 / (arg0 as u128)) * 18446744073709551616 / 1000000000
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: &mut Pool<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 69000);
        assert!(!arg1.is_completed, 69006);
        assert!(arg4 > 0, 69009);
        let v0 = get_amount_out(arg4, arg1.virtual_token_reserves, arg1.virtual_sui_reserves);
        let v1 = v0 / arg0.platform_fee;
        assert!(v0 - v1 >= arg3, 69010);
        let (v2, v3) = swap<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg4, arg6)), 0x2::balance::zero<0x2::sui::SUI>(), 0, v0);
        let v4 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v1), arg6), arg0.admin_addr);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6), 0x2::tx_context::sender(arg6));
        let v5 = Traded{
            is_buy                 : false,
            user                   : 0x2::tx_context::sender(arg6),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v0,
            token_amount           : arg4,
            virtual_sui_reserves   : arg1.virtual_sui_reserves,
            virtual_token_reserves : arg1.virtual_token_reserves,
            pool_id                : 0x2::object::id<Pool<T0>>(arg1),
            ts                     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Traded>(v5);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: &mut Configuration, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 69000);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg2);
        let v0 = AdminConfigChanged{
            old_admin_addr : arg1.admin_addr,
            new_admin_addr : arg2,
            ts             : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminConfigChanged>(v0);
        arg1.admin_addr = arg2;
    }

    fun transfer_pool<T0>(arg0: &mut Pool<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: u64, arg4: address, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        0x2::balance::destroy_zero<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.real_token_reserves));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg3), arg8), arg4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserves);
        let v1 = price_to_sqrt_price_x64((((0x2::balance::value<T0>(&arg0.remain_token_reserves) as u128) * 999999 / 1000000) as u64), v0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(443600);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(443600);
        let (_, v5, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v2, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v1), v1, v0, false);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0x2::sui::SUI>(arg1, arg2, 200, v1, 0x1::string::from_ascii(arg0.img_url), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.remain_token_reserves, v5), arg8), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.real_sui_reserves), arg8), arg5, arg6, false, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, @0x0);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v7, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.remain_token_reserves), arg8), @0x0);
        let v10 = PoolCompleted{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()),
            ts            : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PoolCompleted>(v10);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 69000);
        let v0 = ConfigChanged{
            old_platform_fee                   : arg1.platform_fee,
            new_platform_fee                   : arg2,
            old_graduated_fee                  : arg1.graduated_fee,
            new_graduated_fee                  : arg3,
            old_initial_virtual_sui_reserves   : arg1.initial_virtual_sui_reserves,
            new_initial_virtual_sui_reserves   : arg4,
            old_initial_virtual_token_reserves : arg1.initial_virtual_token_reserves,
            new_initial_virtual_token_reserves : arg5,
            old_remain_token_reserves          : arg1.remain_token_reserves,
            new_remain_token_reserves          : arg6,
            ts                                 : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ConfigChanged>(v0);
        arg1.platform_fee = arg2;
        arg1.graduated_fee = arg3;
        arg1.initial_virtual_sui_reserves = arg4;
        arg1.initial_virtual_token_reserves = arg5;
        arg1.remain_token_reserves = arg6;
    }

    // decompiled from Move bytecode v6
}

