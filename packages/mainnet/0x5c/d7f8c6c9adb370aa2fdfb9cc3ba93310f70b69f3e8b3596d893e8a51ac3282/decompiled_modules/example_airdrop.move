module 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::example_airdrop {
    struct Airdrop has key {
        id: 0x2::object::UID,
        amount: u64,
        min_level: u8,
        vault: 0x2::coin::Coin<0x2::sui::SUI>,
        claimed: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public fun new(arg0: u64, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Airdrop{
            id        : 0x2::object::new(arg3),
            amount    : arg0,
            min_level : arg1,
            vault     : arg2,
            claimed   : 0x2::table::new<0x2::object::ID, bool>(arg3),
        };
        0x2::transfer::share_object<Airdrop>(v0);
    }

    public fun claim(arg0: &mut Airdrop, arg1: &0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::RealHumanCredential, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::require_verified(arg1, arg0.min_level, arg2);
        let v0 = 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::id(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, v0), 1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.vault, arg0.amount, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

