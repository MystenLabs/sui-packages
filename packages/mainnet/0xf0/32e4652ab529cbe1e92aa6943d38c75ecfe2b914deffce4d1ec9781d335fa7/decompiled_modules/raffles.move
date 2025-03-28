module 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::raffles {
    struct RAFFLES has drop {
        dummy_field: bool,
    }

    struct Raffles has copy, drop, store {
        dummy_field: bool,
    }

    struct Ticket has drop, store {
        first: u64,
        last: u64,
        total_number: u64,
    }

    struct RaffleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RaffleTreasury has key {
        id: 0x2::object::UID,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        ticket_deals: 0x2::table::Table<u64, u64>,
        active_raffles: 0x2::linked_table::LinkedTable<0x2::object::ID, bool>,
        inactive_raffles: 0x2::linked_table::LinkedTable<0x2::object::ID, bool>,
        managers: 0x2::vec_set::VecSet<address>,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct Raffle has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        cover_image: 0x1::string::String,
        accepted_coin_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        total_tickets: u64,
        participants: 0x2::table::Table<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>,
        end_date: u64,
        winning_ticket: u64,
        winner: address,
        count: u64,
        total_participants: u64,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        prize_value: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        cover_image: 0x1::string::String,
        end_date: u64,
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
        coin_symbol: 0x1::option::Option<0x1::type_name::TypeName>,
        user: address,
        quantity: u64,
        paid: u64,
        origin: 0x1::string::String,
        deal: u64,
        first_number: u64,
    }

    struct RaffleExtended has copy, drop {
        raffle_id: 0x2::object::ID,
        new_end_date: u64,
    }

    struct TicketDealsAdded has copy, drop {
        treasury_id: 0x2::object::ID,
        ticket_amounts: vector<u64>,
        extra_tickets: vector<u64>,
    }

    struct TicketDealsUpdated has copy, drop {
        treasury_id: 0x2::object::ID,
        ticket_amounts: vector<u64>,
        extra_tickets: vector<u64>,
    }

    struct TicketDealsRemoved has copy, drop {
        treasury_id: 0x2::object::ID,
        ticket_amounts: vector<u64>,
    }

    struct RaffleStarred has copy, drop {
        raffle_id: 0x2::object::ID,
    }

    public fun balance<T0>(arg0: &RaffleTreasury) : &0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            err_invalid_coin_type();
        };
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)
    }

    public fun add_asset_type<T0>(arg0: &mut RaffleTreasury, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg2);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut borrow_raffle_mut(arg0, arg1).accepted_coin_types, 0x1::type_name::get<T0>());
    }

    public fun add_manager(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_ticket_deals(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert_valid_version(arg0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 10);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(!0x2::table::contains<u64, u64>(&arg0.ticket_deals, v0), 11);
            0x2::table::add<u64, u64>(&mut arg0.ticket_deals, v0, 0x1::vector::pop_back<u64>(&mut arg3));
        };
        let v1 = TicketDealsAdded{
            treasury_id    : 0x2::object::id<RaffleTreasury>(arg0),
            ticket_amounts : arg2,
            extra_tickets  : arg3,
        };
        0x2::event::emit<TicketDealsAdded>(v1);
    }

    public fun add_version(arg0: &RaffleAdminCap, arg1: &mut RaffleTreasury, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_sender_is_manager(arg0: &RaffleTreasury, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(managers(arg0), &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_version(arg0: &RaffleTreasury) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13);
    }

    fun balance_mut<T0>(arg0: &mut RaffleTreasury) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            err_invalid_coin_type();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun borrow_raffle(arg0: &RaffleTreasury, arg1: 0x2::object::ID) : &Raffle {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Raffle>(&arg0.id, arg1)
    }

    fun borrow_raffle_mut(arg0: &mut RaffleTreasury, arg1: 0x2::object::ID) : &mut Raffle {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Raffle>(&mut arg0.id, arg1)
    }

    fun buy_ticket_helper(arg0: &mut RaffleTreasury, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64, arg6: 0x1::option::Option<0x1::type_name::TypeName>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_raffle_mut(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v0.end_date, 1);
        let v1 = v0.total_tickets + 1;
        if (0x2::table::contains<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&v0.participants, arg3)) {
            let v2 = Ticket{
                first        : v1,
                last         : v0.total_tickets + arg4,
                total_number : arg4,
            };
            0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::push_back<Ticket>(0x2::table::borrow_mut<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&mut v0.participants, arg3), v2);
        } else {
            let v3 = 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::new<Ticket>(5000, arg8);
            let v4 = Ticket{
                first        : v1,
                last         : v0.total_tickets + arg4,
                total_number : arg4,
            };
            0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::push_back<Ticket>(&mut v3, v4);
            0x2::table::add<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&mut v0.participants, arg3, v3);
            v0.total_participants = v0.total_participants + 1;
        };
        v0.total_tickets = v0.total_tickets + arg4;
        let v5 = TicketsBought{
            raffle_id    : arg2,
            coin_symbol  : arg6,
            user         : arg3,
            quantity     : arg4,
            paid         : arg5,
            origin       : arg7,
            deal         : 1,
            first_number : v1,
        };
        0x2::event::emit<TicketsBought>(v5);
    }

    public fun buy_tickets<T0>(arg0: &mut RaffleTreasury, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<address>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = balance_mut<T0>(arg0);
        0x2::coin::put<T0>(v1, arg3);
        let v2 = price_of<T0>(arg0);
        if (0x1::option::is_none<u64>(&v2)) {
            err_invalid_coin_type();
        };
        let v3 = 0x1::option::destroy_some<u64>(v2);
        assert!(v0 % v3 == 0, 2);
        let v4 = if (0x1::option::is_some<address>(&arg4)) {
            0x1::option::extract<address>(&mut arg4)
        } else {
            0x2::tx_context::sender(arg6)
        };
        buy_ticket_helper(arg0, arg1, arg2, v4, v0 / v3, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()), arg5, arg6);
    }

    public fun buy_tickets_from_deal<T0>(arg0: &mut RaffleTreasury, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = balance_mut<T0>(arg0);
        0x2::coin::put<T0>(v1, arg3);
        let v2 = price_of<T0>(arg0);
        if (0x1::option::is_none<u64>(&v2)) {
            err_invalid_coin_type();
        };
        let v3 = 0x1::option::destroy_some<u64>(v2);
        assert!(v0 % arg4 * v3 == 0, 2);
        let v4 = v0 / arg4 * v3 * (arg4 + *0x2::table::borrow<u64, u64>(&arg0.ticket_deals, arg4));
        let v5 = borrow_raffle_mut(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v5.end_date, 1);
        let v6 = v5.total_tickets + 1;
        let v7 = if (0x1::option::is_some<address>(&arg5)) {
            0x1::option::extract<address>(&mut arg5)
        } else {
            0x2::tx_context::sender(arg7)
        };
        if (0x2::table::contains<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&v5.participants, v7)) {
            let v8 = Ticket{
                first        : v6,
                last         : v5.total_tickets + v4,
                total_number : v4,
            };
            0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::push_back<Ticket>(0x2::table::borrow_mut<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&mut v5.participants, v7), v8);
        } else {
            let v9 = 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::new<Ticket>(5000, arg7);
            let v10 = Ticket{
                first        : v6,
                last         : v5.total_tickets + v4,
                total_number : v4,
            };
            0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::push_back<Ticket>(&mut v9, v10);
            0x2::table::add<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&mut v5.participants, v7, v9);
            v5.total_participants = v5.total_participants + 1;
        };
        v5.total_tickets = v5.total_tickets + v4;
        let v11 = TicketsBought{
            raffle_id    : arg2,
            coin_symbol  : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()),
            user         : v7,
            quantity     : v4,
            paid         : v0,
            origin       : arg6,
            deal         : arg4,
            first_number : v6,
        };
        0x2::event::emit<TicketsBought>(v11);
    }

    public fun commit_winner(arg0: &mut RaffleTreasury, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: address) {
        assert_valid_version(arg0);
        0x2::linked_table::remove<0x2::object::ID, bool>(&mut arg0.active_raffles, arg1);
        0x2::linked_table::push_front<0x2::object::ID, bool>(&mut arg0.inactive_raffles, arg1, true);
        let v0 = borrow_raffle_mut(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.end_date, 6);
        assert!(v0.winning_ticket != 0, 8);
        let v1 = 0x2::table::remove<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&mut v0.participants, arg3);
        while (!0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::is_empty<Ticket>(&v1)) {
            let v2 = 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::pop_front<Ticket>(&mut v1);
            if (v0.winning_ticket >= v2.first && v0.winning_ticket <= v2.last) {
                v0.winner = arg3;
                let v3 = WinnerCommitted{
                    raffle_id    : 0x2::object::id<Raffle>(v0),
                    winner       : arg3,
                    lucky_ticket : v0.winning_ticket,
                };
                0x2::event::emit<WinnerCommitted>(v3);
                0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::drop<Ticket>(v1);
                return
            };
        };
        abort 9
    }

    public fun create_child_cap(arg0: &RaffleAdminCap, arg1: &mut 0x2::tx_context::TxContext) : RaffleAdminCap {
        RaffleAdminCap{id: 0x2::object::new(arg1)}
    }

    public fun create_raffle(arg0: &mut RaffleTreasury, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg0);
        assert_sender_is_manager(arg0, arg6);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Raffle{
            id                  : v0,
            title               : arg2,
            description         : arg3,
            cover_image         : arg4,
            accepted_coin_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            total_tickets       : 0,
            participants        : 0x2::table::new<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(arg6),
            end_date            : arg5,
            winning_ticket      : 0,
            winner              : @0x0,
            count               : 0,
            total_participants  : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Raffle>(&mut arg0.id, v1, v2);
        0x2::linked_table::push_front<0x2::object::ID, bool>(&mut arg0.active_raffles, v1, true);
        let v3 = RaffleCreated{
            raffle_id   : v1,
            prize_value : arg1,
            title       : arg2,
            description : arg3,
            cover_image : arg4,
            end_date    : arg5,
        };
        0x2::event::emit<RaffleCreated>(v3);
        v1
    }

    public fun create_raffle_treasury(arg0: &RaffleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleTreasury{
            id               : 0x2::object::new(arg1),
            prices           : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            ticket_deals     : 0x2::table::new<u64, u64>(arg1),
            active_raffles   : 0x2::linked_table::new<0x2::object::ID, bool>(arg1),
            inactive_raffles : 0x2::linked_table::new<0x2::object::ID, bool>(arg1),
            managers         : 0x2::vec_set::empty<address>(),
            version_set      : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<RaffleTreasury>(v0);
    }

    public fun end_date(arg0: &Raffle) : u64 {
        arg0.end_date
    }

    fun err_invalid_coin_type() {
        abort 14
    }

    fun err_sender_is_not_manager() {
        abort 15
    }

    public fun extend_raffle(arg0: &mut RaffleTreasury, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        let v0 = borrow_raffle_mut(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 < v0.end_date, 1);
        assert!(arg2 > v1, 4);
        assert!(arg2 > v0.end_date, 5);
        assert!(v0.winning_ticket == 0, 7);
        v0.end_date = arg2;
        let v2 = RaffleExtended{
            raffle_id    : 0x2::object::id<Raffle>(v0),
            new_end_date : arg2,
        };
        0x2::event::emit<RaffleExtended>(v2);
    }

    fun init(arg0: RAFFLES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RAFFLES>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<RaffleAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_participant(arg0: &Raffle, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::table::contains<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&arg0.participants, 0x2::tx_context::sender(arg1))
    }

    entry fun lucky_number(arg0: &mut RaffleTreasury, arg1: 0x2::object::ID, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        let v0 = borrow_raffle_mut(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) > v0.end_date, 6);
        assert!(v0.winning_ticket == 0, 7);
        let v1 = 0x2::random::new_generator(arg2, arg4);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 1, v0.total_tickets);
        v0.winning_ticket = v2;
        let v3 = LuckyTicketPicked{
            raffle_id    : 0x2::object::id<Raffle>(v0),
            lucky_ticket : v2,
        };
        0x2::event::emit<LuckyTicketPicked>(v3);
    }

    public fun managers(arg0: &RaffleTreasury) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun my_tickets(arg0: &Raffle, arg1: &mut 0x2::tx_context::TxContext) : vector<vector<u64>> {
        assert!(is_participant(arg0, arg1), 3);
        let v0 = 0x2::table::borrow<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&arg0.participants, 0x2::tx_context::sender(arg1));
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::length<Ticket>(v0)) {
            let v3 = 0x1::vector::empty<u64>();
            let v4 = &mut v3;
            0x1::vector::push_back<u64>(v4, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::nth<Ticket>(v0, v2).first);
            0x1::vector::push_back<u64>(v4, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::nth<Ticket>(v0, v2).last);
            0x1::vector::push_back<vector<u64>>(&mut v1, v3);
            v2 = v2 + 1;
        };
        v1
    }

    public fun package_version() : u64 {
        1
    }

    public fun price_of<T0>(arg0: &RaffleTreasury) : 0x1::option::Option<u64> {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg0.prices, &v0)
    }

    public fun prices(arg0: &RaffleTreasury) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.prices
    }

    public fun raffle_cointypes(arg0: &Raffle) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.accepted_coin_types
    }

    public fun remove_asset_type<T0>(arg0: &mut RaffleTreasury, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut borrow_raffle_mut(arg0, arg1).accepted_coin_types, &v0);
    }

    public fun remove_manager(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_price<T0>(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.prices, &v0);
        0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg2)
    }

    public fun remove_ticket_deals(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: vector<u64>) {
        assert_valid_version(arg0);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(0x2::table::contains<u64, u64>(&arg0.ticket_deals, v0), 12);
            0x2::table::remove<u64, u64>(&mut arg0.ticket_deals, v0);
        };
        let v1 = TicketDealsRemoved{
            treasury_id    : 0x2::object::id<RaffleTreasury>(arg0),
            ticket_amounts : arg2,
        };
        0x2::event::emit<TicketDealsRemoved>(v1);
    }

    public fun remove_version(arg0: &RaffleAdminCap, arg1: &mut RaffleTreasury, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun set_price<T0>(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: u64) {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(prices(arg0), &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.prices, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.prices, v0, arg2);
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
    }

    public fun set_star_raffle(arg0: &RaffleTreasury, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg2);
        let v0 = RaffleStarred{raffle_id: arg1};
        0x2::event::emit<RaffleStarred>(v0);
    }

    public fun tickets_bought(arg0: &Raffle, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0x2::table::borrow<address, 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::BigQueue<Ticket>>(&arg0.participants, arg1);
        let v2 = 0;
        while (v2 < 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::length<Ticket>(v1)) {
            v0 = v0 + 0xf032e4652ab529cbe1e92aa6943d38c75ecfe2b914deffce4d1ec9781d335fa7::big_queue::nth<Ticket>(v1, v2).total_number;
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

    public fun update_ticket_deals(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert_valid_version(arg0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 10);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(0x2::table::contains<u64, u64>(&arg0.ticket_deals, v0), 12);
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.ticket_deals, v0) = 0x1::vector::pop_back<u64>(&mut arg3);
        };
        let v1 = TicketDealsUpdated{
            treasury_id    : 0x2::object::id<RaffleTreasury>(arg0),
            ticket_amounts : arg2,
            extra_tickets  : arg3,
        };
        0x2::event::emit<TicketDealsUpdated>(v1);
    }

    public fun winner(arg0: &Raffle) : address {
        arg0.winner
    }

    public fun winning_ticket(arg0: &Raffle) : u64 {
        arg0.winning_ticket
    }

    public fun withdraw_all_by_admin<T0>(arg0: &mut RaffleTreasury, arg1: &RaffleAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = balance_mut<T0>(arg0);
        0x2::coin::take<T0>(v0, 0x2::balance::value<T0>(v0), arg2)
    }

    // decompiled from Move bytecode v6
}

