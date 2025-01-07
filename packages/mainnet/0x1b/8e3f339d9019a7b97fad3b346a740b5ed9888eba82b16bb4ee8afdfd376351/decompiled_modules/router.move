module 0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::router {
    public entry fun deposit<T0>(arg0: &mut 0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::DividendManager, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::utils::merge_coins<T0>(arg1, arg3);
        0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::deposit<T0>(arg0, &mut v0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun push_bonus<T0>(arg0: &0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::AdminCap, arg1: &mut 0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::DividendManager) {
        0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::push_bonus<T0>(arg0, arg1);
    }

    public entry fun redeem<T0>(arg0: &mut 0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::DividendManager, arg1: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::redeem<T0>(arg0, arg1, arg2);
    }

    public entry fun register_bonus<T0>(arg0: &0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::AdminCap, arg1: &mut 0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::DividendManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::register_bonus<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun remove_bonus<T0>(arg0: &0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::AdminCap, arg1: &mut 0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::DividendManager) {
        0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::remove_bonus<T0>(arg0, arg1);
    }

    public entry fun settle(arg0: &0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::SettleCap, arg1: &mut 0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::DividendManager, arg2: &0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg3: u64, arg4: vector<0x2::object::ID>, arg5: u64) {
        0x1b8e3f339d9019a7b97fad3b346a740b5ed9888eba82b16bb4ee8afdfd376351::dividend::settle(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

