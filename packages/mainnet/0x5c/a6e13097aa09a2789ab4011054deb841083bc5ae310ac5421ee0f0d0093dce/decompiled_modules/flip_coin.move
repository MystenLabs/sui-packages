module 0x5ca6e13097aa09a2789ab4011054deb841083bc5ae310ac5421ee0f0d0093dce::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(&mut arg0.amt, 0x2::coin::into_balance<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(&arg3);
        assert!(0x2::balance::value<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(&arg0.amt) >= v0 * 10, 273);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(&mut arg0.amt, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(&mut arg0.amt, 0x2::coin::into_balance<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(arg3));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xdb5bb6b2b6c27a214a1a4ab565d5233350f227ccb1ac306cc44da9603d467745::faucet_coin::FAUCET_COIN>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

