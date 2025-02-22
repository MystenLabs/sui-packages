module 0xa767c762165fd0189487f776ac8a9a6f365e03f8c05a55d0eb0ec04114c06d4e::escrow {
    struct DepositAdminEvent has copy, drop {
        amount: u64,
        address: address,
    }

    struct TransferReceivedEvent has copy, drop {
        from: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        to: address,
        amount: u64,
    }

    struct AddressWhitelistedEvent has copy, drop {
        account: address,
    }

    struct AddressBlacklistedEvent has copy, drop {
        account: address,
    }

    struct EscrowLedger has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    entry fun add_to_whitelist(arg0: &EscrowLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 9223372423402160134);
        let v0 = vector[];
        0x1::vector::push_back<address>(&mut v0, arg1);
        let v1 = AddressWhitelistedEvent{account: arg1};
        0x2::event::emit<AddressWhitelistedEvent>(v1);
    }

    fun change_owner(arg0: &mut EscrowLedger, arg1: address) {
        arg0.owner = arg1;
    }

    entry fun deposit(arg0: &mut EscrowLedger, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!(0x2::coin::value<0x2::sui::SUI>(&arg1) <= 0), 9223372522186670090);
        let (v0, v1) = get_amount_to_transfer(&arg1);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v0), arg2), @0xcc34499279e72798e14de7d79c7cbd927b1a98636072bbfa76649df563453c47);
        let v3 = DepositAdminEvent{
            amount  : v0,
            address : @0xcc34499279e72798e14de7d79c7cbd927b1a98636072bbfa76649df563453c47,
        };
        0x2::event::emit<DepositAdminEvent>(v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v2);
        let v4 = TransferReceivedEvent{
            from   : 0x2::tx_context::sender(arg2),
            amount : v1,
        };
        0x2::event::emit<TransferReceivedEvent>(v4);
    }

    public(friend) fun get_amount_to_transfer(arg0: &0x2::coin::Coin<0x2::sui::SUI>) : (u64, u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        let v1 = v0 / 100 / 10;
        (v1, v0 - v1)
    }

    fun has_funds(arg0: &EscrowLedger) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowLedger{
            id      : 0x2::object::new(arg0),
            owner   : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<EscrowLedger>(v0);
    }

    fun is_owner(arg0: &EscrowLedger, arg1: address) : bool {
        arg0.owner == arg1
    }

    entry fun remove_from_whitelist(arg0: &EscrowLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 9223372457761898502);
        let v0 = vector[];
        assert!(0x1::vector::contains<address>(&v0, &arg1), 9223372462057259020);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        let v3 = AddressBlacklistedEvent{account: arg1};
        0x2::event::emit<AddressBlacklistedEvent>(v3);
    }

    entry fun transfer_ownership(arg0: &mut EscrowLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 9223372492121636870);
        assert!(!is_owner(arg0, arg1), 9223372496416735240);
        change_owner(arg0, arg1);
    }

    entry fun withdraw_funds(arg0: &mut EscrowLedger, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        if (!0x1::vector::contains<address>(&v0, &arg0.owner)) {
            let v1 = vector[];
            0x1::vector::push_back<address>(&mut v1, arg0.owner);
        };
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = vector[];
        let v4 = &v3;
        let v5 = 0;
        let v6;
        while (v5 < 0x1::vector::length<address>(v4)) {
            if (0x1::vector::borrow<address>(v4, v5) == &v2) {
                v6 = true;
                /* label 8 */
                assert!(v6, 9223372629560590342);
                assert!(has_funds(arg0) || !(arg1 > 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), 9223372633855426564);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg3), arg2);
                let v7 = WithdrawEvent{
                    to     : arg2,
                    amount : arg1,
                };
                0x2::event::emit<WithdrawEvent>(v7);
                return
            };
            v5 = v5 + 1;
        };
        v6 = false;
        /* goto 8 */
    }

    // decompiled from Move bytecode v6
}

