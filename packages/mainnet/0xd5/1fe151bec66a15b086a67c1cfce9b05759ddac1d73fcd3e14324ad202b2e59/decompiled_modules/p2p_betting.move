module 0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting {
    struct P2P_BETTING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct WithdrawalProposal has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
        recipient: address,
        proposed_at: u64,
        executed: bool,
    }

    struct WithdrawalExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct P2PConfig has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        min_stake: u64,
        default_fee_bps: u64,
        dispute_window_ms: u64,
        total_offers: u64,
        total_bets: u64,
        total_parlays: u64,
        total_volume: u64,
        fee_vault: 0x2::bag::Bag,
    }

    struct P2PRegistry has key {
        id: 0x2::object::UID,
        open_offers: 0x2::table::Table<0x2::object::ID, bool>,
        live_bets: 0x2::table::Table<0x2::object::ID, bool>,
        open_parlays: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct VolumeKey has copy, drop, store {
        addr: address,
    }

    struct WalletVolume has store {
        maker_volume: u64,
        taker_volume: u64,
        total_bets: u64,
        wins: u64,
    }

    struct P2POffer<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        maker: address,
        event_id: vector<u8>,
        event_name: vector<u8>,
        prediction: vector<u8>,
        market_type: vector<u8>,
        odds_bps: u64,
        maker_stake_total: u64,
        maker_remaining: 0x2::balance::Balance<T0>,
        filled_taker: u64,
        match_count: u64,
        status: u8,
        created_at: u64,
        expires_at: u64,
        maker_rebate_bps: u64,
    }

    struct P2PMatchedBet<phantom T0> has key {
        id: 0x2::object::UID,
        offer_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        maker: address,
        taker: address,
        event_id: vector<u8>,
        event_name: vector<u8>,
        prediction: vector<u8>,
        odds_bps: u64,
        maker_balance: 0x2::balance::Balance<T0>,
        taker_balance: 0x2::balance::Balance<T0>,
        status: u8,
        created_at: u64,
        expires_at: u64,
        maker_rebate_bps: u64,
        taker_fee_bps: u64,
        pending_maker_wins: bool,
        settle_queued_at: u64,
        disputed: bool,
        disputer: 0x1::option::Option<address>,
    }

    struct P2PParlay<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        maker: address,
        event_ids: vector<vector<u8>>,
        event_names: vector<vector<u8>>,
        predictions: vector<vector<u8>>,
        leg_statuses: vector<u8>,
        legs_settled: u64,
        maker_stake: 0x2::balance::Balance<T0>,
        taker_required: u64,
        taker: 0x1::option::Option<address>,
        taker_balance: 0x2::balance::Balance<T0>,
        status: u8,
        created_at: u64,
        expires_at: u64,
        maker_rebate_bps: u64,
        taker_fee_bps: u64,
        pending_maker_wins: bool,
        settle_queued_at: u64,
        disputed: bool,
        disputer: 0x1::option::Option<address>,
    }

    struct PlatformCreated has copy, drop {
        config_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        admin: address,
        min_stake: u64,
        fee_bps: u64,
        dispute_window_ms: u64,
        timestamp: u64,
    }

    struct ConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
        fee_bps: u64,
        min_stake: u64,
        dispute_window_ms: u64,
        timestamp: u64,
    }

    struct OracleCapMinted has copy, drop {
        oracle_cap_id: 0x2::object::ID,
        recipient: address,
        timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        config_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct OfferPosted has copy, drop {
        offer_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        maker: address,
        event_id: vector<u8>,
        event_name: vector<u8>,
        prediction: vector<u8>,
        market_type: vector<u8>,
        odds_bps: u64,
        maker_stake: u64,
        maker_rebate_bps: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct OfferFilled has copy, drop {
        offer_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        taker: address,
        fill_amount: u64,
        remaining: u64,
        timestamp: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        refund: u64,
        timestamp: u64,
    }

    struct OfferExpired has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        refund: u64,
        timestamp: u64,
    }

    struct BetSettleQueued has copy, drop {
        bet_id: 0x2::object::ID,
        pending_maker_wins: bool,
        settle_due_ms: u64,
        timestamp: u64,
    }

    struct BetDisputed has copy, drop {
        bet_id: 0x2::object::ID,
        disputer: address,
        timestamp: u64,
    }

    struct BetDisputeResolved has copy, drop {
        bet_id: 0x2::object::ID,
        oracle: address,
        maker_wins: bool,
        new_settle_due: u64,
        timestamp: u64,
    }

    struct BetSettled has copy, drop {
        bet_id: 0x2::object::ID,
        status: u8,
        winner: address,
        payout: u64,
        platform_fee: u64,
        timestamp: u64,
    }

    struct BetVoided has copy, drop {
        bet_id: 0x2::object::ID,
        maker_refund: u64,
        taker_refund: u64,
        timestamp: u64,
    }

    struct ParlayPosted has copy, drop {
        parlay_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        maker: address,
        num_legs: u64,
        maker_stake: u64,
        taker_required: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct ParlayAccepted has copy, drop {
        parlay_id: 0x2::object::ID,
        taker: address,
        taker_stake: u64,
        taker_fee_bps: u64,
        timestamp: u64,
    }

    struct ParlayLegSettled has copy, drop {
        parlay_id: 0x2::object::ID,
        leg_index: u64,
        leg_status: u8,
        timestamp: u64,
    }

    struct ParlayLegVoided has copy, drop {
        parlay_id: 0x2::object::ID,
        leg_index: u64,
        timestamp: u64,
    }

    struct ParlaySettleQueued has copy, drop {
        parlay_id: 0x2::object::ID,
        pending_maker_wins: bool,
        settle_due_ms: u64,
        timestamp: u64,
    }

    struct ParlayDisputed has copy, drop {
        parlay_id: 0x2::object::ID,
        disputer: address,
        timestamp: u64,
    }

    struct ParlaySettled has copy, drop {
        parlay_id: 0x2::object::ID,
        status: u8,
        winner: address,
        payout: u64,
        platform_fee: u64,
        timestamp: u64,
    }

    struct ParlayVoided has copy, drop {
        parlay_id: 0x2::object::ID,
        maker_refund: u64,
        taker_refund: u64,
        timestamp: u64,
    }

    struct ParlayExpired has copy, drop {
        parlay_id: 0x2::object::ID,
        maker: address,
        refund: u64,
        timestamp: u64,
    }

    struct ParlayDisputeResolved has copy, drop {
        parlay_id: 0x2::object::ID,
        maker_wins: bool,
        new_settle_due: u64,
        timestamp: u64,
    }

    public entry fun accept_offer<T0>(arg0: &mut P2PConfig, arg1: &mut P2PRegistry, arg2: &mut P2POffer<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg0), 13);
        assert!(arg2.status == 0, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 != arg2.maker, 8);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 < arg2.expires_at, 9);
        assert!(arg4 >= arg0.min_stake, 3);
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 7);
        let v2 = (((arg4 as u128) * 10000 / ((arg2.odds_bps - 10000) as u128)) as u64);
        let v3 = 0x2::balance::value<T0>(&arg2.maker_remaining);
        assert!(v3 > 0, 27);
        let v4 = if (v2 > v3) {
            v3
        } else {
            v2
        };
        let v5 = (((v4 as u128) * ((arg2.odds_bps - 10000) as u128) / 10000) as u64);
        assert!(v5 <= arg4, 25);
        let v6 = get_taker_fee_bps(arg0, v0);
        add_taker_volume(arg0, v0, v5);
        arg0.total_bets = arg0.total_bets + 1;
        arg0.total_volume = arg0.total_volume + v5;
        let v7 = if (v5 < arg4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, arg4 - v5, arg6), v0);
            0x2::coin::into_balance<T0>(arg3)
        } else {
            0x2::coin::into_balance<T0>(arg3)
        };
        arg2.filled_taker = arg2.filled_taker + v5;
        arg2.match_count = arg2.match_count + 1;
        let v8 = 0x2::balance::value<T0>(&arg2.maker_remaining);
        if (v8 < arg0.min_stake) {
            arg2.status = 1;
            if (0x2::table::contains<0x2::object::ID, bool>(&arg1.open_offers, 0x2::object::id<P2POffer<T0>>(arg2))) {
                0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open_offers, 0x2::object::id<P2POffer<T0>>(arg2));
            };
        };
        let v9 = P2PMatchedBet<T0>{
            id                 : 0x2::object::new(arg6),
            offer_id           : 0x2::object::id<P2POffer<T0>>(arg2),
            config_id          : 0x2::object::id<P2PConfig>(arg0),
            maker              : arg2.maker,
            taker              : v0,
            event_id           : arg2.event_id,
            event_name         : arg2.event_name,
            prediction         : arg2.prediction,
            odds_bps           : arg2.odds_bps,
            maker_balance      : 0x2::balance::split<T0>(&mut arg2.maker_remaining, v4),
            taker_balance      : v7,
            status             : 2,
            created_at         : v1,
            expires_at         : arg2.expires_at,
            maker_rebate_bps   : arg2.maker_rebate_bps,
            taker_fee_bps      : v6,
            pending_maker_wins : false,
            settle_queued_at   : 0,
            disputed           : false,
            disputer           : 0x1::option::none<address>(),
        };
        let v10 = OfferFilled{
            offer_id    : 0x2::object::id<P2POffer<T0>>(arg2),
            bet_id      : 0x2::object::id<P2PMatchedBet<T0>>(&v9),
            taker       : v0,
            fill_amount : v5,
            remaining   : v8,
            timestamp   : v1,
        };
        0x2::event::emit<OfferFilled>(v10);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(&v9), true);
        0x2::transfer::share_object<P2PMatchedBet<T0>>(v9);
    }

    public entry fun accept_parlay<T0>(arg0: &mut P2PConfig, arg1: &mut P2PParlay<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(arg1.config_id == 0x2::object::id<P2PConfig>(arg0), 13);
        assert!(arg1.status == 0, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 != arg1.maker, 8);
        assert!(v1 == arg1.taker_required, 7);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 < arg1.expires_at, 9);
        let v3 = get_taker_fee_bps(arg0, v0);
        add_taker_volume(arg0, v0, v1);
        arg0.total_volume = arg0.total_volume + v1;
        arg1.taker = 0x1::option::some<address>(v0);
        0x2::balance::join<T0>(&mut arg1.taker_balance, 0x2::coin::into_balance<T0>(arg2));
        arg1.taker_fee_bps = v3;
        arg1.status = 2;
        let v4 = ParlayAccepted{
            parlay_id     : 0x2::object::id<P2PParlay<T0>>(arg1),
            taker         : v0,
            taker_stake   : v1,
            taker_fee_bps : v3,
            timestamp     : v2,
        };
        0x2::event::emit<ParlayAccepted>(v4);
    }

    fun add_maker_volume(arg0: &mut P2PConfig, arg1: address, arg2: u64) {
        let v0 = VolumeKey{addr: arg1};
        if (!0x2::dynamic_field::exists_<VolumeKey>(&arg0.id, v0)) {
            let v1 = VolumeKey{addr: arg1};
            let v2 = WalletVolume{
                maker_volume : arg2,
                taker_volume : 0,
                total_bets   : 1,
                wins         : 0,
            };
            0x2::dynamic_field::add<VolumeKey, WalletVolume>(&mut arg0.id, v1, v2);
        } else {
            let v3 = VolumeKey{addr: arg1};
            let v4 = 0x2::dynamic_field::borrow_mut<VolumeKey, WalletVolume>(&mut arg0.id, v3);
            v4.maker_volume = v4.maker_volume + arg2;
            v4.total_bets = v4.total_bets + 1;
        };
    }

    fun add_taker_volume(arg0: &mut P2PConfig, arg1: address, arg2: u64) {
        let v0 = VolumeKey{addr: arg1};
        if (!0x2::dynamic_field::exists_<VolumeKey>(&arg0.id, v0)) {
            let v1 = VolumeKey{addr: arg1};
            let v2 = WalletVolume{
                maker_volume : 0,
                taker_volume : arg2,
                total_bets   : 1,
                wins         : 0,
            };
            0x2::dynamic_field::add<VolumeKey, WalletVolume>(&mut arg0.id, v1, v2);
        } else {
            let v3 = VolumeKey{addr: arg1};
            let v4 = 0x2::dynamic_field::borrow_mut<VolumeKey, WalletVolume>(&mut arg0.id, v3);
            v4.taker_volume = v4.taker_volume + arg2;
            v4.total_bets = v4.total_bets + 1;
        };
    }

    public fun bet_disputed<T0>(arg0: &P2PMatchedBet<T0>) : bool {
        arg0.disputed
    }

    public fun bet_gross_pot<T0>(arg0: &P2PMatchedBet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.maker_balance) + 0x2::balance::value<T0>(&arg0.taker_balance)
    }

    public fun bet_maker<T0>(arg0: &P2PMatchedBet<T0>) : address {
        arg0.maker
    }

    public fun bet_pending_maker_wins<T0>(arg0: &P2PMatchedBet<T0>) : bool {
        arg0.pending_maker_wins
    }

    public fun bet_settle_queued_at<T0>(arg0: &P2PMatchedBet<T0>) : u64 {
        arg0.settle_queued_at
    }

    public fun bet_status<T0>(arg0: &P2PMatchedBet<T0>) : u8 {
        arg0.status
    }

    public fun bet_taker<T0>(arg0: &P2PMatchedBet<T0>) : address {
        arg0.taker
    }

    fun calc_payout(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = if (arg2 >= arg1) {
            0
        } else {
            arg1 - arg2
        };
        let v1 = (((arg0 as u128) * (v0 as u128) / (10000 as u128)) as u64);
        let v2 = if (v1 >= arg0) {
            0
        } else {
            arg0 - v1
        };
        (v2, v1)
    }

    public entry fun cancel_offer<T0>(arg0: &mut P2POffer<T0>, arg1: &mut P2PRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.maker, 1);
        assert!(arg0.status == 0, 5);
        let v0 = 0x2::balance::value<T0>(&arg0.maker_remaining);
        arg0.status = 7;
        let v1 = OfferCancelled{
            offer_id  : 0x2::object::id<P2POffer<T0>>(arg0),
            maker     : arg0.maker,
            refund    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OfferCancelled>(v1);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.open_offers, 0x2::object::id<P2POffer<T0>>(arg0))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open_offers, 0x2::object::id<P2POffer<T0>>(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.maker_remaining, v0), arg3), arg0.maker);
    }

    public entry fun cancel_parlay<T0>(arg0: &mut P2PParlay<T0>, arg1: &mut P2PRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.maker, 1);
        assert!(arg0.status == 0, 5);
        let v0 = 0x2::balance::value<T0>(&arg0.maker_stake);
        arg0.status = 7;
        let v1 = ParlayVoided{
            parlay_id    : 0x2::object::id<P2PParlay<T0>>(arg0),
            maker_refund : v0,
            taker_refund : 0,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ParlayVoided>(v1);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg0))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.maker_stake, v0), arg3), arg0.maker);
    }

    public entry fun claim_parlay<T0>(arg0: &mut P2PConfig, arg1: &mut P2PRegistry, arg2: &mut P2PParlay<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg0), 13);
        assert!(arg2.status == 3, 18);
        assert!(!arg2.disputed, 22);
        assert!(arg2.settle_queued_at > 0, 28);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.settle_queued_at + arg0.dispute_window_ms, 20);
        let v1 = 0x2::balance::value<T0>(&arg2.maker_stake);
        let v2 = 0x2::balance::value<T0>(&arg2.taker_balance);
        let (_, v4) = calc_payout(v1 + v2, arg2.taker_fee_bps, arg2.maker_rebate_bps);
        let v5 = 0x2::balance::split<T0>(&mut arg2.maker_stake, v1);
        0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(&mut arg2.taker_balance, v2));
        if (v4 > 0) {
            deposit_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v5, v4));
        };
        let v6 = if (arg2.pending_maker_wins) {
            arg2.maker
        } else {
            *0x1::option::borrow<address>(&arg2.taker)
        };
        let v7 = if (arg2.pending_maker_wins) {
            4
        } else {
            5
        };
        record_win(arg0, v6);
        arg2.status = v7;
        let v8 = ParlaySettled{
            parlay_id    : 0x2::object::id<P2PParlay<T0>>(arg2),
            status       : v7,
            winner       : v6,
            payout       : 0x2::balance::value<T0>(&v5),
            platform_fee : v4,
            timestamp    : v0,
        };
        0x2::event::emit<ParlaySettled>(v8);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg2))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg2));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg4), v6);
    }

    public entry fun claim_settlement<T0>(arg0: &mut P2PConfig, arg1: &mut P2PRegistry, arg2: &mut P2PMatchedBet<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg0), 13);
        assert!(arg2.status == 3, 23);
        assert!(!arg2.disputed, 22);
        assert!(arg2.settle_queued_at > 0, 28);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.settle_queued_at + arg0.dispute_window_ms, 20);
        let v1 = 0x2::balance::value<T0>(&arg2.maker_balance);
        let v2 = 0x2::balance::value<T0>(&arg2.taker_balance);
        let (_, v4) = calc_payout(v1 + v2, arg2.taker_fee_bps, arg2.maker_rebate_bps);
        let v5 = 0x2::balance::split<T0>(&mut arg2.maker_balance, v1);
        0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(&mut arg2.taker_balance, v2));
        if (v4 > 0) {
            deposit_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v5, v4));
        };
        let v6 = if (arg2.pending_maker_wins) {
            arg2.maker
        } else {
            arg2.taker
        };
        let v7 = if (arg2.pending_maker_wins) {
            4
        } else {
            5
        };
        record_win(arg0, v6);
        arg2.status = v7;
        let v8 = BetSettled{
            bet_id       : 0x2::object::id<P2PMatchedBet<T0>>(arg2),
            status       : v7,
            winner       : v6,
            payout       : 0x2::balance::value<T0>(&v5),
            platform_fee : v4,
            timestamp    : v0,
        };
        0x2::event::emit<BetSettled>(v8);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg2))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg2));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg4), v6);
    }

    public fun config_dispute_window(arg0: &P2PConfig) : u64 {
        arg0.dispute_window_ms
    }

    public fun config_paused(arg0: &P2PConfig) : bool {
        arg0.paused
    }

    public fun config_total_bets(arg0: &P2PConfig) : u64 {
        arg0.total_bets
    }

    public fun config_total_offers(arg0: &P2PConfig) : u64 {
        arg0.total_offers
    }

    public fun config_total_volume(arg0: &P2PConfig) : u64 {
        arg0.total_volume
    }

    fun count_leg_status(arg0: &vector<u8>, arg1: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v1) == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun deposit_fee<T0>(arg0: &mut P2PConfig, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_vault, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_vault, v0, arg1);
        };
    }

    public entry fun dispute_parlay<T0>(arg0: &mut P2PParlay<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 18);
        assert!(!arg0.disputed, 24);
        assert!(arg0.settle_queued_at > 0, 28);
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.disputed = true;
        arg0.disputer = 0x1::option::some<address>(v0);
        arg0.status = 9;
        let v1 = ParlayDisputed{
            parlay_id : 0x2::object::id<P2PParlay<T0>>(arg0),
            disputer  : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ParlayDisputed>(v1);
    }

    public entry fun dispute_settlement<T0>(arg0: &mut P2PMatchedBet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 23);
        assert!(!arg0.disputed, 24);
        assert!(arg0.settle_queued_at > 0, 28);
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.disputed = true;
        arg0.disputer = 0x1::option::some<address>(v0);
        arg0.status = 9;
        let v1 = BetDisputed{
            bet_id    : 0x2::object::id<P2PMatchedBet<T0>>(arg0),
            disputer  : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<BetDisputed>(v1);
    }

    public entry fun execute_withdrawal<T0>(arg0: &OracleCap, arg1: &mut P2PConfig, arg2: &mut WithdrawalProposal, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        assert!(!arg2.executed, 11);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(v0)) == arg2.coin_type, 13);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fee_vault, v0), 12);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fee_vault, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2.amount, 12);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2.amount), arg4);
        arg2.executed = true;
        let v4 = WithdrawalExecuted{
            proposal_id : 0x2::object::id<WithdrawalProposal>(arg2),
            config_id   : 0x2::object::id<P2PConfig>(arg1),
            amount      : arg2.amount,
            recipient   : arg2.recipient,
            timestamp   : v2,
        };
        0x2::event::emit<WithdrawalExecuted>(v4);
        let v5 = FeesWithdrawn{
            config_id : 0x2::object::id<P2PConfig>(arg1),
            coin_type : arg2.coin_type,
            amount    : arg2.amount,
            recipient : arg2.recipient,
            timestamp : v2,
        };
        0x2::event::emit<FeesWithdrawn>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg2.recipient);
    }

    public entry fun expire_offer<T0>(arg0: &mut P2POffer<T0>, arg1: &mut P2PRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.expires_at, 10);
        let v1 = 0x2::balance::value<T0>(&arg0.maker_remaining);
        arg0.status = 8;
        let v2 = OfferExpired{
            offer_id  : 0x2::object::id<P2POffer<T0>>(arg0),
            maker     : arg0.maker,
            refund    : v1,
            timestamp : v0,
        };
        0x2::event::emit<OfferExpired>(v2);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.open_offers, 0x2::object::id<P2POffer<T0>>(arg0))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open_offers, 0x2::object::id<P2POffer<T0>>(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.maker_remaining, v1), arg3), arg0.maker);
    }

    public entry fun expire_parlay<T0>(arg0: &mut P2PParlay<T0>, arg1: &mut P2PRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.expires_at, 10);
        let v1 = 0x2::balance::value<T0>(&arg0.maker_stake);
        arg0.status = 8;
        let v2 = ParlayExpired{
            parlay_id : 0x2::object::id<P2PParlay<T0>>(arg0),
            maker     : arg0.maker,
            refund    : v1,
            timestamp : v0,
        };
        0x2::event::emit<ParlayExpired>(v2);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg0))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.maker_stake, v1), arg3), arg0.maker);
    }

    fun get_maker_rebate_bps(arg0: &P2PConfig, arg1: address) : u64 {
        maker_rebate_for_volume(get_wallet_volume(arg0, arg1))
    }

    fun get_taker_fee_bps(arg0: &P2PConfig, arg1: address) : u64 {
        taker_fee_for_volume(get_wallet_volume(arg0, arg1))
    }

    fun get_wallet_volume(arg0: &P2PConfig, arg1: address) : u64 {
        let v0 = VolumeKey{addr: arg1};
        if (!0x2::dynamic_field::exists_<VolumeKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = VolumeKey{addr: arg1};
        let v2 = 0x2::dynamic_field::borrow<VolumeKey, WalletVolume>(&arg0.id, v1);
        v2.maker_volume + v2.taker_volume
    }

    fun init(arg0: P2P_BETTING, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<P2P_BETTING>(&arg0), 0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = OracleCap{id: 0x2::object::new(arg1)};
        let v3 = P2PConfig{
            id                : 0x2::object::new(arg1),
            admin             : v0,
            paused            : false,
            min_stake         : 10000000,
            default_fee_bps   : 200,
            dispute_window_ms : 7200000,
            total_offers      : 0,
            total_bets        : 0,
            total_parlays     : 0,
            total_volume      : 0,
            fee_vault         : 0x2::bag::new(arg1),
        };
        let v4 = P2PRegistry{
            id           : 0x2::object::new(arg1),
            open_offers  : 0x2::table::new<0x2::object::ID, bool>(arg1),
            live_bets    : 0x2::table::new<0x2::object::ID, bool>(arg1),
            open_parlays : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        let v5 = PlatformCreated{
            config_id         : 0x2::object::id<P2PConfig>(&v3),
            registry_id       : 0x2::object::id<P2PRegistry>(&v4),
            admin             : v0,
            min_stake         : 10000000,
            fee_bps           : 200,
            dispute_window_ms : 7200000,
            timestamp         : 0,
        };
        0x2::event::emit<PlatformCreated>(v5);
        0x2::transfer::share_object<P2PConfig>(v3);
        0x2::transfer::share_object<P2PRegistry>(v4);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::transfer<OracleCap>(v2, v0);
    }

    public entry fun instant_settle_bet<T0>(arg0: &OracleCap, arg1: &mut P2PConfig, arg2: &mut P2PRegistry, arg3: &mut P2PMatchedBet<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        let v0 = if (arg3.status == 2) {
            true
        } else if (arg3.status == 3) {
            true
        } else {
            arg3.status == 9
        };
        assert!(v0, 11);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::balance::value<T0>(&arg3.maker_balance);
        let v3 = 0x2::balance::value<T0>(&arg3.taker_balance);
        let (_, v5) = calc_payout(v2 + v3, arg3.taker_fee_bps, arg3.maker_rebate_bps);
        let v6 = 0x2::balance::split<T0>(&mut arg3.maker_balance, v2);
        0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(&mut arg3.taker_balance, v3));
        if (v5 > 0) {
            deposit_fee<T0>(arg1, 0x2::balance::split<T0>(&mut v6, v5));
        };
        let v7 = if (arg4) {
            arg3.maker
        } else {
            arg3.taker
        };
        let v8 = if (arg4) {
            4
        } else {
            5
        };
        record_win(arg1, v7);
        arg3.status = v8;
        arg3.pending_maker_wins = arg4;
        arg3.settle_queued_at = v1;
        let v9 = BetSettled{
            bet_id       : 0x2::object::id<P2PMatchedBet<T0>>(arg3),
            status       : v8,
            winner       : v7,
            payout       : 0x2::balance::value<T0>(&v6),
            platform_fee : v5,
            timestamp    : v1,
        };
        0x2::event::emit<BetSettled>(v9);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg2.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg3))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg6), v7);
    }

    public entry fun instant_settle_parlay<T0>(arg0: &OracleCap, arg1: &mut P2PConfig, arg2: &mut P2PRegistry, arg3: &mut P2PParlay<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        assert!(0x1::option::is_some<address>(&arg3.taker), 19);
        let v0 = if (arg3.status == 2) {
            true
        } else if (arg3.status == 3) {
            true
        } else {
            arg3.status == 9
        };
        assert!(v0, 11);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::balance::value<T0>(&arg3.maker_stake);
        let v3 = 0x2::balance::value<T0>(&arg3.taker_balance);
        let (_, v5) = calc_payout(v2 + v3, arg3.taker_fee_bps, arg3.maker_rebate_bps);
        let v6 = 0x2::balance::split<T0>(&mut arg3.maker_stake, v2);
        0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(&mut arg3.taker_balance, v3));
        if (v5 > 0) {
            deposit_fee<T0>(arg1, 0x2::balance::split<T0>(&mut v6, v5));
        };
        let v7 = if (arg4) {
            arg3.maker
        } else {
            *0x1::option::borrow<address>(&arg3.taker)
        };
        let v8 = if (arg4) {
            4
        } else {
            5
        };
        record_win(arg1, v7);
        arg3.status = v8;
        arg3.pending_maker_wins = arg4;
        arg3.settle_queued_at = v1;
        let v9 = ParlaySettled{
            parlay_id    : 0x2::object::id<P2PParlay<T0>>(arg3),
            status       : v8,
            winner       : v7,
            payout       : 0x2::balance::value<T0>(&v6),
            platform_fee : v5,
            timestamp    : v1,
        };
        0x2::event::emit<ParlaySettled>(v9);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg2.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg3))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg6), v7);
    }

    public entry fun instant_void_bet<T0>(arg0: &OracleCap, arg1: &P2PConfig, arg2: &mut P2PRegistry, arg3: &mut P2PMatchedBet<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        let v0 = if (arg3.status == 2) {
            true
        } else if (arg3.status == 3) {
            true
        } else {
            arg3.status == 9
        };
        assert!(v0, 11);
        let v1 = 0x2::balance::value<T0>(&arg3.maker_balance);
        let v2 = 0x2::balance::value<T0>(&arg3.taker_balance);
        arg3.status = 6;
        let v3 = BetVoided{
            bet_id       : 0x2::object::id<P2PMatchedBet<T0>>(arg3),
            maker_refund : v1,
            taker_refund : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BetVoided>(v3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg2.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg3))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.maker_balance, v1), arg5), arg3.maker);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.taker_balance, v2), arg5), arg3.taker);
    }

    fun maker_rebate_for_volume(arg0: u64) : u64 {
        if (arg0 >= 100000000000000) {
            return 30
        };
        if (arg0 >= 10000000000000) {
            return 20
        };
        if (arg0 >= 1000000000000) {
            return 10
        };
        if (arg0 >= 100000000000) {
            return 0
        };
        0
    }

    public entry fun mint_oracle_cap(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleCap{id: 0x2::object::new(arg3)};
        let v1 = OracleCapMinted{
            oracle_cap_id : 0x2::object::id<OracleCap>(&v0),
            recipient     : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OracleCapMinted>(v1);
        0x2::transfer::transfer<OracleCap>(v0, arg1);
    }

    public fun offer_filled<T0>(arg0: &P2POffer<T0>) : u64 {
        arg0.filled_taker
    }

    public fun offer_maker<T0>(arg0: &P2POffer<T0>) : address {
        arg0.maker
    }

    public fun offer_match_count<T0>(arg0: &P2POffer<T0>) : u64 {
        arg0.match_count
    }

    public fun offer_remaining<T0>(arg0: &P2POffer<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.maker_remaining)
    }

    public fun offer_status<T0>(arg0: &P2POffer<T0>) : u8 {
        arg0.status
    }

    public fun parlay_legs_settled<T0>(arg0: &P2PParlay<T0>) : u64 {
        arg0.legs_settled
    }

    public fun parlay_num_legs<T0>(arg0: &P2PParlay<T0>) : u64 {
        0x1::vector::length<u8>(&arg0.leg_statuses)
    }

    public fun parlay_status<T0>(arg0: &P2PParlay<T0>) : u8 {
        arg0.status
    }

    public entry fun post_offer<T0>(arg0: &mut P2PConfig, arg1: &mut P2PRegistry, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(arg7 > 10000 && arg7 <= 10000000, 2);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= arg0.min_stake, 3);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg8 > v2, 9);
        let v3 = get_maker_rebate_bps(arg0, v0);
        add_maker_volume(arg0, v0, v1);
        arg0.total_offers = arg0.total_offers + 1;
        arg0.total_volume = arg0.total_volume + v1;
        let v4 = P2POffer<T0>{
            id                : 0x2::object::new(arg10),
            config_id         : 0x2::object::id<P2PConfig>(arg0),
            maker             : v0,
            event_id          : arg3,
            event_name        : arg4,
            prediction        : arg5,
            market_type       : arg6,
            odds_bps          : arg7,
            maker_stake_total : v1,
            maker_remaining   : 0x2::coin::into_balance<T0>(arg2),
            filled_taker      : 0,
            match_count       : 0,
            status            : 0,
            created_at        : v2,
            expires_at        : arg8,
            maker_rebate_bps  : v3,
        };
        let v5 = OfferPosted{
            offer_id         : 0x2::object::id<P2POffer<T0>>(&v4),
            config_id        : 0x2::object::id<P2PConfig>(arg0),
            maker            : v0,
            event_id         : v4.event_id,
            event_name       : v4.event_name,
            prediction       : v4.prediction,
            market_type      : v4.market_type,
            odds_bps         : arg7,
            maker_stake      : v1,
            maker_rebate_bps : v3,
            expires_at       : arg8,
            timestamp        : v2,
        };
        0x2::event::emit<OfferPosted>(v5);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.open_offers, 0x2::object::id<P2POffer<T0>>(&v4), true);
        0x2::transfer::share_object<P2POffer<T0>>(v4);
    }

    public entry fun post_parlay<T0>(arg0: &mut P2PConfig, arg1: &mut P2PRegistry, arg2: 0x2::coin::Coin<T0>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<u64>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 >= 2 && v0 <= 8, 16);
        assert!(arg7 > 10000, 2);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= arg0.min_stake, 3);
        let v3 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg8 > v3, 9);
        let v4 = (((v2 as u128) * ((arg7 - 10000) as u128) / 10000) as u64);
        assert!(v4 >= arg0.min_stake, 3);
        let v5 = get_maker_rebate_bps(arg0, v1);
        add_maker_volume(arg0, v1, v2);
        arg0.total_parlays = arg0.total_parlays + 1;
        arg0.total_volume = arg0.total_volume + v2;
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 0;
        while (v7 < v0) {
            0x1::vector::push_back<u8>(&mut v6, 0);
            v7 = v7 + 1;
        };
        let v8 = P2PParlay<T0>{
            id                 : 0x2::object::new(arg10),
            config_id          : 0x2::object::id<P2PConfig>(arg0),
            maker              : v1,
            event_ids          : arg3,
            event_names        : arg4,
            predictions        : arg5,
            leg_statuses       : v6,
            legs_settled       : 0,
            maker_stake        : 0x2::coin::into_balance<T0>(arg2),
            taker_required     : v4,
            taker              : 0x1::option::none<address>(),
            taker_balance      : 0x2::balance::zero<T0>(),
            status             : 0,
            created_at         : v3,
            expires_at         : arg8,
            maker_rebate_bps   : v5,
            taker_fee_bps      : 0,
            pending_maker_wins : false,
            settle_queued_at   : 0,
            disputed           : false,
            disputer           : 0x1::option::none<address>(),
        };
        let v9 = ParlayPosted{
            parlay_id      : 0x2::object::id<P2PParlay<T0>>(&v8),
            config_id      : 0x2::object::id<P2PConfig>(arg0),
            maker          : v1,
            num_legs       : v0,
            maker_stake    : v2,
            taker_required : v4,
            expires_at     : arg8,
            timestamp      : v3,
        };
        0x2::event::emit<ParlayPosted>(v9);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.open_parlays, 0x2::object::id<P2PParlay<T0>>(&v8), true);
        0x2::transfer::share_object<P2PParlay<T0>>(v8);
    }

    public entry fun propose_withdrawal<T0>(arg0: &AdminCap, arg1: &P2PConfig, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fee_vault, v0), 12);
        assert!(0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.fee_vault, v0)) >= arg2, 12);
        let v1 = WithdrawalProposal{
            id          : 0x2::object::new(arg5),
            config_id   : 0x2::object::id<P2PConfig>(arg1),
            coin_type   : 0x1::ascii::into_bytes(0x1::type_name::into_string(v0)),
            amount      : arg2,
            recipient   : arg3,
            proposed_at : 0x2::clock::timestamp_ms(arg4),
            executed    : false,
        };
        0x2::transfer::share_object<WithdrawalProposal>(v1);
    }

    public entry fun queue_finalize_parlay<T0>(arg0: &OracleCap, arg1: &P2PConfig, arg2: &mut P2PParlay<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        assert!(arg2.status == 3 || arg2.status == 2, 18);
        assert!(0x1::option::is_some<address>(&arg2.taker), 19);
        assert!(count_leg_status(&arg2.leg_statuses, 0) == 0, 15);
        let v0 = count_leg_status(&arg2.leg_statuses, 2) == 0;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        arg2.pending_maker_wins = v0;
        arg2.settle_queued_at = v1;
        arg2.disputed = false;
        arg2.status = 3;
        let v2 = ParlaySettleQueued{
            parlay_id          : 0x2::object::id<P2PParlay<T0>>(arg2),
            pending_maker_wins : v0,
            settle_due_ms      : v1 + arg1.dispute_window_ms,
            timestamp          : v1,
        };
        0x2::event::emit<ParlaySettleQueued>(v2);
    }

    public entry fun queue_settle_bet<T0>(arg0: &OracleCap, arg1: &P2PConfig, arg2: &mut P2PMatchedBet<T0>, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        assert!(arg2.status == 2, 6);
        assert!(arg2.settle_queued_at == 0, 11);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.status = 3;
        arg2.pending_maker_wins = arg3;
        arg2.settle_queued_at = v0;
        arg2.disputed = false;
        let v1 = BetSettleQueued{
            bet_id             : 0x2::object::id<P2PMatchedBet<T0>>(arg2),
            pending_maker_wins : arg3,
            settle_due_ms      : v0 + arg1.dispute_window_ms,
            timestamp          : v0,
        };
        0x2::event::emit<BetSettleQueued>(v1);
    }

    fun record_win(arg0: &mut P2PConfig, arg1: address) {
        let v0 = VolumeKey{addr: arg1};
        if (0x2::dynamic_field::exists_<VolumeKey>(&arg0.id, v0)) {
            let v1 = VolumeKey{addr: arg1};
            let v2 = 0x2::dynamic_field::borrow_mut<VolumeKey, WalletVolume>(&mut arg0.id, v1);
            v2.wins = v2.wins + 1;
        };
    }

    public fun registry_live_bets_count(arg0: &P2PRegistry) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.live_bets)
    }

    public fun registry_open_offers_count(arg0: &P2PRegistry) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.open_offers)
    }

    public fun registry_open_parlays_count(arg0: &P2PRegistry) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.open_parlays)
    }

    public entry fun resolve_dispute<T0>(arg0: &OracleCap, arg1: &P2PConfig, arg2: &mut P2PMatchedBet<T0>, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        assert!(arg2.status == 9, 23);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.pending_maker_wins = arg3;
        arg2.settle_queued_at = v0;
        arg2.disputed = false;
        arg2.disputer = 0x1::option::none<address>();
        arg2.status = 3;
        let v1 = BetDisputeResolved{
            bet_id         : 0x2::object::id<P2PMatchedBet<T0>>(arg2),
            oracle         : @0x0,
            maker_wins     : arg3,
            new_settle_due : v0 + arg1.dispute_window_ms,
            timestamp      : v0,
        };
        0x2::event::emit<BetDisputeResolved>(v1);
    }

    public entry fun resolve_parlay_dispute<T0>(arg0: &OracleCap, arg1: &P2PConfig, arg2: &mut P2PParlay<T0>, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(arg2.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        assert!(arg2.status == 9, 18);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.pending_maker_wins = arg3;
        arg2.settle_queued_at = v0;
        arg2.disputed = false;
        arg2.disputer = 0x1::option::none<address>();
        arg2.status = 3;
        let v1 = ParlayDisputeResolved{
            parlay_id      : 0x2::object::id<P2PParlay<T0>>(arg2),
            maker_wins     : arg3,
            new_settle_due : v0 + arg1.dispute_window_ms,
            timestamp      : v0,
        };
        0x2::event::emit<ParlayDisputeResolved>(v1);
    }

    public entry fun set_dispute_window(arg0: &AdminCap, arg1: &mut P2PConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.dispute_window_ms = arg2;
        let v0 = ConfigUpdated{
            config_id         : 0x2::object::id<P2PConfig>(arg1),
            paused            : arg1.paused,
            fee_bps           : arg1.default_fee_bps,
            min_stake         : arg1.min_stake,
            dispute_window_ms : arg2,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public entry fun set_min_stake(arg0: &AdminCap, arg1: &mut P2PConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 > 0, 3);
        arg1.min_stake = arg2;
        let v0 = ConfigUpdated{
            config_id         : 0x2::object::id<P2PConfig>(arg1),
            paused            : arg1.paused,
            fee_bps           : arg1.default_fee_bps,
            min_stake         : arg2,
            dispute_window_ms : arg1.dispute_window_ms,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut P2PConfig, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        let v0 = ConfigUpdated{
            config_id         : 0x2::object::id<P2PConfig>(arg1),
            paused            : arg2,
            fee_bps           : arg1.default_fee_bps,
            min_stake         : arg1.min_stake,
            dispute_window_ms : arg1.dispute_window_ms,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public entry fun settle_parlay_leg<T0>(arg0: &OracleCap, arg1: &mut P2PParlay<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(arg1.status == 2 || arg1.status == 3, 18);
        assert!(arg2 < 0x1::vector::length<u8>(&arg1.leg_statuses), 17);
        assert!(*0x1::vector::borrow<u8>(&arg1.leg_statuses, arg2) == 0, 14);
        let v0 = if (arg3) {
            1
        } else {
            2
        };
        *0x1::vector::borrow_mut<u8>(&mut arg1.leg_statuses, arg2) = v0;
        arg1.legs_settled = arg1.legs_settled + 1;
        if (arg1.status == 2) {
            arg1.status = 3;
        };
        let v1 = ParlayLegSettled{
            parlay_id  : 0x2::object::id<P2PParlay<T0>>(arg1),
            leg_index  : arg2,
            leg_status : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ParlayLegSettled>(v1);
    }

    fun taker_fee_for_volume(arg0: u64) : u64 {
        if (arg0 >= 100000000000000) {
            return 50
        };
        if (arg0 >= 10000000000000) {
            return 75
        };
        if (arg0 >= 1000000000000) {
            return 100
        };
        if (arg0 >= 100000000000) {
            return 150
        };
        200
    }

    public entry fun void_bet<T0>(arg0: &OracleCap, arg1: &P2PConfig, arg2: &mut P2PRegistry, arg3: &mut P2PMatchedBet<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        let v0 = if (arg3.status == 2) {
            true
        } else if (arg3.status == 3) {
            true
        } else {
            arg3.status == 9
        };
        assert!(v0, 11);
        let v1 = 0x2::balance::value<T0>(&arg3.maker_balance);
        let v2 = 0x2::balance::value<T0>(&arg3.taker_balance);
        arg3.status = 6;
        let v3 = BetVoided{
            bet_id       : 0x2::object::id<P2PMatchedBet<T0>>(arg3),
            maker_refund : v1,
            taker_refund : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BetVoided>(v3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg2.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg3))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.live_bets, 0x2::object::id<P2PMatchedBet<T0>>(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.maker_balance, v1), arg5), arg3.maker);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.taker_balance, v2), arg5), arg3.taker);
    }

    public entry fun void_parlay<T0>(arg0: &OracleCap, arg1: &P2PConfig, arg2: &mut P2PRegistry, arg3: &mut P2PParlay<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.config_id == 0x2::object::id<P2PConfig>(arg1), 13);
        let v0 = if (arg3.status == 0) {
            true
        } else if (arg3.status == 2) {
            true
        } else if (arg3.status == 3) {
            true
        } else {
            arg3.status == 9
        };
        assert!(v0, 11);
        let v1 = 0x2::balance::value<T0>(&arg3.maker_stake);
        let v2 = 0x2::balance::value<T0>(&arg3.taker_balance);
        arg3.status = 6;
        let v3 = ParlayVoided{
            parlay_id    : 0x2::object::id<P2PParlay<T0>>(arg3),
            maker_refund : v1,
            taker_refund : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ParlayVoided>(v3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg2.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg3))) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.open_parlays, 0x2::object::id<P2PParlay<T0>>(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.maker_stake, v1), arg5), arg3.maker);
        if (v2 > 0 && 0x1::option::is_some<address>(&arg3.taker)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.taker_balance, v2), arg5), *0x1::option::borrow<address>(&arg3.taker));
        };
    }

    public entry fun void_parlay_leg<T0>(arg0: &OracleCap, arg1: &mut P2PParlay<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.status == 2 || arg1.status == 3, 18);
        assert!(arg2 < 0x1::vector::length<u8>(&arg1.leg_statuses), 17);
        assert!(*0x1::vector::borrow<u8>(&arg1.leg_statuses, arg2) == 0, 14);
        *0x1::vector::borrow_mut<u8>(&mut arg1.leg_statuses, arg2) = 3;
        arg1.legs_settled = arg1.legs_settled + 1;
        if (arg1.status == 2) {
            arg1.status = 3;
        };
        let v0 = ParlayLegVoided{
            parlay_id : 0x2::object::id<P2PParlay<T0>>(arg1),
            leg_index : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ParlayLegVoided>(v0);
    }

    public fun wallet_maker_rebate_bps(arg0: &P2PConfig, arg1: address) : u64 {
        get_maker_rebate_bps(arg0, arg1)
    }

    public fun wallet_taker_fee_bps(arg0: &P2PConfig, arg1: address) : u64 {
        get_taker_fee_bps(arg0, arg1)
    }

    public fun wallet_volume(arg0: &P2PConfig, arg1: address) : u64 {
        get_wallet_volume(arg0, arg1)
    }

    public entry fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut P2PConfig, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fee_vault, v0), 12);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fee_vault, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 12);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg5);
        let v3 = FeesWithdrawn{
            config_id : 0x2::object::id<P2PConfig>(arg1),
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(v0)),
            amount    : arg2,
            recipient : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FeesWithdrawn>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg3);
    }

    // decompiled from Move bytecode v7
}

