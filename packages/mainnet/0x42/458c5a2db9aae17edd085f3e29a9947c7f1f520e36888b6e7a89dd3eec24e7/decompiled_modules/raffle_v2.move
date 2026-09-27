module 0x42458c5a2db9aae17edd085f3e29a9947c7f1f520e36888b6e7a89dd3eec24e7::raffle_v2 {
    struct RaffleV2 has drop {
        dummy_field: bool,
    }

    struct RaffleConfig has key {
        id: 0x2::object::UID,
        config_version: u64,
        min_entry: u64,
        limit_updates_renounced: bool,
    }

    struct LimitUpdatesRenounced has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        min_entry: u64,
    }

    struct MinEntryUpdated has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        previous_min_entry: u64,
        new_min_entry: u64,
        config_version: u64,
    }

    struct RaffleRegistry has key {
        id: 0x2::object::UID,
        next_round_id: u64,
        current_open_round_id: u64,
        has_open_round: bool,
    }

    struct Entry has copy, drop, store {
        owner: address,
        amount: u64,
        cumulative_end: u64,
    }

    struct RaffleRoundV2 has key {
        id: 0x2::object::UID,
        round_id: u64,
        version: u64,
        config_version: u64,
        status: u8,
        start_ms: u64,
        close_ms: u64,
        max_close_ms: u64,
        user_pool: u64,
        reserve_match: u64,
        user_custody: 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>,
        reserve_custody: 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>,
        entry_count: u64,
        current_window_baseline_user_pool: u64,
        entries: 0x2::table::Table<u64, vector<Entry>>,
        num_buckets: u64,
        bucket_ends: vector<u64>,
        bucket_capacity: u64,
        max_buckets: u64,
        winner_index: u64,
        winner_set: bool,
        winner: address,
        winner_cap_supply_snapshot: u64,
        winner_payout_cap_snapshot: u64,
        winner_cap_snapshot_set: bool,
        paid: bool,
        settled_at_ms: u64,
        min_entry_snapshot: u64,
    }

    struct RoundCreated has copy, drop {
        round_object_id: 0x2::object::ID,
        round_id: u64,
        creator: address,
        first_entry_amount: u64,
        start_ms: u64,
        close_ms: u64,
        max_close_ms: u64,
        config_version: u64,
    }

    struct RaffleEntryCreated has copy, drop {
        round_object_id: 0x2::object::ID,
        round_id: u64,
        entrant: address,
        amount: u64,
        range_start: u64,
        range_end: u64,
        bucket_index: u64,
        user_pool_after: u64,
        reserve_match_added: u64,
        close_ms: u64,
        entry_count: u64,
    }

    struct RoundSettled has copy, drop {
        round_object_id: 0x2::object::ID,
        round_id: u64,
        winner_index: u64,
        user_pool: u64,
        reserve_match: u64,
        gross_prize: u64,
        winner_cap_supply_snapshot: u64,
        winner_payout_cap_snapshot: u64,
        settled_at_ms: u64,
    }

    struct WinnerPaid has copy, drop {
        round_object_id: 0x2::object::ID,
        round_id: u64,
        winner: address,
        winner_index: u64,
        winner_entry_amount: u64,
        gross_prize: u64,
        fee_amount: u64,
        winner_payout: u64,
        cap_excess_to_reserve: u64,
    }

    struct RoundPruned has copy, drop {
        round_object_id: 0x2::object::ID,
        round_id: u64,
        pruned_by: address,
        buckets_removed: u64,
        buckets_remaining: u64,
    }

    struct RoundDestroyed has copy, drop {
        round_object_id: 0x2::object::ID,
        round_id: u64,
        destroyed_by: address,
    }

    public fun admin_renounce_limit_updates(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut RaffleConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 16);
        assert!(arg1.min_entry >= 100000000, 17);
        arg1.limit_updates_renounced = true;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitUpdatesRenounced{
            config_id : 0x2::object::id<RaffleConfig>(arg1),
            admin     : 0x2::tx_context::sender(arg2),
            min_entry : arg1.min_entry,
        };
        0x2::event::emit<LimitUpdatesRenounced>(v0);
    }

    fun assert_active_round(arg0: &RaffleRegistry, arg1: &RaffleRoundV2) {
        assert!(arg0.has_open_round && arg0.current_open_round_id == arg1.round_id, 12);
    }

    fun assert_settleable(arg0: &RaffleRegistry, arg1: &RaffleRoundV2, arg2: u64) {
        assert_active_round(arg0, arg1);
        assert!(arg1.status == 0, 5);
        assert!(!arg1.winner_set, 11);
        assert!(arg1.user_pool > 0, 10);
        assert!(arg2 >= arg1.close_ms, 3);
    }

    fun calculate_fee_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::bps_denominator() as u128)) as u64)
    }

    fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 20);
        (v0 as u64)
    }

    fun clear_active_round(arg0: &mut RaffleRegistry, arg1: &RaffleRoundV2) {
        assert_active_round(arg0, arg1);
        arg0.current_open_round_id = 0;
        arg0.has_open_round = false;
    }

    public fun config_version(arg0: &RaffleConfig) : u64 {
        arg0.config_version
    }

    public(friend) entry fun create_round_and_enter_first_shared_v2(arg0: &mut RaffleRegistry, arg1: &RaffleConfig, arg2: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RaffleRoundV2>(create_round_and_enter_first_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public(friend) fun create_round_and_enter_first_v2(arg0: &mut RaffleRegistry, arg1: &RaffleConfig, arg2: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg6: &mut 0x2::tx_context::TxContext) : RaffleRoundV2 {
        let v0 = create_round_v2(arg0, arg1, arg2, arg6);
        let v1 = &mut v0;
        enter_raffle_v2(v1, arg2, arg3, arg4, arg5, arg6);
        let v2 = RoundCreated{
            round_object_id    : 0x2::object::id<RaffleRoundV2>(&v0),
            round_id           : v0.round_id,
            creator            : 0x2::tx_context::sender(arg6),
            first_entry_amount : 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5),
            start_ms           : v0.start_ms,
            close_ms           : v0.close_ms,
            max_close_ms       : v0.max_close_ms,
            config_version     : v0.config_version,
        };
        0x2::event::emit<RoundCreated>(v2);
        v0
    }

    public(friend) fun create_round_v2(arg0: &mut RaffleRegistry, arg1: &RaffleConfig, arg2: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg3: &mut 0x2::tx_context::TxContext) : RaffleRoundV2 {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<RaffleV2>(arg2);
        assert!(!arg0.has_open_round, 2);
        let v0 = RaffleRoundV2{
            id                                : 0x2::object::new(arg3),
            round_id                          : arg0.next_round_id,
            version                           : 2,
            config_version                    : arg1.config_version,
            status                            : 0,
            start_ms                          : 0,
            close_ms                          : 0,
            max_close_ms                      : 0,
            user_pool                         : 0,
            reserve_match                     : 0,
            user_custody                      : 0x2::balance::zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(),
            reserve_custody                   : 0x2::balance::zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(),
            entry_count                       : 0,
            current_window_baseline_user_pool : 0,
            entries                           : 0x2::table::new<u64, vector<Entry>>(arg3),
            num_buckets                       : 0,
            bucket_ends                       : vector[],
            bucket_capacity                   : 512,
            max_buckets                       : 31000,
            winner_index                      : 0,
            winner_set                        : false,
            winner                            : @0x0,
            winner_cap_supply_snapshot        : 0,
            winner_payout_cap_snapshot        : 0,
            winner_cap_snapshot_set           : false,
            paid                              : false,
            settled_at_ms                     : 0,
            min_entry_snapshot                : arg1.min_entry,
        };
        arg0.current_open_round_id = arg0.next_round_id;
        arg0.has_open_round = true;
        arg0.next_round_id = arg0.next_round_id + 1;
        v0
    }

    public fun destroy_pruned_round_v2(arg0: RaffleRoundV2, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1 && arg0.paid, 6);
        assert!(arg0.num_buckets == 0, 19);
        let v0 = RoundDestroyed{
            round_object_id : 0x2::object::id<RaffleRoundV2>(&arg0),
            round_id        : arg0.round_id,
            destroyed_by    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RoundDestroyed>(v0);
        let RaffleRoundV2 {
            id                                : v1,
            round_id                          : _,
            version                           : _,
            config_version                    : _,
            status                            : _,
            start_ms                          : _,
            close_ms                          : _,
            max_close_ms                      : _,
            user_pool                         : _,
            reserve_match                     : _,
            user_custody                      : v11,
            reserve_custody                   : v12,
            entry_count                       : _,
            current_window_baseline_user_pool : _,
            entries                           : v15,
            num_buckets                       : _,
            bucket_ends                       : _,
            bucket_capacity                   : _,
            max_buckets                       : _,
            winner_index                      : _,
            winner_set                        : _,
            winner                            : _,
            winner_cap_supply_snapshot        : _,
            winner_payout_cap_snapshot        : _,
            winner_cap_snapshot_set           : _,
            paid                              : _,
            settled_at_ms                     : _,
            min_entry_snapshot                : _,
        } = arg0;
        0x2::table::destroy_empty<u64, vector<Entry>>(v15);
        0x2::balance::destroy_zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(v11);
        0x2::balance::destroy_zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(v12);
        0x2::object::delete(v1);
    }

    public fun enter_raffle_v2(arg0: &mut RaffleRoundV2, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg5: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<RaffleV2>(arg1);
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg4);
        assert!(v0 >= arg0.min_entry_snapshot, 4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (arg0.entry_count == 0) {
            arg0.start_ms = v1;
            arg0.close_ms = v1 + 7200000;
            arg0.max_close_ms = v1 + 172800000;
        };
        assert!(v1 < arg0.close_ms, 3);
        let v2 = arg0.user_pool;
        let v3 = checked_add_u64(v2, v0) - 1;
        let v4 = RaffleV2{dummy_field: false};
        let v5 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::withdraw_reserve_up_to<RaffleV2>(v4, arg1, arg2, v0, arg5);
        let v6 = 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&v5);
        let v7 = if (arg0.close_ms > 1200000) {
            arg0.close_ms - 1200000
        } else {
            0
        };
        if (v1 >= v7) {
            if (arg0.current_window_baseline_user_pool == 0) {
                arg0.current_window_baseline_user_pool = arg0.user_pool;
            };
            let v8 = checked_add_u64(arg0.user_pool, v0);
            if ((v8 as u128) * 100 >= (arg0.current_window_baseline_user_pool as u128) * 110) {
                let v9 = arg0.close_ms + 1200000;
                let v10 = if (v9 <= arg0.max_close_ms) {
                    v9
                } else {
                    arg0.max_close_ms
                };
                arg0.close_ms = v10;
                arg0.current_window_baseline_user_pool = v8;
            };
        };
        0x2::coin::put<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.user_custody, arg4);
        0x2::coin::put<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.reserve_custody, v5);
        arg0.user_pool = checked_add_u64(arg0.user_pool, v0);
        arg0.reserve_match = checked_add_u64(arg0.reserve_match, v6);
        arg0.entry_count = arg0.entry_count + 1;
        let v11 = Entry{
            owner          : 0x2::tx_context::sender(arg5),
            amount         : v0,
            cumulative_end : v3,
        };
        let v12 = push_entry(arg0, v11);
        let v13 = RaffleEntryCreated{
            round_object_id     : 0x2::object::id<RaffleRoundV2>(arg0),
            round_id            : arg0.round_id,
            entrant             : 0x2::tx_context::sender(arg5),
            amount              : v0,
            range_start         : v2,
            range_end           : v3,
            bucket_index        : v12,
            user_pool_after     : arg0.user_pool,
            reserve_match_added : v6,
            close_ms            : arg0.close_ms,
            entry_count         : arg0.entry_count,
        };
        0x2::event::emit<RaffleEntryCreated>(v13);
    }

    public fun entries_per_bucket() : u64 {
        512
    }

    fun find_winner(arg0: &RaffleRoundV2, arg1: u64) : (address, u64) {
        assert!(arg0.num_buckets > 0, 10);
        assert!(0x1::vector::length<u64>(&arg0.bucket_ends) == arg0.num_buckets, 18);
        assert!(arg1 < arg0.user_pool, 18);
        let v0 = arg0.num_buckets - 1;
        let v1 = 0x2::table::borrow<u64, vector<Entry>>(&arg0.entries, v0);
        assert!(0x1::vector::borrow<Entry>(v1, 0x1::vector::length<Entry>(v1) - 1).cumulative_end == arg0.user_pool - 1, 18);
        assert!(*0x1::vector::borrow<u64>(&arg0.bucket_ends, v0) == arg0.user_pool - 1, 18);
        let v2 = 0;
        let v3 = 0;
        while (v3 < arg0.num_buckets) {
            v2 = v2 + ((18446744073709551616 + (arg1 as u128) - (*0x1::vector::borrow<u64>(&arg0.bucket_ends, v3) as u128) - 1 >> 64) as u64);
            v3 = v3 + 1;
        };
        let v4 = ((18446744073709551616 + (v0 as u128) - (v2 as u128) - 1 >> 64) as u64);
        let v5 = v2 * v4;
        let v6 = 0x2::table::borrow<u64, vector<Entry>>(&arg0.entries, v5);
        assert!(0x1::vector::borrow<Entry>(v6, 0x1::vector::length<Entry>(v6) - 1).cumulative_end == *0x1::vector::borrow<u64>(&arg0.bucket_ends, v5), 18);
        let v7 = 0x2::table::borrow<u64, vector<Entry>>(&arg0.entries, v0 * (1 - v4) + v5 * v4);
        let v8 = 0x1::vector::length<Entry>(v7);
        let v9 = ((18446744073709551616 + (arg0.bucket_capacity as u128) - (v8 as u128) - 1 >> 64) as u64);
        let v10 = 0;
        let v11 = 0;
        while (v11 < arg0.bucket_capacity * v9 + v8 * (1 - v9)) {
            let v12 = ((18446744073709551616 + (v8 as u128) - (v11 as u128) - 1 >> 64) as u64);
            let v13 = v11 * v12 + (v8 - 1) * (1 - v12);
            let v14 = ((18446744073709551616 + (arg1 as u128) - (0x1::vector::borrow<Entry>(v7, v13).cumulative_end as u128) - 1 >> 64) as u64);
            let v15 = v10 * (1 - v14);
            v10 = v15 + (v13 + 1) * v14;
            v11 = v11 + 1;
        };
        let v16 = 0x1::vector::borrow<Entry>(v7, v10);
        assert!(v16.cumulative_end >= arg1 && v16.cumulative_end - arg1 < v16.amount, 18);
        (v16.owner, v16.amount)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_registry(arg0);
        0x2::transfer::share_object<RaffleRegistry>(v0);
        let v1 = RaffleConfig{
            id                      : 0x2::object::new(arg0),
            config_version          : 1,
            min_entry               : 100000000,
            limit_updates_renounced : false,
        };
        0x2::transfer::share_object<RaffleConfig>(v1);
    }

    public fun limit_updates_renounced(arg0: &RaffleConfig) : bool {
        arg0.limit_updates_renounced
    }

    public fun max_entry_buckets() : u64 {
        31000
    }

    public fun min_entry(arg0: &RaffleConfig) : u64 {
        arg0.min_entry
    }

    public(friend) fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : RaffleRegistry {
        RaffleRegistry{
            id                    : 0x2::object::new(arg0),
            next_round_id         : 1,
            current_open_round_id : 0,
            has_open_round        : false,
        }
    }

    public fun prune_settled_round_v2(arg0: &mut RaffleRoundV2, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1 && arg0.paid, 6);
        let v0 = 0;
        while (v0 < arg1 && arg0.num_buckets > 0) {
            let v1 = arg0.num_buckets - 1;
            0x2::table::remove<u64, vector<Entry>>(&mut arg0.entries, v1);
            0x1::vector::pop_back<u64>(&mut arg0.bucket_ends);
            arg0.num_buckets = v1;
            v0 = v0 + 1;
        };
        let v2 = RoundPruned{
            round_object_id   : 0x2::object::id<RaffleRoundV2>(arg0),
            round_id          : arg0.round_id,
            pruned_by         : 0x2::tx_context::sender(arg2),
            buckets_removed   : v0,
            buckets_remaining : arg0.num_buckets,
        };
        0x2::event::emit<RoundPruned>(v2);
    }

    fun push_entry(arg0: &mut RaffleRoundV2, arg1: Entry) : u64 {
        if (arg0.num_buckets > 0) {
            let v0 = arg0.num_buckets - 1;
            let v1 = 0x2::table::borrow_mut<u64, vector<Entry>>(&mut arg0.entries, v0);
            if (0x1::vector::length<Entry>(v1) < arg0.bucket_capacity) {
                0x1::vector::push_back<Entry>(v1, arg1);
                *0x1::vector::borrow_mut<u64>(&mut arg0.bucket_ends, v0) = arg1.cumulative_end;
                return v0
            };
        };
        assert!(arg0.num_buckets < arg0.max_buckets, 21);
        let v2 = 0x1::vector::empty<Entry>();
        0x1::vector::push_back<Entry>(&mut v2, arg1);
        0x2::table::add<u64, vector<Entry>>(&mut arg0.entries, arg0.num_buckets, v2);
        0x1::vector::push_back<u64>(&mut arg0.bucket_ends, arg1.cumulative_end);
        arg0.num_buckets = arg0.num_buckets + 1;
        arg0.num_buckets - 1
    }

    public fun raffle_extension_ms() : u64 {
        1200000
    }

    public fun raffle_fee_bps() : u64 {
        300
    }

    public fun raffle_final_window_ms() : u64 {
        1200000
    }

    public fun raffle_initial_ms() : u64 {
        7200000
    }

    public fun raffle_max_lifetime_ms() : u64 {
        172800000
    }

    fun settle_and_pay(arg0: &mut RaffleRegistry, arg1: &mut RaffleRoundV2, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::Treasury, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1) = find_winner(arg1, arg5);
        let v2 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::current_total_tracked_supply(arg4);
        arg1.winner_index = arg5;
        arg1.winner = v0;
        arg1.winner_cap_supply_snapshot = v2;
        arg1.winner_payout_cap_snapshot = v2 / 10;
        arg1.winner_cap_snapshot_set = true;
        arg1.settled_at_ms = arg6;
        arg1.winner_set = true;
        arg1.status = 1;
        let v3 = 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg1.user_custody) + 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg1.reserve_custody);
        let v4 = calculate_fee_u64(v3, 300);
        let v5 = 0x2::coin::from_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(0x2::balance::withdraw_all<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg1.user_custody), arg7);
        0x2::coin::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut v5, 0x2::coin::from_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(0x2::balance::withdraw_all<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg1.reserve_custody), arg7));
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::deposit_fee_with_cap(arg2, arg3, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut v5, v4, arg7), arg7);
        let v6 = v3 - v4;
        let v7 = if (v6 > arg1.winner_payout_cap_snapshot) {
            arg1.winner_payout_cap_snapshot
        } else {
            v6
        };
        let v8 = v6 - v7;
        if (v8 > 0) {
            0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::deposit_reserve(arg3, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut v5, v8, arg7));
        };
        arg1.paid = true;
        let v9 = RoundSettled{
            round_object_id            : 0x2::object::id<RaffleRoundV2>(arg1),
            round_id                   : arg1.round_id,
            winner_index               : arg5,
            user_pool                  : arg1.user_pool,
            reserve_match              : arg1.reserve_match,
            gross_prize                : v3,
            winner_cap_supply_snapshot : arg1.winner_cap_supply_snapshot,
            winner_payout_cap_snapshot : arg1.winner_payout_cap_snapshot,
            settled_at_ms              : arg6,
        };
        0x2::event::emit<RoundSettled>(v9);
        let v10 = WinnerPaid{
            round_object_id       : 0x2::object::id<RaffleRoundV2>(arg1),
            round_id              : arg1.round_id,
            winner                : v0,
            winner_index          : arg5,
            winner_entry_amount   : v1,
            gross_prize           : v3,
            fee_amount            : v4,
            winner_payout         : v7,
            cap_excess_to_reserve : v8,
        };
        0x2::event::emit<WinnerPaid>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(v5, v0);
        clear_active_round(arg0, arg1);
        v7
    }

    entry fun settle_raffle_v2(arg0: &mut RaffleRegistry, arg1: &mut RaffleRoundV2, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::Treasury, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert_settleable(arg0, arg1, v0);
        let v1 = 0x2::random::new_generator(arg6, arg7);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 0, arg1.user_pool - 1);
        settle_and_pay(arg0, arg1, arg2, arg3, arg4, v2, v0, arg7);
    }

    public fun update_min_entry(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut RaffleConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 15);
        assert!(arg2 >= 100000000, 17);
        arg1.min_entry = arg2;
        arg1.config_version = arg1.config_version + 1;
        let v0 = MinEntryUpdated{
            config_id          : 0x2::object::id<RaffleConfig>(arg1),
            admin              : 0x2::tx_context::sender(arg3),
            previous_min_entry : arg1.min_entry,
            new_min_entry      : arg2,
            config_version     : arg1.config_version,
        };
        0x2::event::emit<MinEntryUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

