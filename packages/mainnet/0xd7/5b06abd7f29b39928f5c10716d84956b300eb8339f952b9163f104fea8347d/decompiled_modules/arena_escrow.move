module 0xd75b06abd7f29b39928f5c10716d84956b300eb8339f952b9163f104fea8347d::arena_escrow {
    struct ARENA_ESCROW has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EscrowRegistry has key {
        id: 0x2::object::UID,
        total_events: u64,
        total_volume: u64,
        total_prizes_distributed: u64,
    }

    struct ArenaEscrow<phantom T0> has store, key {
        id: 0x2::object::UID,
        event_id: 0x1::string::String,
        admin: address,
        prize_pool: 0x2::balance::Balance<T0>,
        prize_amount: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        winner: 0x1::option::Option<address>,
        created_at: u64,
    }

    struct PrizeDeposited has copy, drop {
        event_id: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        admin: address,
        prize_amount: u64,
        start_time: u64,
        end_time: u64,
        timestamp: u64,
    }

    struct PrizeDistributed has copy, drop {
        event_id: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        winner: address,
        prize_amount: u64,
        timestamp: u64,
    }

    struct EventCancelled has copy, drop {
        event_id: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        admin: address,
        refund_amount: u64,
        timestamp: u64,
    }

    public fun cancel_and_refund<T0>(arg0: &mut ArenaEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg0.status == 0, 9);
        arg0.status = 2;
        let v0 = EventCancelled{
            event_id      : arg0.event_id,
            escrow_id     : 0x2::object::uid_to_inner(&arg0.id),
            admin         : arg0.admin,
            refund_amount : 0x2::balance::value<T0>(&arg0.prize_pool),
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventCancelled>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.prize_pool), arg2), arg0.admin);
    }

    public fun deposit_prize<T0>(arg0: &mut EscrowRegistry, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 8);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = ArenaEscrow<T0>{
            id           : v1,
            event_id     : arg1,
            admin        : 0x2::tx_context::sender(arg6),
            prize_pool   : 0x2::coin::into_balance<T0>(arg2),
            prize_amount : v0,
            start_time   : arg3,
            end_time     : arg4,
            status       : 0,
            winner       : 0x1::option::none<address>(),
            created_at   : 0x2::clock::timestamp_ms(arg5),
        };
        arg0.total_events = arg0.total_events + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v4 = PrizeDeposited{
            event_id     : v3.event_id,
            escrow_id    : v2,
            admin        : 0x2::tx_context::sender(arg6),
            prize_amount : v0,
            start_time   : arg3,
            end_time     : arg4,
            timestamp    : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PrizeDeposited>(v4);
        0x2::transfer::share_object<ArenaEscrow<T0>>(v3);
        v2
    }

    public fun distribute_prize<T0>(arg0: &mut EscrowRegistry, arg1: &mut ArenaEscrow<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.end_time, 4);
        assert!(arg1.status == 0, 5);
        assert!(arg2 != @0x0, 6);
        let v1 = 0x2::balance::value<T0>(&arg1.prize_pool);
        arg1.status = 1;
        arg1.winner = 0x1::option::some<address>(arg2);
        arg0.total_prizes_distributed = arg0.total_prizes_distributed + v1;
        let v2 = PrizeDistributed{
            event_id     : arg1.event_id,
            escrow_id    : 0x2::object::uid_to_inner(&arg1.id),
            winner       : arg2,
            prize_amount : v1,
            timestamp    : v0,
        };
        0x2::event::emit<PrizeDistributed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.prize_pool), arg4), arg2);
    }

    public fun get_admin<T0>(arg0: &ArenaEscrow<T0>) : address {
        arg0.admin
    }

    public fun get_current_balance<T0>(arg0: &ArenaEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prize_pool)
    }

    public fun get_end_time<T0>(arg0: &ArenaEscrow<T0>) : u64 {
        arg0.end_time
    }

    public fun get_event_id<T0>(arg0: &ArenaEscrow<T0>) : 0x1::string::String {
        arg0.event_id
    }

    public fun get_prize_amount<T0>(arg0: &ArenaEscrow<T0>) : u64 {
        arg0.prize_amount
    }

    public fun get_start_time<T0>(arg0: &ArenaEscrow<T0>) : u64 {
        arg0.start_time
    }

    public fun get_status<T0>(arg0: &ArenaEscrow<T0>) : u8 {
        arg0.status
    }

    public fun get_total_events(arg0: &EscrowRegistry) : u64 {
        arg0.total_events
    }

    public fun get_total_prizes_distributed(arg0: &EscrowRegistry) : u64 {
        arg0.total_prizes_distributed
    }

    public fun get_total_volume(arg0: &EscrowRegistry) : u64 {
        arg0.total_volume
    }

    public fun get_winner<T0>(arg0: &ArenaEscrow<T0>) : 0x1::option::Option<address> {
        arg0.winner
    }

    fun init(arg0: ARENA_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = EscrowRegistry{
            id                       : 0x2::object::new(arg1),
            total_events             : 0,
            total_volume             : 0,
            total_prizes_distributed : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<EscrowRegistry>(v1);
    }

    public fun is_active<T0>(arg0: &ArenaEscrow<T0>) : bool {
        arg0.status == 0
    }

    public fun is_cancelled<T0>(arg0: &ArenaEscrow<T0>) : bool {
        arg0.status == 2
    }

    public fun is_completed<T0>(arg0: &ArenaEscrow<T0>) : bool {
        arg0.status == 1
    }

    // decompiled from Move bytecode v6
}

