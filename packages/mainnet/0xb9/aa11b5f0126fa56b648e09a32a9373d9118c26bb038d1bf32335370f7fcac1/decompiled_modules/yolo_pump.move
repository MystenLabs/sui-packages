module 0xb9aa11b5f0126fa56b648e09a32a9373d9118c26bb038d1bf32335370f7fcac1::yolo_pump {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        platform_fee: u64,
        graduated_fee: u64,
        deployment_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        threshold: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        uri: 0x1::ascii::String,
        creator: address,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        is_completed: bool,
    }

    struct ConfigChangedEvent has copy, drop, store {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_graduated_fee: u64,
        new_graduated_fee: u64,
        old_deployment_fee: u64,
        new_deployment_fee: u64,
        old_initial_virtual_sui_reserves: u64,
        new_initial_virtual_sui_reserves: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
        old_threshold: u64,
        new_threshold: u64,
        ts: u64,
    }

    struct CreatedEvent has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        ts: u64,
    }

    struct OwnershipTransferredEvent has copy, drop, store {
        old_admin: address,
        new_admin: address,
        ts: u64,
    }

    struct PoolCompletedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
    }

    struct TradedEvent has copy, drop, store {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        platform_fee: u64,
        token_amount: u64,
        real_sui_reserves: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        pool_id: 0x2::object::ID,
        ts: u64,
    }

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 2);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 4);
    }

    public entry fun buy_v2<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut Configuration, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert_version(arg5.version);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg5.id, 0x1::type_name::get_address(&v1));
        assert!(!v2.is_completed, 5);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v4 = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v2.remain_token_reserves);
        let v5 = calculate_platform_fee(v3, arg5.platform_fee);
        let v6 = v3 - v5;
        assert!(v6 > 0, 2);
        let v7 = 0x1::u64::min(0xb9aa11b5f0126fa56b648e09a32a9373d9118c26bb038d1bf32335370f7fcac1::curves::calculate_token_amount_received(v2.virtual_sui_reserves, v2.virtual_token_reserves, v6), v4);
        assert!(v2.virtual_token_reserves >= v7, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v5, arg8), arg5.admin);
        let v8 = 0x2::coin::zero<T0>(arg8);
        let (v9, v10) = swap<T0>(v2, v8, arg6, v7, 0, arg8);
        let v11 = v9;
        v2.virtual_token_reserves = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v0);
        if (v4 == v7 || 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves) >= arg5.threshold) {
            transfer_pool<T0>(arg0, arg1, arg2, arg3, arg4, v2, arg5.graduated_fee, arg7, arg8);
        };
        let v12 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v6,
            platform_fee           : v5,
            token_amount           : v7,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves),
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            ts                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TradedEvent>(v12);
    }

    fun calculate_platform_fee(arg0: u64, arg1: u64) : u64 {
        0xb9aa11b5f0126fa56b648e09a32a9373d9118c26bb038d1bf32335370f7fcac1::curves::mul_div(arg0, arg1, 10000)
    }

    public fun check_pool_exist<T0>(arg0: &Configuration, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, 0x1::type_name::get_address(&v0))
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg5) <= 300, 2);
        assert!(0x1::ascii::length(&arg6) <= 1000, 2);
        assert!(0x1::ascii::length(&arg7) <= 500, 2);
        assert!(0x1::ascii::length(&arg8) <= 500, 2);
        assert!(0x1::ascii::length(&arg9) <= 500, 2);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 7);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = Pool<T0>{
            id                     : 0x2::object::new(arg10),
            uri                    : arg5,
            creator                : v0,
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg10),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg10),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg10),
            is_completed           : false,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<Pool<T0>>();
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v2), v1);
        let v4 = CreatedEvent{
            name                   : arg3,
            symbol                 : arg4,
            uri                    : arg5,
            description            : arg6,
            twitter                : arg7,
            telegram               : arg8,
            website                : arg9,
            token_address          : 0x1::type_name::into_string(v2),
            bonding_curve          : 0x1::type_name::get_module(&v3),
            pool_id                : 0x2::object::id<Pool<T0>>(&v1),
            created_by             : v0,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CreatedEvent>(v4);
    }

    public entry fun create_and_first_buy<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut Configuration, arg6: 0x2::coin::TreasuryCap<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: 0x1::ascii::String, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg11) <= 300, 2);
        assert!(0x1::ascii::length(&arg12) <= 1000, 2);
        assert!(0x1::ascii::length(&arg13) <= 500, 2);
        assert!(0x1::ascii::length(&arg14) <= 500, 2);
        assert!(0x1::ascii::length(&arg15) <= 500, 2);
        assert_version(arg5.version);
        assert!(0x2::coin::total_supply<T0>(&arg6) == 0, 7);
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = Pool<T0>{
            id                     : 0x2::object::new(arg16),
            uri                    : arg11,
            creator                : v0,
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg16),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg6, arg5.initial_virtual_token_reserves - arg5.remain_token_reserves, arg16),
            virtual_token_reserves : arg5.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg5.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg6, arg5.remain_token_reserves, arg16),
            is_completed           : false,
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) > arg5.deployment_fee, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg5.deployment_fee, arg16), arg5.admin);
            let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
            let v3 = calculate_platform_fee(v2, arg5.platform_fee);
            let v4 = v2 - v3;
            assert!(v4 > 0, 2);
            let v5 = 0x1::u64::min(0xb9aa11b5f0126fa56b648e09a32a9373d9118c26bb038d1bf32335370f7fcac1::curves::calculate_token_amount_received(v1.virtual_sui_reserves, v1.virtual_token_reserves, v4), arg5.initial_virtual_token_reserves - arg5.remain_token_reserves);
            assert!(v1.virtual_token_reserves >= v5, 8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v3, arg16), arg5.admin);
            let v6 = &mut v1;
            let v7 = 0x2::coin::zero<T0>(arg16);
            let (v8, v9) = swap<T0>(v6, v7, arg7, v5, 0, arg16);
            let v10 = v8;
            v1.virtual_token_reserves = v1.virtual_token_reserves - 0x2::coin::value<T0>(&v10);
            let v11 = 0x2::tx_context::sender(arg16);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v11);
            if (v5 == arg5.initial_virtual_token_reserves - arg5.remain_token_reserves || 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves) >= arg5.threshold) {
                let v12 = &mut v1;
                transfer_pool<T0>(arg0, arg1, arg2, arg3, arg4, v12, arg5.graduated_fee, arg8, arg16);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg6, @0x0);
        let v13 = 0x1::type_name::get<T0>();
        let v14 = 0x1::type_name::get<Pool<T0>>();
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg5.id, 0x1::type_name::get_address(&v13), v1);
        let v15 = CreatedEvent{
            name                   : arg9,
            symbol                 : arg10,
            uri                    : arg11,
            description            : arg12,
            twitter                : arg13,
            telegram               : arg14,
            website                : arg15,
            token_address          : 0x1::type_name::into_string(v13),
            bonding_curve          : 0x1::type_name::get_module(&v14),
            pool_id                : 0x2::object::id<Pool<T0>>(&v1),
            created_by             : v0,
            virtual_sui_reserves   : arg5.initial_virtual_sui_reserves,
            virtual_token_reserves : arg5.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<CreatedEvent>(v15);
    }

    public fun early_complete_pool<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut Configuration, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg5.id, 0x1::type_name::get_address(&v0));
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves) >= arg5.threshold, 3);
        transfer_pool<T0>(arg0, arg1, arg2, arg3, arg4, v1, arg5.graduated_fee, arg6, arg7);
    }

    public fun estimate_amount_out<T0>(arg0: &mut Configuration, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        if (arg1 > 0 && arg2 == 0) {
            (0, 0xb9aa11b5f0126fa56b648e09a32a9373d9118c26bb038d1bf32335370f7fcac1::curves::calculate_token_amount_received(v1.virtual_sui_reserves, v1.virtual_token_reserves, arg1 - calculate_platform_fee(arg1, arg0.platform_fee)))
        } else if (arg1 == 0 && arg2 > 0) {
            let v4 = 0xb9aa11b5f0126fa56b648e09a32a9373d9118c26bb038d1bf32335370f7fcac1::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, arg2);
            (v4 - calculate_platform_fee(v4, arg0.platform_fee), 0)
        } else {
            (0, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                             : 0x2::object::new(arg0),
            version                        : 1,
            admin                          : @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f,
            platform_fee                   : 100,
            graduated_fee                  : 100000,
            deployment_fee                 : 100000,
            initial_virtual_sui_reserves   : 5000000,
            initial_virtual_token_reserves : 10000000000000000,
            remain_token_reserves          : 2000000000000000,
            token_decimals                 : 6,
            threshold                      : 20000000,
        };
        0x2::transfer::public_share_object<Configuration>(v0);
    }

    fun init_cetus_pool<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public entry fun migrate_version(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.admin == v0 || v0 == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        arg0.version = arg1;
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert_version(arg0.version);
        assert!(!v2.is_completed, 5);
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 > 0, 2);
        let v4 = 0x1::u64::min(0xb9aa11b5f0126fa56b648e09a32a9373d9118c26bb038d1bf32335370f7fcac1::curves::calculate_remove_liquidity_return(v2.virtual_token_reserves, v2.virtual_sui_reserves, v3), 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves));
        let v5 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v6, v7) = swap<T0>(v2, arg1, v5, 0, v4, arg4);
        let v8 = v7;
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&v8);
        let v10 = calculate_platform_fee(v9, arg0.platform_fee);
        assert!(v9 - v10 >= arg2, 2);
        v2.virtual_sui_reserves = v2.virtual_sui_reserves - 0x2::coin::value<0x2::sui::SUI>(&v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v10, arg4), arg0.admin);
        let v11 = TradedEvent{
            is_buy                 : false,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v4,
            platform_fee           : v10,
            token_amount           : v3,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves),
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v11);
    }

    public fun skim<T0>(arg0: &mut Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(v2.is_completed, 9);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves);
        let v4 = 0x2::coin::value<T0>(&v2.real_token_reserves);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2.real_sui_reserves, v3, arg1), v0);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2.real_token_reserves, v4, arg1), v0);
        };
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 2);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public entry fun transfer_admin(arg0: &mut Configuration, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.admin == v0 || v0 == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        arg0.admin = arg1;
        let v1 = OwnershipTransferredEvent{
            old_admin : arg0.admin,
            new_admin : arg1,
            ts        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v1);
    }

    fun transfer_pool<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut Pool<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        arg5.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg5.real_token_reserves, 0x2::coin::value<T0>(&arg5.real_token_reserves), arg8);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg5.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&arg5.real_sui_reserves), arg8);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg5.remain_token_reserves, 0x2::coin::value<T0>(&arg5.remain_token_reserves), arg8));
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > arg6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, arg6, arg8), arg5.creator);
        };
        let (v2, v3, v4) = init_cetus_pool<T0, 0x2::sui::SUI>(arg0, arg1, 60, sqrt(0x1::u256::pow(2, 128) * (0x2::coin::value<0x2::sui::SUI>(&v1) as u256) / (0x2::coin::value<T0>(&v0) as u256)), 0x1::string::from_ascii(arg5.uri), 4294523716, 443580, v0, v1, arg4, arg3, true, arg7, arg8);
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg2, v2, arg8), @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f);
        let v5 = PoolCompletedEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PoolCompletedEvent>(v5);
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg0.admin == v0 || v0 == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        arg0.platform_fee = arg1;
        arg0.graduated_fee = arg2;
        arg0.deployment_fee = arg3;
        arg0.initial_virtual_sui_reserves = arg4;
        arg0.initial_virtual_token_reserves = arg5;
        arg0.remain_token_reserves = arg6;
        arg0.token_decimals = arg7;
        arg0.threshold = arg8;
        let v1 = ConfigChangedEvent{
            old_platform_fee                   : arg0.platform_fee,
            new_platform_fee                   : arg1,
            old_graduated_fee                  : arg0.graduated_fee,
            new_graduated_fee                  : arg2,
            old_deployment_fee                 : arg0.deployment_fee,
            new_deployment_fee                 : arg3,
            old_initial_virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            new_initial_virtual_sui_reserves   : arg4,
            old_initial_virtual_token_reserves : arg0.initial_virtual_token_reserves,
            new_initial_virtual_token_reserves : arg5,
            old_remain_token_reserves          : arg0.remain_token_reserves,
            new_remain_token_reserves          : arg6,
            old_token_decimals                 : arg0.token_decimals,
            new_token_decimals                 : arg7,
            old_threshold                      : arg0.threshold,
            new_threshold                      : arg8,
            ts                                 : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<ConfigChangedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

