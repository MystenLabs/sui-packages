module 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault {
    struct PARLAY_VAULT has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_staked_mist: u64,
        total_paid_out_mist: u64,
        total_tickets: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        owner: address,
        stake_mist: u64,
        payout_mist: u64,
        leg_count: u8,
        legs: vector<Leg>,
        status: u8,
        blob_id: vector<u8>,
        created_at_ms: u64,
        leg_summary: 0x1::string::String,
        payout_sui_display: 0x1::string::String,
    }

    struct Leg has copy, drop, store {
        market_id: 0x2::object::ID,
        outcome: u8,
        price_wad: u64,
    }

    struct WinningTicket has store, key {
        id: 0x2::object::UID,
        original_ticket_id: 0x2::object::ID,
        owner: address,
        payout_mist: u64,
        leg_summary: 0x1::string::String,
        settled_at_ms: u64,
    }

    struct TreasurySeeded has copy, drop {
        treasury_id: 0x2::object::ID,
        amount_mist: u64,
    }

    struct TicketMinted has copy, drop {
        ticket_id: 0x2::object::ID,
        owner: address,
        stake_mist: u64,
        payout_mist: u64,
        leg_count: u8,
    }

    struct TicketClaimed has copy, drop {
        ticket_id: 0x2::object::ID,
        owner: address,
        payout_mist: u64,
    }

    struct TicketLost has copy, drop {
        ticket_id: 0x2::object::ID,
        owner: address,
        stake_mist: u64,
    }

    struct TicketCashedOut has copy, drop {
        ticket_id: 0x2::object::ID,
        owner: address,
        payout_mist: u64,
    }

    public entry fun claim(arg0: &mut Treasury, arg1: Ticket, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1.payout_mist, 0);
        let v0 = arg1.owner;
        let v1 = arg1.payout_mist;
        let v2 = 0x2::object::id<Ticket>(&arg1);
        arg0.total_paid_out_mist = arg0.total_paid_out_mist + v1;
        let v3 = TicketClaimed{
            ticket_id   : v2,
            owner       : v0,
            payout_mist : v1,
        };
        0x2::event::emit<TicketClaimed>(v3);
        let Ticket {
            id                 : v4,
            owner              : _,
            stake_mist         : _,
            payout_mist        : _,
            leg_count          : _,
            legs               : _,
            status             : _,
            blob_id            : _,
            created_at_ms      : _,
            leg_summary        : _,
            payout_sui_display : _,
        } = arg1;
        0x2::object::delete(v4);
        let v15 = WinningTicket{
            id                 : 0x2::object::new(arg3),
            original_ticket_id : v2,
            owner              : v0,
            payout_mist        : v1,
            leg_summary        : arg1.leg_summary,
            settled_at_ms      : arg2,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg3), v0);
        0x2::transfer::transfer<WinningTicket>(v15, v0);
    }

    public entry fun add_liquidity(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun cash_out(arg0: &mut Treasury, arg1: Ticket, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0);
        let v0 = arg1.owner;
        let v1 = TicketCashedOut{
            ticket_id   : 0x2::object::id<Ticket>(&arg1),
            owner       : v0,
            payout_mist : arg2,
        };
        0x2::event::emit<TicketCashedOut>(v1);
        let Ticket {
            id                 : v2,
            owner              : _,
            stake_mist         : _,
            payout_mist        : _,
            leg_count          : _,
            legs               : _,
            status             : _,
            blob_id            : _,
            created_at_ms      : _,
            leg_summary        : _,
            payout_sui_display : _,
        } = arg1;
        0x2::object::delete(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3), v0);
    }

    fun init(arg0: PARLAY_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PARLAY_VAULT>(arg0, arg1);
        let v1 = 0x2::display::new<Ticket>(&v0, arg1);
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Parlay Ticket"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Picks: {leg_summary} | Potential payout: {payout_sui_display}"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://parlay-markets.vercel.app/api/ticket-image/{id}"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://parlay-markets.vercel.app"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Parlay Markets"));
        0x2::display::update_version<Ticket>(&mut v1);
        let v2 = 0x2::display::new<WinningTicket>(&v0, arg1);
        0x2::display::add<WinningTicket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Winning Parlay Trophy"));
        0x2::display::add<WinningTicket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Verified winning parlay. Picks: {leg_summary} | Won: {payout_sui_display}"));
        0x2::display::add<WinningTicket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://parlay-markets.vercel.app/api/trophy-image/{id}"));
        0x2::display::add<WinningTicket>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://parlay-markets.vercel.app"));
        0x2::display::update_version<WinningTicket>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WinningTicket>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun leg_market_id(arg0: &Leg) : 0x2::object::ID {
        arg0.market_id
    }

    public fun leg_outcome(arg0: &Leg) : u8 {
        arg0.outcome
    }

    public fun leg_price(arg0: &Leg) : u64 {
        arg0.price_wad
    }

    public(friend) fun mark_lost(arg0: &mut Ticket) {
        assert!(arg0.status == 0, 2);
        arg0.status = 2;
        let v0 = TicketLost{
            ticket_id  : 0x2::object::id<Ticket>(arg0),
            owner      : arg0.owner,
            stake_mist : arg0.stake_mist,
        };
        0x2::event::emit<TicketLost>(v0);
    }

    public(friend) fun mark_won(arg0: &mut Ticket) {
        assert!(arg0.status == 0, 2);
        arg0.status = 1;
    }

    public fun max_payout() : u64 {
        100000000000
    }

    public(friend) fun mint_ticket(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: vector<Leg>, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 7);
        assert!(arg2 <= 100000000000, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = (0x1::vector::length<Leg>(&arg3) as u8);
        let v2 = Ticket{
            id                 : 0x2::object::new(arg9),
            owner              : arg8,
            stake_mist         : v0,
            payout_mist        : arg2,
            leg_count          : v1,
            legs               : arg3,
            status             : 0,
            blob_id            : arg4,
            created_at_ms      : arg7,
            leg_summary        : arg5,
            payout_sui_display : arg6,
        };
        let v3 = 0x2::object::id<Ticket>(&v2);
        arg0.total_staked_mist = arg0.total_staked_mist + v0;
        arg0.total_tickets = arg0.total_tickets + 1;
        let v4 = TicketMinted{
            ticket_id   : v3,
            owner       : arg8,
            stake_mist  : v0,
            payout_mist : arg2,
            leg_count   : v1,
        };
        0x2::event::emit<TicketMinted>(v4);
        0x2::transfer::transfer<Ticket>(v2, arg8);
        v3
    }

    public fun new_leg(arg0: 0x2::object::ID, arg1: u8, arg2: u64) : Leg {
        Leg{
            market_id : arg0,
            outcome   : arg1,
            price_wad : arg2,
        }
    }

    public entry fun seed_treasury(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                  : 0x2::object::new(arg1),
            balance             : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            total_staked_mist   : 0,
            total_paid_out_mist : 0,
            total_tickets       : 0,
        };
        let v1 = TreasurySeeded{
            treasury_id : 0x2::object::id<Treasury>(&v0),
            amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg0),
        };
        0x2::event::emit<TreasurySeeded>(v1);
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun status_lost() : u8 {
        2
    }

    public fun status_open() : u8 {
        0
    }

    public fun status_won() : u8 {
        1
    }

    public fun ticket_legs(arg0: &Ticket) : &vector<Leg> {
        &arg0.legs
    }

    public fun ticket_owner(arg0: &Ticket) : address {
        arg0.owner
    }

    public fun ticket_payout(arg0: &Ticket) : u64 {
        arg0.payout_mist
    }

    public fun ticket_stake(arg0: &Ticket) : u64 {
        arg0.stake_mist
    }

    public fun ticket_status(arg0: &Ticket) : u8 {
        arg0.status
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    // decompiled from Move bytecode v7
}

