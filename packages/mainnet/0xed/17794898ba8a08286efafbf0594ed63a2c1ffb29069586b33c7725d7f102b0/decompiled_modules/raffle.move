module 0xed17794898ba8a08286efafbf0594ed63a2c1ffb29069586b33c7725d7f102b0::raffle {
    struct Raffle has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: vector<u8>,
        ticket_price: u64,
        winner_ticket: 0x1::option::Option<u64>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        sold: u64,
        tickets: 0x2::table::Table<u64, address>,
    }

    public fun buy_ticket(arg0: &mut Raffle, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<u64>(&arg0.winner_ticket), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.ticket_price, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.ticket_price, arg2)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = arg0.sold;
        0x2::table::add<u64, address>(&mut arg0.tickets, v1, v0);
        arg0.sold = v1 + 1;
        0x2::transfer::public_transfer<0xed17794898ba8a08286efafbf0594ed63a2c1ffb29069586b33c7725d7f102b0::ticket::Ticket>(0xed17794898ba8a08286efafbf0594ed63a2c1ffb29069586b33c7725d7f102b0::ticket::create(arg2, 0x2::object::id<Raffle>(arg0)), v0);
    }

    public fun create(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Raffle{
            id            : 0x2::object::new(arg2),
            owner         : 0x2::tx_context::sender(arg2),
            title         : arg0,
            ticket_price  : arg1,
            winner_ticket : 0x1::option::none<u64>(),
            pot           : 0x2::balance::zero<0x2::sui::SUI>(),
            sold          : 0,
            tickets       : 0x2::table::new<u64, address>(arg2),
        };
        0x2::transfer::share_object<Raffle>(v0);
    }

    fun draw_winner(arg0: &mut Raffle, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        arg0.winner_ticket = 0x1::option::some<u64>(0x2::random::generate_u64_in_range(&mut v0, 0, arg0.sold));
    }

    public fun end(arg0: &mut Raffle, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<u64>(&arg0.winner_ticket), 1);
        assert!(arg0.sold > 1, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        draw_winner(arg0, arg1, arg2);
        settle(arg0, arg2);
    }

    fun settle(arg0: &mut Raffle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) * 5 / 100, arg1), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, *0x2::table::borrow<u64, address>(&arg0.tickets, *0x1::option::borrow<u64>(&arg0.winner_ticket)));
    }

    // decompiled from Move bytecode v6
}

