module 0xd0caf3fe16208ea5321a6d50678fa96c5aef245e7f832522bf63f289206d7d71::account_module {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserStrategies has key {
        id: 0x2::object::UID,
        owner: address,
        authorized_users: 0x2::table::Table<address, bool>,
        assets: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun add_assets(arg0: &mut UserStrategies, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.assets, arg1);
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
        };
        0x2::transfer::share_object<UserStrategies>(v0);
    }

    public entry fun run_strategy(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut UserStrategies, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg3.owner || 0x2::table::contains<address, bool>(&arg3.authorized_users, v0), 100);
        0x5f0d8e42d71344e566fcec09e1f173aaf0381eb4cbede6e7d6bfa7c05164a3da::strategy_module::strategy1(arg0, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3.assets, arg4, arg5), arg5);
    }

    public entry fun set_user_authorization(arg0: &AdminCap, arg1: &mut UserStrategies, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 100);
        if (0x2::table::contains<address, bool>(&arg1.authorized_users, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.authorized_users, arg2) = arg3;
        } else {
            0x2::table::add<address, bool>(&mut arg1.authorized_users, arg2, arg3);
        };
    }

    public entry fun withdraw_assets(arg0: &AdminCap, arg1: &mut UserStrategies, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.assets, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

