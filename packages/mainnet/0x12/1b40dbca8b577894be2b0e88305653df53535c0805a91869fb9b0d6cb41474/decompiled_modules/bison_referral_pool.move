module 0x121b40dbca8b577894be2b0e88305653df53535c0805a91869fb9b0d6cb41474::bison_referral_pool {
    struct AmountDepositedEvent has copy, drop {
        amount: u64,
        from: address,
    }

    struct AmountWithdrawnEvent has copy, drop {
        amount: u64,
        to: address,
    }

    struct ReferralLedger has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    entry fun deposit(arg0: &mut ReferralLedger, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = AmountDepositedEvent{
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AmountDepositedEvent>(v0);
    }

    fun has_enough_funds(arg0: &ReferralLedger, arg1: u64) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralLedger{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<ReferralLedger>(v0);
    }

    fun is_owner(arg0: &ReferralLedger, arg1: address) : bool {
        arg0.owner == arg1
    }

    entry fun transfer_ownership(arg0: &mut ReferralLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 9223372268783140867);
        assert!(arg0.owner != arg1, 9223372273078239237);
        arg0.owner = arg1;
    }

    entry fun withdraw_funds(arg0: &mut ReferralLedger, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_owner(arg0, v0), 9223372346092552195);
        assert!(has_enough_funds(arg0, arg2), 9223372350387388417);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3), arg1);
        let v1 = AmountWithdrawnEvent{
            amount : arg2,
            to     : v0,
        };
        0x2::event::emit<AmountWithdrawnEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

