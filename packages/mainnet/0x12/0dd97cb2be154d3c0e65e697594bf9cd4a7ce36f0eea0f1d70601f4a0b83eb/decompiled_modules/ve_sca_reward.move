module 0x120dd97cb2be154d3c0e65e697594bf9cd4a7ce36f0eea0f1d70601f4a0b83eb::ve_sca_reward {
    struct RewardPool has key {
        id: 0x2::object::UID,
        user_rewards: 0x2::table::Table<0x2::object::ID, u64>,
        reserve_ve_sca_key: 0x1::option::Option<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>,
        enable_claim: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun borrow_reserve_ve_sca_key(arg0: &AdminCap, arg1: &RewardPool) : &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey {
        0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg1.reserve_ve_sca_key)
    }

    public entry fun decrease_user_reward(arg0: &AdminCap, arg1: &mut RewardPool, arg2: 0x2::object::ID, arg3: u64) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.user_rewards, arg2)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.user_rewards, arg2);
            if (*v0 > arg3) {
                *v0 = *v0 - arg3;
            } else {
                *v0 = 0;
            };
        };
    }

    public entry fun disable_claim(arg0: &AdminCap, arg1: &mut RewardPool) {
        arg1.enable_claim = false;
    }

    public entry fun enable_claim(arg0: &AdminCap, arg1: &mut RewardPool) {
        arg1.enable_claim = true;
    }

    public fun extract_reserve_ve_sca_key(arg0: &AdminCap, arg1: &mut RewardPool) : 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey {
        0x1::option::extract<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&mut arg1.reserve_ve_sca_key)
    }

    public fun fill_reserve_ve_sca_key(arg0: &AdminCap, arg1: 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg2: &mut RewardPool) {
        0x1::option::fill<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&mut arg2.reserve_ve_sca_key, arg1);
    }

    public entry fun increase_user_reward(arg0: &AdminCap, arg1: &mut RewardPool, arg2: 0x2::object::ID, arg3: u64) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.user_rewards, arg2)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.user_rewards, arg2);
            *v0 = *v0 + arg3;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.user_rewards, arg2, arg3);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id                 : 0x2::object::new(arg0),
            user_rewards       : 0x2::table::new<0x2::object::ID, u64>(arg0),
            reserve_ve_sca_key : 0x1::option::none<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(),
            enable_claim       : true,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewardPool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun redeem_reward(arg0: &mut RewardPool, arg1: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg2: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg3: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg5: &mut 0x2::tx_context::TxContext) : 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey {
        assert!(arg0.enable_claim, 1001);
        let v0 = 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.user_rewards, v0), 1002);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.user_rewards, v0);
        assert!(*v1 > 0, 1002);
        *v1 = 0;
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::split(arg2, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.reserve_ve_sca_key), arg3, arg4, *v1, arg5)
    }

    // decompiled from Move bytecode v6
}

