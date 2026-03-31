module 0x873d5392f0daae66531e9eef996275889b7ff17aa0729f8a0fb3276dfea4662c::recovery {
    struct RecoveryVault has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit(arg0: &mut RecoveryVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_balance(arg0: &RecoveryVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecoveryVault{
            id  : 0x2::object::new(arg0),
            sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<RecoveryVault>(v0);
    }

    public entry fun withdraw(arg0: &mut RecoveryVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_all(arg0: &mut RecoveryVault, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui)), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

