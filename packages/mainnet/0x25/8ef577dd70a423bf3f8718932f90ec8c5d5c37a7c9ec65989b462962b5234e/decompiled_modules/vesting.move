module 0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::vesting {
    struct Locker has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        current_balance: 0x2::balance::Balance<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>,
        owner: address,
    }

    public entry fun lock_tokens(arg0: 0x2::coin::Coin<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::coin::into_balance<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>(arg0);
        let v2 = Locker{
            id               : 0x2::object::new(arg3),
            start_date       : v0,
            final_date       : v0 + arg1,
            original_balance : 0x2::balance::value<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>(&v1),
            current_balance  : v1,
            owner            : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::public_share_object<Locker>(v2);
    }

    public entry fun withdraw_vested(arg0: &mut Locker, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = arg0.final_date - arg0.start_date;
        let v1 = 0x2::clock::timestamp_ms(arg1) - arg0.start_date;
        let v2 = if (v1 > v0) {
            v0
        } else {
            v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>>(0x2::coin::from_balance<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>(0x2::balance::split<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>(&mut arg0.current_balance, arg0.original_balance * v2 / v0 - arg0.original_balance - 0x2::balance::value<0x258ef577dd70a423bf3f8718932f90ec8c5d5c37a7c9ec65989b462962b5234e::swhit::SWHIT>(&arg0.current_balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

