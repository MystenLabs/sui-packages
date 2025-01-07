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

    struct EscrowLedger has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    fun change_owner(arg0: &mut EscrowLedger, arg1: address) {
        arg0.owner = arg1;
    }

    entry fun deposit(arg0: &mut EscrowLedger, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!(0x2::coin::value<0x2::sui::SUI>(&arg1) <= 0), 9223372436287258633);
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

    entry fun transfer_ownership(arg0: &mut EscrowLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 9223372397632290821);
        assert!(!is_owner(arg0, arg1), 9223372401927389191);
        change_owner(arg0, arg1);
    }

    entry fun withdraw_funds(arg0: &mut EscrowLedger, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg3)), 9223372522186342405);
        assert!(has_funds(arg0) || !(arg1 > 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), 9223372526481178627);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg3), arg2);
        let v0 = WithdrawEvent{
            to     : arg2,
            amount : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

