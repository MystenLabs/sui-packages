module 0xa27b92a8ba45011baf32f50d80951edadc7adedd34fbeb4c93d4145ee09a8bd4::bettr {
    struct BETTR has drop {
        dummy_field: bool,
    }

    struct PlayerRegistry has key {
        id: 0x2::object::UID,
        players: 0x2::table::Table<address, Player>,
    }

    struct Player has store {
        bets: 0x2::table::Table<0x2::object::ID, Role>,
    }

    struct Role has copy, drop, store {
        creator: bool,
        judge: bool,
        invited: bool,
        bettor: bool,
    }

    struct PublicBetCreated has copy, drop {
        bet_id: 0x2::object::ID,
        creator: address,
    }

    struct PrivateBetCreated has copy, drop {
        bet_id: 0x2::object::ID,
        creator: address,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        encryption_nonce: vector<u8>,
        encrypted_title: vector<u8>,
        encrypted_description: vector<u8>,
        encrypted_option_a: vector<u8>,
        encrypted_option_b: vector<u8>,
        allowed_players: vector<address>,
        judges: vector<address>,
        quorum: u64,
        bet_price: u64,
        closing_time_ms: 0x1::option::Option<u64>,
        expiration_ms: u64,
        created_at_ms: u64,
        last_modified_at_ms: u64,
        bets_on_a: 0x2::vec_map::VecMap<address, u64>,
        bets_on_b: 0x2::vec_map::VecMap<address, u64>,
        total_bets_on_a: u64,
        total_bets_on_b: u64,
        total_pool: 0x2::balance::Balance<T0>,
        votes: 0x2::vec_map::VecMap<address, bool>,
        votes_for_a: u64,
        votes_for_b: u64,
        resolved: bool,
        winning_option: 0x1::option::Option<bool>,
    }

    public fun allowed_players<T0>(arg0: &Bet<T0>) : &vector<address> {
        &arg0.allowed_players
    }

    public fun bet_price<T0>(arg0: &Bet<T0>) : u64 {
        arg0.bet_price
    }

    public fun cancel<T0>(arg0: Bet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Bet {
            id                    : v0,
            creator               : v1,
            encryption_nonce      : _,
            encrypted_title       : _,
            encrypted_description : _,
            encrypted_option_a    : _,
            encrypted_option_b    : _,
            allowed_players       : _,
            judges                : _,
            quorum                : _,
            bet_price             : _,
            closing_time_ms       : _,
            expiration_ms         : _,
            created_at_ms         : _,
            last_modified_at_ms   : _,
            bets_on_a             : v15,
            bets_on_b             : v16,
            total_bets_on_a       : v17,
            total_bets_on_b       : v18,
            total_pool            : v19,
            votes                 : _,
            votes_for_a           : _,
            votes_for_b           : _,
            resolved              : _,
            winning_option        : _,
        } = arg0;
        assert!(0x2::tx_context::sender(arg1) == v1, 11);
        assert!(v17 == 0 && v18 == 0, 12);
        0x2::balance::destroy_zero<T0>(v19);
        0x2::vec_map::destroy_empty<address, u64>(v15);
        0x2::vec_map::destroy_empty<address, u64>(v16);
        0x2::object::delete(v0);
    }

    public fun cleanup_expired<T0>(arg0: &mut Bet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.expiration_ms, 13);
        assert!(!arg0.resolved, 10);
        arg0.resolved = true;
        let v0 = 0x2::tx_context::sender(arg2);
        refund_all<T0>(arg0, v0, arg2);
        arg0.last_modified_at_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun closing_time_ms<T0>(arg0: &Bet<T0>) : 0x1::option::Option<u64> {
        arg0.closing_time_ms
    }

    fun compute_key_id(arg0: address, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        v0
    }

    public fun create<T0>(arg0: &mut PlayerRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<address>, arg7: vector<address>, arg8: u64, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : Bet<T0> {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 16);
        assert!(arg9 > 0, 1);
        assert!(arg8 > 0 && arg8 <= 0x1::vector::length<address>(&arg7), 0);
        assert!(arg11 > 0x2::clock::timestamp_ms(arg12), 2);
        if (0x1::option::is_some<u64>(&arg10)) {
            assert!(*0x1::option::borrow<u64>(&arg10) < arg11, 3);
        };
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = Bet<T0>{
            id                    : 0x2::object::new(arg13),
            creator               : 0x2::tx_context::sender(arg13),
            encryption_nonce      : arg1,
            encrypted_title       : arg2,
            encrypted_description : arg3,
            encrypted_option_a    : arg4,
            encrypted_option_b    : arg5,
            allowed_players       : arg6,
            judges                : arg7,
            quorum                : arg8,
            bet_price             : arg9,
            closing_time_ms       : arg10,
            expiration_ms         : arg11,
            created_at_ms         : v0,
            last_modified_at_ms   : v0,
            bets_on_a             : 0x2::vec_map::empty<address, u64>(),
            bets_on_b             : 0x2::vec_map::empty<address, u64>(),
            total_bets_on_a       : 0,
            total_bets_on_b       : 0,
            total_pool            : 0x2::balance::zero<T0>(),
            votes                 : 0x2::vec_map::empty<address, bool>(),
            votes_for_a           : 0,
            votes_for_b           : 0,
            resolved              : false,
            winning_option        : 0x1::option::none<bool>(),
        };
        let v2 = 0x2::object::id<Bet<T0>>(&v1);
        let v3 = 0x2::tx_context::sender(arg13);
        update_role(arg0, v3, v2, true, false, false, false, arg13);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v1.judges)) {
            update_role(arg0, *0x1::vector::borrow<address>(&v1.judges, v4), v2, false, true, false, false, arg13);
            v4 = v4 + 1;
        };
        if (!0x1::vector::is_empty<address>(&v1.allowed_players)) {
            let v5 = 0;
            while (v5 < 0x1::vector::length<address>(&v1.allowed_players)) {
                update_role(arg0, *0x1::vector::borrow<address>(&v1.allowed_players, v5), v2, false, false, true, false, arg13);
                v5 = v5 + 1;
            };
            let v6 = PrivateBetCreated{
                bet_id  : v2,
                creator : v3,
            };
            0x2::event::emit<PrivateBetCreated>(v6);
        } else {
            let v7 = PublicBetCreated{
                bet_id  : v2,
                creator : v3,
            };
            0x2::event::emit<PublicBetCreated>(v7);
        };
        v1
    }

    public fun create_player_decided<T0>(arg0: &mut PlayerRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<address>, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : Bet<T0> {
        assert!(0x1::vector::length<address>(&arg6) >= 2, 18);
        create<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg6, 0x1::vector::length<address>(&arg6) / 2 + 1, arg7, arg8, arg9, arg10, arg11)
    }

    public fun created_at_ms<T0>(arg0: &Bet<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Bet<T0>) : address {
        arg0.creator
    }

    fun ensure_player(arg0: &mut PlayerRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, Player>(&arg0.players, arg1)) {
            let v0 = Player{bets: 0x2::table::new<0x2::object::ID, Role>(arg2)};
            0x2::table::add<address, Player>(&mut arg0.players, arg1, v0);
        };
    }

    public fun expiration_ms<T0>(arg0: &Bet<T0>) : u64 {
        arg0.expiration_ms
    }

    fun get_or_create_role(arg0: &mut Player, arg1: 0x2::object::ID) : &mut Role {
        if (!0x2::table::contains<0x2::object::ID, Role>(&arg0.bets, arg1)) {
            let v0 = Role{
                creator : false,
                judge   : false,
                invited : false,
                bettor  : false,
            };
            0x2::table::add<0x2::object::ID, Role>(&mut arg0.bets, arg1, v0);
        };
        0x2::table::borrow_mut<0x2::object::ID, Role>(&mut arg0.bets, arg1)
    }

    public fun has_voted<T0>(arg0: &Bet<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, bool>(&arg0.votes, &arg1)
    }

    fun init(arg0: BETTR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::types::is_one_time_witness<BETTR>(&arg0);
        let v0 = PlayerRegistry{
            id      : 0x2::object::new(arg1),
            players : 0x2::table::new<address, Player>(arg1),
        };
        0x2::transfer::share_object<PlayerRegistry>(v0);
    }

    public fun is_open_access<T0>(arg0: &Bet<T0>) : bool {
        0x1::vector::is_empty<address>(&arg0.allowed_players)
    }

    public fun is_resolved<T0>(arg0: &Bet<T0>) : bool {
        arg0.resolved
    }

    public fun judge_vote<T0>(arg0: &Bet<T0>, arg1: address) : 0x1::option::Option<bool> {
        if (0x2::vec_map::contains<address, bool>(&arg0.votes, &arg1)) {
            0x1::option::some<bool>(*0x2::vec_map::get<address, bool>(&arg0.votes, &arg1))
        } else {
            0x1::option::none<bool>()
        }
    }

    public fun judges<T0>(arg0: &Bet<T0>) : &vector<address> {
        &arg0.judges
    }

    public fun last_modified_at_ms<T0>(arg0: &Bet<T0>) : u64 {
        arg0.last_modified_at_ms
    }

    public fun place_bet<T0>(arg0: &mut PlayerRegistry, arg1: &mut Bet<T0>, arg2: bool, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(!arg1.resolved, 10);
        assert!(v1 <= arg1.expiration_ms, 7);
        if (0x1::option::is_some<u64>(&arg1.closing_time_ms)) {
            assert!(v1 <= *0x1::option::borrow<u64>(&arg1.closing_time_ms), 6);
        };
        if (!0x1::vector::is_empty<address>(&arg1.allowed_players)) {
            assert!(0x1::vector::contains<address>(&arg1.allowed_players, &v0), 4);
        };
        assert!(arg3 >= 1, 17);
        assert!(0x2::coin::value<T0>(&arg4) == arg1.bet_price * arg3, 5);
        if (arg2) {
            if (0x2::vec_map::contains<address, u64>(&arg1.bets_on_a, &v0)) {
                *0x2::vec_map::get_mut<address, u64>(&mut arg1.bets_on_a, &v0) = *0x2::vec_map::get<address, u64>(&arg1.bets_on_a, &v0) + arg3;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg1.bets_on_a, v0, arg3);
            };
            arg1.total_bets_on_a = arg1.total_bets_on_a + arg3;
        } else {
            if (0x2::vec_map::contains<address, u64>(&arg1.bets_on_b, &v0)) {
                *0x2::vec_map::get_mut<address, u64>(&mut arg1.bets_on_b, &v0) = *0x2::vec_map::get<address, u64>(&arg1.bets_on_b, &v0) + arg3;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg1.bets_on_b, v0, arg3);
            };
            arg1.total_bets_on_b = arg1.total_bets_on_b + arg3;
        };
        0x2::balance::join<T0>(&mut arg1.total_pool, 0x2::coin::into_balance<T0>(arg4));
        arg1.last_modified_at_ms = v1;
        update_role(arg0, v0, 0x2::object::id<Bet<T0>>(arg1), false, false, false, true, arg6);
    }

    public fun player_bets_on_a<T0>(arg0: &Bet<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.bets_on_a, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.bets_on_a, &arg1)
        } else {
            0
        }
    }

    public fun player_bets_on_b<T0>(arg0: &Bet<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.bets_on_b, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.bets_on_b, &arg1)
        } else {
            0
        }
    }

    public fun quorum<T0>(arg0: &Bet<T0>) : u64 {
        arg0.quorum
    }

    fun refund_all<T0>(arg0: &mut Bet<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.bets_on_a;
        let v1 = &mut arg0.total_pool;
        refund_bets<T0>(v0, arg0.bet_price, v1, arg2);
        let v2 = &mut arg0.bets_on_b;
        let v3 = &mut arg0.total_pool;
        refund_bets<T0>(v2, arg0.bet_price, v3, arg2);
        let v4 = 0x2::balance::value<T0>(&arg0.total_pool);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_pool, v4), arg2), arg1);
        };
    }

    fun refund_bets<T0>(arg0: &mut 0x2::vec_map::VecMap<address, u64>, arg1: u64, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x2::vec_map::is_empty<address, u64>(arg0)) {
            let (v0, v1) = 0x2::vec_map::pop<address, u64>(arg0);
            let v2 = v1 * arg1;
            if (0x2::balance::value<T0>(arg2) >= v2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg2, v2), arg3), v0);
            };
        };
    }

    fun resolve_and_distribute<T0>(arg0: &mut Bet<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.resolved = true;
        arg0.winning_option = 0x1::option::some<bool>(arg1);
        let v0 = 0x2::balance::value<T0>(&arg0.total_pool);
        if (v0 == 0) {
            return
        };
        let (v1, v2) = if (arg1) {
            let v2 = arg0.total_bets_on_a;
            let v1 = &arg0.bets_on_a;
            (v1, v2)
        } else {
            let v2 = arg0.total_bets_on_b;
            let v1 = &arg0.bets_on_b;
            (v1, v2)
        };
        if (v2 == 0) {
            let v3 = 0x2::tx_context::sender(arg2);
            refund_all<T0>(arg0, v3, arg2);
            return
        };
        let v4 = 0x2::vec_map::length<address, u64>(v1);
        let v5 = 0;
        while (v5 < v4) {
            let (v6, v7) = 0x2::vec_map::get_entry_by_idx<address, u64>(v1, v5);
            let v8 = *v7 * v0 / v2;
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_pool, v8), arg2), *v6);
            };
            v5 = v5 + 1;
        };
        let v9 = 0x2::balance::value<T0>(&arg0.total_pool);
        if (v9 > 0 && v4 > 0) {
            let (v10, _) = 0x2::vec_map::get_entry_by_idx<address, u64>(v1, v4 - 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_pool, v9), arg2), *v10);
        };
    }

    entry fun seal_approve<T0>(arg0: vector<u8>, arg1: &Bet<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == compute_key_id(arg1.creator, &arg1.encryption_nonce), 15);
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x1::vector::is_empty<address>(&arg1.allowed_players)) {
            return
        };
        assert!(0x1::vector::contains<address>(&arg1.allowed_players, &v0) || 0x1::vector::contains<address>(&arg1.judges, &v0), 14);
    }

    public fun total_bets_on_a<T0>(arg0: &Bet<T0>) : u64 {
        arg0.total_bets_on_a
    }

    public fun total_bets_on_b<T0>(arg0: &Bet<T0>) : u64 {
        arg0.total_bets_on_b
    }

    public fun total_pool_value<T0>(arg0: &Bet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_pool)
    }

    fun update_role(arg0: &mut PlayerRegistry, arg1: address, arg2: 0x2::object::ID, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_player(arg0, arg1, arg7);
        let v0 = 0x2::table::borrow_mut<address, Player>(&mut arg0.players, arg1);
        let v1 = get_or_create_role(v0, arg2);
        if (arg3) {
            v1.creator = true;
        };
        if (arg4) {
            v1.judge = true;
        };
        if (arg5) {
            v1.invited = true;
        };
        if (arg6) {
            v1.bettor = true;
        };
    }

    public fun vote<T0>(arg0: &mut PlayerRegistry, arg1: &mut Bet<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(!arg1.resolved, 10);
        assert!(v1 <= arg1.expiration_ms, 7);
        assert!(0x1::vector::contains<address>(&arg1.judges, &v0), 8);
        assert!(!0x2::vec_map::contains<address, bool>(&arg1.votes, &v0), 9);
        0x2::vec_map::insert<address, bool>(&mut arg1.votes, v0, arg2);
        if (arg2) {
            arg1.votes_for_a = arg1.votes_for_a + 1;
        } else {
            arg1.votes_for_b = arg1.votes_for_b + 1;
        };
        arg1.last_modified_at_ms = v1;
        if (arg1.votes_for_a >= arg1.quorum) {
            resolve_and_distribute<T0>(arg1, true, arg4);
        } else if (arg1.votes_for_b >= arg1.quorum) {
            resolve_and_distribute<T0>(arg1, false, arg4);
        };
    }

    public fun votes_for_a<T0>(arg0: &Bet<T0>) : u64 {
        arg0.votes_for_a
    }

    public fun votes_for_b<T0>(arg0: &Bet<T0>) : u64 {
        arg0.votes_for_b
    }

    public fun winning_option<T0>(arg0: &Bet<T0>) : 0x1::option::Option<bool> {
        arg0.winning_option
    }

    // decompiled from Move bytecode v6
}

