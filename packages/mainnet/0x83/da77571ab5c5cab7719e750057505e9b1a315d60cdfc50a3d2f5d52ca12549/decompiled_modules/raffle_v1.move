module 0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::raffle_v1 {
    struct RAFFLE_V1 has drop {
        dummy_field: bool,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        paused: bool,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        raffles_created: u64,
    }

    struct PlatformCap has store, key {
        id: 0x2::object::UID,
        platform: 0x2::object::ID,
    }

    struct Allowed has copy, drop, store {
        organiser: address,
    }

    struct OrganiserAllowed has copy, drop {
        platform: 0x2::object::ID,
        organiser: address,
    }

    struct OrganiserRevoked has copy, drop {
        platform: 0x2::object::ID,
        organiser: address,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        raffle: 0x2::object::ID,
    }

    struct Entrant has store {
        slot: u64,
        tickets: u64,
        paid: u64,
        refunded: bool,
    }

    struct Raffle<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        platform: 0x2::object::ID,
        operator: address,
        organiser_legal_name: 0x1::string::String,
        title: 0x1::string::String,
        prize: 0x1::string::String,
        ticket_price: u64,
        total_tickets: u64,
        min_tickets: u64,
        max_per_entrant: u64,
        opens_at_ms: u64,
        closes_at_ms: u64,
        draw_at_ms: u64,
        operator_window_ms: u64,
        fee_bps_snapshot: u64,
        state: u8,
        sold: u64,
        escrow: 0x2::balance::Balance<T0>,
        entrants: 0x2::table::Table<address, Entrant>,
        slot_owner: 0x2::table::Table<u64, address>,
        index: 0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::fenwick::Fenwick,
        winner: 0x1::option::Option<address>,
        winning_ticket: 0x1::option::Option<u64>,
        fee_claimed: bool,
        proceeds_claimed: bool,
    }

    struct RaffleCreated has copy, drop {
        raffle: 0x2::object::ID,
        operator: address,
        organiser_legal_name: 0x1::string::String,
        ticket_price: u64,
        total_tickets: u64,
        min_tickets: u64,
        fee_bps: u64,
    }

    struct TicketsBought has copy, drop {
        raffle: 0x2::object::ID,
        entrant: address,
        tickets: u64,
        paid: u64,
        free: bool,
        sold_after: u64,
    }

    struct RaffleClosed has copy, drop {
        raffle: 0x2::object::ID,
        sold: u64,
        minimum_met: bool,
    }

    struct WinnerDrawn has copy, drop {
        raffle: 0x2::object::ID,
        winner: address,
        winning_ticket: u64,
        total_tickets_in_draw: u128,
    }

    struct Claimed has copy, drop {
        raffle: 0x2::object::ID,
        who: address,
        amount: u64,
        kind: u8,
    }

    public fun allow_organiser(arg0: &mut Platform, arg1: &PlatformCap, arg2: address) {
        assert_platform_cap(arg0, arg1);
        let v0 = Allowed{organiser: arg2};
        if (!0x2::dynamic_field::exists<Allowed>(&arg0.id, v0)) {
            0x2::dynamic_field::add<Allowed, bool>(&mut arg0.id, v0, true);
            let v1 = OrganiserAllowed{
                platform  : 0x2::object::uid_to_inner(&arg0.id),
                organiser : arg2,
            };
            0x2::event::emit<OrganiserAllowed>(v1);
        };
    }

    fun assert_operator<T0>(arg0: &Raffle<T0>, arg1: &OperatorCap) {
        assert!(arg1.raffle == 0x2::object::uid_to_inner(&arg0.id), 5);
    }

    fun assert_platform_cap(arg0: &Platform, arg1: &PlatformCap) {
        assert!(arg1.platform == 0x2::object::uid_to_inner(&arg0.id), 4);
    }

    public fun buy_tickets<T0>(arg0: &mut Raffle<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert!(arg0.state == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.opens_at_ms, 10);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.closes_at_ms, 11);
        assert!(arg2 > 0, 14);
        assert!(arg0.sold + arg2 <= arg0.total_tickets, 15);
        let v0 = arg0.ticket_price * arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v0, 17);
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v0));
        record_entry<T0>(arg0, 0x2::tx_context::sender(arg4), arg2, v0, false);
        arg1
    }

    public fun cancel<T0>(arg0: &mut Raffle<T0>, arg1: &OperatorCap) {
        assert!(arg0.version == 1, 1);
        assert_operator<T0>(arg0, arg1);
        assert!(arg0.state == 0, 6);
        arg0.state = 3;
        let v0 = RaffleClosed{
            raffle      : 0x2::object::uid_to_inner(&arg0.id),
            sold        : arg0.sold,
            minimum_met : false,
        };
        0x2::event::emit<RaffleClosed>(v0);
    }

    public fun claim_operator_proceeds<T0>(arg0: &mut Raffle<T0>, arg1: &OperatorCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert_operator<T0>(arg0, arg1);
        assert!(arg0.state == 2, 8);
        assert!(!arg0.proceeds_claimed, 19);
        let v0 = 0x2::balance::value<T0>(&arg0.escrow);
        let v1 = v0 - v0 * arg0.fee_bps_snapshot / 10000;
        arg0.proceeds_claimed = true;
        let v2 = Claimed{
            raffle : 0x2::object::uid_to_inner(&arg0.id),
            who    : 0x2::tx_context::sender(arg2),
            amount : v1,
            kind   : 0,
        };
        0x2::event::emit<Claimed>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v1), arg2)
    }

    public fun claim_platform_fee<T0>(arg0: &mut Raffle<T0>, arg1: &Platform, arg2: &PlatformCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert!(arg2.platform == 0x2::object::uid_to_inner(&arg1.id), 4);
        assert!(arg0.platform == 0x2::object::uid_to_inner(&arg1.id), 4);
        assert!(arg0.state == 2, 8);
        assert!(!arg0.fee_claimed, 19);
        assert!(arg0.proceeds_claimed, 8);
        let v0 = 0x2::balance::value<T0>(&arg0.escrow);
        arg0.fee_claimed = true;
        let v1 = Claimed{
            raffle : 0x2::object::uid_to_inner(&arg0.id),
            who    : 0x2::tx_context::sender(arg3),
            amount : v0,
            kind   : 1,
        };
        0x2::event::emit<Claimed>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v0), arg3)
    }

    public fun claim_refund<T0>(arg0: &mut Raffle<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert!(arg0.state == 3, 9);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::table::borrow_mut<address, Entrant>(&mut arg0.entrants, v0);
        assert!(!v1.refunded, 19);
        assert!(v1.paid > 0, 20);
        let v2 = v1.paid;
        v1.refunded = true;
        let v3 = Claimed{
            raffle : 0x2::object::uid_to_inner(&arg0.id),
            who    : v0,
            amount : v2,
            kind   : 2,
        };
        0x2::event::emit<Claimed>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v2), arg1)
    }

    public fun close<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1);
        assert!(arg0.state == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.closes_at_ms || arg0.sold == arg0.total_tickets, 10);
        let v0 = arg0.sold >= arg0.min_tickets;
        let v1 = if (v0) {
            1
        } else {
            3
        };
        arg0.state = v1;
        let v2 = RaffleClosed{
            raffle      : 0x2::object::uid_to_inner(&arg0.id),
            sold        : arg0.sold,
            minimum_met : v0,
        };
        0x2::event::emit<RaffleClosed>(v2);
    }

    public fun create_raffle<T0>(arg0: &mut Platform, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : OperatorCap {
        abort 25
    }

    public fun create_raffle_v2<T0>(arg0: &mut Platform, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : OperatorCap {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(is_organiser_allowed(arg0, 0x2::tx_context::sender(arg13)), 28);
        assert!(arg9 >= 0x2::clock::timestamp_ms(arg12) + 60000, 26);
        assert!(arg10 >= arg9 + 60000, 21);
        assert!(arg11 >= 60000 && arg11 <= 604800000, 27);
        assert!(arg4 > 0, 23);
        assert!(arg5 > 0, 22);
        assert!(arg6 > 0 && arg6 <= arg5, 22);
        assert!(arg7 > 0 && arg7 <= arg5, 22);
        assert!(0x1::string::length(&arg1) > 0, 24);
        assert!(0x1::string::length(&arg2) > 0, 24);
        assert!(0x1::string::length(&arg3) > 0, 24);
        assert!(arg8 < arg9, 21);
        assert!(arg10 >= arg9, 21);
        let v0 = Raffle<T0>{
            id                   : 0x2::object::new(arg13),
            version              : 1,
            platform             : 0x2::object::uid_to_inner(&arg0.id),
            operator             : 0x2::tx_context::sender(arg13),
            organiser_legal_name : arg1,
            title                : arg2,
            prize                : arg3,
            ticket_price         : arg4,
            total_tickets        : arg5,
            min_tickets          : arg6,
            max_per_entrant      : arg7,
            opens_at_ms          : arg8,
            closes_at_ms         : arg9,
            draw_at_ms           : arg10,
            operator_window_ms   : arg11,
            fee_bps_snapshot     : arg0.fee_bps,
            state                : 0,
            sold                 : 0,
            escrow               : 0x2::balance::zero<T0>(),
            entrants             : 0x2::table::new<address, Entrant>(arg13),
            slot_owner           : 0x2::table::new<u64, address>(arg13),
            index                : 0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::fenwick::new(arg13),
            winner               : 0x1::option::none<address>(),
            winning_ticket       : 0x1::option::none<u64>(),
            fee_claimed          : false,
            proceeds_claimed     : false,
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        arg0.raffles_created = arg0.raffles_created + 1;
        let v2 = RaffleCreated{
            raffle               : v1,
            operator             : 0x2::tx_context::sender(arg13),
            organiser_legal_name : v0.organiser_legal_name,
            ticket_price         : arg4,
            total_tickets        : arg5,
            min_tickets          : arg6,
            fee_bps              : v0.fee_bps_snapshot,
        };
        0x2::event::emit<RaffleCreated>(v2);
        0x2::transfer::share_object<Raffle<T0>>(v0);
        OperatorCap{
            id     : 0x2::object::new(arg13),
            raffle : v1,
        }
    }

    public fun creator() : address {
        @0x5c9b938b22076a4c6269cfa6d0ac104b6b51acfe981a55f00521be7e5de47674
    }

    entry fun draw<T0>(arg0: &mut Raffle<T0>, arg1: &OperatorCap, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_operator<T0>(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.draw_at_ms, 12);
        settle<T0>(arg0, arg2, arg4);
    }

    entry fun draw_permissionless<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.draw_at_ms + arg0.operator_window_ms, 13);
        settle<T0>(arg0, arg1, arg3);
    }

    public fun escrow_value<T0>(arg0: &Raffle<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun fee_bps_snapshot<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.fee_bps_snapshot
    }

    fun init(arg0: RAFFLE_V1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Platform{
            id              : 0x2::object::new(arg1),
            version         : 1,
            fee_bps         : 0,
            paused          : true,
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
            raffles_created : 0,
        };
        let v1 = PlatformCap{
            id       : 0x2::object::new(arg1),
            platform : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::share_object<Platform>(v0);
        0x2::transfer::public_transfer<PlatformCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_organiser_allowed(arg0: &Platform, arg1: address) : bool {
        let v0 = Allowed{organiser: arg1};
        0x2::dynamic_field::exists<Allowed>(&arg0.id, v0)
    }

    public fun migrate(arg0: &mut Platform, arg1: &PlatformCap) {
        assert_platform_cap(arg0, arg1);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun min_tickets<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.min_tickets
    }

    public fun organiser_legal_name<T0>(arg0: &Raffle<T0>) : 0x1::string::String {
        arg0.organiser_legal_name
    }

    public fun paid_by<T0>(arg0: &Raffle<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, Entrant>(&arg0.entrants, arg1)) {
            0x2::table::borrow<address, Entrant>(&arg0.entrants, arg1).paid
        } else {
            0
        }
    }

    public fun platform_fee_bps(arg0: &Platform) : u64 {
        arg0.fee_bps
    }

    public fun platform_paused(arg0: &Platform) : bool {
        arg0.paused
    }

    public fun platform_treasury(arg0: &Platform) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun raffle_of(arg0: &OperatorCap) : 0x2::object::ID {
        arg0.raffle
    }

    public fun raffles_created(arg0: &Platform) : u64 {
        arg0.raffles_created
    }

    fun record_entry<T0>(arg0: &mut Raffle<T0>, arg1: address, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = if (0x2::table::contains<address, Entrant>(&arg0.entrants, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, Entrant>(&mut arg0.entrants, arg1);
            assert!(v1.tickets + arg2 <= arg0.max_per_entrant, 16);
            v1.tickets = v1.tickets + arg2;
            v1.paid = v1.paid + arg3;
            v1.slot
        } else {
            assert!(arg2 <= arg0.max_per_entrant, 16);
            let v2 = 0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::fenwick::push_slot(&mut arg0.index);
            let v3 = Entrant{
                slot     : v2,
                tickets  : arg2,
                paid     : arg3,
                refunded : false,
            };
            0x2::table::add<address, Entrant>(&mut arg0.entrants, arg1, v3);
            0x2::table::add<u64, address>(&mut arg0.slot_owner, v2, arg1);
            v2
        };
        0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::fenwick::add(&mut arg0.index, v0, (arg2 as u128));
        arg0.sold = arg0.sold + arg2;
        let v4 = TicketsBought{
            raffle     : 0x2::object::uid_to_inner(&arg0.id),
            entrant    : arg1,
            tickets    : arg2,
            paid       : arg3,
            free       : arg4,
            sold_after : arg0.sold,
        };
        0x2::event::emit<TicketsBought>(v4);
    }

    public fun record_free_entry<T0>(arg0: &mut Raffle<T0>, arg1: &OperatorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1);
        assert_operator<T0>(arg0, arg1);
        assert!(arg0.state == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.closes_at_ms, 11);
        assert!(arg3 > 0, 14);
        let v0 = arg3 * 1;
        assert!(arg0.sold + v0 <= arg0.total_tickets, 15);
        record_entry<T0>(arg0, arg2, v0, 0, true);
    }

    public fun revoke_organiser(arg0: &mut Platform, arg1: &PlatformCap, arg2: address) {
        assert_platform_cap(arg0, arg1);
        let v0 = Allowed{organiser: arg2};
        if (0x2::dynamic_field::exists<Allowed>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<Allowed, bool>(&mut arg0.id, v0);
            let v1 = OrganiserRevoked{
                platform  : 0x2::object::uid_to_inner(&arg0.id),
                organiser : arg2,
            };
            0x2::event::emit<OrganiserRevoked>(v1);
        };
    }

    public fun set_fee_bps(arg0: &mut Platform, arg1: &PlatformCap, arg2: u64) {
        assert_platform_cap(arg0, arg1);
        assert!(arg2 <= 1000, 3);
        arg0.fee_bps = arg2;
    }

    public fun set_paused(arg0: &mut Platform, arg1: &PlatformCap, arg2: bool) {
        assert_platform_cap(arg0, arg1);
        arg0.paused = arg2;
    }

    fun settle<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg0.state == 1, 7);
        let v0 = 0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::fenwick::total(&arg0.index);
        assert!(v0 > 0, 18);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::fenwick::find(&arg0.index, 0x2::random::generate_u128_in_range(&mut v1, 0, ((v0 - 1) as u128)));
        let v3 = *0x2::table::borrow<u64, address>(&arg0.slot_owner, v2);
        arg0.winner = 0x1::option::some<address>(v3);
        arg0.winning_ticket = 0x1::option::some<u64>(v2);
        arg0.state = 2;
        let v4 = WinnerDrawn{
            raffle                : 0x2::object::uid_to_inner(&arg0.id),
            winner                : v3,
            winning_ticket        : v2,
            total_tickets_in_draw : v0,
        };
        0x2::event::emit<WinnerDrawn>(v4);
    }

    public fun sold<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.sold
    }

    public fun state<T0>(arg0: &Raffle<T0>) : u8 {
        arg0.state
    }

    public fun state_closed() : u8 {
        1
    }

    public fun state_drawn() : u8 {
        2
    }

    public fun state_open() : u8 {
        0
    }

    public fun state_refunding() : u8 {
        3
    }

    public fun ticket_price<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.ticket_price
    }

    public fun tickets_of<T0>(arg0: &Raffle<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, Entrant>(&arg0.entrants, arg1)) {
            0x2::table::borrow<address, Entrant>(&arg0.entrants, arg1).tickets
        } else {
            0
        }
    }

    public fun total_tickets<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.total_tickets
    }

    public fun winner<T0>(arg0: &Raffle<T0>) : 0x1::option::Option<address> {
        arg0.winner
    }

    public fun winning_ticket<T0>(arg0: &Raffle<T0>) : 0x1::option::Option<u64> {
        arg0.winning_ticket
    }

    public fun withdraw_platform(arg0: &mut Platform, arg1: &PlatformCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_platform_cap(arg0, arg1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

