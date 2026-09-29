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

    struct AdminCap has store, key {
        id: 0x2::object::UID,
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

    fun add_unrefined(arg0: &mut Board, arg1: address, arg2: 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>) {
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
        let v4 = 0x2::dynamic_field::borrow_mut<UnrefinedKey, Unrefined>(&mut arg0.id, v2);
        v4.bonus = v4.bonus + earned(v4.amount, v1, v4.snap);
        v4.snap = v1;
        v4.amount = v4.amount + v0;
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

    public fun buyback_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback)
    }

    fun check_version(arg0: &mut Board) {
        assert!(arg0.version <= 1, 14);
        arg0.version = 1;
    }

    public fun claim(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg0);
        assert!(arg1.round_id != 0, 10);
        assert!(0x2::table::contains<u64, RoundInfo>(&arg0.rounds, arg1.round_id), 11);
        let v0 = arg1.round_id;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::table::borrow<u64, RoundInfo>(&arg0.rounds, v0);
        let v3 = v2.total_deployed;
        let v4 = v2.winners_total;
        let v5 = if (v3 == 0) {
            0
        } else {
            mul_div(v2.round_reward, arg1.total_deployed, v3)
        };
        let v6 = 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::mint(arg2, v5, arg3);
        let v7 = 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&v6);
        let v8 = if (v7 == 0 || is_bot(v1)) {
            v6
        } else {
            add_unrefined(arg0, v1, 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(v6));
            0x2::coin::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg3)
        };
        let v9 = *0x1::vector::borrow<u64>(&arg1.deployed, (v2.winning_square as u64));
        let v10 = if (v9 > 0 && v4 > 0) {
            let v11 = JackpotKey{round_id: v0};
            let v12 = if (0x2::dynamic_field::exists<JackpotKey>(&arg0.id, v11)) {
                mul_div(*0x2::dynamic_field::borrow<JackpotKey, u64>(&arg0.id, v11), v9, v4)
            } else {
                0
            };
            let v13 = mul_div(v2.losing_pot_after_fee, v9, v4) - v12;
            let v14 = arg1.total_deployed;
            let v15 = mul_div(v13, v9, v14);
            let v16 = if (is_bot(v1)) {
                0
            } else {
                mul_div(v12, v9, v14)
            };
            let v17 = v13 - v15;
            let v18 = v12 - v16;
            if (v17 > 0) {
                0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v17));
            };
            if (v18 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v18));
                let v19 = MotherlodeReturned{
                    round_id : v0,
                    amount   : v18,
                    balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
                };
                0x2::event::emit<MotherlodeReturned>(v19);
            };
            if (v17 > 0 || v18 > 0) {
                let v20 = Forfeited{
                    round_id   : v0,
                    player     : v1,
                    to_reserve : v17,
                    to_fund    : v18,
                };
                0x2::event::emit<Forfeited>(v20);
            };
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v9 + v15 + v16), arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v21 = v10;
        let v22 = SeatKey{
            round_id : v0,
            player   : v1,
        };
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v22) && *0x2::dynamic_field::borrow<SeatKey, 0x2::object::ID>(&arg0.id, v22) == 0x2::object::id<Miner>(arg1)) {
            0x2::dynamic_field::remove<SeatKey, 0x2::object::ID>(&mut arg0.id, v22);
        };
        let v23 = Claimed{
            round_id : v0,
            player   : v1,
            gts      : v7,
            sui      : 0x2::coin::value<0x2::sui::SUI>(&v21),
        };
        0x2::event::emit<Claimed>(v23);
        arg1.round_id = 0;
        arg1.total_deployed = 0;
        arg1.deployed = zeros();
        (v8, v21)
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Board{
            id                 : 0x2::object::new(arg0),
            version            : 1,
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
            buyback_bps        : 500,
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

    public fun pot_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
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

    public fun set_params(arg0: &AdminCap, arg1: &mut Board, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool) {
        check_version(arg1);
        assert!(arg2 >= 2 && arg2 <= 1000000, 18);
        assert!(100 + arg4 + arg5 + arg3 <= 10000, 18);
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

    entry fun settle(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.ml_odds;
        settle_with_odds(arg0, arg1, arg2, arg3, v0, arg4);
    }

    fun settle_with_odds(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.cur_started, 9);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.cur_end_ms, 8);
        let v0 = 0x2::random::new_generator(arg2, arg5);
        let v1 = 0x2::random::generate_u64(&mut v0);
        let v2 = ((v1 % 25) as u8);
        let v3 = *0x1::vector::borrow<u64>(&arg0.cur_deployed, (v2 as u64));
        let v4 = arg0.cur_total - v3;
        let v5 = mul_div(v4, arg0.vault_bps, 10000);
        let v6 = v5;
        let v7 = mul_div(v4, 100, 10000);
        let v8 = mul_div(v4, arg0.buyback_bps, 10000);
        let v9 = v4 - v5 - v7 - v8;
        let v10 = v9;
        if (v5 > 0) {
            0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v5));
        };
        if (v7 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v7));
        };
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8));
        };
        let v11 = 0;
        let v12 = 0;
        if (v3 == 0) {
            if (v9 > 0) {
                let v13 = mul_div(v4, arg0.ml_share_bps, 10000);
                v11 = v13;
                let v14 = v9 - v13;
                if (v13 > 0) {
                    0x2::balance::join<0x2::sui::SUI>(&mut arg0.motherlode, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v13));
                };
                if (v14 > 0) {
                    0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v14));
                    v6 = v5 + v14;
                };
                v10 = 0;
            };
        } else if (0x2::random::generate_u64_in_range(&mut v0, 0, arg4 - 1) == 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode) > 0) {
            let v15 = 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode);
            v12 = v15;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.motherlode));
            v10 = v9 + v15;
            let v16 = JackpotKey{round_id: arg0.cur_id};
            0x2::dynamic_field::add<JackpotKey, u64>(&mut arg0.id, v16, v15);
        };
        let v17 = MotherlodeUpdate{
            round_id : arg0.cur_id,
            added    : v11,
            paid     : v12,
            balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.motherlode),
        };
        0x2::event::emit<MotherlodeUpdate>(v17);
        let v18 = if (arg0.cur_total >= arg0.full_reward_deploy) {
            next_full_reward(arg0)
        } else {
            mul_div(next_full_reward(arg0), arg0.cur_total, arg0.full_reward_deploy)
        };
        arg0.committed = arg0.committed + v18;
        arg0.step_count = arg0.step_count + 1;
        if (arg0.step_count >= arg0.step_rounds) {
            arg0.step_count = 0;
            arg0.reward = mul_div(arg0.reward, 1000000 - arg0.decay_ppm, 1000000);
        };
        let v19 = RoundInfo{
            total_deployed       : arg0.cur_total,
            deployed             : arg0.cur_deployed,
            winning_square       : v2,
            losing_pot_after_fee : v10,
            winners_total        : v3,
            round_reward         : v18,
            rng                  : v1,
        };
        0x2::table::add<u64, RoundInfo>(&mut arg0.rounds, arg0.cur_id, v19);
        let v20 = RoundSettled{
            round_id       : arg0.cur_id,
            winning_square : v2,
            total_deployed : arg0.cur_total,
            winners_total  : v3,
            round_reward   : v18,
            losing_pot     : v4,
            winners_payout : v10,
            vault_fee      : v6,
            buyback_fee    : v8,
            dev_fee        : v7,
            players        : arg0.cur_players,
            committed      : arg0.committed,
            next_reward    : next_full_reward(arg0),
        };
        0x2::event::emit<RoundSettled>(v20);
        arg0.cur_id = arg0.cur_id + 1;
        arg0.cur_started = false;
        arg0.cur_total = 0;
        arg0.cur_deployed = zeros();
        arg0.cur_players = 0;
    }

    public fun take_buyback(arg0: &AdminCap, arg1: &mut Board, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_version(arg1);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.buyback);
        let v1 = BuybackTaken{amount: 0x2::balance::value<0x2::sui::SUI>(&v0)};
        0x2::event::emit<BuybackTaken>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2)
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

    entry fun withdraw_dev_fees(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.dev_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.dev_fees, v0), arg1), @0xa19b2d37f95ca4c48efafb2cd01d0f97f33852457daa27cfba3de37fdec24d4b);
        };
    }

    public fun withdraw_gts(arg0: &mut Board, arg1: &mut 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::Treasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = UnrefinedKey{player: v0};
        assert!(0x2::dynamic_field::exists<UnrefinedKey>(&arg0.id, v1), 20);
        let Unrefined {
            amount : v2,
            bonus  : v3,
            snap   : v4,
        } = 0x2::dynamic_field::remove<UnrefinedKey, Unrefined>(&mut arg0.id, v1);
        let v5 = v3 + earned(v2, arg0.acc, v4);
        let v6 = mul_div(v2, arg0.refine_fee_bps, 10000);
        arg0.unrefined_total = arg0.unrefined_total - v2;
        let v7 = 0;
        if (v6 > 0) {
            if (arg0.unrefined_total > 0) {
                arg0.acc = arg0.acc + (v6 as u256) * 1000000000000000000 / (arg0.unrefined_total as u256);
            } else if (0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_value(arg1) > 0) {
                0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::vault_add(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::redeem(arg1, 0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.unrefined, v6), arg2), arg2)));
                v7 = v6;
            };
        };
        let v8 = GtsWithdrawn{
            player : v0,
            amount : v2,
            fee    : v6,
            bonus  : v5,
            paid   : v2 - v6 + v5,
            burned : v7,
        };
        0x2::event::emit<GtsWithdrawn>(v8);
        0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.unrefined, v2 - v6 + v5), arg2)
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

