module 0xfc84f0c73aebf30203987c1d7c30438df8644ece6ec33b1b432deb1608951370::reward_pool {
    struct RewardPool has key {
        id: 0x2::object::UID,
        user_rewards: 0x2::table::Table<0x2::object::ID, u64>,
        balance: 0x2::balance::Balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
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

    public entry fun deposit_reward(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>) {
        0x2::balance::join<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg0.balance, 0x2::coin::into_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(arg1));
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
            id           : 0x2::object::new(arg0),
            user_rewards : 0x2::table::new<0x2::object::ID, u64>(arg0),
            balance      : 0x2::balance::zero<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewardPool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun redeem_reward(arg0: &mut RewardPool, arg1: &0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA> {
        let v0 = 0x2::object::id<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.user_rewards, v0)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.user_rewards, v0);
            *v2 = 0;
            0x2::coin::from_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(0x2::balance::split<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg0.balance, *v2), arg2)
        } else {
            0x2::coin::zero<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(arg2)
        }
    }

    public fun withdraw_reward(arg0: &AdminCap, arg1: &mut RewardPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA> {
        0x2::coin::from_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(0x2::balance::split<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg1.balance, 0x2::math::min(arg2, 0x2::balance::value<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&arg1.balance))), arg3)
    }

    // decompiled from Move bytecode v6
}

