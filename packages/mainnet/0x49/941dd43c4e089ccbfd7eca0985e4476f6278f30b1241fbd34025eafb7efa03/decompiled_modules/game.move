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

    struct MinterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LimiterKey has copy, drop, store {
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

    fun add_unrefined(arg0: &mut Board, arg1: address, arg2: 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: &0x2::tx_context::TxContext) {
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
        if (!0x2::dynamic_field::exists<RefineClockKey>(&arg0.id, v4)) {
            let v5 = 0x2::tx_context::epoch_timestamp_ms(arg3);
            let v6 = if (arg0.cur_end_ms > v5) {
                arg0.cur_end_ms
            } else {
                v5
            };
            0x2::dynamic_field::add<RefineClockKey, u64>(&mut arg0.id, v4, v6);
        };
        let v7 = 0x2::dynamic_field::borrow_mut<UnrefinedKey, Unrefined>(&mut arg0.id, v2);
        v7.bonus = v7.bonus + earned(v7.amount, v1, v7.snap);
        v7.snap = v1;
        v7.amount = v7.amount + v0;
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
        let v3 = v2 != 0 && 0x2::table::contains<u64, RoundInfo>(&arg0.rounds, v2);
        let v4 = LimiterKey{dummy_field: false};
        if (v3 && round_gts(arg0, &v1.miner) <= 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::room_today<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::dynamic_object_field::borrow<LimiterKey, 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&arg0.id, v4), arg4)) {
            let v5 = &mut v1.miner;
            let (v6, v7, v8, v9) = claim_as(arg0, v5, arg3, false, arg2, arg4, arg5);
            let v10 = v7;
            let v11 = v6;
            if (0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v11) == 0) {
                0x2::coin::destroy_zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v11);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(v11, arg3);
            };
            let v12 = 0x2::coin::value<0x2::sui::SUI>(&v10);
            if (v12 > 0) {
                v1.wins = v1.wins + 1;
                v1.won = v1.won + v12;
                0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::credit(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(v10));
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
            };
            v1.mined = v1.mined + v9;
            let v13 = &mut v1;
            auto_drop_old_tickets(arg0, v13);
            v1.tickets = v1.tickets + v8;
            v1.claims = v1.claims + 1;
            let v14 = AutoClaimed{
                round_id : v2,
                player   : arg3,
                sui      : v12,
                gts      : v9,
            };
            0x2::event::emit<AutoClaimed>(v14);
        };
        let v15 = if (v1.tickets > 0) {
            if (v1.claims >= 10) {
                true
            } else if (!auto_live(arg1, arg3)) {
                true
            } else {
                tickets_merge(arg0, arg3)
            }
        } else {
            false
        };
        if (v15) {
            let v16 = if (v2 != 0) {
                v2
            } else {
                arg0.cur_id
            };
            let v17 = &mut v1;
            auto_add_tickets(arg0, v17, arg3, v16);
        };
        let v18 = AutoKey{player: arg3};
        0x2::dynamic_field::add<AutoKey, AutoSeat>(&mut arg0.id, v18, v1);
    }

    fun auto_deploy(arg0: &mut Board, arg1: &mut 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::Vault, arg2: address, arg3: &mut 0x2::random::RandomGenerator, arg4: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.paused || !0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::ready(arg1, arg2, arg5)) {
            return
        };
        let (_, v1, v2, _, _, _, _) = 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::plan_of(arg1, arg2);
        if (v2 < 50000000 || v1 > 2) {
            return
        };
        let v7 = 0x2::clock::timestamp_ms(arg5);
        if (arg0.cur_started && v7 + arg0.freeze_ms > arg0.cur_end_ms) {
            return
        };
        if (v1 == 2 && (!arg0.cur_started || v7 + arg0.freeze_ms + 10000 < arg0.cur_end_ms)) {
            return
        };
        let v8 = SeatKey{
            round_id : arg0.cur_id,
            player   : arg2,
        };
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v8)) {
            return
        };
        let v9 = if (v1 == 1) {
            1
        } else if (5 < max_tiles(arg0)) {
            5
        } else {
            max_tiles(arg0)
        };
        let v10 = mul_div(v2, 100, 10000);
        let v11 = (v2 - v10 - mul_div(v2, 100, 10000)) / v9;
        if (v11 < arg0.min_deploy) {
            return
        };
        let v12 = AutoKey{player: arg2};
        let v13 = 0x2::dynamic_field::remove<AutoKey, AutoSeat>(&mut arg0.id, v12);
        if (v13.miner.round_id == 0) {
            let v14 = AutoCapKey{dummy_field: false};
            let v15 = 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::pull(arg1, 0x2::dynamic_object_field::borrow<AutoCapKey, 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::PullCap>(&arg0.id, v14), arg2, arg5);
            0x2::balance::join<0x2::sui::SUI>(arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v15, v10));
            let v16 = v11 * v9;
            let v17 = 0x2::balance::value<0x2::sui::SUI>(&v15);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, v15);
            let v18 = if (v1 == 2) {
                emptiest_tiles(&arg0.cur_deployed, v9, v11, arg3)
            } else {
                random_tiles(v9, v11, arg3)
            };
            let v19 = &mut v13.miner;
            deploy_as(arg0, v19, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v15, v16), arg6), v18, arg5);
            v13.rounds = v13.rounds + 1;
            v13.deployed = v13.deployed + v16;
            v13.fees = v13.fees + v10 + v17;
            let v20 = AutoMined{
                round_id    : arg0.cur_id,
                player      : arg2,
                strategy    : v1,
                spent       : v2,
                deployed    : v16,
                keeper_fee  : v10,
                buyback_fee : v17,
            };
            0x2::event::emit<AutoMined>(v20);
        };
        let v21 = AutoKey{player: arg2};
        0x2::dynamic_field::add<AutoKey, AutoSeat>(&mut arg0.id, v21, v13);
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
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AutoKey{player: v0};
        if (0x2::dynamic_field::exists<AutoKey>(&arg0.id, v1)) {
            return
        };
        let v2 = AutoKey{player: v0};
        let v3 = AutoSeat{
            miner        : new_miner(arg1),
            tickets      : 0,
            ticket_epoch : 0,
            claims       : 0,
            rounds       : 0,
            wins         : 0,
            deployed     : 0,
            fees         : 0,
            won          : 0,
            mined        : 0,
        };
        0x2::dynamic_field::add<AutoKey, AutoSeat>(&mut arg0.id, v2, v3);
        let v4 = AutoJoined{player: v0};
        0x2::event::emit<AutoJoined>(v4);
    }

    public fun auto_joined(arg0: &Board, arg1: address) : bool {
        let v0 = AutoKey{player: arg1};
        0x2::dynamic_field::exists<AutoKey>(&arg0.id, v0)
    }

    fun auto_live(arg0: &0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::Vault, arg1: address) : bool {
        let (v0, _, v2, v3, v4, v5, _) = 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::plan_of(arg0, arg1);
        let v7 = 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::balance_of(arg0, arg1);
        if (v0) {
            if (v3 > 0) {
                if (v2 >= 50000000) {
                    if (v7 >= v2) {
                        if (v7 - v2 >= v4) {
                            v5 == 0 || v7 < v5
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    entry fun auto_run(arg0: &mut Board, arg1: &mut 0x781f524560af7086ce0530c39ffbd6d04ebf3d9597a22fba267ad033c81c7114::vault::Vault, arg2: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: vector<address>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = AutoCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<AutoCapKey>(&arg0.id, v0), 38);
        let v1 = 0x2::random::new_generator(arg4, arg6);
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg3)) {
            let v4 = *0x1::vector::borrow<address>(&arg3, v3);
            let v5 = AutoKey{player: v4};
            if (0x2::dynamic_field::exists<AutoKey>(&arg0.id, v5)) {
                auto_claim(arg0, arg1, arg2, v4, arg5, arg6);
                let v6 = &mut v1;
                let v7 = &mut v2;
                auto_deploy(arg0, arg1, v4, v6, v7, arg5, arg6);
            };
            v3 = v3 + 1;
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
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

    public fun buyback_burn(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: BuybackReceipt, arg3: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        let BuybackReceipt {  } = arg2;
        abort 30
    }

    public fun buyback_burn_v2(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: BuybackReceipt, arg3: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let BuybackReceipt { sui: v0 } = arg2;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v1 <= v0, 7);
        assert!(0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&arg3) > 0, 27);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v2 = 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg3);
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut v2, 0x2::balance::withdraw_all<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(bought_mut(arg0)));
        0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::burn<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg1, 0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v2, arg5));
        let v3 = BuybackDone{
            sui_spent  : v0 - v1,
            gts_burned : 0x2::balance::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v2),
        };
        0x2::event::emit<BuybackDone>(v3);
    }

    public fun buyback_keep(arg0: &mut Board, arg1: BuybackReceipt, arg2: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        let BuybackReceipt {  } = arg1;
        abort 35
    }

    public fun buyback_take(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuybackReceipt) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == @0x22390096d8def0638c92f86da60683e37d1a7f00b4b22fcb359952db300c3549, 25);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback);
        assert!(v0 > 0, 26);
        let v1 = BuybackReceipt{sui: v0};
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.buyback), arg1), v1)
    }

    public fun buyback_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback)
    }

    fun check_version(arg0: &mut Board) {
        assert!(arg0.version <= 17, 14);
        arg0.version = 17;
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
        let v11 = mint_gts(arg0, arg4, v9, arg5, arg6);
        let v12 = 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v11);
        let v13 = if (v12 == 0 || is_bot(arg2)) {
            v11
        } else {
            add_unrefined(arg0, arg2, 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v11), arg6);
            0x2::coin::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg6)
        };
        let v14 = if (v7 && v8 > 0) {
            let v15 = mul_div(v4, v8, v5);
            let v16 = mul_div(v15, v8, arg1.total_deployed);
            let v17 = v15 - v16;
            if (v17 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v17));
                let v18 = MotherlodeReturned{
                    round_id : v0,
                    amount   : v17,
                    balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
                };
                0x2::event::emit<MotherlodeReturned>(v18);
                let v19 = Forfeited{
                    round_id   : v0,
                    player     : arg2,
                    to_reserve : 0,
                    to_fund    : v17,
                };
                0x2::event::emit<Forfeited>(v19);
            };
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + v16), arg6)
        } else if (v6 && v8 > 0) {
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + mul_div(v4, v8, v5)), arg6)
        } else if (v8 > 0 && v5 > 0) {
            let v20 = JackpotKey{round_id: v0};
            let v21 = if (0x2::dynamic_field::exists<JackpotKey>(&arg0.id, v20)) {
                mul_div(*0x2::dynamic_field::borrow<JackpotKey, u64>(&arg0.id, v20), v8, v5)
            } else {
                0
            };
            let v22 = mul_div(v4, v8, v5) - v21;
            let v23 = arg1.total_deployed;
            let v24 = mul_div(v22, v8, v23);
            let v25 = if (is_bot(arg2)) {
                0
            } else {
                mul_div(v21, v8, v23)
            };
            let v26 = v21 - v25 + v22 - v24;
            let v27 = 0;
            if (v26 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v26));
                let v28 = MotherlodeReturned{
                    round_id : v0,
                    amount   : v26,
                    balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
                };
                0x2::event::emit<MotherlodeReturned>(v28);
            };
            if (v27 > 0 || v26 > 0) {
                let v29 = Forfeited{
                    round_id   : v0,
                    player     : arg2,
                    to_reserve : v27,
                    to_fund    : v26,
                };
                0x2::event::emit<Forfeited>(v29);
            };
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + v24 + v25), arg6)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg6)
        };
        let v30 = v14;
        let v31 = mul_div(arg1.total_deployed - v8, fee_bps(arg0), 10000);
        let v32 = 0;
        if (v31 > 0 && !no_tickets(arg2)) {
            if (arg3) {
                add_tickets(arg0, v0, arg2, v31);
            } else {
                v32 = v31;
            };
        };
        let v33 = SeatKey{
            round_id : v0,
            player   : arg2,
        };
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v33) && *0x2::dynamic_field::borrow<SeatKey, 0x2::object::ID>(&arg0.id, v33) == 0x2::object::id<Miner>(arg1)) {
            0x2::dynamic_field::remove<SeatKey, 0x2::object::ID>(&mut arg0.id, v33);
        };
        let v34 = RoundLeftKey{round_id: v0};
        if (0x2::dynamic_field::exists<RoundLeftKey>(&arg0.id, v34)) {
            let v35 = 0x2::dynamic_field::borrow_mut<RoundLeftKey, u64>(&mut arg0.id, v34);
            *v35 = *v35 - 1;
            if (*v35 == 0) {
                0x2::dynamic_field::remove<RoundLeftKey, u64>(&mut arg0.id, v34);
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
        let v43 = Claimed{
            round_id : v0,
            player   : arg2,
            gts      : v12,
            sui      : 0x2::coin::value<0x2::sui::SUI>(&v30),
        };
        0x2::event::emit<Claimed>(v43);
        arg1.round_id = 0;
        arg1.total_deployed = 0;
        arg1.deployed = zeros();
        (v13, v30, v32, v12)
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

    fun earned(arg0: u64, arg1: u256, arg2: u256) : u64 {
        (((arg0 as u256) * (arg1 - arg2) / 1000000000000000000) as u64)
    }

    public fun emission(arg0: &Board) : (u64, u64, u64, u64, u64, u64) {
        (arg0.reward, arg0.step_rounds, arg0.decay_ppm, arg0.step_count, arg0.full_reward_deploy, arg0.committed)
    }

    fun emptiest_tiles(arg0: &vector<u64>, arg1: u64, arg2: u64, arg3: &mut 0x2::random::RandomGenerator) : vector<u64> {
        let v0 = zeros();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = 25;
            let v3 = v2;
            let v4 = 0;
            while (v4 < 25) {
                let v5 = (0x2::random::generate_u64_in_range(arg3, 0, 25 - 1) + v4) % 25;
                if (*0x1::vector::borrow<u64>(&v0, v5) == 0 && (v2 == 25 || *0x1::vector::borrow<u64>(arg0, v5) < 0)) {
                    v3 = v5;
                };
                v4 = v4 + 1;
            };
            *0x1::vector::borrow_mut<u64>(&mut v0, v3) = arg2;
            v1 = v1 + 1;
        };
        v0
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
            version            : 17,
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
            decay_ppm          : 14250,
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
        check_version(arg0);
        let LiquidityReceipt { sui: v0 } = arg1;
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position", 32);
        lock_position<T0>(arg0, v0, arg2, arg3, arg4);
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
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == @0x22390096d8def0638c92f86da60683e37d1a7f00b4b22fcb359952db300c3549, 25);
        let v0 = liquidity_mut(arg0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(v0);
        assert!(v1 > 0, 31);
        let v2 = LiquidityReceipt{sui: v1};
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(v0), arg1), v2)
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

    fun lock_position<T0: store + key>(arg0: &mut Board, arg1: u64, arg2: T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 < arg1, 7);
        let v1 = liquidity_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(v1, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v2 = bought_mut(arg0);
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v2, 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg4));
        let v3 = LpCountKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LpCountKey>(&arg0.id, v3)) {
            let v4 = LpCountKey{dummy_field: false};
            0x2::dynamic_field::add<LpCountKey, u64>(&mut arg0.id, v4, 0);
        };
        let v5 = LpCountKey{dummy_field: false};
        let v6 = *0x2::dynamic_field::borrow<LpCountKey, u64>(&arg0.id, v5);
        let v7 = LpKey{i: v6};
        0x2::dynamic_object_field::add<LpKey, T0>(&mut arg0.id, v7, arg2);
        let v8 = LpCountKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<LpCountKey, u64>(&mut arg0.id, v8) = v6 + 1;
        let v9 = LiquidityLocked{
            sui_spent : arg1 - v0,
            gts_left  : 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&arg4),
            position  : 0x2::object::id<T0>(&arg2),
            positions : v6 + 1,
        };
        0x2::event::emit<LiquidityLocked>(v9);
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

    fun mint_gts(arg0: &mut Board, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        let v0 = LimiterKey{dummy_field: false};
        0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::mint<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::dynamic_object_field::borrow_mut<LimiterKey, 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&mut arg0.id, v0), arg1, arg2, arg3, arg4)
    }

    public fun mint_limiter_id(arg0: &Board) : 0x2::object::ID {
        let v0 = LimiterKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::id<LimiterKey>(&arg0.id, v0);
        *0x1::option::borrow<0x2::object::ID>(&v1)
    }

    public fun mint_room_today(arg0: &Board, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = LimiterKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow<LimiterKey, 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::DailyLimiter<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(&arg0.id, v0);
        (0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::room_today<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v1, arg1), 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily::per_day<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v1))
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

    public fun poke(arg0: &mut Board, arg1: address, arg2: &0x2::clock::Clock) {
        check_version(arg0);
        settle_gts_both(arg0, arg1);
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::poke(pool_mut(arg0), arg1, arg2);
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

    fun random_tiles(arg0: u64, arg1: u64, arg2: &mut 0x2::random::RandomGenerator) : vector<u64> {
        let v0 = zeros();
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = 0x2::random::generate_u64_in_range(arg2, 0, 25 - 1);
            if (*0x1::vector::borrow<u64>(&v0, v2) == 0) {
                *0x1::vector::borrow_mut<u64>(&mut v0, v2) = arg1;
                v1 = v1 + 1;
            };
        };
        v0
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

    fun round_gts(arg0: &Board, arg1: &Miner) : u64 {
        let v0 = 0x2::table::borrow<u64, RoundInfo>(&arg0.rounds, arg1.round_id);
        if (v0.total_deployed == 0) {
            0
        } else {
            mul_div(v0.round_reward, arg1.total_deployed, v0.total_deployed)
        }
    }

    public fun set_emission(arg0: &AdminCap, arg1: &mut Board, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        check_version(arg1);
        assert!(arg2 <= 10000000000, 18);
        assert!(arg3 >= 1 && arg5 < arg3, 18);
        assert!(arg4 <= 500000, 18);
        assert!(arg6 >= 1000000 && arg6 <= 1000000000000, 18);
        let v0 = if (arg2 <= arg1.reward) {
            if (arg4 >= arg1.decay_ppm) {
                arg3 <= arg1.step_rounds
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 36);
        assert!(arg5 >= arg1.step_count && arg6 >= arg1.full_reward_deploy, 36);
        arg1.reward = arg2;
        arg1.step_rounds = arg3;
        arg1.decay_ppm = arg4;
        arg1.step_count = arg5;
        arg1.full_reward_deploy = arg6;
        let v1 = EmissionChanged{
            reward             : arg2,
            step_rounds        : arg3,
            decay_ppm          : arg4,
            step_count         : arg5,
            full_reward_deploy : arg6,
        };
        0x2::event::emit<EmissionChanged>(v1);
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
        let v0 = arg0.ml_odds;
        settle_with_odds(arg0, arg1, arg2, v0, arg3);
    }

    fun settle_with_odds(arg0: &mut Board, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.cur_started, 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.cur_end_ms, 8);
        let v0 = V5FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V5FromKey>(&arg0.id, v0)) {
            let v1 = V5FromKey{dummy_field: false};
            0x2::dynamic_field::add<V5FromKey, u64>(&mut arg0.id, v1, arg0.cur_id);
        };
        let v2 = RefineFromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RefineFromKey>(&arg0.id, v2)) {
            let v3 = RefineFromKey{dummy_field: false};
            0x2::dynamic_field::add<RefineFromKey, u64>(&mut arg0.id, v3, 0x2::clock::timestamp_ms(arg2));
        };
        let v4 = V8FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V8FromKey>(&arg0.id, v4)) {
            let v5 = V8FromKey{dummy_field: false};
            0x2::dynamic_field::add<V8FromKey, u64>(&mut arg0.id, v5, arg0.cur_id);
        };
        let v6 = V9FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V9FromKey>(&arg0.id, v6)) {
            let v7 = V9FromKey{dummy_field: false};
            0x2::dynamic_field::add<V9FromKey, u64>(&mut arg0.id, v7, arg0.cur_id);
        };
        let v8 = V10FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V10FromKey>(&arg0.id, v8)) {
            let v9 = V10FromKey{dummy_field: false};
            0x2::dynamic_field::add<V10FromKey, u64>(&mut arg0.id, v9, arg0.cur_id);
        };
        let v10 = 0x2::random::new_generator(arg1, arg4);
        let v11 = 0x2::random::generate_u64(&mut v10);
        let v12 = ((v11 % 25) as u8);
        let v13 = TicketsKey{dummy_field: false};
        let (v14, v15, v16) = if (0x2::dynamic_field::exists<TicketsKey>(&arg0.id, v13)) {
            let v17 = TicketsKey{dummy_field: false};
            let v18 = 0x2::dynamic_field::borrow<TicketsKey, Tickets>(&arg0.id, v17);
            (v18.epoch, v18.total, v18.count)
        } else {
            (0, 0, 0)
        };
        let v19 = if (v15 > 0) {
            v15 - 1
        } else {
            0
        };
        let v20 = *0x1::vector::borrow<u64>(&arg0.cur_deployed, (v12 as u64));
        let v21 = arg0.cur_total - v20;
        let v22 = mul_div(v21, arg0.vault_bps, 10000);
        let v23 = mul_div(v21, 100, 10000);
        arg0.buyback_bps = 300;
        let v24 = mul_div(v21, 300, 10000);
        let v25 = mul_div(v21, 200, 10000);
        let v26 = mul_div(v21, stake_bps(arg0), 10000);
        let v27 = mul_div(v21, fund_bps(arg0), 10000);
        let v28 = v22 + v27;
        let v29 = if (v28 < 5000000) {
            v28
        } else {
            5000000
        };
        let v30 = 5000000 - v29;
        let v31 = if (v25 < v30) {
            v25
        } else {
            v30
        };
        let v32 = v29 + v31;
        let v33 = v25 - v31;
        let v34 = v28 - v29;
        let v35 = v34;
        let v36 = v21 - v22 - v23 - v24 - v25 - v26 - v27;
        let v37 = v36;
        if (v26 > 0) {
            let v38 = StakeKey{dummy_field: false};
            let v39 = 0x2::dynamic_field::borrow_mut<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&mut arg0.id, v38);
            if (0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::has_stakers(v39)) {
                0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::reward(v39, arg0.cur_id, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v26));
            } else {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v26));
                v35 = v34 + v26;
            };
        };
        if (v23 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v23));
        };
        if (v24 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v24));
        };
        if (v33 > 0) {
            let v40 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v33);
            let v41 = liquidity_mut(arg0);
            0x2::balance::join<0x2::sui::SUI>(v41, v40);
        };
        if (v32 > 0) {
            let v42 = 0x2::tx_context::sender(arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v32), arg4), v42);
            let v43 = DrawPaid{
                round_id : arg0.cur_id,
                settler  : v42,
                amount   : v32,
            };
            0x2::event::emit<DrawPaid>(v43);
        };
        if (v20 == 0) {
            v35 = v35 + v36;
            v37 = 0;
        };
        let v44 = 0;
        if (v35 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v35));
        };
        let v45 = if (0x2::random::generate_u64_in_range(&mut v10, 0, arg3 - 1) == 0) {
            if (v15 > 0) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode) > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v45) {
            let v46 = ticket_holder(arg0, v14, v16, 0x2::random::generate_u64_in_range(&mut v10, 0, v19));
            let v47 = PlayerTicketsKey{
                epoch  : v14,
                player : v46,
            };
            let v48 = *0x2::dynamic_field::borrow<PlayerTicketsKey, u64>(&arg0.id, v47);
            let v49 = 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode);
            v44 = v49;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.motherlode), arg4), v46);
            let v50 = tickets_mut(arg0);
            v50.epoch = v14 + 1;
            v50.total = 0;
            v50.count = 0;
            let v51 = WealthFundWon{
                round_id       : arg0.cur_id,
                epoch          : v14,
                winner         : v46,
                amount         : v49,
                winner_tickets : v48,
                total_tickets  : v15,
            };
            0x2::event::emit<WealthFundWon>(v51);
        };
        let v52 = MotherlodeUpdate{
            round_id : arg0.cur_id,
            added    : v35,
            paid     : v44,
            balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
        };
        0x2::event::emit<MotherlodeUpdate>(v52);
        let v53 = if (arg0.cur_total >= arg0.full_reward_deploy) {
            next_full_reward(arg0)
        } else {
            mul_div(next_full_reward(arg0), arg0.cur_total, arg0.full_reward_deploy)
        };
        arg0.committed = arg0.committed + v53;
        arg0.step_count = arg0.step_count + 1;
        if (arg0.step_count >= arg0.step_rounds) {
            arg0.step_count = 0;
            arg0.reward = mul_div(arg0.reward, 1000000 - arg0.decay_ppm, 1000000);
        };
        let v54 = RoundInfo{
            total_deployed       : arg0.cur_total,
            deployed             : arg0.cur_deployed,
            winning_square       : v12,
            losing_pot_after_fee : v37,
            winners_total        : v20,
            round_reward         : v53,
            rng                  : v11,
        };
        0x2::table::add<u64, RoundInfo>(&mut arg0.rounds, arg0.cur_id, v54);
        if (arg0.cur_players > 0) {
            let v55 = RoundLeftKey{round_id: arg0.cur_id};
            0x2::dynamic_field::add<RoundLeftKey, u64>(&mut arg0.id, v55, arg0.cur_players);
        };
        let v56 = RoundSettled{
            round_id       : arg0.cur_id,
            winning_square : v12,
            total_deployed : arg0.cur_total,
            winners_total  : v20,
            round_reward   : v53,
            losing_pot     : v21,
            winners_payout : v37,
            vault_fee      : 0,
            buyback_fee    : v24,
            dev_fee        : v23,
            players        : arg0.cur_players,
            committed      : arg0.committed,
            next_reward    : next_full_reward(arg0),
        };
        0x2::event::emit<RoundSettled>(v56);
        arg0.cur_id = arg0.cur_id + 1;
        arg0.cur_started = false;
        arg0.cur_total = 0;
        arg0.cur_deployed = zeros();
        arg0.cur_players = 0;
    }

    public fun stake(arg0: &mut Board, arg1: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        settle_gts_both(arg0, 0x2::tx_context::sender(arg4));
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::stake(pool_mut(arg0), arg1, arg2, arg3, arg4);
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

    public fun staking_totals(arg0: &Board) : (u64, u128, u64, u64) {
        let v0 = StakeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StakeKey>(&arg0.id, v0)) {
            return (0, 0, 0, 0)
        };
        let v1 = StakeKey{dummy_field: false};
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::totals(0x2::dynamic_field::borrow<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&arg0.id, v1))
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

    fun tickets_merge(arg0: &Board, arg1: address) : bool {
        let v0 = TicketsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TicketsKey>(&arg0.id, v0)) {
            return false
        };
        let v1 = TicketsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<TicketsKey, Tickets>(&arg0.id, v1);
        if (v2.count > 0) {
            let v4 = TicketKey{
                epoch : v2.epoch,
                i     : v2.count - 1,
            };
            0x2::dynamic_field::borrow<TicketKey, TicketEntry>(&arg0.id, v4).player == arg1
        } else {
            false
        }
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
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::unstake(pool_mut(arg0), arg1, arg2, arg3, arg4)
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

