module 0x6ac71a607632fdc4dda3bb51b0e3a36fd8a7c4a4ac1ccb6cf9c722c8f34ee238::pulse_engine {
    struct PulsePool<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        event_id: vector<u8>,
        side_a_name: vector<u8>,
        side_b_name: vector<u8>,
        coin_type: 0x1::type_name::TypeName,
        side_a_pool: 0x2::balance::Balance<T0>,
        side_b_pool: 0x2::balance::Balance<T0>,
        payout_vault: 0x2::balance::Balance<T0>,
        total_a_staked: u64,
        total_b_staked: u64,
        position_count: u64,
        claimed_count: u64,
        winner: u8,
        winning_side_total: u64,
        settled_payout_pool: u64,
        status: u8,
        created_at: u64,
        locked_at: u64,
        settled_at: u64,
    }

    struct PulsePosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        holder: address,
        side: u8,
        stake: u64,
        snapshot_total: u64,
        snapshot_side: u64,
        joined_at: u64,
    }

    struct PulseStats has key {
        id: 0x2::object::UID,
        total_pools: u64,
        total_positions: u64,
        total_settled: u64,
        total_voided: u64,
        total_volume: u64,
        total_batches: u64,
        max_batch_size: u64,
        last_batch_ts: u64,
    }

    struct PulseAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PulsePoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        event_id: vector<u8>,
        side_a_name: vector<u8>,
        side_b_name: vector<u8>,
        seed_a: u64,
        seed_b: u64,
        coin_type: vector<u8>,
        timestamp: u64,
    }

    struct PulsePositionTaken has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        taker: address,
        side: u8,
        stake: u64,
        live_odds_num: u64,
        live_odds_den: u64,
        timestamp: u64,
    }

    struct PulsePoolLocked has copy, drop {
        pool_id: 0x2::object::ID,
        total_a: u64,
        total_b: u64,
        timestamp: u64,
    }

    struct PulsePoolSettled has copy, drop {
        pool_id: 0x2::object::ID,
        winner: u8,
        payout_pool: u64,
        fee: u64,
        winning_side: u64,
        timestamp: u64,
    }

    struct PulseWinningsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        winner: address,
        stake: u64,
        payout: u64,
        timestamp: u64,
    }

    struct PulseVoidRefunded has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        holder: address,
        refund: u64,
        timestamp: u64,
    }

    struct PulsePoolVoided has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PulseBatchSettled has copy, drop {
        batch_id: u64,
        count: u64,
        voided: u64,
        timestamp: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PulseStats{
            id              : 0x2::object::new(arg0),
            total_pools     : 0,
            total_positions : 0,
            total_settled   : 0,
            total_voided    : 0,
            total_volume    : 0,
            total_batches   : 0,
            max_batch_size  : 0,
            last_batch_ts   : 0,
        };
        let v1 = PulseAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PulseStats>(v0);
        0x2::transfer::transfer<PulseAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun live_odds_den_a<T0>(arg0: &PulsePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.side_a_pool)
    }

    public fun live_odds_den_b<T0>(arg0: &PulsePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.side_b_pool)
    }

    public fun live_odds_num<T0>(arg0: &PulsePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.side_a_pool) + 0x2::balance::value<T0>(&arg0.side_b_pool)
    }

    public fun pool_claimed_count<T0>(arg0: &PulsePool<T0>) : u64 {
        arg0.claimed_count
    }

    public fun pool_created_at<T0>(arg0: &PulsePool<T0>) : u64 {
        arg0.created_at
    }

    public fun pool_payout_vault<T0>(arg0: &PulsePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.payout_vault)
    }

    public fun pool_position_count<T0>(arg0: &PulsePool<T0>) : u64 {
        arg0.position_count
    }

    public fun pool_settled_at<T0>(arg0: &PulsePool<T0>) : u64 {
        arg0.settled_at
    }

    public fun pool_settled_payout<T0>(arg0: &PulsePool<T0>) : u64 {
        arg0.settled_payout_pool
    }

    public fun pool_status<T0>(arg0: &PulsePool<T0>) : u8 {
        arg0.status
    }

    public fun pool_total_a<T0>(arg0: &PulsePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.side_a_pool)
    }

    public fun pool_total_b<T0>(arg0: &PulsePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.side_b_pool)
    }

    public fun pool_total_staked<T0>(arg0: &PulsePool<T0>) : u64 {
        arg0.total_a_staked + arg0.total_b_staked
    }

    public fun pool_winner<T0>(arg0: &PulsePool<T0>) : u8 {
        arg0.winner
    }

    public fun pool_winning_side_total<T0>(arg0: &PulsePool<T0>) : u64 {
        arg0.winning_side_total
    }

    public fun position_holder<T0>(arg0: &PulsePosition<T0>) : address {
        arg0.holder
    }

    public fun position_joined_at<T0>(arg0: &PulsePosition<T0>) : u64 {
        arg0.joined_at
    }

    public fun position_pool_id<T0>(arg0: &PulsePosition<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_side<T0>(arg0: &PulsePosition<T0>) : u8 {
        arg0.side
    }

    public fun position_snap_odds_den<T0>(arg0: &PulsePosition<T0>) : u64 {
        arg0.snapshot_side
    }

    public fun position_snap_odds_num<T0>(arg0: &PulsePosition<T0>) : u64 {
        arg0.snapshot_total
    }

    public fun position_stake<T0>(arg0: &PulsePosition<T0>) : u64 {
        arg0.stake
    }

    public entry fun pulse_batch_close(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut PulseStats, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0, 410);
        assert!(arg2 <= 512, 411);
        assert!(arg3 <= 512, 411);
        arg1.total_batches = arg1.total_batches + 1;
        arg1.last_batch_ts = 0x2::clock::timestamp_ms(arg4);
        let v0 = arg2 + arg3;
        if (v0 > arg1.max_batch_size) {
            arg1.max_batch_size = v0;
        };
        let v1 = PulseBatchSettled{
            batch_id  : arg1.total_batches,
            count     : arg2,
            voided    : arg3,
            timestamp : arg1.last_batch_ts,
        };
        0x2::event::emit<PulseBatchSettled>(v1);
    }

    public entry fun pulse_claim_void_refund<T0>(arg0: &mut PulsePool<T0>, arg1: PulsePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 403);
        let PulsePosition {
            id             : v0,
            pool_id        : v1,
            holder         : v2,
            side           : v3,
            stake          : v4,
            snapshot_total : _,
            snapshot_side  : _,
            joined_at      : _,
        } = arg1;
        let v8 = v0;
        assert!(v1 == 0x2::object::id<PulsePool<T0>>(arg0), 406);
        assert!(0x2::tx_context::sender(arg3) == v2, 412);
        0x2::object::delete(v8);
        arg0.claimed_count = arg0.claimed_count + 1;
        let v9 = if (v3 == 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.side_a_pool, v4), arg3)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.side_b_pool, v4), arg3)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v2);
        let v10 = PulseVoidRefunded{
            pool_id     : 0x2::object::id<PulsePool<T0>>(arg0),
            position_id : 0x2::object::uid_to_inner(&v8),
            holder      : v2,
            refund      : v4,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PulseVoidRefunded>(v10);
    }

    public entry fun pulse_claim_winnings<T0>(arg0: &mut PulsePool<T0>, arg1: PulsePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 402);
        let PulsePosition {
            id             : v0,
            pool_id        : v1,
            holder         : v2,
            side           : v3,
            stake          : v4,
            snapshot_total : _,
            snapshot_side  : _,
            joined_at      : _,
        } = arg1;
        let v8 = v0;
        assert!(v1 == 0x2::object::id<PulsePool<T0>>(arg0), 406);
        assert!(v3 == arg0.winner, 408);
        assert!(0x2::tx_context::sender(arg3) == v2, 412);
        let v9 = (((v4 as u128) * (arg0.settled_payout_pool as u128) / (arg0.winning_side_total as u128)) as u64);
        0x2::object::delete(v8);
        arg0.claimed_count = arg0.claimed_count + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_vault, v9), arg3), v2);
        let v10 = PulseWinningsClaimed{
            pool_id     : 0x2::object::id<PulsePool<T0>>(arg0),
            position_id : 0x2::object::uid_to_inner(&v8),
            winner      : v2,
            stake       : v4,
            payout      : v9,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PulseWinningsClaimed>(v10);
    }

    public entry fun pulse_create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut PulseStats, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000, 405);
        assert!(v1 >= 10000000, 405);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0x2::tx_context::sender(arg7);
        let v5 = PulsePool<T0>{
            id                  : 0x2::object::new(arg7),
            creator             : v4,
            event_id            : arg2,
            side_a_name         : arg3,
            side_b_name         : arg4,
            coin_type           : v3,
            side_a_pool         : 0x2::coin::into_balance<T0>(arg0),
            side_b_pool         : 0x2::coin::into_balance<T0>(arg1),
            payout_vault        : 0x2::balance::zero<T0>(),
            total_a_staked      : v0,
            total_b_staked      : v1,
            position_count      : 0,
            claimed_count       : 0,
            winner              : 255,
            winning_side_total  : 0,
            settled_payout_pool : 0,
            status              : 0,
            created_at          : v2,
            locked_at           : 0,
            settled_at          : 0,
        };
        arg5.total_pools = arg5.total_pools + 1;
        arg5.total_volume = arg5.total_volume + v0 + v1;
        let v6 = PulsePoolCreated{
            pool_id     : 0x2::object::id<PulsePool<T0>>(&v5),
            creator     : v4,
            event_id    : v5.event_id,
            side_a_name : v5.side_a_name,
            side_b_name : v5.side_b_name,
            seed_a      : v0,
            seed_b      : v1,
            coin_type   : 0x1::ascii::into_bytes(0x1::type_name::into_string(v3)),
            timestamp   : v2,
        };
        0x2::event::emit<PulsePoolCreated>(v6);
        0x2::transfer::share_object<PulsePool<T0>>(v5);
    }

    public entry fun pulse_lock_pool<T0>(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut PulsePool<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.status == 0, 400);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.status = 1;
        arg1.locked_at = v0;
        let v1 = PulsePoolLocked{
            pool_id   : 0x2::object::id<PulsePool<T0>>(arg1),
            total_a   : 0x2::balance::value<T0>(&arg1.side_a_pool),
            total_b   : 0x2::balance::value<T0>(&arg1.side_b_pool),
            timestamp : v0,
        };
        0x2::event::emit<PulsePoolLocked>(v1);
    }

    public entry fun pulse_settle_pool<T0>(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut PulsePool<T0>, arg2: u8, arg3: &mut PulseStats, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 401);
        assert!(arg2 == 0 || arg2 == 1, 404);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::balance::value<T0>(&arg1.side_a_pool);
        let v2 = 0x2::balance::value<T0>(&arg1.side_b_pool);
        let v3 = v1 + v2;
        assert!(v3 > 0, 413);
        let v4 = v3 * 200 / 10000;
        let v5 = v3 - v4;
        arg1.winner = arg2;
        arg1.settled_payout_pool = v5;
        arg1.status = 2;
        arg1.settled_at = v0;
        let v6 = if (arg2 == 0) {
            arg1.total_a_staked
        } else {
            arg1.total_b_staked
        };
        arg1.winning_side_total = v6;
        let v7 = 0x2::balance::split<T0>(&mut arg1.side_a_pool, v1);
        0x2::balance::join<T0>(&mut v7, 0x2::balance::split<T0>(&mut arg1.side_b_pool, v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v4), arg5), 0x2::tx_context::sender(arg5));
        0x2::balance::join<T0>(&mut arg1.payout_vault, v7);
        arg3.total_settled = arg3.total_settled + 1;
        let v8 = PulsePoolSettled{
            pool_id      : 0x2::object::id<PulsePool<T0>>(arg1),
            winner       : arg2,
            payout_pool  : v5,
            fee          : v4,
            winning_side : arg1.winning_side_total,
            timestamp    : v0,
        };
        0x2::event::emit<PulsePoolSettled>(v8);
    }

    public entry fun pulse_take_position<T0>(arg0: &mut PulsePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &mut PulseStats, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 400);
        assert!(arg2 == 0 || arg2 == 1, 404);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::tx_context::sender(arg5);
        assert!(v0 >= 10000000, 405);
        let v3 = 0x2::balance::value<T0>(&arg0.side_a_pool);
        let v4 = 0x2::balance::value<T0>(&arg0.side_b_pool);
        let (v5, v6) = if (arg2 == 0) {
            (v3 + v4 + v0, v3 + v0)
        } else {
            (v3 + v4 + v0, v4 + v0)
        };
        if (arg2 == 0) {
            0x2::balance::join<T0>(&mut arg0.side_a_pool, 0x2::coin::into_balance<T0>(arg1));
            arg0.total_a_staked = arg0.total_a_staked + v0;
        } else {
            0x2::balance::join<T0>(&mut arg0.side_b_pool, 0x2::coin::into_balance<T0>(arg1));
            arg0.total_b_staked = arg0.total_b_staked + v0;
        };
        arg0.position_count = arg0.position_count + 1;
        let v7 = PulsePosition<T0>{
            id             : 0x2::object::new(arg5),
            pool_id        : 0x2::object::id<PulsePool<T0>>(arg0),
            holder         : v2,
            side           : arg2,
            stake          : v0,
            snapshot_total : v5,
            snapshot_side  : v6,
            joined_at      : v1,
        };
        arg3.total_positions = arg3.total_positions + 1;
        arg3.total_volume = arg3.total_volume + v0;
        let v8 = PulsePositionTaken{
            pool_id       : 0x2::object::id<PulsePool<T0>>(arg0),
            position_id   : 0x2::object::id<PulsePosition<T0>>(&v7),
            taker         : v2,
            side          : arg2,
            stake         : v0,
            live_odds_num : v5,
            live_odds_den : v6,
            timestamp     : v1,
        };
        0x2::event::emit<PulsePositionTaken>(v8);
        0x2::transfer::public_transfer<PulsePosition<T0>>(v7, v2);
    }

    public entry fun pulse_void_pool<T0>(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut PulsePool<T0>, arg2: &mut PulseStats, arg3: &0x2::clock::Clock) {
        assert!(arg1.status == 0 || arg1.status == 1, 400);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.status = 3;
        arg1.settled_at = v0;
        arg2.total_voided = arg2.total_voided + 1;
        let v1 = PulsePoolVoided{
            pool_id   : 0x2::object::id<PulsePool<T0>>(arg1),
            timestamp : v0,
        };
        0x2::event::emit<PulsePoolVoided>(v1);
    }

    public fun stats_last_batch_ts(arg0: &PulseStats) : u64 {
        arg0.last_batch_ts
    }

    public fun stats_max_batch_size(arg0: &PulseStats) : u64 {
        arg0.max_batch_size
    }

    public fun stats_total_batches(arg0: &PulseStats) : u64 {
        arg0.total_batches
    }

    public fun stats_total_pools(arg0: &PulseStats) : u64 {
        arg0.total_pools
    }

    public fun stats_total_positions(arg0: &PulseStats) : u64 {
        arg0.total_positions
    }

    public fun stats_total_settled(arg0: &PulseStats) : u64 {
        arg0.total_settled
    }

    public fun stats_total_voided(arg0: &PulseStats) : u64 {
        arg0.total_voided
    }

    public fun stats_total_volume(arg0: &PulseStats) : u64 {
        arg0.total_volume
    }

    // decompiled from Move bytecode v6
}

