module 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    public entry fun clear_round_record(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::clear_round_record(arg1, arg2, arg3);
    }

    public entry fun collect_expired_prize(arg0: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::collect_expired_prize(arg0, arg1, arg2);
    }

    public entry fun collect_fee(arg0: &AdminCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::collect_fee(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun destroy_operator(arg0: OperatorCap) {
        let OperatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun draw(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::draw(arg1, arg2, arg3, arg4);
    }

    public entry fun draw_step_1(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::draw_step_1(arg1, arg2, arg3, arg4);
    }

    entry fun draw_step_1_new(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::draw_step_1_new(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun draw_step_2(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::draw_step_2(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun draw_step_2_new(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::draw_step_2_new(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun draw_step_3(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::draw_step_3(arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v2, v0);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::migrate(arg1);
    }

    public entry fun pause(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::pause(arg1);
    }

    public entry fun resume(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::resume(arg1);
    }

    public entry fun set_prize_rate(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: vector<u64>) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::set_prize_rate(0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::get_config_mut(arg1), arg2);
    }

    public entry fun set_round_duration(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: u64) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::set_round_duration(0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::get_config_mut(arg1), arg2);
    }

    public entry fun set_withdraw_fee_rate(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: u64) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::set_withdraw_fee_rate(0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::get_config_mut(arg1), arg2);
    }

    public entry fun start_first_round(arg0: &OperatorCap, arg1: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::start_first_round(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

