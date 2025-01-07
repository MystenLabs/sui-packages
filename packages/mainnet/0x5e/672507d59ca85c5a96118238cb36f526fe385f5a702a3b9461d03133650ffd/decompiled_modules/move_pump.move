module 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::move_pump {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        platform_fee: u64,
        graduated_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
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
        old_initial_virtual_sui_reserves: u64,
        new_initial_virtual_sui_reserves: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
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
        token_amount: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        ts: u64,
    }

    public fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
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

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_version(arg0.version);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get_module(&v1);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v2);
        assert!(!v3.is_completed, 5);
        assert!(arg3 > 0, 2);
        let v4 = v3.virtual_token_reserves - 0x2::coin::value<T0>(&v3.remain_token_reserves);
        let v5 = 0x2::math::min(arg3, v4);
        let v6 = 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::curves::calculate_add_liquidity_cost(v3.virtual_sui_reserves, v3.virtual_token_reserves, v5) + 1;
        let v7 = 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::as_u64(0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::div(0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::mul(0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::from_u64(v6), 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::from_u64(arg0.platform_fee)), 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::from_u64(10000)));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v6 + v7, 6);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v7, arg5);
        let v9 = 0x2::coin::zero<T0>(arg5);
        let (v10, v11) = swap<T0>(v3, v9, arg1, 0, v5, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v11, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v0);
        let v12 = arg0.admin;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v12);
        if (v4 == v5) {
            transfer_pool<T0>(v3, arg2, v12, arg0.graduated_fee, arg4, arg5);
        };
        let v13 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : v2,
            sui_amount             : v6,
            token_amount           : v5,
            virtual_sui_reserves   : v3.virtual_sui_reserves,
            virtual_token_reserves : v3.virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TradedEvent>(v13);
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg5) <= 300, 2);
        assert!(0x1::ascii::length(&arg6) <= 1000, 2);
        assert!(0x1::ascii::length(&arg7) <= 500, 2);
        assert!(0x1::ascii::length(&arg8) <= 500, 2);
        assert!(0x1::ascii::length(&arg9) <= 500, 2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg10),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg10),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg10),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg10),
            is_completed           : false,
        };
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get_module(&v1);
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v2, v0);
        let v3 = 0x1::type_name::get<Pool<T0>>();
        let v4 = CreatedEvent{
            name                   : arg3,
            symbol                 : arg4,
            uri                    : arg5,
            description            : arg6,
            twitter                : arg7,
            telegram               : arg8,
            website                : arg9,
            token_address          : v2,
            bonding_curve          : 0x1::type_name::get_module(&v3),
            created_by             : 0x2::tx_context::sender(arg10),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CreatedEvent>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                             : 0x2::object::new(arg0),
            version                        : 1,
            admin                          : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            platform_fee                   : 50,
            graduated_fee                  : 300000000000,
            initial_virtual_sui_reserves   : 3000000000000,
            initial_virtual_token_reserves : 10000000000000000,
            remain_token_reserves          : 2000000000000000,
            token_decimals                 : 6,
        };
        0x2::transfer::public_share_object<Configuration>(v0);
    }

    public entry fun migrate_version(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.admin == v0 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.version = arg1;
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get_module(&v1);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v2);
        assert!(!v3.is_completed, 5);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 > 0, 2);
        let v5 = 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::curves::calculate_remove_liquidity_return(v3.virtual_token_reserves, v3.virtual_sui_reserves, v4);
        let v6 = 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::as_u64(0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::div(0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::mul(0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::from_u64(v5), 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::from_u64(arg0.platform_fee)), 0xc45cd4efcd2963bdee861ddef337f2eba4e3815ec425ae216f8bf0bd21e81ee9::utils::from_u64(10000)));
        assert!(v5 - v6 >= arg2, 2);
        let v7 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v8, v9) = swap<T0>(v3, arg1, v7, 0, v5, arg4);
        let v10 = v9;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v6, arg4), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v0);
        let v11 = TradedEvent{
            is_buy                 : false,
            user                   : v0,
            token_address          : v2,
            sui_amount             : v5,
            token_amount           : v4,
            virtual_sui_reserves   : v3.virtual_sui_reserves,
            virtual_token_reserves : v3.virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v11);
    }

    public fun skim<T0>(arg0: &mut Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_module(&v1));
        assert!(!v2.is_completed, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves), arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2.real_token_reserves, 0x2::coin::value<T0>(&v2.real_token_reserves), arg1), v0);
    }

    public entry fun transfer_admin(arg0: &mut Configuration, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.admin == v0 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.admin = arg1;
        let v1 = OwnershipTransferredEvent{
            old_admin : v0,
            new_admin : arg1,
            ts        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v1);
    }

    fun transfer_pool<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg3, arg5), arg2);
        let v0 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&arg0.real_sui_reserves), arg5);
        let v1 = 0x2::coin::split<T0>(&mut arg0.real_token_reserves, 0x2::coin::value<T0>(&arg0.real_token_reserves), arg5);
        let v2 = 0x1::type_name::get<T0>();
        0x2::coin::join<T0>(&mut v1, 0x2::coin::split<T0>(&mut arg0.remain_token_reserves, 0x2::coin::value<T0>(&arg0.remain_token_reserves), arg5));
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, 0x2::sui::SUI>()) {
            let (v3, v4, v5) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::add_liquidity_returns<T0, 0x2::sui::SUI>(0x2::coin::value<T0>(&v1), v1, 0x2::coin::value<0x2::sui::SUI>(&v0), v0, 1, 1, arg1, arg5);
            0x2::coin::join<T0>(&mut arg0.real_token_reserves, v3);
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<T0, 0x2::sui::SUI>>>(v5, @0x2);
            let v6 = 0x1::type_name::get<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<T0, 0x2::sui::SUI>>();
            let v7 = PoolCompletedEvent{
                token_address : 0x1::type_name::get_module(&v2),
                lp            : 0x1::type_name::get_module(&v6),
                ts            : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<PoolCompletedEvent>(v7);
        } else {
            let (v8, v9, v10) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::add_liquidity_returns<0x2::sui::SUI, T0>(0x2::coin::value<0x2::sui::SUI>(&v0), v0, 0x2::coin::value<T0>(&v1), v1, 1, 1, arg1, arg5);
            0x2::coin::join<T0>(&mut arg0.real_token_reserves, v9);
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>>(v10, @0x2);
            let v11 = 0x1::type_name::get<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<T0, 0x2::sui::SUI>>();
            let v12 = PoolCompletedEvent{
                token_address : 0x1::type_name::get_module(&v2),
                lp            : 0x1::type_name::get_module(&v11),
                ts            : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<PoolCompletedEvent>(v12);
        };
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg0.admin == v0 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.platform_fee = arg1;
        arg0.graduated_fee = arg2;
        arg0.initial_virtual_sui_reserves = arg3;
        arg0.initial_virtual_token_reserves = arg4;
        arg0.remain_token_reserves = arg5;
        arg0.token_decimals = arg6;
        let v1 = ConfigChangedEvent{
            old_platform_fee                   : arg0.platform_fee,
            new_platform_fee                   : arg1,
            old_graduated_fee                  : arg0.graduated_fee,
            new_graduated_fee                  : arg2,
            old_initial_virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            new_initial_virtual_sui_reserves   : arg3,
            old_initial_virtual_token_reserves : arg0.initial_virtual_token_reserves,
            new_initial_virtual_token_reserves : arg4,
            old_remain_token_reserves          : arg0.remain_token_reserves,
            new_remain_token_reserves          : arg5,
            old_token_decimals                 : arg0.token_decimals,
            new_token_decimals                 : arg6,
            ts                                 : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ConfigChangedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

