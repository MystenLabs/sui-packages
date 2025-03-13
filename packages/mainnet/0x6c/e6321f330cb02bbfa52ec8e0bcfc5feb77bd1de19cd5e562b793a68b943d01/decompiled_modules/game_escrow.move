module 0x6ce6321f330cb02bbfa52ec8e0bcfc5feb77bd1de19cd5e562b793a68b943d01::game_escrow {
    struct DepositEvent has copy, drop {
        amount: u64,
        from: address,
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

    struct CapOwnershipTransferredEvent has copy, drop {
        new_owner: address,
        old_owner: address,
    }

    struct GameWhitelistCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        whitelisted_addresses: vector<address>,
    }

    struct GameLedger has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    entry fun add_to_whitelist(arg0: &mut GameWhitelistCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 9223372496416407555);
        assert!(!0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1), 9223372500711768073);
        0x1::vector::push_back<address>(&mut arg0.whitelisted_addresses, arg1);
        let v0 = AddressWhitelistedEvent{account: arg1};
        0x2::event::emit<AddressWhitelistedEvent>(v0);
    }

    fun change_owner(arg0: &mut GameLedger, arg1: address) {
        arg0.owner = arg1;
    }

    entry fun create_whitelist_cap(arg0: &GameLedger, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_owner(arg0, v0), 9223372414812028931);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = GameWhitelistCap{
            id                    : 0x2::object::new(arg1),
            owner                 : v0,
            whitelisted_addresses : v1,
        };
        0x2::transfer::share_object<GameWhitelistCap>(v2);
    }

    entry fun deposit(arg0: &mut GameLedger, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(!(0x2::coin::value<0x2::sui::SUI>(&arg1) <= 0), 9223372608085688325);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = DepositEvent{
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun has_funds(arg0: &GameLedger) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameLedger{
            id      : 0x2::object::new(arg0),
            owner   : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<GameLedger>(v0);
    }

    fun is_owner(arg0: &GameLedger, arg1: address) : bool {
        arg0.owner == arg1
    }

    entry fun remove_from_whitelist(arg0: &mut GameWhitelistCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 9223372535071113219);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelisted_addresses, &arg1);
        assert!(v0, 9223372543661572107);
        0x1::vector::remove<address>(&mut arg0.whitelisted_addresses, v1);
        let v2 = AddressBlacklistedEvent{account: arg1};
        0x2::event::emit<AddressBlacklistedEvent>(v2);
    }

    entry fun transfer_cap_ownership(arg0: &mut GameWhitelistCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 9223372462056669187);
        assert!(arg1 != v0, 9223372466351898631);
        arg0.owner = arg1;
        let v1 = CapOwnershipTransferredEvent{
            new_owner : arg1,
            old_owner : v0,
        };
        0x2::event::emit<CapOwnershipTransferredEvent>(v1);
    }

    entry fun transfer_ownership(arg0: &mut GameLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 9223372578020786179);
        assert!(!is_owner(arg0, arg1), 9223372582316015623);
        change_owner(arg0, arg1);
    }

    entry fun withdraw_funds(arg0: &mut GameLedger, arg1: &GameWhitelistCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &arg1.whitelisted_addresses;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<address>(v1)) {
            if (0x1::vector::borrow<address>(v1, v2) == &v0) {
                v3 = true;
                /* label 6 */
                assert!(v3, 9223372659625164803);
                assert!(has_funds(arg0) || !(arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), 9223372663920001025);
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

