module 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::game {
    struct RoundInfo has store {
        total_deployed: u64,
        deployed: vector<u64>,
        winning_square: u8,
        losing_pot_after_fee: u64,
        winners_total: u64,
        round_reward: u64,
        rng: u64,
    }

    struct Board has key {
        id: 0x2::object::UID,
        version: u64,
        cur_id: u64,
        cur_started: bool,
        cur_start_ms: u64,
        cur_end_ms: u64,
        cur_total: u64,
        cur_deployed: vector<u64>,
        cur_players: u64,
        rounds: 0x2::table::Table<u64, RoundInfo>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        dev_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        buyback: 0x2::balance::Balance<0x2::sui::SUI>,
        motherlode: 0x2::balance::Balance<0x2::sui::SUI>,
        unrefined: 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>,
        unrefined_total: u64,
        acc: u256,
        reward: u64,
        step_rounds: u64,
        decay_ppm: u64,
        step_count: u64,
        full_reward_deploy: u64,
        committed: u64,
        round_ms: u64,
        freeze_ms: u64,
        min_deploy: u64,
        vault_bps: u64,
        buyback_bps: u64,
        ml_odds: u64,
        ml_share_bps: u64,
        refine_fee_bps: u64,
        paused: bool,
    }

    struct JackpotKey has copy, drop, store {
        round_id: u64,
    }

    struct SeatKey has copy, drop, store {
        round_id: u64,
        player: address,
    }

    struct RoundLeftKey has copy, drop, store {
        round_id: u64,
    }

    struct UnrefinedKey has copy, drop, store {
        player: address,
    }

    struct Unrefined has drop, store {
        amount: u64,
        bonus: u64,
        snap: u256,
    }

    struct TicketsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Tickets has store {
        epoch: u64,
        total: u64,
        count: u64,
    }

    struct TicketKey has copy, drop, store {
        epoch: u64,
        i: u64,
    }

    struct TicketEntry has drop, store {
        player: address,
        end: u64,
    }

    struct PlayerTicketsKey has copy, drop, store {
        epoch: u64,
        player: address,
    }

    struct FundBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct V5FromKey has copy, drop, store {
        dummy_field: bool,
    }

    struct V8FromKey has copy, drop, store {
        dummy_field: bool,
    }

    struct V9FromKey has copy, drop, store {
        dummy_field: bool,
    }

    struct V10FromKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MaxTilesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RefineClockKey has copy, drop, store {
        player: address,
    }

    struct RefineFromKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LiquidityKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoughtKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LpKey has copy, drop, store {
        i: u64,
    }

    struct LpCountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GtsYieldKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GtsYield has store {
        rewards: 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>,
        acc: u256,
        paid_total: u64,
    }

    struct GtsPosKey has copy, drop, store {
        player: address,
        locked: bool,
    }

    struct GtsPos has drop, store {
        snap: u256,
        pending: u64,
    }

    struct StakeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StakeBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScheduleKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MinterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LimiterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwedKey has copy, drop, store {
        player: address,
    }

    struct PriceRefKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MarketAliveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TestPoolKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AutoCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AutoKey has copy, drop, store {
        player: address,
    }

    struct AutoSeat has store {
        miner: Miner,
        tickets: u64,
        ticket_epoch: u64,
        claims: u64,
        rounds: u64,
        wins: u64,
        deployed: u64,
        fees: u64,
        won: u64,
        mined: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuybackReceipt {
        sui: u64,
    }

    struct LiquidityReceipt {
        sui: u64,
    }

    struct Miner has store, key {
        id: 0x2::object::UID,
        round_id: u64,
        deployed: vector<u64>,
        total_deployed: u64,
    }

    struct ParamsChanged has copy, drop {
        ml_odds: u64,
        ml_share_bps: u64,
        vault_bps: u64,
        buyback_bps: u64,
        refine_fee_bps: u64,
        min_deploy: u64,
        round_ms: u64,
        freeze_ms: u64,
        paused: bool,
    }

    struct EmissionChanged has copy, drop {
        reward: u64,
        step_rounds: u64,
        decay_ppm: u64,
        step_count: u64,
        full_reward_deploy: u64,
    }

    struct Renounced has copy, drop {
        dummy_field: bool,
    }

    struct RoundSettled has copy, drop {
        round_id: u64,
        winning_square: u8,
        total_deployed: u64,
        winners_total: u64,
        round_reward: u64,
        losing_pot: u64,
        winners_payout: u64,
        vault_fee: u64,
        buyback_fee: u64,
        dev_fee: u64,
        players: u64,
        committed: u64,
        next_reward: u64,
    }

    struct MotherlodeUpdate has copy, drop {
        round_id: u64,
        added: u64,
        paid: u64,
        balance: u64,
    }

    struct WealthFundWon has copy, drop {
        round_id: u64,
        epoch: u64,
        winner: address,
        amount: u64,
        winner_tickets: u64,
        total_tickets: u64,
    }

    struct TicketsAdded has copy, drop {
        round_id: u64,
        epoch: u64,
        player: address,
        tickets: u64,
        total: u64,
    }

    struct MotherlodeReturned has copy, drop {
        round_id: u64,
        amount: u64,
        balance: u64,
    }

    struct Forfeited has copy, drop {
        round_id: u64,
        player: address,
        to_reserve: u64,
        to_fund: u64,
    }

    struct GtsWithdrawn has copy, drop {
        player: address,
        amount: u64,
        fee: u64,
        bonus: u64,
        paid: u64,
        burned: u64,
    }

    struct Deployed has copy, drop {
        round_id: u64,
        player: address,
        amounts: vector<u64>,
        total: u64,
    }

    struct Claimed has copy, drop {
        round_id: u64,
        player: address,
        gts: u64,
        sui: u64,
    }

    struct BuybackTaken has copy, drop {
        amount: u64,
    }

    struct BuybackBurned has copy, drop {
        amount: u64,
    }

    struct BuybackDone has copy, drop {
        sui_spent: u64,
        gts_burned: u64,
    }

    struct StakingChanged has copy, drop {
        stake_bps: u64,
    }

    struct FundBpsChanged has copy, drop {
        fund_bps: u64,
    }

    struct MaxTilesChanged has copy, drop {
        max_tiles: u64,
    }

    struct BuybackKept has copy, drop {
        sui_spent: u64,
        gts_kept: u64,
        gts_total: u64,
    }

    struct GtsYieldAdded has copy, drop {
        amount: u64,
        total_weight: u128,
    }

    struct GtsYieldClaimed has copy, drop {
        player: address,
        gts: u64,
    }

    struct LiquidityLocked has copy, drop {
        sui_spent: u64,
        gts_left: u64,
        position: 0x2::object::ID,
        positions: u64,
    }

    struct DrawPaid has copy, drop {
        round_id: u64,
        settler: address,
        amount: u64,
    }

    struct SupplyLocked has copy, drop {
        capped_treasury: 0x2::object::ID,
        minted: u64,
        max: u64,
    }

    struct WithdrawFeeShared has copy, drop {
        player: address,
        amount: u64,
        holders_total: u64,
    }

    struct MintRateLimited has copy, drop {
        limiter: 0x2::object::ID,
        per_day: u64,
    }

    struct AutoInstalled has copy, drop {
        cap: 0x2::object::ID,
    }

    struct AutoJoined has copy, drop {
        player: address,
    }

    struct AutoMined has copy, drop {
        round_id: u64,
        player: address,
        strategy: u8,
        spent: u64,
        deployed: u64,
        keeper_fee: u64,
        buyback_fee: u64,
    }

    struct AutoClaimed has copy, drop {
        round_id: u64,
        player: address,
        sui: u64,
        gts: u64,
    }

    struct LiquidityAdded has copy, drop {
        sui_swapped: u64,
        sui_added: u64,
        gts_added: u64,
        gts_left: u64,
        position: 0x2::object::ID,
    }

    struct FeesCompounded has copy, drop {
        sui_fees: u64,
        gts_fees: u64,
        sui_added: u64,
        gts_added: u64,
        sui_left: u64,
        gts_left: u64,
    }

    struct MarketToFund has copy, drop {
        round_id: u64,
        saved: u64,
        share: u64,
    }

    struct PositionLocked has copy, drop {
        position: 0x2::object::ID,
        liquidity: u128,
        from: address,
        positions: u64,
    }

    struct LiquidityGiven has copy, drop {
        from: address,
        gts_added: u64,
        sui_added: u64,
        position: 0x2::object::ID,
    }

    struct PriceRefSet has copy, drop {
        sqrt_price: u128,
    }

    struct GtsOwed has copy, drop {
        round_id: u64,
        player: address,
        amount: u64,
        owed: u64,
    }

    struct OwedPaid has copy, drop {
        player: address,
        amount: u64,
        owed: u64,
    }

    struct ReserveToFund has copy, drop {
        amount: u64,
        balance: u64,
    }

    fun add_tickets(arg0: &mut Board, arg1: u64, arg2: address, arg3: u64) {
        let v0 = tickets_mut(arg0);
        let v1 = v0.epoch;
        let v2 = v0.count;
        v0.total = v0.total + arg3;
        let v3 = v0.total;
        let v4 = if (v2 > 0) {
            let v5 = TicketKey{
                epoch : v1,
                i     : v2 - 1,
            };
            0x2::dynamic_field::borrow<TicketKey, TicketEntry>(&arg0.id, v5).player == arg2
        } else {
            false
        };
        if (v4) {
            let v6 = TicketKey{
                epoch : v1,
                i     : v2 - 1,
            };
            0x2::dynamic_field::borrow_mut<TicketKey, TicketEntry>(&mut arg0.id, v6).end = v3;
        } else {
            let v7 = TicketKey{
                epoch : v1,
                i     : v2,
            };
            let v8 = TicketEntry{
                player : arg2,
                end    : v3,
            };
            0x2::dynamic_field::add<TicketKey, TicketEntry>(&mut arg0.id, v7, v8);
            let v9 = tickets_mut(arg0);
            v9.count = v2 + 1;
        };
        let v10 = PlayerTicketsKey{
            epoch  : v1,
            player : arg2,
        };
        if (0x2::dynamic_field::exists<PlayerTicketsKey>(&arg0.id, v10)) {
            let v11 = 0x2::dynamic_field::borrow_mut<PlayerTicketsKey, u64>(&mut arg0.id, v10);
            *v11 = *v11 + arg3;
        } else {
            0x2::dynamic_field::add<PlayerTicketsKey, u64>(&mut arg0.id, v10, arg3);
        };
        let v12 = TicketsAdded{
            round_id : arg1,
            epoch    : v1,
            player   : arg2,
            tickets  : arg3,
            total    : v3,
        };
        0x2::event::emit<TicketsAdded>(v12);
    }

    fun add_to_pool(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg3: &mut 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(arg4);
        let v2 = if (v0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else if (lp_positions(arg0) == 0) {
            true
        } else {
            !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2)
        };
        if (v2) {
            return (0, 0)
        };
        let v3 = LpKey{i: 0};
        let v4 = 0x2::dynamic_object_field::borrow_mut<LpKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v3);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v4) != 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>>(arg2)) {
            return (0, 0)
        };
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v4);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2);
        if (v8 <= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v5) || v8 >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6)) {
            return (0, 0)
        };
        let (v9, _, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v5, v6, v7, v8, v0, true);
        let (v12, v13) = if (v9 > 0 && v11 <= v1) {
            (true, v0)
        } else {
            let (v14, v15, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v5, v6, v7, v8, v1, false);
            if (v14 == 0 || v15 > v0) {
                return (0, 0)
            };
            (false, v1)
        };
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg1, arg2, v4, v13, v12, arg5);
        let (v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(&v17);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg3, v18), 0x2::balance::split<0x2::sui::SUI>(arg4, v19), v17);
        (v18, v19)
    }

    fun add_unrefined(arg0: &mut Board, arg1: address, arg2: 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: u64) {
        let v0 = 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&arg2);
        let v1 = arg0.acc;
        let v2 = UnrefinedKey{player: arg1};
        if (!0x2::dynamic_field::exists<UnrefinedKey>(&arg0.id, v2)) {
            let v3 = Unrefined{
                amount : 0,
                bonus  : 0,
                snap   : v1,
            };
            0x2::dynamic_field::add<UnrefinedKey, Unrefined>(&mut arg0.id, v2, v3);
        };
        let v4 = RefineClockKey{player: arg1};
        if (0x2::dynamic_field::exists<RefineClockKey>(&arg0.id, v4)) {
            *0x2::dynamic_field::borrow_mut<RefineClockKey, u64>(&mut arg0.id, v4) = blended_start(refine_start(arg0, arg1), 0x2::dynamic_field::borrow<UnrefinedKey, Unrefined>(&arg0.id, v2).amount, v0, arg3);
        } else {
            0x2::dynamic_field::add<RefineClockKey, u64>(&mut arg0.id, v4, blended_start(refine_start(arg0, arg1), 0x2::dynamic_field::borrow<UnrefinedKey, Unrefined>(&arg0.id, v2).amount, v0, arg3));
        };
        let v5 = 0x2::dynamic_field::borrow_mut<UnrefinedKey, Unrefined>(&mut arg0.id, v2);
        v5.bonus = v5.bonus + earned(v5.amount, v1, v5.snap);
        v5.snap = v1;
        v5.amount = v5.amount + v0;
        arg0.unrefined_total = arg0.unrefined_total + v0;
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.unrefined, arg2);
    }

    fun auto_add_tickets(arg0: &mut Board, arg1: &mut AutoSeat, arg2: address, arg3: u64) {
        auto_drop_old_tickets(arg0, arg1);
        if (arg1.tickets > 0) {
            add_tickets(arg0, arg3, arg2, arg1.tickets);
        };
        arg1.tickets = 0;
        arg1.claims = 0;
    }

    fun auto_claim(arg0: &mut Board, arg1: &mut 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::Vault, arg2: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AutoKey{player: arg3};
        let v1 = 0x2::dynamic_field::remove<AutoKey, AutoSeat>(&mut arg0.id, v0);
        let v2 = v1.miner.round_id;
        if (v2 != 0 && 0x2::table::contains<u64, RoundInfo>(&arg0.rounds, v2)) {
            let v3 = &mut v1.miner;
            let (v4, v5, v6, v7) = claim_as(arg0, v3, arg3, false, arg2, arg4, arg5);
            let v8 = v5;
            let v9 = v4;
            if (0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v9) == 0) {
                0x2::coin::destroy_zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v9);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(v9, arg3);
            };
            let v10 = 0x2::coin::value<0x2::sui::SUI>(&v8);
            if (v10 > 0) {
                v1.wins = v1.wins + 1;
                v1.won = v1.won + v10;
                0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::credit(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(v8));
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
            };
            v1.mined = v1.mined + v7;
            let v11 = &mut v1;
            auto_drop_old_tickets(arg0, v11);
            v1.tickets = v1.tickets + v6;
            v1.claims = v1.claims + 1;
            let v12 = AutoClaimed{
                round_id : v2,
                player   : arg3,
                sui      : v10,
                gts      : v7,
            };
            0x2::event::emit<AutoClaimed>(v12);
        };
        if (v1.tickets > 0) {
            let v13 = if (v2 != 0) {
                v2
            } else {
                arg0.cur_id
            };
            let v14 = &mut v1;
            auto_add_tickets(arg0, v14, arg3, v13);
        };
        let v15 = AutoKey{player: arg3};
        0x2::dynamic_field::add<AutoKey, AutoSeat>(&mut arg0.id, v15, v1);
    }

    fun auto_drop_old_tickets(arg0: &Board, arg1: &mut AutoSeat) {
        let v0 = ticket_epoch(arg0);
        if (arg1.ticket_epoch != v0) {
            arg1.tickets = 0;
            arg1.ticket_epoch = v0;
        };
    }

    public fun auto_flush(arg0: &mut Board, arg1: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AutoKey{player: v0};
        if (!0x2::dynamic_field::exists<AutoKey>(&arg0.id, v1)) {
            return
        };
        let v2 = AutoKey{player: v0};
        let v3 = 0x2::dynamic_field::remove<AutoKey, AutoSeat>(&mut arg0.id, v2);
        let v4 = arg0.cur_id;
        let v5 = &mut v3;
        auto_add_tickets(arg0, v5, v0, v4);
        let v6 = AutoKey{player: v0};
        0x2::dynamic_field::add<AutoKey, AutoSeat>(&mut arg0.id, v6, v3);
    }

    public fun auto_install(arg0: &AdminCap, arg1: &mut Board, arg2: 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::PullCap) {
        check_version(arg1);
        let v0 = AutoCapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<AutoCapKey>(&arg1.id, v0), 37);
        let v1 = AutoInstalled{cap: 0x2::object::id<0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::PullCap>(&arg2)};
        0x2::event::emit<AutoInstalled>(v1);
        let v2 = AutoCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<AutoCapKey, 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::PullCap>(&mut arg1.id, v2, arg2);
    }

    public fun auto_installed(arg0: &Board) : bool {
        let v0 = AutoCapKey{dummy_field: false};
        0x2::dynamic_object_field::exists<AutoCapKey>(&arg0.id, v0)
    }

    public fun auto_join(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) {
        abort 43
    }

    public fun auto_joined(arg0: &Board, arg1: address) : bool {
        let v0 = AutoKey{player: arg1};
        0x2::dynamic_field::exists<AutoKey>(&arg0.id, v0)
    }

    entry fun auto_run(arg0: &mut Board, arg1: &mut 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::Vault, arg2: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: vector<address>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = AutoCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<AutoCapKey>(&arg0.id, v0), 38);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v1);
            let v3 = AutoKey{player: v2};
            if (0x2::dynamic_field::exists<AutoKey>(&arg0.id, v3)) {
                auto_claim(arg0, arg1, arg2, v2, arg5, arg6);
            };
            v1 = v1 + 1;
        };
    }

    public fun auto_seat(arg0: &Board, arg1: address) : (u64, vector<u64>, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = AutoKey{player: arg1};
        let v1 = 0x2::dynamic_field::borrow<AutoKey, AutoSeat>(&arg0.id, v0);
        let v2 = if (v1.ticket_epoch == ticket_epoch(arg0)) {
            v1.tickets
        } else {
            0
        };
        (v1.miner.round_id, v1.miner.deployed, v2, v1.rounds, v1.wins, v1.deployed, v1.fees, v1.won, v1.mined)
    }

    public fun auto_terms() : (u64, u64, u64) {
        (100, 100, 50000000)
    }

    fun blended_start(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return arg3
        };
        let v0 = if (arg3 > 604800000) {
            arg3 - 604800000
        } else {
            0
        };
        let v1 = if (arg0 > arg3) {
            arg3
        } else if (arg0 < v0) {
            v0
        } else {
            arg0
        };
        ((((v1 as u128) * (arg1 as u128) + (arg3 as u128) * (arg2 as u128)) / ((arg1 as u128) + (arg2 as u128))) as u64)
    }

    fun bought_mut(arg0: &mut Board) : &mut 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        let v0 = BoughtKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<BoughtKey>(&arg0.id, v0)) {
            let v1 = BoughtKey{dummy_field: false};
            0x2::dynamic_field::add<BoughtKey, 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&mut arg0.id, v1, 0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>());
        };
        let v2 = BoughtKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BoughtKey, 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&mut arg0.id, v2)
    }

    public fun bought_value(arg0: &Board) : u64 {
        let v0 = BoughtKey{dummy_field: false};
        if (0x2::dynamic_field::exists<BoughtKey>(&arg0.id, v0)) {
            let v2 = BoughtKey{dummy_field: false};
            0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::dynamic_field::borrow<BoughtKey, 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun burn_bought(arg0: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg1: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 33
    }

    fun buy_gts(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        let v0 = if (arg3 < 5000000 / 5) {
            true
        } else if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg1)) {
            true
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg1) == 0) {
            true
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg1) * 1000500 / 1000000 > arg4
        };
        if (v0) {
            return 0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>()
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg0, arg1, false, true, arg3, arg4, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(), 0x2::balance::split<0x2::sui::SUI>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(&v4)), v4);
        v1
    }

    public fun buyback_burn(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: BuybackReceipt, arg3: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        let BuybackReceipt {  } = arg2;
        abort 30
    }

    public fun buyback_burn_v2(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: BuybackReceipt, arg3: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let BuybackReceipt {  } = arg2;
        abort 39
    }

    public fun buyback_keep(arg0: &mut Board, arg1: BuybackReceipt, arg2: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        let BuybackReceipt {  } = arg1;
        abort 35
    }

    public fun buyback_take(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuybackReceipt) {
        abort 39
    }

    public fun buyback_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback)
    }

    fun check_version(arg0: &mut Board) {
        assert!(arg0.version <= 22, 14);
        if (arg0.version < 22) {
            start_halving(arg0);
        };
        arg0.version = 22;
    }

    public fun claim(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>) {
        abort 33
    }

    fun claim_as(arg0: &mut Board, arg1: &mut Miner, arg2: address, arg3: bool, arg4: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>, u64, u64) {
        assert!(arg1.round_id != 0, 10);
        assert!(0x2::table::contains<u64, RoundInfo>(&arg0.rounds, arg1.round_id), 11);
        let v0 = arg1.round_id;
        let v1 = 0x2::table::borrow<u64, RoundInfo>(&arg0.rounds, v0);
        let v2 = v1.total_deployed;
        let v3 = (v1.winning_square as u64);
        let v4 = v1.losing_pot_after_fee;
        let v5 = v1.winners_total;
        let v6 = v0 >= v5_from(arg0);
        let v7 = if (v0 >= v9_from(arg0)) {
            v0 < v10_from(arg0)
        } else {
            false
        };
        let v8 = *0x1::vector::borrow<u64>(&arg1.deployed, v3);
        let v9 = if (v6 && v0 < v8_from(arg0)) {
            let v10 = v2 - v5;
            if (v10 == 0) {
                0
            } else {
                mul_div(v1.round_reward, arg1.total_deployed - v8, v10)
            }
        } else if (v2 == 0) {
            0
        } else {
            mul_div(v1.round_reward, arg1.total_deployed, v2)
        };
        let v11 = pay_owed(arg0, arg4, arg2, arg5, arg6);
        let v12 = if (v11 > 0) {
            v9
        } else {
            mint_unrefined(arg0, arg4, arg2, v9, arg5, arg6)
        };
        if (v12 > 0) {
            let v13 = OwedKey{player: arg2};
            if (0x2::dynamic_field::exists<OwedKey>(&arg0.id, v13)) {
                let v14 = 0x2::dynamic_field::borrow_mut<OwedKey, u64>(&mut arg0.id, v13);
                *v14 = *v14 + v12;
            } else {
                0x2::dynamic_field::add<OwedKey, u64>(&mut arg0.id, v13, v12);
            };
            let v15 = GtsOwed{
                round_id : v0,
                player   : arg2,
                amount   : v12,
                owed     : v11 + v12,
            };
            0x2::event::emit<GtsOwed>(v15);
        };
        let v16 = if (v7 && v8 > 0) {
            let v17 = mul_div(v4, v8, v5);
            let v18 = mul_div(v17, v8, arg1.total_deployed);
            let v19 = v17 - v18;
            if (v19 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v19));
                let v20 = MotherlodeReturned{
                    round_id : v0,
                    amount   : v19,
                    balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
                };
                0x2::event::emit<MotherlodeReturned>(v20);
                let v21 = Forfeited{
                    round_id   : v0,
                    player     : arg2,
                    to_reserve : 0,
                    to_fund    : v19,
                };
                0x2::event::emit<Forfeited>(v21);
            };
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + v18), arg6)
        } else if (v6 && v8 > 0) {
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + mul_div(v4, v8, v5)), arg6)
        } else if (v8 > 0 && v5 > 0) {
            let v22 = JackpotKey{round_id: v0};
            let v23 = if (0x2::dynamic_field::exists<JackpotKey>(&arg0.id, v22)) {
                mul_div(*0x2::dynamic_field::borrow<JackpotKey, u64>(&arg0.id, v22), v8, v5)
            } else {
                0
            };
            let v24 = mul_div(v4, v8, v5) - v23;
            let v25 = arg1.total_deployed;
            let v26 = mul_div(v24, v8, v25);
            let v27 = if (is_bot(arg2)) {
                0
            } else {
                mul_div(v23, v8, v25)
            };
            let v28 = v23 - v27 + v24 - v26;
            let v29 = 0;
            if (v28 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v28));
                let v30 = MotherlodeReturned{
                    round_id : v0,
                    amount   : v28,
                    balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
                };
                0x2::event::emit<MotherlodeReturned>(v30);
            };
            if (v29 > 0 || v28 > 0) {
                let v31 = Forfeited{
                    round_id   : v0,
                    player     : arg2,
                    to_reserve : v29,
                    to_fund    : v28,
                };
                0x2::event::emit<Forfeited>(v31);
            };
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + v26 + v27), arg6)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg6)
        };
        let v32 = v16;
        let v33 = mul_div(arg1.total_deployed - v8, fee_bps(arg0), 10000);
        let v34 = 0;
        if (v33 > 0 && !no_tickets(arg2)) {
            if (arg3) {
                add_tickets(arg0, v0, arg2, v33);
            } else {
                v34 = v33;
            };
        };
        let v35 = SeatKey{
            round_id : v0,
            player   : arg2,
        };
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v35) && *0x2::dynamic_field::borrow<SeatKey, 0x2::object::ID>(&arg0.id, v35) == 0x2::object::id<Miner>(arg1)) {
            0x2::dynamic_field::remove<SeatKey, 0x2::object::ID>(&mut arg0.id, v35);
        };
        let v36 = RoundLeftKey{round_id: v0};
        if (0x2::dynamic_field::exists<RoundLeftKey>(&arg0.id, v36)) {
            let v37 = 0x2::dynamic_field::borrow_mut<RoundLeftKey, u64>(&mut arg0.id, v36);
            *v37 = *v37 - 1;
            if (*v37 == 0) {
                0x2::dynamic_field::remove<RoundLeftKey, u64>(&mut arg0.id, v36);
                let RoundInfo {
                    total_deployed       : _,
                    deployed             : _,
                    winning_square       : _,
                    losing_pot_after_fee : _,
                    winners_total        : _,
                    round_reward         : _,
                    rng                  : _,
                } = 0x2::table::remove<u64, RoundInfo>(&mut arg0.rounds, v0);
            };
        };
        let v45 = Claimed{
            round_id : v0,
            player   : arg2,
            gts      : v9,
            sui      : 0x2::coin::value<0x2::sui::SUI>(&v32),
        };
        0x2::event::emit<Claimed>(v45);
        arg1.round_id = 0;
        arg1.total_deployed = 0;
        arg1.deployed = zeros();
        (0x2::coin::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg6), v32, v34, v9)
    }

    public fun claim_gts(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        settle_gts_both(arg0, v0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 2) {
            let v3 = GtsPosKey{
                player : v0,
                locked : v2 == 1,
            };
            if (0x2::dynamic_field::exists<GtsPosKey>(&arg0.id, v3)) {
                let v4 = 0x2::dynamic_field::borrow_mut<GtsPosKey, GtsPos>(&mut arg0.id, v3);
                v1 = v1 + v4.pending;
                v4.pending = 0;
                if (0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::weight(pool_ref(arg0), v0, v2 == 1) == 0) {
                    0x2::dynamic_field::remove<GtsPosKey, GtsPos>(&mut arg0.id, v3);
                };
            };
            v2 = v2 + 1;
        };
        if (v1 > 0) {
            let v5 = GtsYieldClaimed{
                player : v0,
                gts    : v1,
            };
            0x2::event::emit<GtsYieldClaimed>(v5);
        };
        0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut gts_yield_mut(arg0).rewards, v1), arg1)
    }

    public fun claim_owed(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg2 == 0x2::tx_context::sender(arg4), 41);
        pay_owed(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claim_sui(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 33
    }

    public fun claim_sui_v2(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 34
    }

    public fun claim_sui_v3(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = claim_v3(arg0, arg1, arg2, arg3, arg4);
        let v2 = v0;
        if (0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v2) == 0) {
            0x2::coin::destroy_zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(v2, 0x2::tx_context::sender(arg4));
        };
        v1
    }

    public fun claim_v2(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>) {
        abort 34
    }

    public fun claim_v3(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2, _, _) = claim_as(arg0, arg1, v0, true, arg2, arg3, arg4);
        (v1, v2)
    }

    public fun claim_yield(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_version(arg0);
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::claim(pool_mut(arg0), arg1)
    }

    public fun compound_fees(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        check_version(arg0);
        assert!(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>>(arg2) == market_pool(arg0), 40);
        let v0 = PriceRefKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PriceRefKey>(&arg0.id, v0)) {
            return
        };
        let v1 = PriceRefKey{dummy_field: false};
        let v2 = *0x2::dynamic_field::borrow<PriceRefKey, u128>(&arg0.id, v1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2);
        if (v3 > price_cap(v2) || v2 > price_cap(v3)) {
            return
        };
        let v4 = lp_positions(arg0);
        let v5 = if (arg4 < v4) {
            arg4
        } else {
            v4
        };
        let v6 = 0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>();
        let v7 = 0x2::balance::zero<0x2::sui::SUI>();
        while (arg3 < v5) {
            let v8 = LpKey{i: arg3};
            let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg1, arg2, 0x2::dynamic_object_field::borrow<LpKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, v8), true);
            0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut v6, v9);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v10);
            arg3 = arg3 + 1;
        };
        let v11 = 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v6);
        let v12 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        let v13 = liquidity_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x2::balance::withdraw_all<0x2::sui::SUI>(v13));
        let v14 = &mut v6;
        let v15 = &mut v7;
        let (v16, v17) = add_to_pool(arg0, arg1, arg2, v14, v15, arg5);
        let v18 = liquidity_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(v18, v7);
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(bought_mut(arg0), v6);
        if (v11 > 0 || v12 > 0) {
            let v19 = FeesCompounded{
                sui_fees  : v12,
                gts_fees  : v11,
                sui_added : v17,
                gts_added : v16,
                sui_left  : 0x2::balance::value<0x2::sui::SUI>(&v7),
                gts_left  : 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v6),
            };
            0x2::event::emit<FeesCompounded>(v19);
        };
    }

    entry fun create_miner(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_miner(arg0);
        0x2::transfer::public_transfer<Miner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun current_end_ms(arg0: &Board) : u64 {
        arg0.cur_end_ms
    }

    public fun current_params(arg0: &Board) : (u64, u64, u64, u64, u64, u64, bool) {
        (arg0.ml_odds, arg0.ml_share_bps, arg0.vault_bps, 300, 100, arg0.refine_fee_bps, arg0.paused)
    }

    public fun current_reward(arg0: &Board) : u64 {
        next_full_reward(arg0)
    }

    public fun current_round(arg0: &Board) : u64 {
        arg0.cur_id
    }

    public fun current_total(arg0: &Board) : u64 {
        arg0.cur_total
    }

    public fun deploy(arg0: &mut Board, arg1: &mut Miner, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        deploy_as(arg0, arg1, 0x2::tx_context::sender(arg5), arg2, arg3, arg4);
    }

    fun deploy_as(arg0: &mut Board, arg1: &mut Miner, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u64>(&arg4) == 25, 1);
        assert!(!arg0.paused, 19);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (!arg0.cur_started) {
            arg0.cur_start_ms = v0;
            arg0.cur_end_ms = v0 + arg0.round_ms;
            arg0.cur_started = true;
        };
        assert!(v0 < arg0.cur_end_ms, 2);
        assert!(v0 <= arg0.cur_end_ms - arg0.freeze_ms, 3);
        assert!(arg1.round_id == 0 || arg1.round_id == arg0.cur_id, 4);
        let v1 = SeatKey{
            round_id : arg0.cur_id,
            player   : arg2,
        };
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v1)) {
            assert!(*0x2::dynamic_field::borrow<SeatKey, 0x2::object::ID>(&arg0.id, v1) == 0x2::object::id<Miner>(arg1), 15);
        } else {
            0x2::dynamic_field::add<SeatKey, 0x2::object::ID>(&mut arg0.id, v1, 0x2::object::id<Miner>(arg1));
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < 25) {
            let v4 = *0x1::vector::borrow<u64>(&arg4, v3);
            if (v4 > 0) {
                assert!(v4 >= arg0.min_deploy, 6);
            };
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v2, 7);
        if (arg1.round_id == 0) {
            arg1.round_id = arg0.cur_id;
            arg0.cur_players = arg0.cur_players + 1;
        };
        v3 = 0;
        let v5 = 0;
        while (v3 < 25) {
            let v6 = *0x1::vector::borrow<u64>(&arg4, v3);
            if (v6 > 0) {
                let v7 = 0x1::vector::borrow_mut<u64>(&mut arg0.cur_deployed, v3);
                *v7 = *v7 + v6;
                let v8 = 0x1::vector::borrow_mut<u64>(&mut arg1.deployed, v3);
                *v8 = *v8 + v6;
            };
            if (*0x1::vector::borrow<u64>(&arg1.deployed, v3) > 0) {
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        assert!(v5 <= max_tiles(arg0), 29);
        arg0.cur_total = arg0.cur_total + v2;
        arg1.total_deployed = arg1.total_deployed + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v9 = Deployed{
            round_id : arg0.cur_id,
            player   : arg2,
            amounts  : arg4,
            total    : v2,
        };
        0x2::event::emit<Deployed>(v9);
    }

    public fun dev_fees_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.dev_fees)
    }

    public fun draw_rewards() : (u64, u64) {
        (100, 50)
    }

    fun earned(arg0: u64, arg1: u256, arg2: u256) : u64 {
        (((arg0 as u256) * (arg1 - arg2) / 1000000000000000000) as u64)
    }

    public fun emission(arg0: &Board) : (u64, u64, u64, u64, u64, u64) {
        (arg0.reward, arg0.step_rounds, arg0.decay_ppm, arg0.step_count, arg0.full_reward_deploy, arg0.committed)
    }

    public fun emission_step(arg0: &Board) : (u64, u64) {
        (arg0.step_count, step_gts(arg0))
    }

    fun fee_bps(arg0: &Board) : u64 {
        100 + arg0.vault_bps + 300 + 200 + stake_bps(arg0) + fund_bps(arg0)
    }

    fun fee_bps_at(arg0: &Board, arg1: address, arg2: u64) : u64 {
        let v0 = refine_start(arg0, arg1);
        if (v0 == 0) {
            return arg0.refine_fee_bps
        };
        let v1 = v0 + 604800000;
        if (arg2 >= v1) {
            return 0
        };
        let v2 = if (arg2 > v0) {
            v1 - arg2
        } else {
            604800000
        };
        mul_div(arg0.refine_fee_bps, v2, 604800000)
    }

    fun fund_bps(arg0: &Board) : u64 {
        let v0 = FundBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FundBpsKey>(&arg0.id, v0)) {
            let v2 = FundBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<FundBpsKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun give_liquidity(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg0);
        assert!(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>>(arg2) == market_pool(arg0), 40);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v1 = 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg3);
        let v2 = &mut v1;
        let v3 = &mut v0;
        let (v4, v5) = add_to_pool(arg0, arg1, arg2, v2, v3, arg5);
        if (v4 > 0 || v5 > 0) {
            let v6 = LiquidityGiven{
                from      : 0x2::tx_context::sender(arg6),
                gts_added : v4,
                sui_added : v5,
                position  : lp_position_id(arg0, 0),
            };
            0x2::event::emit<LiquidityGiven>(v6);
        };
        (0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v1, arg6), 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg6))
    }

    fun gts_acc(arg0: &Board) : u256 {
        let v0 = GtsYieldKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GtsYieldKey>(&arg0.id, v0)) {
            let v2 = GtsYieldKey{dummy_field: false};
            0x2::dynamic_field::borrow<GtsYieldKey, GtsYield>(&arg0.id, v2).acc
        } else {
            0
        }
    }

    fun gts_earned(arg0: u128, arg1: u256, arg2: u256) : u64 {
        (((arg0 as u256) * (arg1 - arg2) / 1000000000000000000) as u64)
    }

    fun gts_yield_mut(arg0: &mut Board) : &mut GtsYield {
        let v0 = GtsYieldKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<GtsYieldKey>(&arg0.id, v0)) {
            let v1 = GtsYieldKey{dummy_field: false};
            let v2 = GtsYield{
                rewards    : 0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(),
                acc        : 0,
                paid_total : 0,
            };
            0x2::dynamic_field::add<GtsYieldKey, GtsYield>(&mut arg0.id, v1, v2);
        };
        let v3 = GtsYieldKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<GtsYieldKey, GtsYield>(&mut arg0.id, v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Board{
            id                 : 0x2::object::new(arg0),
            version            : 22,
            cur_id             : 1,
            cur_started        : false,
            cur_start_ms       : 0,
            cur_end_ms         : 0,
            cur_total          : 0,
            cur_deployed       : zeros(),
            cur_players        : 0,
            rounds             : 0x2::table::new<u64, RoundInfo>(arg0),
            pot                : 0x2::balance::zero<0x2::sui::SUI>(),
            dev_fees           : 0x2::balance::zero<0x2::sui::SUI>(),
            buyback            : 0x2::balance::zero<0x2::sui::SUI>(),
            motherlode         : 0x2::balance::zero<0x2::sui::SUI>(),
            unrefined          : 0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(),
            unrefined_total    : 0,
            acc                : 0,
            reward             : 1000000000,
            step_rounds        : 15658,
            decay_ppm          : 500000,
            step_count         : 0,
            full_reward_deploy : 1000000000,
            committed          : 0,
            round_ms           : 60000,
            freeze_ms          : 5000,
            min_deploy         : 10000000,
            vault_bps          : 0,
            buyback_bps        : 300,
            ml_odds            : 1000,
            ml_share_bps       : 1950,
            refine_fee_bps     : 1000,
            paused             : false,
        };
        0x2::transfer::share_object<Board>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_bot(arg0: address) : bool {
        if (arg0 == @0x4a6e7d021beb465ce1a68ffe45d6e18cd30f6aea45560364a8c59bcdd497458a) {
            true
        } else if (arg0 == @0xab4deb30e34487f75bf5632038e46d419c6238b4ea52d35f3ad3421a5bb268fa) {
            true
        } else if (arg0 == @0x779b49acf4db04d835440c12ffe24929de505a9b8112b4040da5103d225b37e7) {
            true
        } else if (arg0 == @0xb8d118f954c90a87abc2b3e07c408681efed88b552ebcd94fc5cb292f3c9dc4) {
            true
        } else {
            arg0 == @0x2a869532f55594a9ffed4a5d7ee2a48cf5c857ac740090d39c733e0279b6a8de
        }
    }

    public fun limit_mint_rate(arg0: &AdminCap, arg1: &mut Board, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = MinterKey{dummy_field: false};
        let v1 = 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::wrap<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::dynamic_field::remove<MinterKey, 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::MinterCap<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&mut arg1.id, v0), 2000000000000, arg2);
        let v2 = MintRateLimited{
            limiter : 0x2::object::id<0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&v1),
            per_day : 2000000000000,
        };
        0x2::event::emit<MintRateLimited>(v2);
        let v3 = LimiterKey{dummy_field: false};
        0x2::dynamic_object_field::add<LimiterKey, 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&mut arg1.id, v3, v1);
    }

    public fun liquidity_bps() : u64 {
        200
    }

    public fun liquidity_lock<T0: store + key>(arg0: &mut Board, arg1: LiquidityReceipt, arg2: T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>) {
        let LiquidityReceipt {  } = arg1;
        abort 39
    }

    fun liquidity_mut(arg0: &mut Board) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = LiquidityKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LiquidityKey>(&arg0.id, v0)) {
            let v1 = LiquidityKey{dummy_field: false};
            0x2::dynamic_field::add<LiquidityKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v1, 0x2::balance::zero<0x2::sui::SUI>());
        };
        let v2 = LiquidityKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<LiquidityKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v2)
    }

    public fun liquidity_take(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, LiquidityReceipt) {
        abort 39
    }

    public fun liquidity_value(arg0: &Board) : u64 {
        let v0 = LiquidityKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LiquidityKey>(&arg0.id, v0)) {
            let v2 = LiquidityKey{dummy_field: false};
            0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<LiquidityKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun lock_position(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>>(arg1) == market_pool(arg0), 40);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>>(arg1), 40);
        let v0 = LpCountKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LpCountKey>(&arg0.id, v0)) {
            let v1 = LpCountKey{dummy_field: false};
            0x2::dynamic_field::add<LpCountKey, u64>(&mut arg0.id, v1, 0);
        };
        let v2 = LpCountKey{dummy_field: false};
        let v3 = *0x2::dynamic_field::borrow<LpCountKey, u64>(&arg0.id, v2);
        let v4 = PositionLocked{
            position  : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2),
            liquidity : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2),
            from      : 0x2::tx_context::sender(arg3),
            positions : v3 + 1,
        };
        0x2::event::emit<PositionLocked>(v4);
        let v5 = LpKey{i: v3};
        0x2::dynamic_object_field::add<LpKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v5, arg2);
        let v6 = LpCountKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<LpCountKey, u64>(&mut arg0.id, v6) = v3 + 1;
    }

    public fun lock_supply(arg0: &AdminCap, arg1: &mut Board, arg2: 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let (v0, v1) = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::release(arg2);
        let v2 = 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::lock<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v0, v1, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::max_supply(), arg3);
        let v3 = SupplyLocked{
            capped_treasury : 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::treasury_of<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v2),
            minted          : v1,
            max             : 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::max_supply(),
        };
        0x2::event::emit<SupplyLocked>(v3);
        let v4 = MinterKey{dummy_field: false};
        0x2::dynamic_field::add<MinterKey, 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::MinterCap<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&mut arg1.id, v4, v2);
    }

    public fun lp_position_id(arg0: &Board, arg1: u64) : 0x2::object::ID {
        let v0 = LpKey{i: arg1};
        let v1 = 0x2::dynamic_object_field::id<LpKey>(&arg0.id, v0);
        *0x1::option::borrow<0x2::object::ID>(&v1)
    }

    public fun lp_positions(arg0: &Board) : u64 {
        let v0 = LpCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LpCountKey>(&arg0.id, v0)) {
            let v2 = LpCountKey{dummy_field: false};
            *0x2::dynamic_field::borrow<LpCountKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun market(arg0: &Board) : (address, u128, u64, u64) {
        let v0 = PriceRefKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<PriceRefKey>(&arg0.id, v0)) {
            let v2 = PriceRefKey{dummy_field: false};
            *0x2::dynamic_field::borrow<PriceRefKey, u128>(&arg0.id, v2)
        } else {
            0
        };
        (market_pool(arg0), v1, 5000000, 50000000)
    }

    public fun market_alive(arg0: &Board) : (u64, u64, u64) {
        let v0 = MarketAliveKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<MarketAliveKey>(&arg0.id, v0)) {
            let v2 = MarketAliveKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MarketAliveKey, u64>(&arg0.id, v2)
        } else {
            0
        };
        (v1, 21600000, 604800000)
    }

    fun market_alive_at(arg0: &mut Board, arg1: u64) : u64 {
        let v0 = MarketAliveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MarketAliveKey>(&arg0.id, v0)) {
            let v1 = MarketAliveKey{dummy_field: false};
            0x2::dynamic_field::add<MarketAliveKey, u64>(&mut arg0.id, v1, arg1);
        };
        let v2 = MarketAliveKey{dummy_field: false};
        *0x2::dynamic_field::borrow<MarketAliveKey, u64>(&arg0.id, v2)
    }

    fun market_buyback(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg3: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback);
        let v1 = if (v0 >= 5000000) {
            let v2 = &mut arg0.buyback;
            buy_gts(arg1, arg2, v2, v0, arg4, arg5)
        } else {
            0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>()
        };
        let v3 = v1;
        let v4 = v0 - 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback);
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut v3, 0x2::balance::withdraw_all<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(bought_mut(arg0)));
        let v5 = 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v3);
        if (v5 == 0) {
            0x2::balance::destroy_zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v3);
            return
        };
        0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::burn<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg3, 0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v3, arg6));
        let v6 = BuybackDone{
            sui_spent  : v4,
            gts_burned : v5,
        };
        0x2::event::emit<BuybackDone>(v6);
    }

    fun market_liquidity(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg3: u128, arg4: &0x2::clock::Clock) {
        let v0 = liquidity_value(arg0);
        let v1 = if (v0 < 50000000) {
            true
        } else if (lp_positions(arg0) == 0) {
            true
        } else {
            !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2)
        };
        if (v1) {
            return
        };
        let v2 = liquidity_mut(arg0);
        let v3 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v2);
        let v4 = &mut v3;
        let v5 = buy_gts(arg1, arg2, v4, v0 * 49 / 100, arg3, arg4);
        let v6 = v0 - 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v7 = &mut v5;
        let v8 = &mut v3;
        let (v9, v10) = add_to_pool(arg0, arg1, arg2, v7, v8, arg4);
        let v11 = liquidity_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(v11, v3);
        let v12 = bought_mut(arg0);
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v12, v5);
        if (v6 > 0) {
            let v13 = LiquidityAdded{
                sui_swapped : v6,
                sui_added   : v10,
                gts_added   : v9,
                gts_left    : 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v5),
                position    : lp_position_id(arg0, 0),
            };
            0x2::event::emit<LiquidityAdded>(v13);
        };
    }

    fun market_pool(arg0: &Board) : address {
        let v0 = TestPoolKey{dummy_field: false};
        if (0x2::dynamic_field::exists<TestPoolKey>(&arg0.id, v0)) {
            let v2 = TestPoolKey{dummy_field: false};
            *0x2::dynamic_field::borrow<TestPoolKey, address>(&arg0.id, v2)
        } else {
            @0x628902c5acd5b5755c9b1a6494e925d0c5327177486b5e3b25d0e9b0211de71
        }
    }

    fun market_step(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg3: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>>(arg2) == market_pool(arg0), 40);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        market_alive_at(arg0, v0);
        let v1 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2)) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2) > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = MarketAliveKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MarketAliveKey, u64>(&mut arg0.id, v2) = v0;
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2);
        let v4 = PriceRefKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PriceRefKey>(&arg0.id, v4)) {
            let v5 = PriceRefKey{dummy_field: false};
            0x2::dynamic_field::add<PriceRefKey, u128>(&mut arg0.id, v5, v3);
            let v6 = PriceRefSet{sqrt_price: v3};
            0x2::event::emit<PriceRefSet>(v6);
            return
        };
        let v7 = PriceRefKey{dummy_field: false};
        let v8 = *0x2::dynamic_field::borrow<PriceRefKey, u128>(&arg0.id, v7);
        let v9 = price_cap(min128(v8, v3));
        if (arg0.cur_id % 2 == 0) {
            market_liquidity(arg0, arg1, arg2, v9, arg4);
            market_buyback(arg0, arg1, arg2, arg3, v9, arg4, arg5);
        } else {
            market_buyback(arg0, arg1, arg2, arg3, v9, arg4, arg5);
            market_liquidity(arg0, arg1, arg2, v9, arg4);
        };
        let v10 = min128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>(arg2), price_cap(v8));
        if (v10 != v8) {
            let v11 = PriceRefKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<PriceRefKey, u128>(&mut arg0.id, v11) = v10;
            let v12 = PriceRefSet{sqrt_price: v10};
            0x2::event::emit<PriceRefSet>(v12);
        };
    }

    fun max_tiles(arg0: &Board) : u64 {
        let v0 = MaxTilesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxTilesKey>(&arg0.id, v0)) {
            let v2 = MaxTilesKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MaxTilesKey, u64>(&arg0.id, v2)
        } else {
            25
        }
    }

    public fun max_tiles_per_player(arg0: &Board) : u64 {
        max_tiles(arg0)
    }

    fun min128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mint_gts(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        let v0 = LimiterKey{dummy_field: false};
        0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::mint<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::dynamic_object_field::borrow_mut<LimiterKey, 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&mut arg0.id, v0), arg1, arg2, arg3, arg4)
    }

    public fun mint_limiter_id(arg0: &Board) : 0x2::object::ID {
        let v0 = LimiterKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::id<LimiterKey>(&arg0.id, v0);
        *0x1::option::borrow<0x2::object::ID>(&v1)
    }

    fun mint_room(arg0: &Board, arg1: &0x2::clock::Clock) : u64 {
        let v0 = LimiterKey{dummy_field: false};
        0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::room_today<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::dynamic_object_field::borrow<LimiterKey, 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&arg0.id, v0), arg1)
    }

    public fun mint_room_today(arg0: &Board, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = LimiterKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow<LimiterKey, 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&arg0.id, v0);
        (0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::room_today<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v1, arg1), 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::per_day<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v1))
    }

    fun mint_unrefined(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = mint_room(arg0, arg4);
        let v1 = if (arg3 < v0) {
            arg3
        } else {
            v0
        };
        if (v1 > 0) {
            let v2 = mint_gts(arg0, arg1, v1, arg4, arg5);
            if (0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v2) > 0) {
                add_unrefined(arg0, arg2, 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v2), 0x2::clock::timestamp_ms(arg4));
            } else {
                0x2::coin::destroy_zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v2);
            };
        };
        arg3 - v1
    }

    public fun motherlode_paid(arg0: &Board, arg1: u64) : u64 {
        let v0 = JackpotKey{round_id: arg1};
        if (0x2::dynamic_field::exists<JackpotKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<JackpotKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun motherlode_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new_miner(arg0: &mut 0x2::tx_context::TxContext) : Miner {
        Miner{
            id             : 0x2::object::new(arg0),
            round_id       : 0,
            deployed       : zeros(),
            total_deployed : 0,
        }
    }

    fun next_full_reward(arg0: &Board) : u64 {
        let v0 = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::max_supply() - arg0.committed;
        if (arg0.reward < v0) {
            arg0.reward
        } else {
            v0
        }
    }

    fun no_tickets(arg0: address) : bool {
        is_bot(arg0) || arg0 == @0xadf4446b0340e1b8d4c0abde15da3381db54057a1e4bda533cc3c8ca1abbc077
    }

    fun owed(arg0: &Board, arg1: address) : u64 {
        let v0 = OwedKey{player: arg1};
        if (0x2::dynamic_field::exists<OwedKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<OwedKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun owed_of(arg0: &Board, arg1: address) : u64 {
        owed(arg0, arg1)
    }

    fun pay_owed(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = owed(arg0, arg2);
        if (v0 == 0) {
            return 0
        };
        let v1 = mint_unrefined(arg0, arg1, arg2, v0, arg3, arg4);
        if (v1 < v0) {
            let v2 = OwedKey{player: arg2};
            if (v1 == 0) {
                0x2::dynamic_field::remove<OwedKey, u64>(&mut arg0.id, v2);
            } else {
                *0x2::dynamic_field::borrow_mut<OwedKey, u64>(&mut arg0.id, v2) = v1;
            };
            let v3 = OwedPaid{
                player : arg2,
                amount : v0 - v1,
                owed   : v1,
            };
            0x2::event::emit<OwedPaid>(v3);
        };
        v1
    }

    public fun poke(arg0: &mut Board, arg1: address, arg2: &0x2::clock::Clock) {
        check_version(arg0);
        let v0 = ScheduleKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ScheduleKey>(&arg0.id, v0)) {
            return
        };
        settle_gts_both(arg0, arg1);
        let v1 = ScheduleKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<ScheduleKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule>(&mut arg0.id, v1);
        let v3 = pool_mut(arg0);
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::poke(v3, &mut v2, arg1, arg2);
        schedule_put(arg0, v2);
    }

    fun pool_mut(arg0: &mut Board) : &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool {
        let v0 = StakeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<StakeKey>(&arg0.id, v0), 22);
        let v1 = StakeKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&mut arg0.id, v1)
    }

    fun pool_ref(arg0: &Board) : &0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool {
        let v0 = StakeKey{dummy_field: false};
        0x2::dynamic_field::borrow<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&arg0.id, v0)
    }

    public fun pot_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    fun price_cap(arg0: u128) : u128 {
        min128(arg0 * 1009950 / 1000000, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price())
    }

    public fun queue_lock(arg0: &mut Board, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        check_version(arg0);
        let v0 = schedule_take(arg0, arg2);
        let v1 = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::enqueue_lock(pool_ref(arg0), &mut v0, arg1);
        schedule_put(arg0, v0);
        v1
    }

    fun refine_start(arg0: &Board, arg1: address) : u64 {
        let v0 = RefineClockKey{player: arg1};
        if (0x2::dynamic_field::exists<RefineClockKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RefineClockKey, u64>(&arg0.id, v0)
        } else {
            let v2 = RefineFromKey{dummy_field: false};
            if (0x2::dynamic_field::exists<RefineFromKey>(&arg0.id, v2)) {
                let v3 = RefineFromKey{dummy_field: false};
                *0x2::dynamic_field::borrow<RefineFromKey, u64>(&arg0.id, v3)
            } else {
                0
            }
        }
    }

    public fun renounce(arg0: AdminCap, arg1: &Board) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = Renounced{dummy_field: false};
        0x2::event::emit<Renounced>(v1);
    }

    public fun reserve_to_fund(arg0: &AdminCap, arg1: &mut Board, arg2: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury) {
        check_version(arg1);
        let v0 = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_take_all(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.motherlode, v0);
        let v1 = ReserveToFund{
            amount  : 0x2::balance::value<0x2::sui::SUI>(&v0),
            balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.motherlode),
        };
        0x2::event::emit<ReserveToFund>(v1);
    }

    fun schedule_put(arg0: &mut Board, arg1: 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule) {
        let v0 = ScheduleKey{dummy_field: false};
        0x2::dynamic_field::add<ScheduleKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule>(&mut arg0.id, v0, arg1);
    }

    fun schedule_take(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) : 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule {
        let v0 = ScheduleKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ScheduleKey>(&arg0.id, v0)) {
            let v1 = ScheduleKey{dummy_field: false};
            0x2::dynamic_field::add<ScheduleKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule>(&mut arg0.id, v1, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::new_schedule(arg1));
        };
        let v2 = ScheduleKey{dummy_field: false};
        0x2::dynamic_field::remove<ScheduleKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule>(&mut arg0.id, v2)
    }

    public fun set_emission(arg0: &AdminCap, arg1: &mut Board, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        abort 42
    }

    public fun set_fund_bps(arg0: &AdminCap, arg1: &mut Board, arg2: u64) {
        check_version(arg1);
        assert!(arg2 <= 1000, 18);
        assert!(100 + arg1.vault_bps + 300 + 200 + arg1.ml_share_bps + stake_bps(arg1) + arg2 <= 10000, 18);
        let v0 = FundBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FundBpsKey>(&arg1.id, v0)) {
            let v1 = FundBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<FundBpsKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = FundBpsKey{dummy_field: false};
            0x2::dynamic_field::add<FundBpsKey, u64>(&mut arg1.id, v2, arg2);
        };
        let v3 = FundBpsChanged{fund_bps: arg2};
        0x2::event::emit<FundBpsChanged>(v3);
    }

    public fun set_max_tiles(arg0: &AdminCap, arg1: &mut Board, arg2: u64) {
        check_version(arg1);
        assert!(arg2 >= 1 && arg2 <= 25, 18);
        let v0 = MaxTilesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxTilesKey>(&arg1.id, v0)) {
            let v1 = MaxTilesKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MaxTilesKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = MaxTilesKey{dummy_field: false};
            0x2::dynamic_field::add<MaxTilesKey, u64>(&mut arg1.id, v2, arg2);
        };
        let v3 = MaxTilesChanged{max_tiles: arg2};
        0x2::event::emit<MaxTilesChanged>(v3);
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Board, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool) {
        check_version(arg1);
        assert!(arg2 >= 100 && arg2 <= 1000000, 18);
        assert!(arg5 == 300, 18);
        assert!(arg4 == 0, 28);
        assert!(arg3 <= 3000, 18);
        assert!(100 + arg4 + 300 + 200 + arg3 + stake_bps(arg1) + fund_bps(arg1) <= 10000, 18);
        assert!(arg6 <= 5000, 18);
        assert!(arg7 >= 500000 && arg7 <= 10000000000, 18);
        let v0 = if (arg8 >= 30000) {
            if (arg8 <= 3600000) {
                arg9 <= arg8 / 2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 18);
        arg1.ml_odds = arg2;
        arg1.ml_share_bps = arg3;
        arg1.vault_bps = arg4;
        arg1.buyback_bps = arg5;
        arg1.refine_fee_bps = arg6;
        arg1.min_deploy = arg7;
        arg1.round_ms = arg8;
        arg1.freeze_ms = arg9;
        arg1.paused = arg10;
        let v1 = ParamsChanged{
            ml_odds        : arg2,
            ml_share_bps   : arg3,
            vault_bps      : arg4,
            buyback_bps    : arg5,
            refine_fee_bps : arg6,
            min_deploy     : arg7,
            round_ms       : arg8,
            freeze_ms      : arg9,
            paused         : arg10,
        };
        0x2::event::emit<ParamsChanged>(v1);
    }

    public fun set_staking(arg0: &AdminCap, arg1: &mut Board, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(arg2 <= 500, 18);
        assert!(100 + arg1.vault_bps + 300 + 200 + arg1.ml_share_bps + arg2 + fund_bps(arg1) <= 10000, 18);
        let v0 = StakeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StakeKey>(&arg1.id, v0)) {
            let v1 = StakeKey{dummy_field: false};
            0x2::dynamic_field::add<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&mut arg1.id, v1, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::new(arg3));
            let v2 = StakeBpsKey{dummy_field: false};
            0x2::dynamic_field::add<StakeBpsKey, u64>(&mut arg1.id, v2, 0);
        };
        let v3 = StakeBpsKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<StakeBpsKey, u64>(&mut arg1.id, v3) = arg2;
        let v4 = StakingChanged{stake_bps: arg2};
        0x2::event::emit<StakingChanged>(v4);
    }

    entry fun settle(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 33
    }

    fun settle_gts(arg0: &mut Board, arg1: address, arg2: bool) {
        let v0 = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::weight(pool_ref(arg0), arg1, arg2);
        let v1 = gts_acc(arg0);
        let v2 = GtsPosKey{
            player : arg1,
            locked : arg2,
        };
        if (!0x2::dynamic_field::exists<GtsPosKey>(&arg0.id, v2)) {
            if (v0 == 0) {
                let v3 = GtsPos{
                    snap    : v1,
                    pending : 0,
                };
                0x2::dynamic_field::add<GtsPosKey, GtsPos>(&mut arg0.id, v2, v3);
                return
            };
            let v4 = GtsPos{
                snap    : 0,
                pending : 0,
            };
            0x2::dynamic_field::add<GtsPosKey, GtsPos>(&mut arg0.id, v2, v4);
        };
        let v5 = 0x2::dynamic_field::borrow_mut<GtsPosKey, GtsPos>(&mut arg0.id, v2);
        v5.pending = v5.pending + gts_earned(v0, v1, v5.snap);
        v5.snap = v1;
    }

    fun settle_gts_both(arg0: &mut Board, arg1: address) {
        settle_gts(arg0, arg1, false);
        settle_gts(arg0, arg1, true);
    }

    entry fun settle_v2(arg0: &mut Board, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = market_alive_at(arg0, v0);
        let v2 = if (v0 > v1 + 21600000) {
            50
        } else {
            0
        };
        let v3 = arg0.ml_odds;
        settle_with_odds(arg0, arg1, arg2, v3, v2, arg3);
    }

    entry fun settle_v3(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS, 0x2::sui::SUI>, arg3: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.cur_started, 9);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg0.cur_end_ms, 8);
        market_step(arg0, arg1, arg2, arg3, arg5, arg6);
        let v0 = arg0.ml_odds;
        settle_with_odds(arg0, arg4, arg5, v0, 100, arg6);
    }

    fun settle_with_odds(arg0: &mut Board, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.cur_started, 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.cur_end_ms, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = market_alive_at(arg0, v0);
        let v2 = v0 > v1 + 604800000;
        stake_step(arg0, v0, arg5);
        let v3 = V5FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V5FromKey>(&arg0.id, v3)) {
            let v4 = V5FromKey{dummy_field: false};
            0x2::dynamic_field::add<V5FromKey, u64>(&mut arg0.id, v4, arg0.cur_id);
        };
        let v5 = RefineFromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RefineFromKey>(&arg0.id, v5)) {
            let v6 = RefineFromKey{dummy_field: false};
            0x2::dynamic_field::add<RefineFromKey, u64>(&mut arg0.id, v6, 0x2::clock::timestamp_ms(arg2));
        };
        let v7 = V8FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V8FromKey>(&arg0.id, v7)) {
            let v8 = V8FromKey{dummy_field: false};
            0x2::dynamic_field::add<V8FromKey, u64>(&mut arg0.id, v8, arg0.cur_id);
        };
        let v9 = V9FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V9FromKey>(&arg0.id, v9)) {
            let v10 = V9FromKey{dummy_field: false};
            0x2::dynamic_field::add<V9FromKey, u64>(&mut arg0.id, v10, arg0.cur_id);
        };
        let v11 = V10FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V10FromKey>(&arg0.id, v11)) {
            let v12 = V10FromKey{dummy_field: false};
            0x2::dynamic_field::add<V10FromKey, u64>(&mut arg0.id, v12, arg0.cur_id);
        };
        let v13 = 0x2::random::new_generator(arg1, arg5);
        let v14 = 0x2::random::generate_u64(&mut v13);
        let v15 = ((v14 % 25) as u8);
        let v16 = TicketsKey{dummy_field: false};
        let (v17, v18, v19) = if (0x2::dynamic_field::exists<TicketsKey>(&arg0.id, v16)) {
            let v20 = TicketsKey{dummy_field: false};
            let v21 = 0x2::dynamic_field::borrow<TicketsKey, Tickets>(&arg0.id, v20);
            (v21.epoch, v21.total, v21.count)
        } else {
            (0, 0, 0)
        };
        let v22 = if (v18 > 0) {
            v18 - 1
        } else {
            0
        };
        let v23 = *0x1::vector::borrow<u64>(&arg0.cur_deployed, (v15 as u64));
        let v24 = arg0.cur_total - v23;
        let v25 = mul_div(v24, arg0.vault_bps, 10000);
        let v26 = mul_div(v24, 100, 10000);
        arg0.buyback_bps = 300;
        let v27 = mul_div(v24, 300, 10000);
        let v28 = mul_div(v24, 200, 10000);
        let v29 = mul_div(v24, stake_bps(arg0), 10000);
        let v30 = mul_div(v24, fund_bps(arg0), 10000);
        let v31 = v25 + v30;
        let v32 = mul_div(v31, arg4, 100);
        let v33 = v27 + v28;
        let v34 = if (v2) {
            0
        } else {
            v27
        };
        let v35 = if (v2) {
            0
        } else {
            v28
        };
        let v36 = if (v2) {
            v33
        } else {
            0
        };
        let v37 = v31 - v32 + v36;
        let v38 = v37;
        let v39 = v24 - v25 - v26 - v27 - v28 - v29 - v30;
        let v40 = v39;
        if (v29 > 0) {
            let v41 = StakeKey{dummy_field: false};
            let v42 = 0x2::dynamic_field::borrow_mut<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&mut arg0.id, v41);
            if (0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::has_stakers(v42)) {
                0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::reward(v42, arg0.cur_id, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v29));
            } else {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v29));
                v38 = v37 + v29;
            };
        };
        if (v26 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v26));
        };
        if (v34 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v34));
        };
        if (v35 > 0) {
            let v43 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v35);
            let v44 = liquidity_mut(arg0);
            0x2::balance::join<0x2::sui::SUI>(v44, v43);
        };
        if (v32 > 0) {
            let v45 = 0x2::tx_context::sender(arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v32), arg5), v45);
            let v46 = DrawPaid{
                round_id : arg0.cur_id,
                settler  : v45,
                amount   : v32,
            };
            0x2::event::emit<DrawPaid>(v46);
        };
        if (v2) {
            let v47 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.buyback);
            let v48 = liquidity_mut(arg0);
            0x2::balance::join<0x2::sui::SUI>(&mut v47, 0x2::balance::withdraw_all<0x2::sui::SUI>(v48));
            let v49 = MarketToFund{
                round_id : arg0.cur_id,
                saved    : 0x2::balance::value<0x2::sui::SUI>(&v47),
                share    : v33,
            };
            0x2::event::emit<MarketToFund>(v49);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, v47);
        };
        if (v23 == 0) {
            v38 = v38 + v39;
            v40 = 0;
        };
        let v50 = 0;
        if (v38 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v38));
        };
        let v51 = if (0x2::random::generate_u64_in_range(&mut v13, 0, arg3 - 1) == 0) {
            if (v18 > 0) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode) > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v51) {
            let v52 = ticket_holder(arg0, v17, v19, 0x2::random::generate_u64_in_range(&mut v13, 0, v22));
            let v53 = PlayerTicketsKey{
                epoch  : v17,
                player : v52,
            };
            let v54 = *0x2::dynamic_field::borrow<PlayerTicketsKey, u64>(&arg0.id, v53);
            let v55 = 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode);
            v50 = v55;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.motherlode), arg5), v52);
            let v56 = tickets_mut(arg0);
            v56.epoch = v17 + 1;
            v56.total = 0;
            v56.count = 0;
            let v57 = WealthFundWon{
                round_id       : arg0.cur_id,
                epoch          : v17,
                winner         : v52,
                amount         : v55,
                winner_tickets : v54,
                total_tickets  : v18,
            };
            0x2::event::emit<WealthFundWon>(v57);
        };
        let v58 = MotherlodeUpdate{
            round_id : arg0.cur_id,
            added    : v38,
            paid     : v50,
            balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
        };
        0x2::event::emit<MotherlodeUpdate>(v58);
        let v59 = if (arg0.cur_total >= arg0.full_reward_deploy) {
            next_full_reward(arg0)
        } else {
            mul_div(next_full_reward(arg0), arg0.cur_total, arg0.full_reward_deploy)
        };
        arg0.committed = arg0.committed + v59;
        arg0.step_count = arg0.step_count + v59;
        let v60 = step_gts(arg0);
        if (arg0.reward > 0 && arg0.step_count >= v60) {
            arg0.step_count = arg0.step_count - v60;
            arg0.reward = mul_div(arg0.reward, 1000000 - arg0.decay_ppm, 1000000);
        };
        let v61 = RoundInfo{
            total_deployed       : arg0.cur_total,
            deployed             : arg0.cur_deployed,
            winning_square       : v15,
            losing_pot_after_fee : v40,
            winners_total        : v23,
            round_reward         : v59,
            rng                  : v14,
        };
        0x2::table::add<u64, RoundInfo>(&mut arg0.rounds, arg0.cur_id, v61);
        if (arg0.cur_players > 0) {
            let v62 = RoundLeftKey{round_id: arg0.cur_id};
            0x2::dynamic_field::add<RoundLeftKey, u64>(&mut arg0.id, v62, arg0.cur_players);
        };
        let v63 = RoundSettled{
            round_id       : arg0.cur_id,
            winning_square : v15,
            total_deployed : arg0.cur_total,
            winners_total  : v23,
            round_reward   : v59,
            losing_pot     : v24,
            winners_payout : v40,
            vault_fee      : 0,
            buyback_fee    : v34,
            dev_fee        : v26,
            players        : arg0.cur_players,
            committed      : arg0.committed,
            next_reward    : next_full_reward(arg0),
        };
        0x2::event::emit<RoundSettled>(v63);
        arg0.cur_id = arg0.cur_id + 1;
        arg0.cur_started = false;
        arg0.cur_total = 0;
        arg0.cur_deployed = zeros();
        arg0.cur_players = 0;
    }

    public fun stake(arg0: &mut Board, arg1: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        settle_gts_both(arg0, 0x2::tx_context::sender(arg4));
        let v0 = schedule_take(arg0, arg4);
        let v1 = pool_mut(arg0);
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::stake(v1, &mut v0, arg1, arg2, arg3, arg4);
        schedule_put(arg0, v0);
    }

    fun stake_bps(arg0: &Board) : u64 {
        let v0 = StakeBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<StakeBpsKey>(&arg0.id, v0)) {
            let v2 = StakeBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<StakeBpsKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    fun stake_step(arg0: &mut Board, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StakeKey>(&arg0.id, v0)) {
            return
        };
        let v1 = ScheduleKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ScheduleKey>(&arg0.id, v1)) {
            let v2 = ScheduleKey{dummy_field: false};
            let (v3, _) = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::next_due(0x2::dynamic_field::borrow<ScheduleKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule>(&arg0.id, v2), arg1);
            if (!v3) {
                return
            };
        };
        let v5 = schedule_take(arg0, arg2);
        let v6 = 0;
        while (v6 < 20) {
            let (v7, v8) = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::next_due(&v5, arg1);
            if (!v7) {
                break
            };
            settle_gts_both(arg0, v8);
            let v9 = pool_mut(arg0);
            0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::run_due(v9, &mut v5, arg1);
            v6 = v6 + 1;
        };
        schedule_put(arg0, v5);
    }

    public fun staking_bps(arg0: &Board) : u64 {
        stake_bps(arg0)
    }

    public fun staking_gts_of(arg0: &Board, arg1: address) : u64 {
        let v0 = StakeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StakeKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 2) {
            let v3 = GtsPosKey{
                player : arg1,
                locked : v2 == 1,
            };
            let v4 = if (0x2::dynamic_field::exists<GtsPosKey>(&arg0.id, v3)) {
                let v5 = 0x2::dynamic_field::borrow<GtsPosKey, GtsPos>(&arg0.id, v3);
                v5.pending + gts_earned(0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::weight(pool_ref(arg0), arg1, v2 == 1), gts_acc(arg0), v5.snap)
            } else {
                gts_earned(0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::weight(pool_ref(arg0), arg1, v2 == 1), gts_acc(arg0), 0)
            };
            v1 = v1 + v4;
            v2 = v2 + 1;
        };
        v1
    }

    public fun staking_gts_totals(arg0: &Board) : (u64, u64) {
        let v0 = GtsYieldKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<GtsYieldKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = GtsYieldKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<GtsYieldKey, GtsYield>(&arg0.id, v1);
        (v2.paid_total, 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v2.rewards))
    }

    public fun staking_position(arg0: &Board, arg1: address, arg2: bool) : (u64, u64, u64) {
        let v0 = StakeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StakeKey>(&arg0.id, v0)) {
            return (0, 0, 0)
        };
        let v1 = StakeKey{dummy_field: false};
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::position(0x2::dynamic_field::borrow<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&arg0.id, v1), arg1, arg2)
    }

    public fun staking_queued(arg0: &Board) : (u64, u64) {
        let v0 = ScheduleKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ScheduleKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = ScheduleKey{dummy_field: false};
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::queued(0x2::dynamic_field::borrow<ScheduleKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule>(&arg0.id, v1))
    }

    public fun staking_times() : (u64, u64) {
        (0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::warm_ms(), 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::lock_ms())
    }

    public fun staking_totals(arg0: &Board) : (u64, u128, u64, u64) {
        let v0 = StakeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StakeKey>(&arg0.id, v0)) {
            return (0, 0, 0, 0)
        };
        let v1 = StakeKey{dummy_field: false};
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::totals(0x2::dynamic_field::borrow<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&arg0.id, v1))
    }

    public fun staking_warming(arg0: &Board, arg1: address, arg2: bool) : (u64, u64) {
        let v0 = ScheduleKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ScheduleKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = ScheduleKey{dummy_field: false};
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::warming_of(0x2::dynamic_field::borrow<ScheduleKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Schedule>(&arg0.id, v1), arg1, arg2)
    }

    fun start_halving(arg0: &mut Board) {
        arg0.step_rounds = 15658;
        arg0.decay_ppm = 500000;
        arg0.step_count = arg0.committed;
        let v0 = EmissionChanged{
            reward             : arg0.reward,
            step_rounds        : arg0.step_rounds,
            decay_ppm          : arg0.decay_ppm,
            step_count         : arg0.step_count,
            full_reward_deploy : arg0.full_reward_deploy,
        };
        0x2::event::emit<EmissionChanged>(v0);
    }

    fun step_gts(arg0: &Board) : u64 {
        mul_div(arg0.step_rounds, arg0.reward, 1)
    }

    public fun take_buyback(arg0: &AdminCap, arg1: &mut Board, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 23
    }

    fun ticket_epoch(arg0: &Board) : u64 {
        let v0 = TicketsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<TicketsKey>(&arg0.id, v0)) {
            let v2 = TicketsKey{dummy_field: false};
            0x2::dynamic_field::borrow<TicketsKey, Tickets>(&arg0.id, v2).epoch
        } else {
            0
        }
    }

    fun ticket_holder(arg0: &Board, arg1: u64, arg2: u64, arg3: u64) : address {
        let v0 = arg2 - 1;
        let v1 = 0;
        while (v1 < v0) {
            v0 = (v1 + v0) / 2;
            let v2 = TicketKey{
                epoch : arg1,
                i     : v0,
            };
            if (0x2::dynamic_field::borrow<TicketKey, TicketEntry>(&arg0.id, v2).end > arg3) {
                continue
            };
            v1 = v0 + 1;
        };
        let v3 = TicketKey{
            epoch : arg1,
            i     : v1,
        };
        0x2::dynamic_field::borrow<TicketKey, TicketEntry>(&arg0.id, v3).player
    }

    fun tickets_mut(arg0: &mut Board) : &mut Tickets {
        let v0 = TicketsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TicketsKey>(&arg0.id, v0)) {
            let v1 = TicketsKey{dummy_field: false};
            let v2 = Tickets{
                epoch : 0,
                total : 0,
                count : 0,
            };
            0x2::dynamic_field::add<TicketsKey, Tickets>(&mut arg0.id, v1, v2);
        };
        let v3 = TicketsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TicketsKey, Tickets>(&mut arg0.id, v3)
    }

    public fun tickets_of(arg0: &Board, arg1: address) : u64 {
        let (v0, _) = wealth_tickets(arg0);
        let v2 = PlayerTicketsKey{
            epoch  : v0,
            player : arg1,
        };
        if (0x2::dynamic_field::exists<PlayerTicketsKey>(&arg0.id, v2)) {
            *0x2::dynamic_field::borrow<PlayerTicketsKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun unrefined_of(arg0: &Board, arg1: address) : (u64, u64) {
        let v0 = UnrefinedKey{player: arg1};
        if (!0x2::dynamic_field::exists<UnrefinedKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = 0x2::dynamic_field::borrow<UnrefinedKey, Unrefined>(&arg0.id, v0);
        (v1.amount, v1.bonus + earned(v1.amount, arg0.acc, v1.snap))
    }

    public fun unrefined_total(arg0: &Board) : u64 {
        arg0.unrefined_total
    }

    public fun unstake(arg0: &mut Board, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        check_version(arg0);
        settle_gts_both(arg0, 0x2::tx_context::sender(arg4));
        let v0 = schedule_take(arg0, arg4);
        let v1 = pool_mut(arg0);
        schedule_put(arg0, v0);
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::unstake(v1, &mut v0, arg1, arg2, arg3, arg4)
    }

    fun v10_from(arg0: &Board) : u64 {
        let v0 = V10FromKey{dummy_field: false};
        if (0x2::dynamic_field::exists<V10FromKey>(&arg0.id, v0)) {
            let v2 = V10FromKey{dummy_field: false};
            *0x2::dynamic_field::borrow<V10FromKey, u64>(&arg0.id, v2)
        } else {
            18446744073709551615
        }
    }

    fun v5_from(arg0: &Board) : u64 {
        let v0 = V5FromKey{dummy_field: false};
        if (0x2::dynamic_field::exists<V5FromKey>(&arg0.id, v0)) {
            let v2 = V5FromKey{dummy_field: false};
            *0x2::dynamic_field::borrow<V5FromKey, u64>(&arg0.id, v2)
        } else {
            18446744073709551615
        }
    }

    fun v8_from(arg0: &Board) : u64 {
        let v0 = V8FromKey{dummy_field: false};
        if (0x2::dynamic_field::exists<V8FromKey>(&arg0.id, v0)) {
            let v2 = V8FromKey{dummy_field: false};
            *0x2::dynamic_field::borrow<V8FromKey, u64>(&arg0.id, v2)
        } else {
            18446744073709551615
        }
    }

    fun v9_from(arg0: &Board) : u64 {
        let v0 = V9FromKey{dummy_field: false};
        if (0x2::dynamic_field::exists<V9FromKey>(&arg0.id, v0)) {
            let v2 = V9FromKey{dummy_field: false};
            *0x2::dynamic_field::borrow<V9FromKey, u64>(&arg0.id, v2)
        } else {
            18446744073709551615
        }
    }

    public fun wealth_fund_bps(arg0: &Board) : u64 {
        fund_bps(arg0)
    }

    public fun wealth_tickets(arg0: &Board) : (u64, u64) {
        let v0 = TicketsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TicketsKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = TicketsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<TicketsKey, Tickets>(&arg0.id, v1);
        (v2.epoch, v2.total)
    }

    public fun withdraw_clock(arg0: &Board, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        (refine_start(arg0, arg1), 604800000, fee_bps_at(arg0, arg1, 0x2::clock::timestamp_ms(arg2)))
    }

    entry fun withdraw_dev_fees(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.dev_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.dev_fees, v0), arg1), @0xa19b2d37f95ca4c48efafb2cd01d0f97f33852457daa27cfba3de37fdec24d4b);
        };
    }

    public fun withdraw_gts(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        abort 24
    }

    public fun withdraw_gts_v6(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        abort 33
    }

    public fun withdraw_gts_v7(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = UnrefinedKey{player: v0};
        assert!(0x2::dynamic_field::exists<UnrefinedKey>(&arg0.id, v1), 20);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let Unrefined {
            amount : v3,
            bonus  : v4,
            snap   : v5,
        } = 0x2::dynamic_field::remove<UnrefinedKey, Unrefined>(&mut arg0.id, v1);
        let v6 = v4 + earned(v3, arg0.acc, v5);
        let v7 = mul_div(v3, fee_bps_at(arg0, v0, v2), 10000);
        arg0.unrefined_total = arg0.unrefined_total - v3;
        let v8 = arg0.unrefined_total;
        let v9 = if (v8 > 0) {
            v7 / 2
        } else {
            0
        };
        let v10 = v7 - v9;
        if (v9 > 0) {
            arg0.acc = arg0.acc + (v9 as u256) * 1000000000000000000 / (v8 as u256);
            let v11 = WithdrawFeeShared{
                player        : v0,
                amount        : v9,
                holders_total : v8,
            };
            0x2::event::emit<WithdrawFeeShared>(v11);
        };
        if (v10 > 0) {
            0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::burn<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg1, 0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.unrefined, v10), arg3));
        };
        let v12 = RefineClockKey{player: v0};
        if (0x2::dynamic_field::exists<RefineClockKey>(&arg0.id, v12)) {
            *0x2::dynamic_field::borrow_mut<RefineClockKey, u64>(&mut arg0.id, v12) = v2;
        } else {
            0x2::dynamic_field::add<RefineClockKey, u64>(&mut arg0.id, v12, v2);
        };
        let v13 = GtsWithdrawn{
            player : v0,
            amount : v3,
            fee    : v7,
            bonus  : v6,
            paid   : v3 - v7 + v6,
            burned : v10,
        };
        0x2::event::emit<GtsWithdrawn>(v13);
        0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.unrefined, v3 - v7 + v6), arg3)
    }

    fun zeros() : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 25) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

