module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking_distributor {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct StakingDistributorConfig has key {
        id: 0x2::object::UID,
        rate: u64,
        adjust: Adjust,
    }

    struct Adjust has store {
        add: bool,
        rate: u64,
        target: u64,
    }

    struct InitEvent has copy, drop {
        sender: address,
        config_id: 0x2::object::ID,
    }

    struct SetRateEvent has copy, drop {
        sender: address,
        rate: u64,
    }

    struct SetAdjustEvent has copy, drop {
        sender: address,
        add: bool,
        rate: u64,
        target: u64,
    }

    fun adjust(arg0: &mut StakingDistributorConfig) {
        if (arg0.adjust.rate > 0) {
            if (arg0.adjust.add) {
                if (arg0.rate + arg0.adjust.rate >= arg0.adjust.target) {
                    arg0.rate = arg0.adjust.target;
                    arg0.adjust.rate = 0;
                } else {
                    arg0.rate = arg0.rate + arg0.adjust.rate;
                };
            } else if (arg0.rate - arg0.adjust.rate <= arg0.adjust.target) {
                arg0.rate = arg0.adjust.target;
                arg0.adjust.rate = 0;
            } else {
                arg0.rate = arg0.rate - arg0.adjust.rate;
            };
        };
    }

    public(friend) fun distrbute(arg0: &mut StakingDistributorConfig, arg1: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::Treasury) : 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM> {
        if (arg0.rate == 0) {
            return 0x2::balance::zero<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>()
        };
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::mint_rewards(arg2, nextreward_at(arg0, arg1), arg1);
        adjust(arg0);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Adjust{
            add    : false,
            rate   : 0,
            target : 0,
        };
        let v2 = StakingDistributorConfig{
            id     : 0x2::object::new(arg0),
            rate   : 0,
            adjust : v1,
        };
        0x2::transfer::share_object<StakingDistributorConfig>(v2);
        let v3 = InitEvent{
            sender    : 0x2::tx_context::sender(arg0),
            config_id : 0x2::object::id<StakingDistributorConfig>(&v2),
        };
        0x2::event::emit<InitEvent>(v3);
    }

    public fun nextreward_at(arg0: &StakingDistributorConfig, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>) : u64 {
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::total_supply<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg1), arg0.rate, 1000000)
    }

    public entry fun set_adjust(arg0: &AdminCap, arg1: &mut StakingDistributorConfig, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 100000, 0);
        assert!(arg4 <= 100000, 0);
        if (arg2 == false) {
            assert!(arg3 <= arg1.rate, 0);
        };
        arg1.adjust.add = arg2;
        arg1.adjust.rate = arg3;
        arg1.adjust.target = arg4;
        let v0 = SetAdjustEvent{
            sender : 0x2::tx_context::sender(arg5),
            add    : arg2,
            rate   : arg3,
            target : arg4,
        };
        0x2::event::emit<SetAdjustEvent>(v0);
    }

    public entry fun set_rate(arg0: &AdminCap, arg1: &mut StakingDistributorConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100000, 0);
        arg1.rate = arg2;
        let v0 = SetRateEvent{
            sender : 0x2::tx_context::sender(arg3),
            rate   : arg2,
        };
        0x2::event::emit<SetRateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

