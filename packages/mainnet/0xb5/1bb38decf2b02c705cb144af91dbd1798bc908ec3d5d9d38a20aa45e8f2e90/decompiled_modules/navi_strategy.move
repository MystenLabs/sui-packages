module 0xb51bb38decf2b02c705cb144af91dbd1798bc908ec3d5d9d38a20aa45e8f2e90::navi_strategy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        version: u64,
        navi_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        borrowed_ratio: u64,
        vault_access: 0x1::option::Option<0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::VaultAccess>,
        underlying_nominal_value_usdt: u64,
        st_sbuck_reserve: 0x2::balance::Balance<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>,
        collected_profits: 0x2::bag::Bag,
    }

    public entry fun new(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Strategy{
            id                            : 0x2::object::new(arg1),
            version                       : 1,
            navi_cap                      : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            borrowed_ratio                : 6800,
            vault_access                  : 0x1::option::none<0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::VaultAccess>(),
            underlying_nominal_value_usdt : 0,
            st_sbuck_reserve              : 0x2::balance::zero<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(),
            collected_profits             : 0x2::bag::new(arg1),
        };
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&mut v0.collected_profits, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(), 0x2::balance::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>());
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&mut v0.collected_profits, 0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(), 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>());
        0x2::transfer::share_object<Strategy>(v0);
    }

    fun assert_version(arg0: &Strategy) {
        assert!(arg0.version == 1, 101);
    }

    public fun collected_profit<T0>(arg0: &Strategy) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.collected_profits, 0x1::type_name::get<T0>())
    }

    public fun collected_profit_mut<T0>(arg0: &mut Strategy) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_profits, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun join_vault(arg0: &0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::AdminCap<0x19d7e366749cd6703ed1643ff4541f3a09f85d1911e36b13f421971ed775678e::st_nav_buck1::ST_NAV_BUCK1>, arg1: &AdminCap, arg2: &mut 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x19d7e366749cd6703ed1643ff4541f3a09f85d1911e36b13f421971ed775678e::st_nav_buck1::ST_NAV_BUCK1>, arg3: &mut Strategy, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg3);
        0x1::option::fill<0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::VaultAccess>(&mut arg3.vault_access, 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::add_strategy<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x19d7e366749cd6703ed1643ff4541f3a09f85d1911e36b13f421971ed775678e::st_nav_buck1::ST_NAV_BUCK1>(arg0, arg2, arg4));
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Strategy) {
        assert!(arg1.version < 1, 100);
        arg1.version = 1;
    }

    public fun remove_from_vault(arg0: &mut Strategy, arg1: &0x2::clock::Clock) : 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::StrategyRemovalTicket<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x19d7e366749cd6703ed1643ff4541f3a09f85d1911e36b13f421971ed775678e::st_nav_buck1::ST_NAV_BUCK1> {
        assert_version(arg0);
        arg0.underlying_nominal_value_usdt = 0;
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::new_strategy_removal_ticket<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x19d7e366749cd6703ed1643ff4541f3a09f85d1911e36b13f421971ed775678e::st_nav_buck1::ST_NAV_BUCK1>(0x1::option::extract<0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::VaultAccess>(&mut arg0.vault_access), 0x2::balance::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>())
    }

    public entry fun update_borrowed_ratio(arg0: &mut Strategy, arg1: u64, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0x2::clock::Clock) {
        assert!(arg1 < 7000, 106);
        arg0.borrowed_ratio = arg1;
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap);
        assert!(0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::u256_mul_div(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg4, arg2, arg3, 2, v0), (arg0.borrowed_ratio as u256), (10000 as u256)) <= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg4, arg2, arg3, 2, v0), 108);
    }

    // decompiled from Move bytecode v6
}

