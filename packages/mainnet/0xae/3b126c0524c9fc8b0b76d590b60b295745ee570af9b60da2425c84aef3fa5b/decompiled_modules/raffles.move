module 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::raffles {
    struct RAFFLES has drop {
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

    struct RaffleTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        balance: 0x2::balance::Balance<T0>,
        price_per_ticket: u64,
        ticket_deals: 0x2::table::Table<u64, u64>,
    }

    struct Raffle<phantom T0> has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        cover_image: 0x1::string::String,
        total_tickets: u64,
        participants: 0x2::table::Table<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>,
        end_date: u64,
        winning_ticket: u64,
        winner: address,
        count: u64,
        collected: u64,
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

    public fun add_ticket_deals<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &RaffleAdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert_valid_version<T0>(arg0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 10);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(!0x2::table::contains<u64, u64>(&arg0.ticket_deals, v0), 11);
            0x2::table::add<u64, u64>(&mut arg0.ticket_deals, v0, 0x1::vector::pop_back<u64>(&mut arg3));
        };
        let v1 = TicketDealsAdded{
            treasury_id    : 0x2::object::id<RaffleTreasury<T0>>(arg0),
            ticket_amounts : arg2,
            extra_tickets  : arg3,
        };
        0x2::event::emit<TicketDealsAdded>(v1);
    }

    public fun add_version<T0>(arg0: &RaffleAdminCap, arg1: &mut RaffleTreasury<T0>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_valid_version<T0>(arg0: &RaffleTreasury<T0>) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13);
    }

    public fun borrow_raffle<T0>(arg0: &RaffleTreasury<T0>, arg1: 0x2::object::ID) : &Raffle<T0> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Raffle<T0>>(&arg0.id, arg1)
    }

    fun borrow_raffle_mut<T0>(arg0: &mut RaffleTreasury<T0>, arg1: 0x2::object::ID) : &mut Raffle<T0> {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Raffle<T0>>(&mut arg0.id, arg1)
    }

    public fun buy_tickets<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        assert!(v0 % arg0.price_per_ticket == 0, 2);
        let v1 = v0 / arg0.price_per_ticket;
        let v2 = borrow_raffle_mut<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v2.end_date, 1);
        let v3 = v2.total_tickets + 1;
        let v4 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&v2.participants, v4)) {
            let v5 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(0x2::table::borrow_mut<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, v4), v5);
        } else {
            let v6 = 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::new<Ticket>(5000, arg5);
            let v7 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(&mut v6, v7);
            0x2::table::add<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, v4, v6);
            v2.total_participants = v2.total_participants + 1;
        };
        v2.total_tickets = v2.total_tickets + v1;
        v2.collected = v2.collected + v0;
        let v8 = TicketsBought{
            raffle_id    : arg2,
            user         : v4,
            quantity     : v1,
            paid         : v0,
            origin       : arg4,
            deal         : 1,
            first_number : v3,
        };
        0x2::event::emit<TicketsBought>(v8);
    }

    public fun buy_tickets_from_deal<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        assert!(v0 % arg4 * 2000000000 == 0, 2);
        let v1 = v0 / arg4 * 2000000000 * (arg4 + *0x2::table::borrow<u64, u64>(&arg0.ticket_deals, arg4));
        let v2 = borrow_raffle_mut<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v2.end_date, 1);
        let v3 = v2.total_tickets + 1;
        let v4 = 0x2::tx_context::sender(arg6);
        if (0x2::table::contains<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&v2.participants, v4)) {
            let v5 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(0x2::table::borrow_mut<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, v4), v5);
        } else {
            let v6 = 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::new<Ticket>(5000, arg6);
            let v7 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(&mut v6, v7);
            0x2::table::add<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, v4, v6);
            v2.total_participants = v2.total_participants + 1;
        };
        v2.total_tickets = v2.total_tickets + v1;
        v2.collected = v2.collected + v0;
        let v8 = TicketsBought{
            raffle_id    : arg2,
            user         : v4,
            quantity     : v1,
            paid         : v0,
            origin       : arg5,
            deal         : arg4,
            first_number : v3,
        };
        0x2::event::emit<TicketsBought>(v8);
    }

    public fun buy_tickets_from_deal_on_behalf<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        assert!(v0 % arg4 * 2000000000 == 0, 2);
        let v1 = v0 / arg4 * 2000000000 * (arg4 + *0x2::table::borrow<u64, u64>(&arg0.ticket_deals, arg4));
        let v2 = borrow_raffle_mut<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v2.end_date, 1);
        let v3 = v2.total_tickets + 1;
        if (0x2::table::contains<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&v2.participants, arg5)) {
            let v4 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(0x2::table::borrow_mut<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, arg5), v4);
        } else {
            let v5 = 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::new<Ticket>(5000, arg7);
            let v6 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(&mut v5, v6);
            0x2::table::add<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, arg5, v5);
            v2.total_participants = v2.total_participants + 1;
        };
        v2.total_tickets = v2.total_tickets + v1;
        v2.collected = v2.collected + v0;
        let v7 = TicketsBought{
            raffle_id    : arg2,
            user         : arg5,
            quantity     : v1,
            paid         : v0,
            origin       : arg6,
            deal         : arg4,
            first_number : v3,
        };
        0x2::event::emit<TicketsBought>(v7);
    }

    public fun buy_tickets_on_behalf<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        assert!(v0 % arg0.price_per_ticket == 0, 2);
        let v1 = arg0.price_per_ticket / v0;
        let v2 = borrow_raffle_mut<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v2.end_date, 1);
        let v3 = v2.total_tickets + 1;
        if (0x2::table::contains<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&v2.participants, arg4)) {
            let v4 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(0x2::table::borrow_mut<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, arg4), v4);
        } else {
            let v5 = 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::new<Ticket>(5000, arg6);
            let v6 = Ticket{
                first        : v3,
                last         : v2.total_tickets + v1,
                total_number : v1,
            };
            0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::push_back<Ticket>(&mut v5, v6);
            0x2::table::add<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v2.participants, arg4, v5);
            v2.total_participants = v2.total_participants + 1;
        };
        v2.total_tickets = v2.total_tickets + v1;
        v2.collected = v2.collected + v0;
        let v7 = TicketsBought{
            raffle_id    : arg2,
            user         : arg4,
            quantity     : v1,
            paid         : v0,
            origin       : arg5,
            deal         : 1,
            first_number : v3,
        };
        0x2::event::emit<TicketsBought>(v7);
    }

    public fun collected<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.collected
    }

    public fun commit_winner<T0>(arg0: &mut RaffleTreasury<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: address) {
        assert_valid_version<T0>(arg0);
        let v0 = borrow_raffle_mut<T0>(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.end_date, 6);
        assert!(v0.winning_ticket != 0, 8);
        let v1 = 0x2::table::remove<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&mut v0.participants, arg3);
        while (!0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::is_empty<Ticket>(&v1)) {
            let v2 = 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::pop_front<Ticket>(&mut v1);
            if (v0.winning_ticket >= v2.first && v0.winning_ticket <= v2.last) {
                v0.winner = arg3;
                let v3 = WinnerCommitted{
                    raffle_id    : 0x2::object::id<Raffle<T0>>(v0),
                    winner       : arg3,
                    lucky_ticket : v0.winning_ticket,
                };
                0x2::event::emit<WinnerCommitted>(v3);
                0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::drop<Ticket>(v1);
                return
            };
        };
        abort 9
    }

    public fun create_raffle<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &RaffleAdminCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version<T0>(arg0);
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Raffle<T0>{
            id                 : v0,
            title              : arg3,
            description        : arg4,
            cover_image        : arg5,
            total_tickets      : 0,
            participants       : 0x2::table::new<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(arg7),
            end_date           : arg6,
            winning_ticket     : 0,
            winner             : @0x0,
            count              : 0,
            collected          : 0,
            total_participants : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Raffle<T0>>(&mut arg0.id, v1, v2);
        let v3 = RaffleCreated{
            raffle_id   : v1,
            prize_value : arg2,
            title       : arg3,
            description : arg4,
            cover_image : arg5,
            end_date    : arg6,
        };
        0x2::event::emit<RaffleCreated>(v3);
        v1
    }

    public fun create_raffle_treasury<T0>(arg0: &RaffleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleTreasury<T0>{
            id               : 0x2::object::new(arg1),
            version_set      : 0x2::vec_set::singleton<u64>(2),
            balance          : 0x2::balance::zero<T0>(),
            price_per_ticket : 2000000000,
            ticket_deals     : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::share_object<RaffleTreasury<T0>>(v0);
    }

    public fun end_date<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.end_date
    }

    public fun extend_raffle<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &RaffleAdminCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_valid_version<T0>(arg0);
        let v0 = borrow_raffle_mut<T0>(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 < v0.end_date, 1);
        assert!(arg3 > v1, 4);
        assert!(arg3 > v0.end_date, 5);
        assert!(v0.winning_ticket == 0, 7);
        v0.end_date = arg3;
        let v2 = RaffleExtended{
            raffle_id    : 0x2::object::id<Raffle<T0>>(v0),
            new_end_date : arg3,
        };
        0x2::event::emit<RaffleExtended>(v2);
    }

    fun init(arg0: RAFFLES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RAFFLES>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<RaffleAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_participant<T0>(arg0: &Raffle<T0>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::table::contains<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&arg0.participants, 0x2::tx_context::sender(arg1))
    }

    entry fun lucky_number<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &RaffleAdminCap, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version<T0>(arg0);
        let v0 = borrow_raffle_mut<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) > v0.end_date, 6);
        assert!(v0.winning_ticket == 0, 7);
        let v1 = 0x2::random::new_generator(arg3, arg5);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 1, v0.total_tickets);
        v0.winning_ticket = v2;
        let v3 = LuckyTicketPicked{
            raffle_id    : 0x2::object::id<Raffle<T0>>(v0),
            lucky_ticket : v2,
        };
        0x2::event::emit<LuckyTicketPicked>(v3);
    }

    public fun my_tickets<T0>(arg0: &Raffle<T0>, arg1: &mut 0x2::tx_context::TxContext) : vector<vector<u64>> {
        assert!(is_participant<T0>(arg0, arg1), 3);
        let v0 = 0x2::table::borrow<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&arg0.participants, 0x2::tx_context::sender(arg1));
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::length<Ticket>(v0)) {
            let v3 = 0x1::vector::empty<u64>();
            let v4 = &mut v3;
            0x1::vector::push_back<u64>(v4, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::nth<Ticket>(v0, v2).first);
            0x1::vector::push_back<u64>(v4, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::nth<Ticket>(v0, v2).last);
            0x1::vector::push_back<vector<u64>>(&mut v1, v3);
            v2 = v2 + 1;
        };
        v1
    }

    public fun package_version() : u64 {
        2
    }

    public fun remove_ticket_deals<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &RaffleAdminCap, arg2: vector<u64>) {
        assert_valid_version<T0>(arg0);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(0x2::table::contains<u64, u64>(&arg0.ticket_deals, v0), 12);
            0x2::table::remove<u64, u64>(&mut arg0.ticket_deals, v0);
        };
        let v1 = TicketDealsRemoved{
            treasury_id    : 0x2::object::id<RaffleTreasury<T0>>(arg0),
            ticket_amounts : arg2,
        };
        0x2::event::emit<TicketDealsRemoved>(v1);
    }

    public fun remove_version<T0>(arg0: &RaffleAdminCap, arg1: &mut RaffleTreasury<T0>, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun tickets_bought<T0>(arg0: &Raffle<T0>, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0x2::table::borrow<address, 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::BigQueue<Ticket>>(&arg0.participants, arg1);
        let v2 = 0;
        while (v2 < 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::length<Ticket>(v1)) {
            v0 = v0 + 0xdf0eb76181ce7c25b8cc872f0740eebe23f6cfccf05bf4ef7de9332b4de32b82::big_queue::nth<Ticket>(v1, v2).total_number;
            v2 = v2 + 1;
        };
        v0
    }

    public fun total_participants<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.total_participants
    }

    public fun total_tickets<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.total_tickets
    }

    public fun update_ticket_deals<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &RaffleAdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert_valid_version<T0>(arg0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 10);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(0x2::table::contains<u64, u64>(&arg0.ticket_deals, v0), 12);
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.ticket_deals, v0) = 0x1::vector::pop_back<u64>(&mut arg3);
        };
        let v1 = TicketDealsUpdated{
            treasury_id    : 0x2::object::id<RaffleTreasury<T0>>(arg0),
            ticket_amounts : arg2,
            extra_tickets  : arg3,
        };
        0x2::event::emit<TicketDealsUpdated>(v1);
    }

    public fun winner<T0>(arg0: &Raffle<T0>) : address {
        arg0.winner
    }

    public fun winning_ticket<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.winning_ticket
    }

    public fun withdraw_proceeds<T0>(arg0: &mut RaffleTreasury<T0>, arg1: &RaffleAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version<T0>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg2)
    }

    // decompiled from Move bytecode v6
}

