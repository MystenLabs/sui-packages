module 0xfa47f4c79360984701ff9b989944d7dbb568b550e97ad52377b7e7ebbdd9d3f::dailycheck {
    struct State has key {
        id: 0x2::object::UID,
        reward_pool: 0x2::balance::Balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>,
        last_checkin: 0x2::table::Table<address, u64>,
        reward_amount: u64,
        admin: address,
    }

    entry fun check_in(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::table::contains<address, u64>(&arg0.last_checkin, v0)) {
            assert!(v1 >= *0x2::table::borrow<address, u64>(&arg0.last_checkin, v0) + 86400000, 0);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.last_checkin, v0) = v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.last_checkin, v0, v1);
        };
        assert!(0x2::balance::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg0.reward_pool) >= arg0.reward_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>>(0x2::coin::from_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(0x2::balance::split<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.reward_pool, arg0.reward_amount), arg2), v0);
    }

    entry fun deposit_rewards(arg0: &mut State, arg1: 0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>) {
        0x2::balance::join<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.reward_pool, 0x2::coin::into_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id            : 0x2::object::new(arg0),
            reward_pool   : 0x2::balance::zero<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(),
            last_checkin  : 0x2::table::new<address, u64>(arg0),
            reward_amount : 10000,
            admin         : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<State>(v0);
    }

    entry fun update_reward_amount(arg0: &mut State, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.reward_amount = arg1;
    }

    // decompiled from Move bytecode v6
}

