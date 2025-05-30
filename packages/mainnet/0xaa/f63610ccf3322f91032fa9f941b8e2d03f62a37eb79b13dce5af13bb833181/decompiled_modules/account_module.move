module 0xaaf63610ccf3322f91032fa9f941b8e2d03f62a37eb79b13dce5af13bb833181::account_module {
    struct APYEvent has copy, drop {
        apy: u64,
    }

    struct UserStrategies has key {
        id: 0x2::object::UID,
        owner: address,
        keeper: address,
        rate: u64,
        token0: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>,
        token1: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>,
    }

    public entry fun add_assets(arg0: &mut UserStrategies, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&mut arg0.token0, 0x6fc427943cbda30511ae3dd98311e4f18b75405fdb20a6ab20c3ea3ba9302e61::strategy0_module::open_position(arg1, arg2, arg3, arg4, arg5));
    }

    fun check_authorization(arg0: &UserStrategies, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.keeper, 103);
    }

    fun check_owner(arg0: &UserStrategies, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 102);
    }

    public fun check_rate(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let v0 = 4294967296;
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::borrow_dynamics(arg0);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_models(arg0);
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0));
        let v4 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::keys<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel>(v2);
        let v5 = 0x1::vector::length<0x1::type_name::TypeName>(&v4);
        let v6 = 0;
        0x1::vector::empty<0xb8d603a39114a5efef3dd0bf84df0bed1be1fbd39b78b7dd6e8a61ccc5e6006f::market_query::PoolData>();
        while (v6 < v5) {
            let v7 = APYEvent{apy: 1};
            0x2::event::emit<APYEvent>(v7);
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v4, v6);
            let v9 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamic>(v1, v8);
            let v10 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel>(v2, v8);
            let v11 = APYEvent{apy: 2};
            0x2::event::emit<APYEvent>(v11);
            let v12 = APYEvent{apy: 3};
            0x2::event::emit<APYEvent>(v12);
            0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::borrow_fee_key(v8));
            let (v13, v14, v15, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(v3, v8));
            let v17 = APYEvent{apy: 4};
            0x2::event::emit<APYEvent>(v17);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::type_name(v10) == 0x1::type_name::get<0x2::sui::SUI>()) {
                let v18 = APYEvent{apy: 222};
                0x2::event::emit<APYEvent>(v18);
                let v19 = APYEvent{apy: 333};
                0x2::event::emit<APYEvent>(v19);
                return 10000 * 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::interest_rate(v9)) * v14 * (v0 - 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::revenue_factor(v10))) / v0 / 1361925194 / (v13 + v14 - v15)
            };
            v6 = v6 + 1;
        };
        let v20 = APYEvent{apy: v5};
        0x2::event::emit<APYEvent>(v20);
        0
    }

    public entry fun init_user_strategies(arg0: address, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 101);
        let v0 = UserStrategies{
            id     : 0x2::object::new(arg6),
            owner  : 0x2::tx_context::sender(arg6),
            keeper : arg0,
            rate   : arg1,
            token0 : 0x6fc427943cbda30511ae3dd98311e4f18b75405fdb20a6ab20c3ea3ba9302e61::strategy0_module::open_position(arg2, arg3, arg4, arg5, arg6),
            token1 : 0x2::coin::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg6),
        };
        0x2::transfer::share_object<UserStrategies>(v0);
    }

    public entry fun run_strategy1(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut UserStrategies, arg7: &mut 0x2::tx_context::TxContext) {
        check_authorization(arg6, arg7);
        0x2::coin::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut arg6.token1, 0x6fc427943cbda30511ae3dd98311e4f18b75405fdb20a6ab20c3ea3ba9302e61::strategy1_module::open_position(arg3, arg4, arg5, 0x6fc427943cbda30511ae3dd98311e4f18b75405fdb20a6ab20c3ea3ba9302e61::strategy0_module::close_position(arg0, arg1, 0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&mut arg6.token0, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&arg6.token0), arg7), arg2, arg7), arg7));
    }

    public entry fun set_keeper(arg0: &mut UserStrategies, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.keeper = arg1;
    }

    public entry fun withdraw_assets(arg0: &mut UserStrategies, arg1: u64, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg4);
        if (arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>>(0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&mut arg0.token0, arg1, arg4), arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(0x2::coin::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut arg0.token1, arg1, arg4), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

