module 0xc5ce3bfaadba2e8c54a634d850f42748ab7bb44115569a47e8b3496342852375::index_duel {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Duel has key {
        id: 0x2::object::UID,
        creator: address,
        opponent: address,
        entry_amount: u64,
        duration_ms: u64,
        status: u8,
        creator_blob_id: 0x1::string::String,
        opponent_blob_id: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        start_prices_blob_id: 0x1::string::String,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        winner: address,
        result_blob_id: 0x1::string::String,
        platform_fee_bps: u64,
    }

    struct DuelCreated has copy, drop {
        duel_id: 0x2::object::ID,
        creator: address,
        entry_amount: u64,
        duration_ms: u64,
        creator_blob_id: 0x1::string::String,
    }

    struct DuelJoined has copy, drop {
        duel_id: 0x2::object::ID,
        opponent: address,
        opponent_blob_id: 0x1::string::String,
        start_time: u64,
        end_time: u64,
    }

    struct DuelSettled has copy, drop {
        duel_id: 0x2::object::ID,
        winner: address,
        creator_return_bps: u64,
        opponent_return_bps: u64,
        result_blob_id: 0x1::string::String,
    }

    struct DuelCancelled has copy, drop {
        duel_id: 0x2::object::ID,
        creator: address,
    }

    public entry fun cancel_duel(arg0: &mut Duel, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0);
        arg0.status = 3;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v0), arg1), arg0.creator);
        };
        let v1 = DuelCancelled{
            duel_id : 0x2::object::id<Duel>(arg0),
            creator : arg0.creator,
        };
        0x2::event::emit<DuelCancelled>(v1);
    }

    public entry fun create_duel(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        if (v0 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - arg1, arg6), 0x2::tx_context::sender(arg6));
        };
        let v1 = Duel{
            id                   : 0x2::object::new(arg6),
            creator              : 0x2::tx_context::sender(arg6),
            opponent             : @0x0,
            entry_amount         : arg1,
            duration_ms          : arg2,
            status               : 0,
            creator_blob_id      : arg3,
            opponent_blob_id     : 0x1::string::utf8(b""),
            start_time           : 0,
            end_time             : 0,
            start_prices_blob_id : 0x1::string::utf8(b""),
            escrow               : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            winner               : @0x0,
            result_blob_id       : 0x1::string::utf8(b""),
            platform_fee_bps     : arg4,
        };
        let v2 = DuelCreated{
            duel_id         : 0x2::object::id<Duel>(&v1),
            creator         : 0x2::tx_context::sender(arg6),
            entry_amount    : arg1,
            duration_ms     : arg2,
            creator_blob_id : arg3,
        };
        0x2::event::emit<DuelCreated>(v2);
        0x2::transfer::share_object<Duel>(v1);
    }

    public fun get_creator(arg0: &Duel) : address {
        arg0.creator
    }

    public fun get_creator_blob_id(arg0: &Duel) : 0x1::string::String {
        arg0.creator_blob_id
    }

    public fun get_duration_ms(arg0: &Duel) : u64 {
        arg0.duration_ms
    }

    public fun get_end_time(arg0: &Duel) : u64 {
        arg0.end_time
    }

    public fun get_entry_amount(arg0: &Duel) : u64 {
        arg0.entry_amount
    }

    public fun get_escrow_value(arg0: &Duel) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun get_opponent(arg0: &Duel) : address {
        arg0.opponent
    }

    public fun get_opponent_blob_id(arg0: &Duel) : 0x1::string::String {
        arg0.opponent_blob_id
    }

    public fun get_result_blob_id(arg0: &Duel) : 0x1::string::String {
        arg0.result_blob_id
    }

    public fun get_start_time(arg0: &Duel) : u64 {
        arg0.start_time
    }

    public fun get_status(arg0: &Duel) : u8 {
        arg0.status
    }

    public fun get_winner(arg0: &Duel) : address {
        arg0.winner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun join_duel(arg0: &mut Duel, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::sender(arg5) != arg0.creator, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.entry_amount, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        if (v0 > arg0.entry_amount) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - arg0.entry_amount, arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.opponent = 0x2::tx_context::sender(arg5);
        arg0.opponent_blob_id = arg2;
        arg0.start_prices_blob_id = arg3;
        arg0.status = 1;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        arg0.start_time = v1;
        arg0.end_time = v1 + arg0.duration_ms;
        let v2 = DuelJoined{
            duel_id          : 0x2::object::id<Duel>(arg0),
            opponent         : 0x2::tx_context::sender(arg5),
            opponent_blob_id : arg2,
            start_time       : arg0.start_time,
            end_time         : arg0.end_time,
        };
        0x2::event::emit<DuelJoined>(v2);
    }

    public entry fun settle_duel(arg0: &AdminCap, arg1: &mut Duel, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 3);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.end_time, 6);
        let v0 = if (arg2 >= arg3) {
            arg1.creator
        } else {
            arg1.opponent
        };
        arg1.winner = v0;
        arg1.status = 2;
        arg1.result_blob_id = arg4;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow, v1 - v1 * arg1.platform_fee_bps / 10000), arg6), v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.escrow);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow, v2), arg6), 0x2::tx_context::sender(arg6));
        };
        let v3 = DuelSettled{
            duel_id             : 0x2::object::id<Duel>(arg1),
            winner              : v0,
            creator_return_bps  : arg2,
            opponent_return_bps : arg3,
            result_blob_id      : arg4,
        };
        0x2::event::emit<DuelSettled>(v3);
    }

    // decompiled from Move bytecode v6
}

