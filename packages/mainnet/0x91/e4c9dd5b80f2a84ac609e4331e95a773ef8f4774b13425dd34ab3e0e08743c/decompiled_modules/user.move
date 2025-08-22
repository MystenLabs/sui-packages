module 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::user {
    public entry fun claim(arg0: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::WinnerTicket, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::claim(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit(arg0: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::deposit(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdraw(arg0: &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault::withdraw(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

