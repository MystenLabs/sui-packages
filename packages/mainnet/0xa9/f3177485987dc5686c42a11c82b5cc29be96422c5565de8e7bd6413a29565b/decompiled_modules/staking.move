module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Staking has key {
        id: 0x2::object::UID,
        config: StakingConfig,
        vim_balance: 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>,
        svim_balance: 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>,
    }

    struct StakingConfig has store {
        pause: bool,
        epoch_length: u64,
        epoch_number: u64,
        epoch_timestamp: u64,
        epoch_distribute: u64,
    }

    struct InitEvent has copy, drop {
        sender: address,
        staking_id: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = StakingConfig{
            pause            : false,
            epoch_length     : 0,
            epoch_number     : 0,
            epoch_timestamp  : 0,
            epoch_distribute : 0,
        };
        let v2 = Staking{
            id           : 0x2::object::new(arg0),
            config       : v1,
            vim_balance  : 0x2::balance::zero<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(),
            svim_balance : 0x2::balance::zero<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(),
        };
        0x2::transfer::share_object<Staking>(v2);
        let v3 = InitEvent{
            sender     : 0x2::tx_context::sender(arg0),
            staking_id : 0x2::object::id<Staking>(&v2),
        };
        0x2::event::emit<InitEvent>(v3);
    }

    public entry fun initialize(arg0: &AdminCap, arg1: &mut Staking, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.config.epoch_length == 0, 1);
        arg1.config.epoch_length = arg2;
        arg1.config.epoch_number = arg3;
        if (arg4 == 0) {
            arg1.config.epoch_timestamp = 0x2::clock::timestamp_ms(arg6) / 1000 + arg2;
        } else {
            arg1.config.epoch_timestamp = arg4;
        };
        0x2::balance::join<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&mut arg1.svim_balance, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::initialize<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg5));
    }

    public fun next_reward(arg0: &Staking) : u64 {
        arg0.config.epoch_distribute
    }

    public fun next_reward_time(arg0: &Staking) : u64 {
        arg0.config.epoch_timestamp
    }

    public entry fun rebase(arg0: &mut Staking, arg1: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg3: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking_distributor::StakingDistributorConfig, arg4: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::Treasury, arg5: &0x2::clock::Clock) {
        if (arg0.config.epoch_timestamp <= 0x2::clock::timestamp_ms(arg5) / 1000) {
            0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::rebase<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg0.config.epoch_distribute, arg0.config.epoch_number, &arg0.svim_balance, arg2, arg5);
            arg0.config.epoch_timestamp = arg0.config.epoch_timestamp + arg0.config.epoch_length;
            arg0.config.epoch_number = arg0.config.epoch_number + 1;
            0x2::balance::join<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut arg0.vim_balance, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking_distributor::distrbute(arg3, arg1, arg4));
            let v0 = 0x2::balance::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&arg0.vim_balance);
            let v1 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::circulating_supply<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg2, &arg0.svim_balance);
            if (v0 <= v1) {
                arg0.config.epoch_distribute = 0;
            } else {
                arg0.config.epoch_distribute = v0 - v1;
            };
        };
    }

    fun reture_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public entry fun set_pause(arg0: &AdminCap, arg1: &mut Staking, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.config.pause = arg2;
    }

    public entry fun stake(arg0: &mut Staking, arg1: 0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: u64, arg3: address, arg4: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg5: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg6: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking_distributor::StakingDistributorConfig, arg7: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::Treasury, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.config.pause == false, 2);
        assert!(arg2 > 0, 3);
        assert!(0x2::coin::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&arg1) >= arg2, 0);
        rebase(arg0, arg4, arg5, arg6, arg7, arg8);
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::gons_from_value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg5, arg2);
        assert!(0x2::balance::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&arg0.svim_balance) >= v0, 0);
        let v1 = 0x2::coin::into_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg1);
        0x2::balance::join<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut arg0.vim_balance, 0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut v1, arg2));
        reture_back_or_delete<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(v1, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&mut arg0.svim_balance, v0), arg9), arg3);
    }

    public(friend) fun stake_balance(arg0: &mut Staking, arg1: 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg3: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg4: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking_distributor::StakingDistributorConfig, arg5: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::Treasury, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM> {
        assert!(arg0.config.pause == false, 2);
        let v0 = 0x2::balance::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&arg1);
        assert!(v0 > 0, 3);
        rebase(arg0, arg2, arg3, arg4, arg5, arg6);
        0x2::balance::join<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut arg0.vim_balance, arg1);
        let v1 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::gons_from_value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg3, v0);
        assert!(0x2::balance::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&arg0.svim_balance) >= v1, 0);
        0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&mut arg0.svim_balance, v1)
    }

    public entry fun unstake(arg0: &mut Staking, arg1: 0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg2: u64, arg3: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::gons_from_value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg3, arg2);
        assert!(0x2::coin::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&arg1) >= v0, 0);
        assert!(0x2::balance::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&arg0.vim_balance) >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg1);
        0x2::balance::join<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&mut arg0.svim_balance, 0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&mut v1, v0));
        reture_back_or_delete<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(v1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut arg0.vim_balance, arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun vim_staking_balance(arg0: &Staking, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>) : u64 {
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::circulating_supply<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg1, &arg0.svim_balance)
    }

    // decompiled from Move bytecode v6
}

