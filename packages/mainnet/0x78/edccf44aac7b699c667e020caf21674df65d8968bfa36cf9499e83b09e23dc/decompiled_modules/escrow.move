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

    struct WhitelistCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        whitelisted_addresses: vector<address>,
    }

    struct EscrowLedger has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    entry fun add_to_whitelist(arg0: &mut WhitelistCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 9223372496416538629);
        assert!(!0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1), 9223372500712030221);
        0x1::vector::push_back<address>(&mut arg0.whitelisted_addresses, arg1);
        let v0 = AddressWhitelistedEvent{account: arg1};
        0x2::event::emit<AddressWhitelistedEvent>(v0);
    }

    fun change_owner(arg0: &mut EscrowLedger, arg1: address) {
        arg0.owner = arg1;
    }

    entry fun create_whitelist_cap(arg0: &EscrowLedger, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_owner(arg0, v0), 9223372449171898373);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = WhitelistCap{
            id                    : 0x2::object::new(arg1),
            owner                 : v0,
            whitelisted_addresses : v1,
        };
        0x2::transfer::share_object<WhitelistCap>(v2);
    }

    entry fun deposit(arg0: &mut EscrowLedger, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!(0x2::coin::value<0x2::sui::SUI>(&arg1) <= 0), 9223372603790983177);
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

    entry fun remove_from_whitelist(arg0: &mut WhitelistCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 9223372535071244293);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelisted_addresses, &arg1);
        assert!(v0, 9223372543661572107);
        0x1::vector::remove<address>(&mut arg0.whitelisted_addresses, v1);
        let v2 = AddressBlacklistedEvent{account: arg1};
        0x2::event::emit<AddressBlacklistedEvent>(v2);
    }

    entry fun transfer_ownership(arg0: &mut EscrowLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 9223372573725949957);
        assert!(!is_owner(arg0, arg1), 9223372578021048327);
        change_owner(arg0, arg1);
    }

    entry fun withdraw_funds(arg0: &mut EscrowLedger, arg1: &WhitelistCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &arg1.whitelisted_addresses;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<address>(v1)) {
            if (0x1::vector::borrow<address>(v1, v2) == &v0) {
                v3 = true;
                /* label 6 */
                assert!(v3, 9223372685395099653);
                assert!(has_funds(arg0) || !(arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), 9223372689689935875);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg4), arg3);
                let v4 = WithdrawEvent{
                    to     : arg3,
                    amount : arg2,
                };
                0x2::event::emit<WithdrawEvent>(v4);
                return
            };
            v2 = v2 + 1;
        };
        v3 = false;
        /* goto 6 */
    }

    // decompiled from Move bytecode v6
}

