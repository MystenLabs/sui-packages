module 0xd09c9ea83111f0a5e8295f98c7c15b6c131052f37f849fe3fcb88bc975ba0080::bison_presale {
    struct AmountDepositedEvent has copy, drop {
        amount: u64,
        from: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PresaleLedger has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    entry fun deposit(arg0: &mut PresaleLedger, arg1: &mut 0xd09c9ea83111f0a5e8295f98c7c15b6c131052f37f849fe3fcb88bc975ba0080::bison_referral_pool::ReferralLedger, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0xd09c9ea83111f0a5e8295f98c7c15b6c131052f37f849fe3fcb88bc975ba0080::bison_referral_pool::deposit(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, get_referral_amount(v0), arg3), arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = AmountDepositedEvent{
            amount : v0,
            from   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AmountDepositedEvent>(v1);
    }

    fun get_referral_amount(arg0: u64) : u64 {
        arg0 / 100 * 9
    }

    fun has_enough_funds(arg0: &PresaleLedger, arg1: u64) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = PresaleLedger{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner   : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::public_share_object<PresaleLedger>(v2);
    }

    entry fun withdraw_funds(arg0: &AdminCap, arg1: &mut PresaleLedger, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(has_enough_funds(arg1, arg3), 9223372324617584641);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

