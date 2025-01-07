module 0x9152786bc4e506a891f0efc5202860670c99313a809a71bf2b2fb2a8ac080a60::game {
    struct NewDrawing has copy, drop {
        ticket_id: 0x2::object::ID,
        player: address,
    }

    struct DrawingResult has copy, drop {
        ticket_id: 0x2::object::ID,
        player: address,
        amount_won: u64,
        tickets_opened: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        player: address,
        drawing_count: u64,
    }

    struct PrizeStruct has drop, store {
        ticket_amount: u64,
        prize_value: u64,
    }

    struct Metadata has copy, drop, store {
        tickets_claimed: u64,
        amount_won: u64,
    }

    struct LeaderBoard has store {
        lowest_sui_won: u64,
        max_players: u64,
        leaderboard_players: vector<address>,
        leaderboard_player_metadata: 0x2::table::Table<address, Metadata>,
    }

    struct StoreCap has store, key {
        id: 0x2::object::UID,
    }

    struct SetUpCap has store, key {
        id: 0x2::object::UID,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConvenienceStore has key {
        id: 0x2::object::UID,
        creator: address,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        winning_tickets: vector<PrizeStruct>,
        original_ticket_count: u64,
        tickets_issued: u64,
        tickets_evaluated: u64,
        player_metadata: 0x2::table::Table<address, Metadata>,
        leaderboard: LeaderBoard,
        public_key: vector<u8>,
        allow_evaluation: bool,
    }

    struct GAME has drop {
        dummy_field: bool,
    }

    public fun amount_won(arg0: &Metadata) : u64 {
        arg0.amount_won
    }

    public fun evaluate_ticket(arg0: Ticket, arg1: &mut ConvenienceStore, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.tickets_issued <= arg1.original_ticket_count, 2);
        assert!(arg1.allow_evaluation, 4);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        arg0.player = 0x2::tx_context::sender(arg2);
        0x2::dynamic_object_field::add<0x2::object::ID, Ticket>(&mut arg1.id, v0, arg0);
        let v1 = NewDrawing{
            ticket_id : v0,
            player    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NewDrawing>(v1);
        v0
    }

    public fun finish_evaluation(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut ConvenienceStore, arg3: &mut 0x2::tx_context::TxContext) {
        if (!ticket_exists(arg2, arg0)) {
            return
        };
        let Ticket {
            id            : v0,
            player        : v1,
            drawing_count : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Ticket>(&mut arg2.id, arg0);
        let v3 = v0;
        let v4 = 0x2::object::uid_to_bytes(&v3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg2.public_key, &v4), 1);
        0x2::object::delete(v3);
        let v5 = 0x2::hash::blake2b256(&arg1);
        let v6 = 0;
        let v7 = 0;
        while (v6 < v2) {
            let v8 = 0x9152786bc4e506a891f0efc5202860670c99313a809a71bf2b2fb2a8ac080a60::math::get_random_u64_in_range(&v5, tickets_left(arg2));
            let v9 = &v5;
            v5 = 0x2::hash::blake2b256(v9);
            let v10 = 0;
            let v11 = 0;
            while (v10 < v8) {
                v10 = v10 + 0x1::vector::borrow<PrizeStruct>(&arg2.winning_tickets, v11).ticket_amount;
                if (v10 < v8) {
                    v11 = v11 + 1;
                };
            };
            let v12 = 0x1::vector::remove<PrizeStruct>(&mut arg2.winning_tickets, v11);
            v12.ticket_amount = v12.ticket_amount - 1;
            v7 = v7 + v12.prize_value;
            if (v12.ticket_amount > 0) {
                0x1::vector::push_back<PrizeStruct>(&mut arg2.winning_tickets, v12);
            };
            arg2.tickets_evaluated = arg2.tickets_evaluated + 1;
            v6 = v6 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.prize_pool, v7, arg3), v1);
        update_leaderboard(arg2, v1, v2, v7);
        let v13 = DrawingResult{
            ticket_id      : arg0,
            player         : 0x2::tx_context::sender(arg3),
            amount_won     : v7,
            tickets_opened : v2,
        };
        0x2::event::emit<DrawingResult>(v13);
    }

    public fun get_player_metadata_mut(arg0: &mut 0x2::table::Table<address, Metadata>, arg1: address) : &mut Metadata {
        0x2::table::borrow_mut<address, Metadata>(arg0, arg1)
    }

    public fun get_target_player_metadata(arg0: &0x2::table::Table<address, Metadata>, arg1: address) : &Metadata {
        0x2::table::borrow<address, Metadata>(arg0, arg1)
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GAME>(arg0, arg1);
        let v0 = LeaderBoard{
            lowest_sui_won              : 0,
            max_players                 : 10,
            leaderboard_players         : vector[],
            leaderboard_player_metadata : 0x2::table::new<address, Metadata>(arg1),
        };
        let v1 = ConvenienceStore{
            id                    : 0x2::object::new(arg1),
            creator               : 0x2::tx_context::sender(arg1),
            prize_pool            : 0x2::balance::zero<0x2::sui::SUI>(),
            winning_tickets       : 0x1::vector::empty<PrizeStruct>(),
            original_ticket_count : 0,
            tickets_issued        : 0,
            tickets_evaluated     : 0,
            player_metadata       : 0x2::table::new<address, Metadata>(arg1),
            leaderboard           : v0,
            public_key            : b"",
            allow_evaluation      : true,
        };
        0x2::transfer::share_object<ConvenienceStore>(v1);
        let v2 = StoreCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<StoreCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = SetUpCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SetUpCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = WithdrawCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<WithdrawCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun leaderboard(arg0: &ConvenienceStore) : &LeaderBoard {
        &arg0.leaderboard
    }

    public fun leaderboard_players(arg0: &LeaderBoard) : vector<address> {
        arg0.leaderboard_players
    }

    public fun mint_child_store_cap(arg0: &StoreCap, arg1: &mut 0x2::tx_context::TxContext) : StoreCap {
        StoreCap{id: 0x2::object::new(arg1)}
    }

    public fun original_ticket_count(arg0: &ConvenienceStore) : u64 {
        arg0.original_ticket_count
    }

    public fun player_metadata(arg0: &ConvenienceStore) : &0x2::table::Table<address, Metadata> {
        &arg0.player_metadata
    }

    public fun prize_pool_balance(arg0: &ConvenienceStore) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun public_key(arg0: &ConvenienceStore) : vector<u8> {
        arg0.public_key
    }

    public fun send_ticket(arg0: &StoreCap, arg1: address, arg2: &mut ConvenienceStore, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.tickets_issued + arg3 <= arg2.original_ticket_count, 2);
        arg2.tickets_issued = arg2.tickets_issued + arg3;
        let v0 = Ticket{
            id            : 0x2::object::new(arg4),
            player        : arg1,
            drawing_count : arg3,
        };
        0x2::transfer::public_transfer<Ticket>(v0, arg1);
    }

    public fun set_allow_evaluation(arg0: &StoreCap, arg1: &mut ConvenienceStore, arg2: bool) {
        arg1.allow_evaluation = arg2;
    }

    public fun set_public_key(arg0: &StoreCap, arg1: &mut ConvenienceStore, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun stock_store(arg0: SetUpCap, arg1: &mut ConvenienceStore, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 0);
        let SetUpCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        let v2 = 0x1::vector::empty<PrizeStruct>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < v0) {
            let v6 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v7 = 0x1::vector::pop_back<u64>(&mut arg4);
            let v8 = PrizeStruct{
                ticket_amount : v6,
                prize_value   : v7,
            };
            0x1::vector::push_back<PrizeStruct>(&mut v2, v8);
            v5 = v5 + v6 * v7;
            v4 = v4 + v6;
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v5, 3);
        arg1.winning_tickets = v2;
        arg1.original_ticket_count = v4;
        arg1.leaderboard.max_players = arg6;
        arg1.public_key = arg5;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun table_contains_player(arg0: &0x2::table::Table<address, Metadata>, arg1: address) : bool {
        0x2::table::contains<address, Metadata>(arg0, arg1)
    }

    public fun ticket_exists(arg0: &ConvenienceStore, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Ticket>(&arg0.id, arg1)
    }

    public fun tickets_claimed(arg0: &Metadata) : u64 {
        arg0.tickets_claimed
    }

    public fun tickets_issued(arg0: &ConvenienceStore) : u64 {
        arg0.tickets_issued
    }

    public fun tickets_left(arg0: &ConvenienceStore) : u64 {
        arg0.original_ticket_count - arg0.tickets_evaluated
    }

    public fun total_players(arg0: &ConvenienceStore) : u64 {
        0x2::table::length<address, Metadata>(&arg0.player_metadata)
    }

    fun update_leaderboard(arg0: &mut ConvenienceStore, arg1: address, arg2: u64, arg3: u64) {
        if (table_contains_player(&arg0.player_metadata, arg1)) {
            let v0 = &mut arg0.player_metadata;
            let v1 = get_player_metadata_mut(v0, arg1);
            v1.tickets_claimed = v1.tickets_claimed + arg2;
            v1.amount_won = v1.amount_won + arg3;
        } else {
            let v2 = Metadata{
                tickets_claimed : arg2,
                amount_won      : arg3,
            };
            0x2::table::add<address, Metadata>(&mut arg0.player_metadata, arg1, v2);
        };
        let v3 = false;
        let v4 = get_target_player_metadata(&arg0.player_metadata, arg1);
        if (table_contains_player(&arg0.leaderboard.leaderboard_player_metadata, arg1)) {
            0x2::table::remove<address, Metadata>(&mut arg0.leaderboard.leaderboard_player_metadata, arg1);
            0x2::table::add<address, Metadata>(&mut arg0.leaderboard.leaderboard_player_metadata, arg1, *v4);
        } else if (arg0.leaderboard.lowest_sui_won < v4.amount_won) {
            0x2::table::add<address, Metadata>(&mut arg0.leaderboard.leaderboard_player_metadata, arg1, *v4);
            v3 = true;
            0x1::vector::push_back<address>(&mut arg0.leaderboard.leaderboard_players, arg1);
        };
        if (0x2::table::length<address, Metadata>(&arg0.leaderboard.leaderboard_player_metadata) > arg0.leaderboard.max_players) {
            let v5 = 0;
            let v6 = 0x1::vector::borrow<address>(&arg0.leaderboard.leaderboard_players, v5);
            let v7 = 0x2::table::borrow<address, Metadata>(&arg0.leaderboard.leaderboard_player_metadata, *v6).amount_won;
            let v8 = *v6;
            let v9 = v5 + 1;
            while (v9 < arg0.leaderboard.max_players) {
                let v10 = 0x1::vector::borrow<address>(&arg0.leaderboard.leaderboard_players, v9);
                let v11 = 0x2::table::borrow<address, Metadata>(&arg0.leaderboard.leaderboard_player_metadata, *v10);
                if (v7 > v11.amount_won) {
                    v7 = v11.amount_won;
                    v8 = *v10;
                };
                v9 = v9 + 1;
            };
            0x1::vector::remove<address>(&mut arg0.leaderboard.leaderboard_players, 0);
            0x2::table::remove<address, Metadata>(&mut arg0.leaderboard.leaderboard_player_metadata, v8);
        };
        if (v3) {
            if (0x2::table::length<address, Metadata>(&arg0.leaderboard.leaderboard_player_metadata) == arg0.leaderboard.max_players) {
                let v12 = 0;
                let v13 = 0x2::table::borrow<address, Metadata>(&arg0.leaderboard.leaderboard_player_metadata, *0x1::vector::borrow<address>(&arg0.leaderboard.leaderboard_players, v12)).amount_won;
                let v14 = v12 + 1;
                while (v14 < arg0.leaderboard.max_players) {
                    let v15 = 0x2::table::borrow<address, Metadata>(&arg0.leaderboard.leaderboard_player_metadata, *0x1::vector::borrow<address>(&arg0.leaderboard.leaderboard_players, v14));
                    if (v13 > v15.amount_won) {
                        v13 = v15.amount_won;
                    };
                    v14 = v14 + 1;
                };
                arg0.leaderboard.lowest_sui_won = v13;
            };
        };
    }

    public fun winning_tickets(arg0: &ConvenienceStore) : &vector<PrizeStruct> {
        &arg0.winning_tickets
    }

    public fun withdraw_funds(arg0: &WithdrawCap, arg1: &mut ConvenienceStore, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.prize_pool, 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool), arg2)
    }

    // decompiled from Move bytecode v6
}

