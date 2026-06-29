module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::prepaid_ticket {
    struct PrepaidTicket has store, key {
        id: 0x2::object::UID,
        depositor: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TicketDeposited has copy, drop {
        ticket: address,
        owner: address,
        amount: u64,
    }

    struct TicketConsumed has copy, drop {
        ticket: address,
        for_relayer: address,
        amount: u64,
        remaining: u64,
    }

    struct TicketDrained has copy, drop {
        ticket: address,
        owner: address,
        amount: u64,
    }

    public fun balance(arg0: &PrepaidTicket) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public(friend) fun consume(arg0: &mut PrepaidTicket, arg1: address, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 2);
        let v0 = TicketConsumed{
            ticket      : 0x2::object::uid_to_address(&arg0.id),
            for_relayer : arg1,
            amount      : arg2,
            remaining   : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) - arg2,
        };
        0x2::event::emit<TicketConsumed>(v0);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2)
    }

    public fun depositor(arg0: &PrepaidTicket) : address {
        arg0.depositor
    }

    entry fun drain(arg0: PrepaidTicket, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let PrepaidTicket {
            id        : v0,
            depositor : _,
            balance   : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = TicketDrained{
            ticket : 0x2::object::uid_to_address(&v4),
            owner  : 0x2::tx_context::sender(arg1),
            amount : 0x2::balance::value<0x2::sui::SUI>(&v3),
        };
        0x2::event::emit<TicketDrained>(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg1)
    }

    entry fun mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = PrepaidTicket{
            id        : 0x2::object::new(arg1),
            depositor : v1,
            balance   : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        let v3 = TicketDeposited{
            ticket : 0x2::object::uid_to_address(&v2.id),
            owner  : v1,
            amount : v0,
        };
        0x2::event::emit<TicketDeposited>(v3);
        0x2::transfer::public_transfer<PrepaidTicket>(v2, v1);
    }

    entry fun top_up(arg0: &mut PrepaidTicket, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = TicketDeposited{
            ticket : 0x2::object::uid_to_address(&arg0.id),
            owner  : arg0.depositor,
            amount : v0,
        };
        0x2::event::emit<TicketDeposited>(v1);
    }

    // decompiled from Move bytecode v7
}

