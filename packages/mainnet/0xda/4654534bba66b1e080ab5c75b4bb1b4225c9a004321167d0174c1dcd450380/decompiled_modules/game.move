module 0xda4654534bba66b1e080ab5c75b4bb1b4225c9a004321167d0174c1dcd450380::game {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlayEvent has copy, drop {
        input: bool,
        rand: bool,
        bet_amount: u64,
    }

    entry fun deposit(arg0: &AdminCap, arg1: &mut Game, arg2: &mut 0x2::coin::Coin<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(arg2) >= arg3, 1);
        0x2::balance::join<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&mut arg1.balance, 0x2::coin::into_balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(0x2::coin::split<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(arg2, arg3, arg4)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(arg3) >= arg4, 3);
        assert!(0x2::balance::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&arg0.balance) >= arg4, 4);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = 0x2::random::generate_bool(&mut v0);
        if (arg2 == v1) {
            0x2::coin::join<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(arg3, 0x2::coin::from_balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg4), arg5));
        } else {
            0x2::balance::join<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(0x2::coin::split<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(arg3, arg4, arg5)));
        };
        let v2 = PlayEvent{
            input      : arg2,
            rand       : v1,
            bet_amount : arg4,
        };
        0x2::event::emit<PlayEvent>(v2);
    }

    entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&arg1.balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

