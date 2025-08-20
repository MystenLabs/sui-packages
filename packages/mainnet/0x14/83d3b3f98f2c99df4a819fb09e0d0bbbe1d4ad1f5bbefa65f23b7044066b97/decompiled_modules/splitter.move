module 0x1483d3b3f98f2c99df4a819fb09e0d0bbbe1d4ad1f5bbefa65f23b7044066b97::splitter {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Recipient has drop, store {
        share: u64,
        alias: 0x1::string::String,
    }

    struct PaymentSplitter has store, key {
        id: 0x2::object::UID,
        recipients: 0x2::vec_map::VecMap<address, Recipient>,
        total_shares: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        active: bool,
    }

    struct RecipientAdded has copy, drop {
        splitter: address,
        recipient: address,
        share: u64,
        total_shares_after: u64,
        sender: address,
    }

    struct RecipientRevoked has copy, drop {
        splitter: address,
        recipient: address,
        removed_share: u64,
        total_shares_after: u64,
        sender: address,
    }

    struct RecipientShareUpdated has copy, drop {
        splitter: address,
        recipient: address,
        old_share: u64,
        new_share: u64,
        total_shares_after: u64,
        by: address,
    }

    struct RecipientAliasUpdated has copy, drop {
        splitter: address,
        recipient: address,
        by: address,
    }

    struct DepositEvent has copy, drop {
        splitter: address,
        from: address,
        amount: u64,
        balance_after: u64,
    }

    struct SplitPayout has copy, drop {
        splitter: address,
        recipient: address,
        amount: u64,
    }

    struct SplitRemainder has copy, drop {
        splitter: address,
        to: address,
        amount: u64,
    }

    struct SplitCompleted has copy, drop {
        splitter: address,
        total_before: u64,
        total_distributed: u64,
        recipients_count: u64,
        remainder: u64,
        caller: address,
    }

    struct Withdrawn has copy, drop {
        splitter: address,
        to: address,
        amount: u64,
        by: address,
    }

    struct Deactivated has copy, drop {
        splitter: address,
        by: address,
    }

    struct Activated has copy, drop {
        splitter: address,
        by: address,
    }

    public entry fun activate(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.active = true;
        let v0 = Activated{
            splitter : 0x2::object::uid_to_address(&arg1.id),
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Activated>(v0);
    }

    public entry fun add_recipient(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 6);
        assert!(arg3 > 0, 1);
        assert!(arg1.total_shares + arg3 <= 10000, 4);
        assert!(!0x2::vec_map::contains<address, Recipient>(&arg1.recipients, &arg2), 2);
        let v0 = Recipient{
            share : arg3,
            alias : arg4,
        };
        0x2::vec_map::insert<address, Recipient>(&mut arg1.recipients, arg2, v0);
        arg1.total_shares = arg1.total_shares + arg3;
        let v1 = RecipientAdded{
            splitter           : 0x2::object::uid_to_address(&arg1.id),
            recipient          : arg2,
            share              : arg3,
            total_shares_after : arg1.total_shares,
            sender             : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RecipientAdded>(v1);
    }

    public entry fun deactivate(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.active = false;
        let v0 = Deactivated{
            splitter : 0x2::object::uid_to_address(&arg1.id),
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Deactivated>(v0);
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut PaymentSplitter, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v0 = DepositEvent{
            splitter      : 0x2::object::uid_to_address(&arg1.id),
            from          : 0x2::tx_context::sender(arg2),
            amount        : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            balance_after : 0x2::balance::value<0x2::sui::SUI>(&arg1.balance),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        let v1 = PaymentSplitter{
            id           : 0x2::object::new(arg0),
            recipients   : 0x2::vec_map::empty<address, Recipient>(),
            total_shares : 0,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            active       : true,
        };
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PaymentSplitter>(v1);
    }

    public entry fun revoke_recipient(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 6);
        assert!(0x2::vec_map::contains<address, Recipient>(&arg1.recipients, &arg2), 3);
        let (_, v1) = 0x2::vec_map::remove<address, Recipient>(&mut arg1.recipients, &arg2);
        let Recipient {
            share : v2,
            alias : _,
        } = v1;
        arg1.total_shares = arg1.total_shares - v2;
        let v4 = RecipientRevoked{
            splitter           : 0x2::object::uid_to_address(&arg1.id),
            recipient          : arg2,
            removed_share      : v2,
            total_shares_after : arg1.total_shares,
            sender             : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RecipientRevoked>(v4);
    }

    public entry fun set_recipient_alias(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 6);
        assert!(0x2::vec_map::contains<address, Recipient>(&arg1.recipients, &arg2), 3);
        let (_, v1) = 0x2::vec_map::remove<address, Recipient>(&mut arg1.recipients, &arg2);
        let v2 = v1;
        v2.alias = arg3;
        0x2::vec_map::insert<address, Recipient>(&mut arg1.recipients, arg2, v2);
        let v3 = RecipientAliasUpdated{
            splitter  : 0x2::object::uid_to_address(&arg1.id),
            recipient : arg2,
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RecipientAliasUpdated>(v3);
    }

    public entry fun set_recipient_share(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 6);
        assert!(0x2::vec_map::contains<address, Recipient>(&arg1.recipients, &arg2), 3);
        assert!(arg3 > 0, 1);
        let (_, v1) = 0x2::vec_map::remove<address, Recipient>(&mut arg1.recipients, &arg2);
        let v2 = v1;
        let v3 = v2.share;
        let Recipient {
            share : _,
            alias : v5,
        } = v2;
        if (arg3 >= v3) {
            let v6 = arg3 - v3;
            assert!(arg1.total_shares + v6 <= 10000, 4);
            arg1.total_shares = arg1.total_shares + v6;
        } else {
            arg1.total_shares = arg1.total_shares - v3 - arg3;
        };
        let v7 = Recipient{
            share : arg3,
            alias : v5,
        };
        0x2::vec_map::insert<address, Recipient>(&mut arg1.recipients, arg2, v7);
        let v8 = RecipientShareUpdated{
            splitter           : 0x2::object::uid_to_address(&arg1.id),
            recipient          : arg2,
            old_share          : v3,
            new_share          : arg3,
            total_shares_after : arg1.total_shares,
            by                 : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RecipientShareUpdated>(v8);
    }

    public entry fun split_payment(arg0: &mut PaymentSplitter, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v1 = &arg0.recipients;
        assert!(0x2::vec_map::size<address, Recipient>(v1) > 0, 5);
        assert!(v0 > 0, 0);
        assert!(arg0.total_shares > 0, 4);
        let v2 = 0x2::vec_map::size<address, Recipient>(v1);
        let v3 = 0;
        let v4 = 0;
        while (v3 < v2) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<address, Recipient>(v1, v3);
            let v7 = v0 * v6.share / 10000;
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v7), arg1), *v5);
                v4 = v4 + v7;
                let v8 = SplitPayout{
                    splitter  : 0x2::object::uid_to_address(&arg0.id),
                    recipient : *v5,
                    amount    : v7,
                };
                0x2::event::emit<SplitPayout>(v8);
            };
            v3 = v3 + 1;
        };
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v9), arg1), 0x2::tx_context::sender(arg1));
            let v10 = SplitRemainder{
                splitter : 0x2::object::uid_to_address(&arg0.id),
                to       : 0x2::tx_context::sender(arg1),
                amount   : v9,
            };
            0x2::event::emit<SplitRemainder>(v10);
        };
        let v11 = SplitCompleted{
            splitter          : 0x2::object::uid_to_address(&arg0.id),
            total_before      : v0,
            total_distributed : v4,
            recipients_count  : v2,
            remainder         : v9,
            caller            : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<SplitCompleted>(v11);
    }

    public entry fun withdraw_all(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg3), arg2);
        let v1 = Withdrawn{
            splitter : 0x2::object::uid_to_address(&arg1.id),
            to       : arg2,
            amount   : v0,
            by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Withdrawn>(v1);
    }

    public entry fun withdraw_amount(arg0: &OwnerCap, arg1: &mut PaymentSplitter, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg3), arg4), arg2);
        let v0 = Withdrawn{
            splitter : 0x2::object::uid_to_address(&arg1.id),
            to       : arg2,
            amount   : arg3,
            by       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

