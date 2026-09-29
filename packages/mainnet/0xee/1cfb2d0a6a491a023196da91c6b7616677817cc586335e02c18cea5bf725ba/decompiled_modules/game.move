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

    struct RefineClockKey has copy, drop, store {
        player: address,
    }

    struct RefineFromKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StakeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StakeBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuybackReceipt {
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

    struct DrawPaid has copy, drop {
        round_id: u64,
        settler: address,
        amount: u64,
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

    public fun burn_bought(arg0: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg1: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg1);
            return
        };
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::redeem(arg0, arg1, arg2)));
        let v1 = BuybackBurned{amount: v0};
        0x2::event::emit<BuybackBurned>(v1);
    }

    public fun buyback_burn(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: BuybackReceipt, arg3: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg0);
        let BuybackReceipt { sui: v0 } = arg2;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v1 <= v0, 7);
        let v2 = 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&arg3);
        assert!(v2 > 0, 27);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::burn(arg1, arg3);
        let v3 = BuybackDone{
            sui_spent  : v0 - v1,
            gts_burned : v2,
        };
        0x2::event::emit<BuybackDone>(v3);
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
        assert!(arg0.version <= 8, 14);
        arg0.version = 8;
    }

    public fun claim(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg0);
        assert!(arg1.round_id != 0, 10);
        assert!(0x2::table::contains<u64, RoundInfo>(&arg0.rounds, arg1.round_id), 11);
        let v0 = arg1.round_id;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::table::borrow<u64, RoundInfo>(&arg0.rounds, v0);
        let v3 = v2.total_deployed;
        let v4 = (v2.winning_square as u64);
        let v5 = v2.losing_pot_after_fee;
        let v6 = v2.winners_total;
        let v7 = v0 >= v5_from(arg0);
        let v8 = *0x1::vector::borrow<u64>(&arg1.deployed, v4);
        let v9 = if (v7 && v0 < v8_from(arg0)) {
            let v10 = v3 - v6;
            if (v10 == 0) {
                0
            } else {
                mul_div(v2.round_reward, arg1.total_deployed - v8, v10)
            }
        } else if (v3 == 0) {
            0
        } else {
            mul_div(v2.round_reward, arg1.total_deployed, v3)
        };
        let v11 = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::mint(arg2, v9, arg3);
        let v12 = 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v11);
        let v13 = if (v12 == 0 || is_bot(v1)) {
            v11
        } else {
            add_unrefined(arg0, v1, 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v11), arg3);
            0x2::coin::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg3)
        };
        let v14 = if (v7 && v8 > 0) {
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + mul_div(v5, v8, v6)), arg3)
        } else if (v8 > 0 && v6 > 0) {
            let v15 = JackpotKey{round_id: v0};
            let v16 = if (0x2::dynamic_field::exists<JackpotKey>(&arg0.id, v15)) {
                mul_div(*0x2::dynamic_field::borrow<JackpotKey, u64>(&arg0.id, v15), v8, v6)
            } else {
                0
            };
            let v17 = mul_div(v5, v8, v6) - v16;
            let v18 = arg1.total_deployed;
            let v19 = mul_div(v17, v8, v18);
            let v20 = if (is_bot(v1)) {
                0
            } else {
                mul_div(v16, v8, v18)
            };
            let v21 = v17 - v19;
            let v22 = v16 - v20;
            if (v21 > 0) {
                0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v21));
            };
            if (v22 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v22));
                let v23 = MotherlodeReturned{
                    round_id : v0,
                    amount   : v22,
                    balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
                };
                0x2::event::emit<MotherlodeReturned>(v23);
            };
            if (v21 > 0 || v22 > 0) {
                let v24 = Forfeited{
                    round_id   : v0,
                    player     : v1,
                    to_reserve : v21,
                    to_fund    : v22,
                };
                0x2::event::emit<Forfeited>(v24);
            };
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8 + v19 + v20), arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v25 = v14;
        let v26 = mul_div(arg1.total_deployed - v8, fee_bps(arg0), 10000);
        if (v26 > 0 && !no_tickets(v1)) {
            add_tickets(arg0, v0, v1, v26);
        };
        let v27 = SeatKey{
            round_id : v0,
            player   : v1,
        };
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v27) && *0x2::dynamic_field::borrow<SeatKey, 0x2::object::ID>(&arg0.id, v27) == 0x2::object::id<Miner>(arg1)) {
            0x2::dynamic_field::remove<SeatKey, 0x2::object::ID>(&mut arg0.id, v27);
        };
        let v28 = Claimed{
            round_id : v0,
            player   : v1,
            gts      : v12,
            sui      : 0x2::coin::value<0x2::sui::SUI>(&v25),
        };
        0x2::event::emit<Claimed>(v28);
        arg1.round_id = 0;
        arg1.total_deployed = 0;
        arg1.deployed = zeros();
        (v13, v25)
    }

    public fun claim_sui(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = claim(arg0, arg1, arg2, arg3);
        let v2 = v0;
        if (0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v2) == 0) {
            0x2::coin::destroy_zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>>(v2, 0x2::tx_context::sender(arg3));
        };
        v1
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
        (arg0.ml_odds, arg0.ml_share_bps, arg0.vault_bps, arg0.buyback_bps, 100, arg0.refine_fee_bps, arg0.paused)
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
        assert!(0x1::vector::length<u64>(&arg3) == 25, 1);
        assert!(!arg0.paused, 19);
        let v0 = 0x2::clock::timestamp_ms(arg4);
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
            player   : 0x2::tx_context::sender(arg5),
        };
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v1)) {
            assert!(*0x2::dynamic_field::borrow<SeatKey, 0x2::object::ID>(&arg0.id, v1) == 0x2::object::id<Miner>(arg1), 15);
        } else {
            0x2::dynamic_field::add<SeatKey, 0x2::object::ID>(&mut arg0.id, v1, 0x2::object::id<Miner>(arg1));
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < 25) {
            let v4 = *0x1::vector::borrow<u64>(&arg3, v3);
            if (v4 > 0) {
                assert!(v4 >= arg0.min_deploy, 6);
            };
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v2, 7);
        if (arg1.round_id == 0) {
            arg1.round_id = arg0.cur_id;
            arg0.cur_players = arg0.cur_players + 1;
        };
        v3 = 0;
        while (v3 < 25) {
            let v5 = *0x1::vector::borrow<u64>(&arg3, v3);
            if (v5 > 0) {
                let v6 = 0x1::vector::borrow_mut<u64>(&mut arg0.cur_deployed, v3);
                *v6 = *v6 + v5;
                let v7 = 0x1::vector::borrow_mut<u64>(&mut arg1.deployed, v3);
                *v7 = *v7 + v5;
            };
            v3 = v3 + 1;
        };
        arg0.cur_total = arg0.cur_total + v2;
        arg1.total_deployed = arg1.total_deployed + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v8 = Deployed{
            round_id : arg0.cur_id,
            player   : 0x2::tx_context::sender(arg5),
            amounts  : arg3,
            total    : v2,
        };
        0x2::event::emit<Deployed>(v8);
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

    fun fee_bps(arg0: &Board) : u64 {
        100 + arg0.vault_bps + arg0.buyback_bps + stake_bps(arg0) + fund_bps(arg0)
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Board{
            id                 : 0x2::object::new(arg0),
            version            : 8,
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
            vault_bps          : 400,
            buyback_bps        : 0,
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
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::poke(pool_mut(arg0), arg1, arg2);
    }

    fun pool_mut(arg0: &mut Board) : &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool {
        let v0 = StakeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<StakeKey>(&arg0.id, v0), 22);
        let v1 = StakeKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&mut arg0.id, v1)
    }

    public fun pot_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
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
        assert!(arg1.buyback_bps == 0 && 0x2::balance::value<0x2::sui::SUI>(&arg1.buyback) == 0, 21);
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = Renounced{dummy_field: false};
        0x2::event::emit<Renounced>(v1);
    }

    public fun set_emission(arg0: &AdminCap, arg1: &mut Board, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        check_version(arg1);
        assert!(arg2 <= 10000000000, 18);
        assert!(arg3 >= 1 && arg5 < arg3, 18);
        assert!(arg4 <= 500000, 18);
        assert!(arg6 >= 1000000 && arg6 <= 1000000000000, 18);
        arg1.reward = arg2;
        arg1.step_rounds = arg3;
        arg1.decay_ppm = arg4;
        arg1.step_count = arg5;
        arg1.full_reward_deploy = arg6;
        let v0 = EmissionChanged{
            reward             : arg2,
            step_rounds        : arg3,
            decay_ppm          : arg4,
            step_count         : arg5,
            full_reward_deploy : arg6,
        };
        0x2::event::emit<EmissionChanged>(v0);
    }

    public fun set_fund_bps(arg0: &AdminCap, arg1: &mut Board, arg2: u64) {
        check_version(arg1);
        assert!(arg2 <= 1000, 18);
        assert!(100 + arg1.vault_bps + arg1.buyback_bps + arg1.ml_share_bps + stake_bps(arg1) + arg2 <= 10000, 18);
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

    public fun set_params(arg0: &AdminCap, arg1: &mut Board, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool) {
        check_version(arg1);
        assert!(arg2 >= 100 && arg2 <= 1000000, 18);
        assert!(arg5 <= 300, 18);
        assert!(arg4 <= 1500 && arg3 <= 3000, 18);
        assert!(100 + arg4 + arg5 + arg3 + stake_bps(arg1) + fund_bps(arg1) <= 10000, 18);
        assert!(arg6 <= 5000, 18);
        assert!(arg7 >= 1000000 && arg7 <= 10000000000, 18);
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
        assert!(100 + arg1.vault_bps + arg1.buyback_bps + arg1.ml_share_bps + arg2 + fund_bps(arg1) <= 10000, 18);
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
        let v0 = arg0.ml_odds;
        settle_with_odds(arg0, arg1, arg2, arg3, v0, arg4);
    }

    fun settle_with_odds(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.cur_started, 9);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.cur_end_ms, 8);
        let v0 = V5FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V5FromKey>(&arg0.id, v0)) {
            let v1 = V5FromKey{dummy_field: false};
            0x2::dynamic_field::add<V5FromKey, u64>(&mut arg0.id, v1, arg0.cur_id);
        };
        let v2 = RefineFromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RefineFromKey>(&arg0.id, v2)) {
            let v3 = RefineFromKey{dummy_field: false};
            0x2::dynamic_field::add<RefineFromKey, u64>(&mut arg0.id, v3, 0x2::clock::timestamp_ms(arg3));
        };
        let v4 = V8FromKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<V8FromKey>(&arg0.id, v4)) {
            let v5 = V8FromKey{dummy_field: false};
            0x2::dynamic_field::add<V8FromKey, u64>(&mut arg0.id, v5, arg0.cur_id);
        };
        let v6 = 0x2::random::new_generator(arg2, arg5);
        let v7 = 0x2::random::generate_u64(&mut v6);
        let v8 = ((v7 % 25) as u8);
        let v9 = TicketsKey{dummy_field: false};
        let (v10, v11, v12) = if (0x2::dynamic_field::exists<TicketsKey>(&arg0.id, v9)) {
            let v13 = TicketsKey{dummy_field: false};
            let v14 = 0x2::dynamic_field::borrow<TicketsKey, Tickets>(&arg0.id, v13);
            (v14.epoch, v14.total, v14.count)
        } else {
            (0, 0, 0)
        };
        let v15 = if (v11 > 0) {
            v11 - 1
        } else {
            0
        };
        let v16 = *0x1::vector::borrow<u64>(&arg0.cur_deployed, (v8 as u64));
        let v17 = arg0.cur_total - v16;
        let v18 = mul_div(v17, arg0.vault_bps, 10000);
        let v19 = mul_div(v17, 100, 10000);
        let v20 = mul_div(v17, arg0.buyback_bps, 10000);
        let v21 = mul_div(v17, stake_bps(arg0), 10000);
        let v22 = mul_div(v17, fund_bps(arg0), 10000);
        let v23 = if (v18 < 5000000) {
            v18
        } else {
            5000000
        };
        let v24 = 5000000 - v23;
        let v25 = if (v20 < v24) {
            v20
        } else {
            v24
        };
        let v26 = v25 + v23;
        let v27 = v20 - v25;
        let v28 = v18 - v23;
        let v29 = v28;
        let v30 = v17 - v18 - v19 - v20 - v21 - v22;
        let v31 = v30;
        if (v21 > 0) {
            let v32 = StakeKey{dummy_field: false};
            let v33 = 0x2::dynamic_field::borrow_mut<StakeKey, 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::Pool>(&mut arg0.id, v32);
            if (0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::has_stakers(v33)) {
                0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::reward(v33, arg0.cur_id, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v21));
            } else {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v21));
                v29 = v28 + v21;
            };
        };
        if (v29 > 0) {
            0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v29));
        };
        if (v19 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v19));
        };
        if (v27 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v27));
        };
        if (v26 > 0) {
            let v34 = 0x2::tx_context::sender(arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v26), arg5), v34);
            let v35 = DrawPaid{
                round_id : arg0.cur_id,
                settler  : v34,
                amount   : v26,
            };
            0x2::event::emit<DrawPaid>(v35);
        };
        let v36 = v22;
        let v37 = 0;
        if (v22 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v22));
        };
        if (v16 == 0) {
            if (v30 > 0) {
                let v38 = mul_div(v17, arg0.ml_share_bps, 10000);
                v36 = v22 + v38;
                let v39 = v30 - v38;
                if (v38 > 0) {
                    0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v38));
                };
                if (v39 > 0) {
                    0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v39));
                    v29 = v29 + v39;
                };
                v31 = 0;
            };
        };
        let v40 = if (0x2::random::generate_u64_in_range(&mut v6, 0, arg4 - 1) == 0) {
            if (v11 > 0) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode) > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v40) {
            let v41 = ticket_holder(arg0, v10, v12, 0x2::random::generate_u64_in_range(&mut v6, 0, v15));
            let v42 = PlayerTicketsKey{
                epoch  : v10,
                player : v41,
            };
            let v43 = *0x2::dynamic_field::borrow<PlayerTicketsKey, u64>(&arg0.id, v42);
            let v44 = 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode);
            v37 = v44;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.motherlode), arg5), v41);
            let v45 = tickets_mut(arg0);
            v45.epoch = v10 + 1;
            v45.total = 0;
            v45.count = 0;
            let v46 = WealthFundWon{
                round_id       : arg0.cur_id,
                epoch          : v10,
                winner         : v41,
                amount         : v44,
                winner_tickets : v43,
                total_tickets  : v11,
            };
            0x2::event::emit<WealthFundWon>(v46);
        };
        let v47 = MotherlodeUpdate{
            round_id : arg0.cur_id,
            added    : v36,
            paid     : v37,
            balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
        };
        0x2::event::emit<MotherlodeUpdate>(v47);
        let v48 = if (arg0.cur_total >= arg0.full_reward_deploy) {
            next_full_reward(arg0)
        } else {
            mul_div(next_full_reward(arg0), arg0.cur_total, arg0.full_reward_deploy)
        };
        arg0.committed = arg0.committed + v48;
        arg0.step_count = arg0.step_count + 1;
        if (arg0.step_count >= arg0.step_rounds) {
            arg0.step_count = 0;
            arg0.reward = mul_div(arg0.reward, 1000000 - arg0.decay_ppm, 1000000);
        };
        let v49 = RoundInfo{
            total_deployed       : arg0.cur_total,
            deployed             : arg0.cur_deployed,
            winning_square       : v8,
            losing_pot_after_fee : v31,
            winners_total        : v16,
            round_reward         : v48,
            rng                  : v7,
        };
        0x2::table::add<u64, RoundInfo>(&mut arg0.rounds, arg0.cur_id, v49);
        let v50 = RoundSettled{
            round_id       : arg0.cur_id,
            winning_square : v8,
            total_deployed : arg0.cur_total,
            winners_total  : v16,
            round_reward   : v48,
            losing_pot     : v17,
            winners_payout : v31,
            vault_fee      : v29,
            buyback_fee    : v27,
            dev_fee        : v19,
            players        : arg0.cur_players,
            committed      : arg0.committed,
            next_reward    : next_full_reward(arg0),
        };
        0x2::event::emit<RoundSettled>(v50);
        arg0.cur_id = arg0.cur_id + 1;
        arg0.cur_started = false;
        arg0.cur_total = 0;
        arg0.cur_deployed = zeros();
        arg0.cur_players = 0;
    }

    public fun stake(arg0: &mut Board, arg1: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
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
        0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking::unstake(pool_mut(arg0), arg1, arg2, arg3, arg4)
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
        if (v7 > 0) {
            0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::burn(arg1, 0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.unrefined, v7), arg3));
        };
        let v8 = RefineClockKey{player: v0};
        if (0x2::dynamic_field::exists<RefineClockKey>(&arg0.id, v8)) {
            *0x2::dynamic_field::borrow_mut<RefineClockKey, u64>(&mut arg0.id, v8) = v2;
        } else {
            0x2::dynamic_field::add<RefineClockKey, u64>(&mut arg0.id, v8, v2);
        };
        let v9 = GtsWithdrawn{
            player : v0,
            amount : v3,
            fee    : v7,
            bonus  : v6,
            paid   : v3 - v7 + v6,
            burned : v7,
        };
        0x2::event::emit<GtsWithdrawn>(v9);
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

