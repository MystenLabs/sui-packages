module 0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::raffle {
    struct RAFFLE has drop {
        dummy_field: bool,
    }

    struct Prize has store, key {
        id: 0x2::object::UID,
        img_url: 0x1::string::String,
        winner: address,
        winning_ticket: u64,
        raffle_id: 0x2::object::ID,
        value: u64,
    }

    struct Ticket has drop, store {
        first: u64,
        last: u64,
        total_number: u64,
    }

    struct RaffleTreasury has key {
        id: 0x2::object::UID,
        total_balances: u64,
        non_zero_balances: u64,
        accepted_coins: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        price_per_ticket: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        ticket_options: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>,
    }

    struct Raffle has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        cover_image: 0x1::string::String,
        prize: 0x1::option::Option<Prize>,
        total_tickets: u64,
        participants: 0x2::table::Table<address, vector<Ticket>>,
        end_date: u64,
        winning_ticket: u64,
        winner: address,
        count: u64,
        collected: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        drand_round: u64,
        total_participants: u64,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        prize_value: u64,
        drand_round: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        cover_image: 0x1::string::String,
        end_date: u64,
    }

    struct AcceptedCoinAdded has copy, drop {
        treasury: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price_per_ticket: u64,
    }

    struct AcceptedCoinRemoved has copy, drop {
        treasury: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    struct TicketPriceUpdated has copy, drop {
        treasury: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price_per_ticket: u64,
    }

    struct TicketOptionsAdded has copy, drop {
        treasury: 0x2::object::ID,
        ticket_amounts: vector<u64>,
        extra_tickets: vector<u64>,
        coin_type: 0x1::ascii::String,
    }

    struct TicketOptionsUpdated has copy, drop {
        treasury: 0x2::object::ID,
        ticket_amounts: vector<u64>,
        extra_tickets: vector<u64>,
        coin_type: 0x1::ascii::String,
    }

    struct TicketOptionRemoved has copy, drop {
        treasury: 0x2::object::ID,
        ticket_amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct LuckyTicketPicked has copy, drop {
        raffle_id: 0x2::object::ID,
        lucky_ticket: u64,
    }

    struct WinnerCommitted has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        lucky_ticket: u64,
    }

    struct TicketsBought has copy, drop {
        raffle_id: 0x2::object::ID,
        user: address,
        quantity: u64,
        paid: u64,
        coin_type: 0x1::ascii::String,
        origin: 0x1::string::String,
        deal: u64,
        first_number: u64,
    }

    struct RaffleExtended has copy, drop {
        raffle_id: 0x2::object::ID,
        new_end_date: u64,
    }

    public fun add_accepted_coin_type<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.accepted_coins, v0, true);
        0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.ticket_options, v0, 0x2::table::new<u64, u64>(arg3));
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.price_per_ticket, v0, arg2);
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
            arg0.total_balances = arg0.total_balances + 1;
        };
        let v1 = AcceptedCoinAdded{
            treasury         : 0x2::object::id<RaffleTreasury>(arg0),
            coin_type        : 0x1::type_name::into_string(v0),
            price_per_ticket : arg2,
        };
        0x2::event::emit<AcceptedCoinAdded>(v1);
    }

    public fun add_ticket_options<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 8);
        let v0 = get_valid_coin_type<T0>(arg0);
        let v1 = TicketOptionsAdded{
            treasury       : 0x2::object::id<RaffleTreasury>(arg0),
            ticket_amounts : arg2,
            extra_tickets  : arg3,
            coin_type      : 0x1::type_name::into_string(v0),
        };
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.ticket_options, v0);
            assert!(!0x2::table::contains<u64, u64>(v3, v2), 18);
            0x2::table::add<u64, u64>(v3, v2, 0x1::vector::pop_back<u64>(&mut arg3));
        };
        0x2::event::emit<TicketOptionsAdded>(v1);
    }

    public fun buy_tickets<T0>(arg0: &mut Raffle, arg1: &mut RaffleTreasury, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_valid_coin_type<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_date, 10);
        assert!(0x1::option::is_some<Prize>(&arg0.prize), 15);
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::balance::zero<T0>());
        };
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.price_per_ticket, v0), 12);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.price_per_ticket, v0) * arg3;
        assert!(v1 == 0x2::coin::value<T0>(&arg4), 11);
        let v2 = arg0.total_tickets + 1;
        let v3 = 0x2::tx_context::sender(arg6);
        if (0x2::table::contains<address, vector<Ticket>>(&arg0.participants, v3)) {
            let v4 = Ticket{
                first        : v2,
                last         : arg0.total_tickets + arg3,
                total_number : arg3,
            };
            0x1::vector::push_back<Ticket>(0x2::table::borrow_mut<address, vector<Ticket>>(&mut arg0.participants, v3), v4);
        } else {
            let v5 = Ticket{
                first        : v2,
                last         : arg0.total_tickets + arg3,
                total_number : arg3,
            };
            let v6 = 0x1::vector::empty<Ticket>();
            0x1::vector::push_back<Ticket>(&mut v6, v5);
            0x2::table::add<address, vector<Ticket>>(&mut arg0.participants, v3, v6);
            arg0.total_participants = arg0.total_participants + 1;
        };
        let v7 = TicketsBought{
            raffle_id    : 0x2::object::id<Raffle>(arg0),
            user         : v3,
            quantity     : arg3,
            paid         : v1,
            coin_type    : 0x1::type_name::into_string(v0),
            origin       : arg5,
            deal         : 1,
            first_number : v2,
        };
        0x2::event::emit<TicketsBought>(v7);
        arg0.total_tickets = arg0.total_tickets + arg3;
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.collected, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.collected, v0) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.collected, v0) + v1;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.collected, v0, v1);
        };
        let v8 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        if (0x2::balance::value<T0>(v8) == 0) {
            arg1.non_zero_balances = arg1.non_zero_balances + 1;
        };
        0x2::balance::join<T0>(v8, 0x2::coin::into_balance<T0>(arg4));
    }

    public fun buy_tickets_from_option<T0>(arg0: &mut Raffle, arg1: &mut RaffleTreasury, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = get_valid_coin_type<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_date, 10);
        assert!(0x1::option::is_some<Prize>(&arg0.prize), 15);
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg1.ticket_options, v0);
        assert!(0x2::table::contains<u64, u64>(v1, arg3), 9);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.price_per_ticket, v0), 12);
        let v2 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.price_per_ticket, v0) * arg3 * arg4;
        assert!(v2 == 0x2::coin::value<T0>(&arg5), 11);
        let v3 = (arg3 + *0x2::table::borrow<u64, u64>(v1, arg3)) * arg4;
        let v4 = arg0.total_tickets + 1;
        let v5 = 0x2::tx_context::sender(arg7);
        if (0x2::table::contains<address, vector<Ticket>>(&arg0.participants, v5)) {
            let v6 = Ticket{
                first        : v4,
                last         : arg0.total_tickets + v3,
                total_number : arg3,
            };
            0x1::vector::push_back<Ticket>(0x2::table::borrow_mut<address, vector<Ticket>>(&mut arg0.participants, v5), v6);
        } else {
            let v7 = Ticket{
                first        : v4,
                last         : arg0.total_tickets + v3,
                total_number : arg3,
            };
            let v8 = 0x1::vector::empty<Ticket>();
            0x1::vector::push_back<Ticket>(&mut v8, v7);
            0x2::table::add<address, vector<Ticket>>(&mut arg0.participants, v5, v8);
            arg0.total_participants = arg0.total_participants + 1;
        };
        let v9 = TicketsBought{
            raffle_id    : 0x2::object::id<Raffle>(arg0),
            user         : v5,
            quantity     : v3,
            paid         : v2,
            coin_type    : 0x1::type_name::into_string(v0),
            origin       : arg6,
            deal         : arg3,
            first_number : v4,
        };
        0x2::event::emit<TicketsBought>(v9);
        arg0.total_tickets = arg0.total_tickets + v3;
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.collected, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.collected, v0) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.collected, v0) + v2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.collected, v0, v2);
        };
        let v10 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        if (0x2::balance::value<T0>(v10) == 0) {
            arg1.non_zero_balances = arg1.non_zero_balances + 1;
        };
        0x2::balance::join<T0>(v10, 0x2::coin::into_balance<T0>(arg5));
    }

    public fun collected<T0>(arg0: &Raffle) : u64 {
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.collected, 0x1::type_name::get<T0>())
    }

    public fun commit_winner(arg0: &mut Raffle, arg1: &0x2::clock::Clock, arg2: address) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_date, 4);
        assert!(arg0.winning_ticket != 0, 6);
        let v0 = 0x2::table::remove<address, vector<Ticket>>(&mut arg0.participants, arg2);
        while (!0x1::vector::is_empty<Ticket>(&v0)) {
            let v1 = 0x1::vector::pop_back<Ticket>(&mut v0);
            if (arg0.winning_ticket >= v1.first && arg0.winning_ticket <= v1.last) {
                arg0.winner = arg2;
                let v2 = 0x1::option::extract<Prize>(&mut arg0.prize);
                v2.winning_ticket = arg0.winning_ticket;
                v2.winner = arg2;
                0x2::transfer::public_transfer<Prize>(v2, arg2);
                let v3 = WinnerCommitted{
                    raffle_id    : 0x2::object::id<Raffle>(arg0),
                    winner       : arg2,
                    lucky_ticket : arg0.winning_ticket,
                };
                0x2::event::emit<WinnerCommitted>(v3);
                return
            };
        };
        abort 7
    }

    public fun create(arg0: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: Prize, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = derive_next_drand_round(arg4);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        arg3.raffle_id = v2;
        let v3 = arg3.img_url;
        let v4 = Raffle{
            id                 : v1,
            title              : arg1,
            description        : arg2,
            cover_image        : v3,
            prize              : 0x1::option::some<Prize>(arg3),
            total_tickets      : 0,
            participants       : 0x2::table::new<address, vector<Ticket>>(arg5),
            end_date           : arg4,
            winning_ticket     : 0,
            winner             : @0x0,
            count              : 0,
            collected          : 0x2::table::new<0x1::type_name::TypeName, u64>(arg5),
            drand_round        : v0,
            total_participants : 0,
        };
        let v5 = RaffleCreated{
            raffle_id   : v2,
            prize_value : arg3.value,
            drand_round : v0,
            title       : arg1,
            description : arg2,
            cover_image : v3,
            end_date    : arg4,
        };
        0x2::event::emit<RaffleCreated>(v5);
        0x2::transfer::share_object<Raffle>(v4);
    }

    public fun create_treasury(arg0: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleTreasury{
            id                : 0x2::object::new(arg1),
            total_balances    : 0,
            non_zero_balances : 0,
            accepted_coins    : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            price_per_ticket  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            ticket_options    : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(arg1),
        };
        0x2::transfer::share_object<RaffleTreasury>(v0);
    }

    fun derive_next_drand_round(arg0: u64) : u64 {
        (arg0 / 1000 - 1595431050) / 30 + 2
    }

    public fun disable_accepted_coin_type<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_coins, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg0.accepted_coins, v0) = false;
        };
    }

    public fun drand_round(arg0: &Raffle) : u64 {
        arg0.drand_round
    }

    public fun enable_accepted_coin_type<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_coins, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg0.accepted_coins, v0) = true;
        };
    }

    public fun end_date(arg0: &Raffle) : u64 {
        arg0.end_date
    }

    public fun extend_raffle(arg0: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg1: &mut Raffle, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > v0, 1);
        assert!(v0 < arg1.end_date, 2);
        assert!(arg2 > arg1.end_date, 3);
        arg1.end_date = arg2;
        arg1.drand_round = derive_next_drand_round(arg2);
        let v1 = RaffleExtended{
            raffle_id    : 0x2::object::id<Raffle>(arg1),
            new_end_date : arg2,
        };
        0x2::event::emit<RaffleExtended>(v1);
    }

    fun get_valid_coin_type<T0>(arg0: &RaffleTreasury) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_coins, v0), 16);
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.accepted_coins, v0), 17);
        v0
    }

    fun init(arg0: RAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleTreasury{
            id                : 0x2::object::new(arg1),
            total_balances    : 0,
            non_zero_balances : 0,
            accepted_coins    : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            price_per_ticket  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            ticket_options    : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(arg1),
        };
        0x2::transfer::share_object<RaffleTreasury>(v0);
        let v1 = 0x2::package::claim<RAFFLE>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Prize for Raffle {raffle_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"This NFT proves that you won a raffle!"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.doubleup.fun"));
        let v6 = 0x2::display::new_with_fields<Prize>(&v1, v2, v4, arg1);
        0x2::display::update_version<Prize>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Prize>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_participant(arg0: &mut Raffle, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::table::contains<address, vector<Ticket>>(&arg0.participants, 0x2::tx_context::sender(arg1))
    }

    public fun lucky_number(arg0: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg1: &mut Raffle, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.end_date, 4);
        assert!(arg1.winning_ticket == 0, 5);
        let v0 = 0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::drand_utils::safe_selection(arg1.total_tickets, arg1.drand_round, arg3, arg4);
        arg1.winning_ticket = v0 + 1;
        let v1 = LuckyTicketPicked{
            raffle_id    : 0x2::object::id<Raffle>(arg1),
            lucky_ticket : v0 + 1,
        };
        0x2::event::emit<LuckyTicketPicked>(v1);
    }

    public fun my_tickets(arg0: &mut Raffle, arg1: &mut 0x2::tx_context::TxContext) : vector<vector<u64>> {
        assert!(is_participant(arg0, arg1), 14);
        let v0 = 0x2::table::borrow<address, vector<Ticket>>(&arg0.participants, 0x2::tx_context::sender(arg1));
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Ticket>(v0)) {
            let v3 = 0x1::vector::empty<u64>();
            let v4 = &mut v3;
            0x1::vector::push_back<u64>(v4, 0x1::vector::borrow<Ticket>(v0, v2).first);
            0x1::vector::push_back<u64>(v4, 0x1::vector::borrow<Ticket>(v0, v2).last);
            0x1::vector::push_back<vector<u64>>(&mut v1, v3);
            v2 = v2 + 1;
        };
        v1
    }

    public fun new_prize(arg0: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Prize {
        Prize{
            id             : 0x2::object::new(arg3),
            img_url        : arg1,
            winner         : @0x0,
            winning_ticket : 0,
            raffle_id      : 0x2::object::id_from_address(@0x0),
            value          : arg2,
        }
    }

    public fun prize_value(arg0: &Prize) : u64 {
        arg0.value
    }

    public fun prize_value_raffle(arg0: &Raffle) : u64 {
        assert!(0x1::option::is_some<Prize>(&arg0.prize), 15);
        0x1::option::borrow<Prize>(&arg0.prize).value
    }

    public fun remove_accepted_coin_type<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_coins, v0)) {
            assert!(0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) == 0, 13);
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.accepted_coins, v0);
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.price_per_ticket, v0);
            0x2::table::drop<u64, u64>(0x2::table::remove<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.ticket_options, v0));
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0));
            arg0.total_balances = arg0.total_balances - 1;
            let v1 = AcceptedCoinRemoved{
                treasury  : 0x2::object::id<RaffleTreasury>(arg0),
                coin_type : 0x1::type_name::into_string(v0),
            };
            0x2::event::emit<AcceptedCoinRemoved>(v1);
        };
    }

    public fun remove_ticket_option<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_coins, v0), 16);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.ticket_options, v0);
        assert!(0x2::table::contains<u64, u64>(v1, arg2), 9);
        0x2::table::remove<u64, u64>(v1, arg2);
        let v2 = TicketOptionRemoved{
            treasury      : 0x2::object::id<RaffleTreasury>(arg0),
            ticket_amount : arg2,
            coin_type     : 0x1::type_name::into_string(v0),
        };
        0x2::event::emit<TicketOptionRemoved>(v2);
    }

    public fun tickets_bought(arg0: &Raffle, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0x2::table::borrow<address, vector<Ticket>>(&arg0.participants, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Ticket>(v1)) {
            v0 = v0 + 0x1::vector::borrow<Ticket>(v1, v2).total_number;
            v2 = v2 + 1;
        };
        v0
    }

    public fun total_participants(arg0: &Raffle) : u64 {
        arg0.total_participants
    }

    public fun total_tickets(arg0: &Raffle) : u64 {
        arg0.total_tickets
    }

    public fun update_price_per_ticket<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_coins, v0), 16);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.price_per_ticket, v0) = arg2;
        let v1 = TicketPriceUpdated{
            treasury         : 0x2::object::id<RaffleTreasury>(arg0),
            coin_type        : 0x1::type_name::into_string(v0),
            price_per_ticket : arg2,
        };
        0x2::event::emit<TicketPriceUpdated>(v1);
    }

    public fun update_ticket_options<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 8);
        let v0 = get_valid_coin_type<T0>(arg0);
        let v1 = TicketOptionsUpdated{
            treasury       : 0x2::object::id<RaffleTreasury>(arg0),
            ticket_amounts : arg2,
            extra_tickets  : arg3,
            coin_type      : 0x1::type_name::into_string(v0),
        };
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.ticket_options, v0);
            assert!(0x2::table::contains<u64, u64>(v3, v2), 9);
            *0x2::table::borrow_mut<u64, u64>(v3, v2) = 0x1::vector::pop_back<u64>(&mut arg3);
        };
        0x2::event::emit<TicketOptionsUpdated>(v1);
    }

    public fun winner(arg0: &Raffle) : address {
        arg0.winner
    }

    public fun winning_ticket(arg0: &Raffle) : u64 {
        arg0.winning_ticket
    }

    public fun withdraw_proceeds<T0>(arg0: &mut RaffleTreasury, arg1: &0x9d78eaed272d80003c0f6f977eaece3dc0a15e289fced1179310832494414791::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 19);
        if (arg0.non_zero_balances > 0) {
            arg0.non_zero_balances = arg0.non_zero_balances - 1;
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        0x2::coin::take<T0>(v1, 0x2::balance::value<T0>(v1), arg2)
    }

    // decompiled from Move bytecode v6
}

