module 0xb47da0ccdaccf0fb426d35c80955279826a2acb6c3893a9c8f8ad00f9908ea21::account_module {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserStrategies has key {
        id: 0x2::object::UID,
        owner: address,
        authorized_users: 0x2::table::Table<address, bool>,
        assets: 0x2::coin::Coin<0x2::sui::SUI>,
        lp_assets: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>,
    }

    public entry fun add_assets(arg0: &mut UserStrategies, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.assets, arg1);
    }

    public entry fun add_lp_assets(arg0: &mut UserStrategies, arg1: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0x2::coin::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut arg0.lp_assets, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_user_strategies(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserStrategies{
            id               : 0x2::object::new(arg1),
            owner            : 0x2::tx_context::sender(arg1),
            authorized_users : 0x2::table::new<address, bool>(arg1),
            assets           : 0x2::coin::zero<0x2::sui::SUI>(arg1),
            lp_assets        : 0x2::coin::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1),
        };
        0x2::transfer::share_object<UserStrategies>(v0);
    }

    public entry fun run_strategy(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut UserStrategies, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (v0 != arg3.owner) {
            assert!(0x2::table::contains<address, bool>(&arg3.authorized_users, v0), 100);
            assert!(*0x2::table::borrow_mut<address, bool>(&mut arg3.authorized_users, v0), 200);
        };
        0x2::coin::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut arg3.lp_assets, 0x5191c1b099a341475c2fa226f4e860bd373fbf1f341040290a15f11476f124bd::strategy_module::strategy1(arg0, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3.assets, arg4, arg5), arg5));
    }

    public entry fun set_user_authorization(arg0: &AdminCap, arg1: &mut UserStrategies, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 100);
        if (0x2::table::contains<address, bool>(&arg1.authorized_users, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.authorized_users, arg2) = arg3;
        } else {
            0x2::table::add<address, bool>(&mut arg1.authorized_users, arg2, arg3);
        };
    }

    public fun spend_lp_assets(arg0: &AdminCap, arg1: &mut UserStrategies, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        let v0 = 0x2::tx_context::sender(arg3);
        if (v0 != arg1.owner) {
            assert!(0x2::table::contains<address, bool>(&arg1.authorized_users, v0), 100);
            assert!(*0x2::table::borrow_mut<address, bool>(&mut arg1.authorized_users, v0), 200);
        };
        0x2::coin::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut arg1.lp_assets, arg2, arg3)
    }

    public entry fun withdraw_assets(arg0: &AdminCap, arg1: &mut UserStrategies, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.assets, arg2, arg4), arg3);
    }

    public entry fun withdraw_lp_assets(arg0: &AdminCap, arg1: &mut UserStrategies, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(0x2::coin::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut arg1.lp_assets, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

