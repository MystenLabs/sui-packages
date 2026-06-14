module 0xfa76c707ef62ecdb2e7486ebb7a6417379406a0af3b8ab1010fa7eb4e9fa3018::flux_engine {
    struct FluxOffer<phantom T0> has key {
        id: 0x2::object::UID,
        maker: address,
        event_id: vector<u8>,
        prediction: vector<u8>,
        odds_bps: u64,
        maker_stake: 0x2::balance::Balance<T0>,
        maker_total: u64,
        filled_maker: u64,
        shard_count: u64,
        settled_count: u64,
        min_shard_taker: u64,
        status: u8,
        created_at: u64,
        expires_at: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct FluxShard<phantom T0> has key {
        id: 0x2::object::UID,
        offer_id: 0x2::object::ID,
        shard_index: u64,
        maker: address,
        taker: address,
        vault: 0x2::balance::Balance<T0>,
        taker_amount: u64,
        maker_amount: u64,
        status: u8,
        filled_at: u64,
        settled_at: u64,
    }

    struct FluxFillReceipt<phantom T0> {
        offer_id: 0x2::object::ID,
        maker_reserve: 0x2::balance::Balance<T0>,
        taker_balance: 0x2::balance::Balance<T0>,
        taker_amount: u64,
        maker_amount: u64,
        taker_addr: address,
        maker_addr: address,
    }

    struct FluxStats has key {
        id: 0x2::object::UID,
        total_offers: u64,
        total_shards: u64,
        total_settled: u64,
        total_voided: u64,
        total_volume: u64,
        total_batches: u64,
        max_batch_size: u64,
        last_batch_ts: u64,
    }

    struct FluxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FluxOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        event_id: vector<u8>,
        prediction: vector<u8>,
        odds_bps: u64,
        maker_stake: u64,
        min_shard_taker: u64,
        coin_type: vector<u8>,
        expires_at: u64,
        timestamp: u64,
    }

    struct FluxShardFilled has copy, drop {
        offer_id: 0x2::object::ID,
        shard_id: 0x2::object::ID,
        shard_index: u64,
        taker: address,
        taker_amount: u64,
        maker_amount: u64,
        timestamp: u64,
    }

    struct FluxShardSettled has copy, drop {
        offer_id: 0x2::object::ID,
        shard_id: 0x2::object::ID,
        shard_index: u64,
        taker_won: bool,
        payout: u64,
        fee: u64,
        timestamp: u64,
    }

    struct FluxShardVoided has copy, drop {
        offer_id: 0x2::object::ID,
        shard_id: 0x2::object::ID,
        shard_index: u64,
        taker_refund: u64,
        maker_refund: u64,
        timestamp: u64,
    }

    struct FluxBatchSettled has copy, drop {
        batch_id: u64,
        count: u64,
        voided: u64,
        timestamp: u64,
    }

    struct FluxOfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        refund: u64,
        timestamp: u64,
    }

    public entry fun flux_batch_close(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut FluxStats, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0, 308);
        assert!(arg2 <= 512, 309);
        assert!(arg3 <= 512, 309);
        arg1.total_batches = arg1.total_batches + 1;
        arg1.last_batch_ts = 0x2::clock::timestamp_ms(arg4);
        let v0 = arg2 + arg3;
        if (v0 > arg1.max_batch_size) {
            arg1.max_batch_size = v0;
        };
        let v1 = FluxBatchSettled{
            batch_id  : arg1.total_batches,
            count     : arg2,
            voided    : arg3,
            timestamp : arg1.last_batch_ts,
        };
        0x2::event::emit<FluxBatchSettled>(v1);
    }

    public fun flux_cancel_fill<T0>(arg0: &mut FluxOffer<T0>, arg1: FluxFillReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let FluxFillReceipt {
            offer_id      : v0,
            maker_reserve : v1,
            taker_balance : v2,
            taker_amount  : _,
            maker_amount  : _,
            taker_addr    : v5,
            maker_addr    : _,
        } = arg1;
        assert!(v0 == 0x2::object::id<FluxOffer<T0>>(arg0), 303);
        0x2::balance::join<T0>(&mut arg0.maker_stake, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), v5);
    }

    public entry fun flux_cancel_offer<T0>(arg0: &mut FluxOffer<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 312);
        assert!(arg0.status == 0 || arg0.status == 1, 300);
        assert!(arg0.shard_count == 0, 310);
        let v0 = 0x2::balance::value<T0>(&arg0.maker_stake);
        arg0.status = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.maker_stake, v0), arg2), arg0.maker);
        let v1 = FluxOfferCancelled{
            offer_id  : 0x2::object::id<FluxOffer<T0>>(arg0),
            maker     : arg0.maker,
            refund    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<FluxOfferCancelled>(v1);
    }

    public fun flux_confirm_fill<T0>(arg0: &mut FluxOffer<T0>, arg1: FluxFillReceipt<T0>, arg2: &mut FluxStats, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let FluxFillReceipt {
            offer_id      : v0,
            maker_reserve : v1,
            taker_balance : v2,
            taker_amount  : v3,
            maker_amount  : v4,
            taker_addr    : v5,
            maker_addr    : v6,
        } = arg1;
        assert!(v0 == 0x2::object::id<FluxOffer<T0>>(arg0), 303);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        let v8 = arg0.shard_count;
        let v9 = v1;
        0x2::balance::join<T0>(&mut v9, v2);
        let v10 = FluxShard<T0>{
            id           : 0x2::object::new(arg4),
            offer_id     : v0,
            shard_index  : v8,
            maker        : v6,
            taker        : v5,
            vault        : v9,
            taker_amount : v3,
            maker_amount : v4,
            status       : 0,
            filled_at    : v7,
            settled_at   : 0,
        };
        arg0.filled_maker = arg0.filled_maker + v4;
        arg0.shard_count = arg0.shard_count + 1;
        if (0x2::balance::value<T0>(&arg0.maker_stake) < arg0.min_shard_taker) {
            arg0.status = 1;
        };
        arg2.total_shards = arg2.total_shards + 1;
        let v11 = FluxShardFilled{
            offer_id     : v0,
            shard_id     : 0x2::object::id<FluxShard<T0>>(&v10),
            shard_index  : v8,
            taker        : v5,
            taker_amount : v3,
            maker_amount : v4,
            timestamp    : v7,
        };
        0x2::event::emit<FluxShardFilled>(v11);
        0x2::transfer::share_object<FluxShard<T0>>(v10);
    }

    public entry fun flux_create_offer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut FluxStats, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = 0x1::type_name::get<T0>();
        assert!(v1 > 0, 306);
        assert!(arg3 > 10000, 307);
        let v4 = if (arg4 == 0) {
            10000000
        } else {
            arg4
        };
        let v5 = FluxOffer<T0>{
            id              : 0x2::object::new(arg7),
            maker           : v0,
            event_id        : arg1,
            prediction      : arg2,
            odds_bps        : arg3,
            maker_stake     : 0x2::coin::into_balance<T0>(arg0),
            maker_total     : v1,
            filled_maker    : 0,
            shard_count     : 0,
            settled_count   : 0,
            min_shard_taker : v4,
            status          : 0,
            created_at      : v2,
            expires_at      : v2 + 604800000,
            coin_type       : v3,
        };
        arg5.total_offers = arg5.total_offers + 1;
        arg5.total_volume = arg5.total_volume + v1;
        let v6 = FluxOfferCreated{
            offer_id        : 0x2::object::id<FluxOffer<T0>>(&v5),
            maker           : v0,
            event_id        : v5.event_id,
            prediction      : v5.prediction,
            odds_bps        : arg3,
            maker_stake     : v1,
            min_shard_taker : v4,
            coin_type       : 0x1::ascii::into_bytes(0x1::type_name::into_string(v3)),
            expires_at      : v5.expires_at,
            timestamp       : v2,
        };
        0x2::event::emit<FluxOfferCreated>(v6);
        0x2::transfer::share_object<FluxOffer<T0>>(v5);
    }

    public fun flux_fill_shard<T0>(arg0: &mut FluxOffer<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : FluxFillReceipt<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(arg0.status == 0, 300);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_at, 305);
        assert!(v0 >= arg0.min_shard_taker, 301);
        let v1 = (((v0 as u128) * 10000 / ((arg0.odds_bps as u128) - 10000)) as u64);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.maker_stake), 302);
        FluxFillReceipt<T0>{
            offer_id      : 0x2::object::id<FluxOffer<T0>>(arg0),
            maker_reserve : 0x2::balance::split<T0>(&mut arg0.maker_stake, v1),
            taker_balance : 0x2::coin::into_balance<T0>(arg1),
            taker_amount  : v0,
            maker_amount  : v1,
            taker_addr    : 0x2::tx_context::sender(arg3),
            maker_addr    : arg0.maker,
        }
    }

    public entry fun flux_mark_shard_settled<T0>(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut FluxOffer<T0>, arg2: &0x2::clock::Clock) {
        arg1.settled_count = arg1.settled_count + 1;
        if (arg1.settled_count == arg1.shard_count && 0x2::balance::value<T0>(&arg1.maker_stake) == 0) {
            arg1.status = 2;
        };
    }

    public entry fun flux_reclaim_unfilled<T0>(arg0: &mut FluxOffer<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 312);
        assert!(arg0.settled_count == arg0.shard_count, 311);
        let v0 = 0x2::balance::value<T0>(&arg0.maker_stake);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.maker_stake, v0), arg2), arg0.maker);
        };
        arg0.status = 2;
        let v1 = FluxOfferCancelled{
            offer_id  : 0x2::object::id<FluxOffer<T0>>(arg0),
            maker     : arg0.maker,
            refund    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<FluxOfferCancelled>(v1);
    }

    public entry fun flux_settle_shard<T0>(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut FluxShard<T0>, arg2: bool, arg3: &mut FluxStats, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 304);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::balance::value<T0>(&arg1.vault);
        let v2 = v1 * 200 / 10000;
        let v3 = v1 - v2;
        let v4 = if (arg2) {
            arg1.taker
        } else {
            arg1.maker
        };
        let v5 = if (arg2) {
            1
        } else {
            2
        };
        arg1.status = v5;
        arg1.settled_at = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v2), arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v3), arg5), v4);
        arg3.total_settled = arg3.total_settled + 1;
        let v6 = FluxShardSettled{
            offer_id    : arg1.offer_id,
            shard_id    : 0x2::object::id<FluxShard<T0>>(arg1),
            shard_index : arg1.shard_index,
            taker_won   : arg2,
            payout      : v3,
            fee         : v2,
            timestamp   : v0,
        };
        0x2::event::emit<FluxShardSettled>(v6);
    }

    public entry fun flux_void_shard<T0>(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut FluxShard<T0>, arg2: &mut FluxStats, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 304);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.status = 3;
        arg1.settled_at = v0;
        let v1 = 0x2::balance::value<T0>(&arg1.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, arg1.taker_amount), arg4), arg1.taker);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v1), arg4), arg1.maker);
        arg2.total_voided = arg2.total_voided + 1;
        let v2 = FluxShardVoided{
            offer_id     : arg1.offer_id,
            shard_id     : 0x2::object::id<FluxShard<T0>>(arg1),
            shard_index  : arg1.shard_index,
            taker_refund : arg1.taker_amount,
            maker_refund : v1,
            timestamp    : v0,
        };
        0x2::event::emit<FluxShardVoided>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FluxStats{
            id             : 0x2::object::new(arg0),
            total_offers   : 0,
            total_shards   : 0,
            total_settled  : 0,
            total_voided   : 0,
            total_volume   : 0,
            total_batches  : 0,
            max_batch_size : 0,
            last_batch_ts  : 0,
        };
        let v1 = FluxAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<FluxStats>(v0);
        0x2::transfer::transfer<FluxAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun offer_expires_at<T0>(arg0: &FluxOffer<T0>) : u64 {
        arg0.expires_at
    }

    public fun offer_filled_maker<T0>(arg0: &FluxOffer<T0>) : u64 {
        arg0.filled_maker
    }

    public fun offer_maker<T0>(arg0: &FluxOffer<T0>) : address {
        arg0.maker
    }

    public fun offer_maker_total<T0>(arg0: &FluxOffer<T0>) : u64 {
        arg0.maker_total
    }

    public fun offer_min_shard_taker<T0>(arg0: &FluxOffer<T0>) : u64 {
        arg0.min_shard_taker
    }

    public fun offer_odds_bps<T0>(arg0: &FluxOffer<T0>) : u64 {
        arg0.odds_bps
    }

    public fun offer_remaining<T0>(arg0: &FluxOffer<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.maker_stake)
    }

    public fun offer_settled_count<T0>(arg0: &FluxOffer<T0>) : u64 {
        arg0.settled_count
    }

    public fun offer_shard_count<T0>(arg0: &FluxOffer<T0>) : u64 {
        arg0.shard_count
    }

    public fun offer_status<T0>(arg0: &FluxOffer<T0>) : u8 {
        arg0.status
    }

    public fun shard_filled_at<T0>(arg0: &FluxShard<T0>) : u64 {
        arg0.filled_at
    }

    public fun shard_index<T0>(arg0: &FluxShard<T0>) : u64 {
        arg0.shard_index
    }

    public fun shard_maker<T0>(arg0: &FluxShard<T0>) : address {
        arg0.maker
    }

    public fun shard_maker_amount<T0>(arg0: &FluxShard<T0>) : u64 {
        arg0.maker_amount
    }

    public fun shard_offer_id<T0>(arg0: &FluxShard<T0>) : 0x2::object::ID {
        arg0.offer_id
    }

    public fun shard_settled_at<T0>(arg0: &FluxShard<T0>) : u64 {
        arg0.settled_at
    }

    public fun shard_status<T0>(arg0: &FluxShard<T0>) : u8 {
        arg0.status
    }

    public fun shard_taker<T0>(arg0: &FluxShard<T0>) : address {
        arg0.taker
    }

    public fun shard_taker_amount<T0>(arg0: &FluxShard<T0>) : u64 {
        arg0.taker_amount
    }

    public fun shard_vault_value<T0>(arg0: &FluxShard<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun stats_last_batch_ts(arg0: &FluxStats) : u64 {
        arg0.last_batch_ts
    }

    public fun stats_max_batch_size(arg0: &FluxStats) : u64 {
        arg0.max_batch_size
    }

    public fun stats_total_batches(arg0: &FluxStats) : u64 {
        arg0.total_batches
    }

    public fun stats_total_offers(arg0: &FluxStats) : u64 {
        arg0.total_offers
    }

    public fun stats_total_settled(arg0: &FluxStats) : u64 {
        arg0.total_settled
    }

    public fun stats_total_shards(arg0: &FluxStats) : u64 {
        arg0.total_shards
    }

    public fun stats_total_voided(arg0: &FluxStats) : u64 {
        arg0.total_voided
    }

    public fun stats_total_volume(arg0: &FluxStats) : u64 {
        arg0.total_volume
    }

    // decompiled from Move bytecode v6
}

