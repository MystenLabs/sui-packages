module 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::table_anchor {
    struct StakesConfig has copy, drop, store {
        small_blind: u64,
        big_blind: u64,
        ante: u64,
        min_buy_in: u64,
        max_buy_in: u64,
        rake_bps: u16,
        rake_cap: u64,
        time_bank_ms: u64,
        time_bank_extra_ms: u64,
        max_rebuys_per_session: u8,
    }

    struct Seat has copy, drop, store {
        seat_idx: u8,
        seat_epoch: u64,
        player: address,
        account_id: 0x2::object::ID,
        initial_buy_in: u64,
        current_stack: u64,
        rebuys_used: u8,
        seated_at_ms: u64,
        sit_out: bool,
    }

    struct ClaimKey has copy, drop, store {
        seat_epoch: u64,
        player: address,
    }

    struct TableAnchor<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        stakes_config: StakesConfig,
        max_players: u8,
        status: u8,
        seats: vector<0x1::option::Option<Seat>>,
        seat_epoch_counter: u64,
        escrow_balance: 0x2::balance::Balance<T0>,
        rake_balance: 0x2::balance::Balance<T0>,
        claims: 0x2::table::Table<ClaimKey, u64>,
        active_hand: 0x1::option::Option<0x2::object::ID>,
        last_settled_hand: 0x1::option::Option<0x2::object::ID>,
        created_at_ms: u64,
    }

    struct TableCreated has copy, drop {
        table_id: 0x2::object::ID,
        creator: address,
        coin_type_tag: vector<u8>,
        stakes_config: StakesConfig,
        max_players: u8,
        created_at_ms: u64,
    }

    struct SeatTaken has copy, drop {
        table_id: 0x2::object::ID,
        seat_idx: u8,
        seat_epoch: u64,
        player: address,
        account_id: 0x2::object::ID,
        buy_in: u64,
        seated_at_ms: u64,
    }

    struct SeatVacated has copy, drop {
        table_id: 0x2::object::ID,
        seat_idx: u8,
        seat_epoch: u64,
        player: address,
        refund_amount: u64,
        vacated_at_ms: u64,
    }

    struct ClaimRecorded has copy, drop {
        table_id: 0x2::object::ID,
        seat_epoch: u64,
        player: address,
        amount: u64,
    }

    struct RebuyMade has copy, drop {
        table_id: 0x2::object::ID,
        seat_idx: u8,
        seat_epoch: u64,
        player: address,
        amount: u64,
        new_stack: u64,
        rebuys_used: u8,
        rebought_at_ms: u64,
    }

    struct FundsClaimed has copy, drop {
        table_id: 0x2::object::ID,
        seat_epoch: u64,
        player: address,
        amount: u64,
        claimed_at_ms: u64,
    }

    struct ActiveHandSet has copy, drop {
        table_id: 0x2::object::ID,
        hand_id: 0x2::object::ID,
    }

    struct ActiveHandCleared has copy, drop {
        table_id: 0x2::object::ID,
        hand_id: 0x2::object::ID,
    }

    struct RakeAccrued has copy, drop {
        table_id: 0x2::object::ID,
        amount: u64,
        new_rake: u64,
    }

    public(friend) fun accrue_rake<T0>(arg0: &mut TableAnchor<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.rake_balance, arg1);
        let v0 = RakeAccrued{
            table_id : 0x2::object::id<TableAnchor<T0>>(arg0),
            amount   : 0x2::balance::value<T0>(&arg1),
            new_rake : 0x2::balance::value<T0>(&arg0.rake_balance),
        };
        0x2::event::emit<RakeAccrued>(v0);
    }

    public fun active_hand<T0>(arg0: &TableAnchor<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.active_hand
    }

    public(friend) fun add_seat_for_via_core<T0>(arg0: &mut TableAnchor<T0>, arg1: &0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::PlayerAccount, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::owner(arg1) == v0, 410);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::is_active(arg1), 416);
        assert!((arg2 as u64) < (arg0.max_players as u64), 409);
        assert!(0x1::option::is_none<Seat>(0x1::vector::borrow<0x1::option::Option<Seat>>(&arg0.seats, (arg2 as u64))), 407);
        let v1 = &arg0.stakes_config;
        assert!(arg3 >= v1.min_buy_in && arg3 <= v1.max_buy_in, 406);
        arg0.seat_epoch_counter = arg0.seat_epoch_counter + 1;
        let v2 = arg0.seat_epoch_counter;
        let v3 = Seat{
            seat_idx       : arg2,
            seat_epoch     : v2,
            player         : v0,
            account_id     : 0x2::object::id<0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::PlayerAccount>(arg1),
            initial_buy_in : arg3,
            current_stack  : arg3,
            rebuys_used    : 0,
            seated_at_ms   : 0x2::clock::timestamp_ms(arg4),
            sit_out        : false,
        };
        *0x1::vector::borrow_mut<0x1::option::Option<Seat>>(&mut arg0.seats, (arg2 as u64)) = 0x1::option::some<Seat>(v3);
        let v4 = SeatTaken{
            table_id     : 0x2::object::id<TableAnchor<T0>>(arg0),
            seat_idx     : arg2,
            seat_epoch   : v2,
            player       : v0,
            account_id   : 0x2::object::id<0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::PlayerAccount>(arg1),
            buy_in       : arg3,
            seated_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SeatTaken>(v4);
    }

    public(friend) fun apply_seat_outcome<T0>(arg0: &mut TableAnchor<T0>, arg1: u8, arg2: u64, arg3: address, arg4: u64) {
        let v0 = (arg1 as u64);
        let v1 = false;
        if (v0 < 0x1::vector::length<0x1::option::Option<Seat>>(&arg0.seats)) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<Seat>>(&mut arg0.seats, v0);
            if (0x1::option::is_some<Seat>(v2)) {
                let v3 = 0x1::option::borrow_mut<Seat>(v2);
                if (v3.seat_epoch == arg2 && v3.player == arg3) {
                    v3.current_stack = arg4;
                } else {
                    v1 = true;
                };
            } else {
                v1 = true;
            };
        } else {
            v1 = true;
        };
        if (v1 && arg4 > 0) {
            record_claim<T0>(arg0, arg2, arg3, arg4);
        };
    }

    public(friend) fun assert_seat_matches<T0>(arg0: &TableAnchor<T0>, arg1: u8, arg2: u64, arg3: address, arg4: 0x2::object::ID) {
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<0x1::option::Option<Seat>>(&arg0.seats), 419);
        let v1 = 0x1::vector::borrow<0x1::option::Option<Seat>>(&arg0.seats, v0);
        assert!(0x1::option::is_some<Seat>(v1), 419);
        let v2 = 0x1::option::borrow<Seat>(v1);
        let v3 = if (v2.seat_epoch == arg2) {
            if (v2.player == arg3) {
                v2.account_id == arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 419);
    }

    public(friend) fun build_table_for_via_core<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u16, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : TableAnchor<T0> {
        assert!(arg0 > 0, 402);
        assert!(arg1 > arg0, 402);
        assert!(arg3 >= arg1 * 20, 406);
        assert!(arg4 >= arg3 && arg4 <= arg1 * 500, 406);
        assert!(arg5 <= 1000, 403);
        assert!(arg9 <= 10, 404);
        assert!(arg7 >= 5000 && arg7 <= 120000, 405);
        assert!(arg10 >= 2 && arg10 <= 9, 401);
        let v0 = StakesConfig{
            small_blind            : arg0,
            big_blind              : arg1,
            ante                   : arg2,
            min_buy_in             : arg3,
            max_buy_in             : arg4,
            rake_bps               : arg5,
            rake_cap               : arg6,
            time_bank_ms           : arg7,
            time_bank_extra_ms     : arg8,
            max_rebuys_per_session : arg9,
        };
        let v1 = 0x1::vector::empty<0x1::option::Option<Seat>>();
        let v2 = 0;
        while (v2 < arg10) {
            0x1::vector::push_back<0x1::option::Option<Seat>>(&mut v1, 0x1::option::none<Seat>());
            v2 = v2 + 1;
        };
        let v3 = 0x2::clock::timestamp_ms(arg12);
        let v4 = 0x2::tx_context::sender(arg13);
        let v5 = TableAnchor<T0>{
            id                 : 0x2::object::new(arg13),
            creator            : v4,
            stakes_config      : v0,
            max_players        : arg10,
            status             : 1,
            seats              : v1,
            seat_epoch_counter : 0,
            escrow_balance     : 0x2::balance::zero<T0>(),
            rake_balance       : 0x2::balance::zero<T0>(),
            claims             : 0x2::table::new<ClaimKey, u64>(arg13),
            active_hand        : 0x1::option::none<0x2::object::ID>(),
            last_settled_hand  : 0x1::option::none<0x2::object::ID>(),
            created_at_ms      : v3,
        };
        let v6 = TableCreated{
            table_id      : 0x2::object::id<TableAnchor<T0>>(&v5),
            creator       : v4,
            coin_type_tag : arg11,
            stakes_config : v5.stakes_config,
            max_players   : arg10,
            created_at_ms : v3,
        };
        0x2::event::emit<TableCreated>(v6);
        v5
    }

    public fun claim_amount<T0>(arg0: &TableAnchor<T0>, arg1: u64, arg2: address) : u64 {
        let v0 = ClaimKey{
            seat_epoch : arg1,
            player     : arg2,
        };
        if (0x2::table::contains<ClaimKey, u64>(&arg0.claims, v0)) {
            *0x2::table::borrow<ClaimKey, u64>(&arg0.claims, v0)
        } else {
            0
        }
    }

    public fun claim_funds<T0>(arg0: &mut TableAnchor<T0>, arg1: &mut 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::TreasuryVault<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::owner<T0>(arg1) == v0, 415);
        let v1 = ClaimKey{
            seat_epoch : arg2,
            player     : v0,
        };
        assert!(0x2::table::contains<ClaimKey, u64>(&arg0.claims, v1), 414);
        let v2 = 0x2::table::remove<ClaimKey, u64>(&mut arg0.claims, v1);
        0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::deposit_balance<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.escrow_balance, v2));
        let v3 = FundsClaimed{
            table_id      : 0x2::object::id<TableAnchor<T0>>(arg0),
            seat_epoch    : arg2,
            player        : v0,
            amount        : v2,
            claimed_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FundsClaimed>(v3);
    }

    public fun claim_key_epoch(arg0: &ClaimKey) : u64 {
        arg0.seat_epoch
    }

    public fun claim_key_player(arg0: &ClaimKey) : address {
        arg0.player
    }

    public(friend) fun clear_active_hand<T0>(arg0: &mut TableAnchor<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.active_hand), 412);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.active_hand) == arg1, 413);
        arg0.active_hand = 0x1::option::none<0x2::object::ID>();
        arg0.last_settled_hand = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = ActiveHandCleared{
            table_id : 0x2::object::id<TableAnchor<T0>>(arg0),
            hand_id  : arg1,
        };
        0x2::event::emit<ActiveHandCleared>(v0);
    }

    public fun create_table<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u16, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        share_table_for_via_core<T0>(build_table_for_via_core<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13));
    }

    public fun creator<T0>(arg0: &TableAnchor<T0>) : address {
        arg0.creator
    }

    public fun escrow_value<T0>(arg0: &TableAnchor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow_balance)
    }

    public(friend) fun extract_all_rake_for_sweep<T0>(arg0: &mut TableAnchor<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.rake_balance, 0x2::balance::value<T0>(&arg0.rake_balance))
    }

    public(friend) fun extract_rake_for_sweep<T0>(arg0: &mut TableAnchor<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.rake_balance, arg1)
    }

    public fun join_table<T0>(arg0: &mut TableAnchor<T0>, arg1: &0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::PlayerAccount, arg2: &mut 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::TreasuryVault<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::owner(arg1) == v0, 410);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::is_active(arg1), 416);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::owner<T0>(arg2) == v0, 415);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::account_id<T0>(arg2) == 0x2::object::id<0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::PlayerAccount>(arg1), 417);
        assert!((arg3 as u64) < (arg0.max_players as u64), 409);
        assert!(0x1::option::is_none<Seat>(0x1::vector::borrow<0x1::option::Option<Seat>>(&arg0.seats, (arg3 as u64))), 407);
        let v1 = &arg0.stakes_config;
        assert!(arg4 >= v1.min_buy_in && arg4 <= v1.max_buy_in, 406);
        let v2 = 0x2::object::id<TableAnchor<T0>>(arg0);
        0x2::balance::join<T0>(&mut arg0.escrow_balance, 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::extract_for_join<T0>(arg2, arg4, v2));
        arg0.seat_epoch_counter = arg0.seat_epoch_counter + 1;
        let v3 = arg0.seat_epoch_counter;
        let v4 = Seat{
            seat_idx       : arg3,
            seat_epoch     : v3,
            player         : v0,
            account_id     : 0x2::object::id<0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::PlayerAccount>(arg1),
            initial_buy_in : arg4,
            current_stack  : arg4,
            rebuys_used    : 0,
            seated_at_ms   : 0x2::clock::timestamp_ms(arg5),
            sit_out        : false,
        };
        *0x1::vector::borrow_mut<0x1::option::Option<Seat>>(&mut arg0.seats, (arg3 as u64)) = 0x1::option::some<Seat>(v4);
        let v5 = SeatTaken{
            table_id     : v2,
            seat_idx     : arg3,
            seat_epoch   : v3,
            player       : v0,
            account_id   : 0x2::object::id<0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::player_account::PlayerAccount>(arg1),
            buy_in       : arg4,
            seated_at_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SeatTaken>(v5);
    }

    public fun leave_table<T0>(arg0: &mut TableAnchor<T0>, arg1: &mut 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::TreasuryVault<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::owner<T0>(arg1) == v0, 415);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_hand), 411);
        assert!((arg2 as u64) < (arg0.max_players as u64), 409);
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<Seat>>(&mut arg0.seats, (arg2 as u64));
        assert!(0x1::option::is_some<Seat>(v1), 408);
        let v2 = 0x1::option::extract<Seat>(v1);
        assert!(v2.player == v0, 410);
        let v3 = v2.current_stack;
        if (v3 > 0) {
            0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::deposit_balance<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.escrow_balance, v3));
        };
        let v4 = SeatVacated{
            table_id      : 0x2::object::id<TableAnchor<T0>>(arg0),
            seat_idx      : arg2,
            seat_epoch    : v2.seat_epoch,
            player        : v0,
            refund_amount : v3,
            vacated_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SeatVacated>(v4);
    }

    public(friend) fun mark_active_hand<T0>(arg0: &mut TableAnchor<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_hand), 411);
        arg0.active_hand = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = ActiveHandSet{
            table_id : 0x2::object::id<TableAnchor<T0>>(arg0),
            hand_id  : arg1,
        };
        0x2::event::emit<ActiveHandSet>(v0);
    }

    public fun max_players<T0>(arg0: &TableAnchor<T0>) : u8 {
        arg0.max_players
    }

    public fun rake_value<T0>(arg0: &TableAnchor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rake_balance)
    }

    public fun rebuy<T0>(arg0: &mut TableAnchor<T0>, arg1: &mut 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::TreasuryVault<T0>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::owner<T0>(arg1) == v0, 415);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_hand), 411);
        assert!((arg2 as u64) < (arg0.max_players as u64), 409);
        assert!(arg3 > 0, 406);
        let v1 = 0x2::object::id<TableAnchor<T0>>(arg0);
        let v2 = &arg0.stakes_config;
        let v3 = v2.max_buy_in;
        let v4 = v2.max_rebuys_per_session;
        let v5 = 0x1::vector::borrow_mut<0x1::option::Option<Seat>>(&mut arg0.seats, (arg2 as u64));
        assert!(0x1::option::is_some<Seat>(v5), 408);
        let v6 = 0x1::option::borrow_mut<Seat>(v5);
        assert!(v6.player == v0, 410);
        assert!(0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::account_id<T0>(arg1) == v6.account_id, 417);
        assert!(v6.rebuys_used < v4, 404);
        assert!(v6.current_stack + arg3 <= v3, 406);
        0x2::balance::join<T0>(&mut arg0.escrow_balance, 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::treasury_vault::extract_for_join<T0>(arg1, arg3, v1));
        v6.current_stack = v6.current_stack + arg3;
        v6.rebuys_used = v6.rebuys_used + 1;
        let v7 = RebuyMade{
            table_id       : v1,
            seat_idx       : arg2,
            seat_epoch     : v6.seat_epoch,
            player         : v0,
            amount         : arg3,
            new_stack      : v6.current_stack,
            rebuys_used    : v6.rebuys_used,
            rebought_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RebuyMade>(v7);
    }

    public(friend) fun record_claim<T0>(arg0: &mut TableAnchor<T0>, arg1: u64, arg2: address, arg3: u64) {
        let v0 = ClaimKey{
            seat_epoch : arg1,
            player     : arg2,
        };
        if (0x2::table::contains<ClaimKey, u64>(&arg0.claims, v0)) {
            let v1 = 0x2::table::borrow_mut<ClaimKey, u64>(&mut arg0.claims, v0);
            *v1 = *v1 + arg3;
        } else {
            0x2::table::add<ClaimKey, u64>(&mut arg0.claims, v0, arg3);
        };
        let v2 = ClaimRecorded{
            table_id   : 0x2::object::id<TableAnchor<T0>>(arg0),
            seat_epoch : arg1,
            player     : arg2,
            amount     : arg3,
        };
        0x2::event::emit<ClaimRecorded>(v2);
    }

    public(friend) fun remove_seat_for_via_core<T0>(arg0: &mut TableAnchor<T0>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_hand), 411);
        assert!((arg1 as u64) < (arg0.max_players as u64), 409);
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<Seat>>(&mut arg0.seats, (arg1 as u64));
        assert!(0x1::option::is_some<Seat>(v1), 408);
        let v2 = 0x1::option::extract<Seat>(v1);
        assert!(v2.player == v0, 410);
        let v3 = v2.current_stack;
        let v4 = SeatVacated{
            table_id      : 0x2::object::id<TableAnchor<T0>>(arg0),
            seat_idx      : arg1,
            seat_epoch    : v2.seat_epoch,
            player        : v0,
            refund_amount : v3,
            vacated_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SeatVacated>(v4);
        v3
    }

    public fun seat_account_id(arg0: &Seat) : 0x2::object::ID {
        arg0.account_id
    }

    public fun seat_at<T0>(arg0: &TableAnchor<T0>, arg1: u8) : &0x1::option::Option<Seat> {
        0x1::vector::borrow<0x1::option::Option<Seat>>(&arg0.seats, (arg1 as u64))
    }

    public fun seat_count_occupied<T0>(arg0: &TableAnchor<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<Seat>>(&arg0.seats)) {
            if (0x1::option::is_some<Seat>(0x1::vector::borrow<0x1::option::Option<Seat>>(&arg0.seats, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun seat_current_stack<T0>(arg0: &TableAnchor<T0>, arg1: u8) : u64 {
        let v0 = 0x1::vector::borrow<0x1::option::Option<Seat>>(&arg0.seats, (arg1 as u64));
        if (0x1::option::is_some<Seat>(v0)) {
            0x1::option::borrow<Seat>(v0).current_stack
        } else {
            0
        }
    }

    public fun seat_current_stack_view(arg0: &Seat) : u64 {
        arg0.current_stack
    }

    public fun seat_epoch(arg0: &Seat) : u64 {
        arg0.seat_epoch
    }

    public fun seat_epoch_counter<T0>(arg0: &TableAnchor<T0>) : u64 {
        arg0.seat_epoch_counter
    }

    public fun seat_idx(arg0: &Seat) : u8 {
        arg0.seat_idx
    }

    public fun seat_initial_buy_in(arg0: &Seat) : u64 {
        arg0.initial_buy_in
    }

    public fun seat_player(arg0: &Seat) : address {
        arg0.player
    }

    public fun seat_rebuys_used(arg0: &Seat) : u8 {
        arg0.rebuys_used
    }

    public fun seat_sit_out(arg0: &Seat) : bool {
        arg0.sit_out
    }

    public(friend) fun share_table_for_via_core<T0>(arg0: TableAnchor<T0>) {
        0x2::transfer::share_object<TableAnchor<T0>>(arg0);
    }

    public fun stakes_ante(arg0: &StakesConfig) : u64 {
        arg0.ante
    }

    public fun stakes_bb(arg0: &StakesConfig) : u64 {
        arg0.big_blind
    }

    public fun stakes_config<T0>(arg0: &TableAnchor<T0>) : &StakesConfig {
        &arg0.stakes_config
    }

    public fun stakes_max_buy_in(arg0: &StakesConfig) : u64 {
        arg0.max_buy_in
    }

    public fun stakes_max_rebuys(arg0: &StakesConfig) : u8 {
        arg0.max_rebuys_per_session
    }

    public fun stakes_min_buy_in(arg0: &StakesConfig) : u64 {
        arg0.min_buy_in
    }

    public fun stakes_rake_bps(arg0: &StakesConfig) : u16 {
        arg0.rake_bps
    }

    public fun stakes_rake_cap(arg0: &StakesConfig) : u64 {
        arg0.rake_cap
    }

    public fun stakes_sb(arg0: &StakesConfig) : u64 {
        arg0.small_blind
    }

    public fun stakes_time_bank_ms(arg0: &StakesConfig) : u64 {
        arg0.time_bank_ms
    }

    public fun status<T0>(arg0: &TableAnchor<T0>) : u8 {
        arg0.status
    }

    public(friend) fun take_from_escrow<T0>(arg0: &mut TableAnchor<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.escrow_balance, arg1)
    }

    // decompiled from Move bytecode v7
}

