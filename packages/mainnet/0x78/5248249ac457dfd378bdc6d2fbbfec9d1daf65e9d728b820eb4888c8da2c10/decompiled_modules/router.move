module 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::router {
    public entry fun deposit<T0>(arg0: &mut 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::DividendManager, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::merge_coins<T0>(arg1, arg3);
        0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::deposit<T0>(arg0, &mut v0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun push_bonus<T0>(arg0: &0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::AdminCap, arg1: &mut 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::DividendManager) {
        0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::push_bonus<T0>(arg0, arg1);
    }

    public entry fun redeem<T0>(arg0: &mut 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::DividendManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::redeem<T0>(arg0, arg1, arg2);
    }

    public entry fun register_bonus<T0>(arg0: &0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::AdminCap, arg1: &mut 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::DividendManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::register_bonus<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun remove_bonus<T0>(arg0: &0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::AdminCap, arg1: &mut 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::DividendManager) {
        0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::remove_bonus<T0>(arg0, arg1);
    }

    public entry fun settle(arg0: &0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::SettleCap, arg1: &mut 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::DividendManager, arg2: &0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg3: u64, arg4: vector<0x2::object::ID>, arg5: u64) {
        0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::settle(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

