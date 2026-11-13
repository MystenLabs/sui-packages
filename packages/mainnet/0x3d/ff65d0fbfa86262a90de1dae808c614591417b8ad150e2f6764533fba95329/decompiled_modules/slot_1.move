module 0x3dff65d0fbfa86262a90de1dae808c614591417b8ad150e2f6764533fba95329::slot_1 {
    struct Slot1 has drop {
        dummy_field: bool,
    }

    struct Slot1Config has key {
        id: 0x2::object::UID,
        config_version: u64,
        min_line_bet: u64,
        max_line_bet: u64,
        limit_updates_renounced: bool,
        config_hash: vector<u8>,
    }

    struct LimitUpdatesRenounced has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        min_line_bet: u64,
        max_line_bet: u64,
    }

    struct LimitsUpdated has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        previous_min_line_bet: u64,
        previous_max_line_bet: u64,
        new_min_line_bet: u64,
        new_max_line_bet: u64,
        config_version: u64,
    }

    struct GameTables has copy, drop {
        reel_len: u8,
        strips: vector<vector<u8>>,
        lines: vector<vector<u8>>,
        line_pays: vector<vector<u64>>,
        scatter_pays_h: vector<u64>,
        bonus_instant_h: vector<u64>,
        bonus_spins: vector<u8>,
        retrigger_spins: vector<u8>,
        fs_cap: u8,
        fs_pays_h: vector<vector<u64>>,
        prize_index: vector<u8>,
        prize_table: vector<u64>,
        prize_base_scale: u64,
        mult_symbol: u8,
        mult_min_count: u8,
        mult_step: u8,
        mult_max: u8,
        fs_pay_scale_k: u64,
        min_line_bet: u64,
        max_line_bet: u64,
        line_bet_step: u64,
        max_spin_payout: u64,
        max_spins: u8,
    }

    struct BatchPlan has copy, drop {
        line_bet: u64,
        total_bet: u64,
        bet_unit_h: u64,
        fs_unit: u64,
        n_spins: u64,
        total_escrow: u64,
    }

    struct SpinRecord has copy, drop, store {
        stops: vector<u8>,
        prize_draw: u8,
        base_win: u64,
        spins_awarded: u8,
        clipped: bool,
        counted: bool,
    }

    struct BatchOutcome has copy, drop {
        budget: u64,
        spins: vector<SpinRecord>,
        fs_stops: vector<u8>,
        fs_prize_draws: vector<u8>,
        fs_used: u8,
        fs_retriggers: u8,
        fs_max_mult: u8,
        fs_win: u64,
        spins_played: u64,
        stake_used: u64,
        refund: u64,
        payout: u64,
        paid_from_stake: u64,
        minted_amount: u64,
        losing_stake: u64,
    }

    struct Slot1BatchSettled has copy, drop {
        player: address,
        asset_type: u8,
        config_hash: vector<u8>,
        line_bet: u64,
        total_bet: u64,
        n_spins: u64,
        budget: u64,
        spins: vector<SpinRecord>,
        fs_stops: vector<u8>,
        fs_prize_draws: vector<u8>,
        fs_used: u8,
        fs_retriggers: u8,
        fs_max_mult: u8,
        fs_win: u64,
        spins_played: u64,
        stake_used: u64,
        refund: u64,
        payout: u64,
        paid_from_stake: u64,
        minted_amount: u64,
        losing_stake: u64,
        burned_amount: u64,
        reserve_amount: u64,
    }

    public fun admin_renounce_limit_updates(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut Slot1Config, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 9);
        assert!(arg1.min_line_bet == arg2 && arg1.max_line_bet == arg3, 21);
        assert_valid_limits(arg1.min_line_bet, arg1.max_line_bet);
        arg1.limit_updates_renounced = true;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitUpdatesRenounced{
            config_id    : 0x2::object::id<Slot1Config>(arg1),
            admin        : 0x2::tx_context::sender(arg4),
            min_line_bet : arg1.min_line_bet,
            max_line_bet : arg1.max_line_bet,
        };
        0x2::event::emit<LimitUpdatesRenounced>(v0);
    }

    fun assert_valid_limits(arg0: u64, arg1: u64) {
        assert!(arg0 >= 10000000, 10);
        assert!(arg0 <= arg1, 10);
        assert!(arg1 <= 10000000000, 10);
        assert!(arg0 % 10000000 == 0, 10);
        assert!(arg1 % 10000000 == 0, 10);
    }

    entry fun bet_game_credits_slot_1(arg0: &Slot1Config, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<Slot1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, arg7);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = Slot1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<Slot1>(v2, arg1, arg4, v1, arg7, arg6);
        let v3 = draw_tape(arg5, arg9, arg10);
        let (v4, v5) = settle_game_credits_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v3, arg6, arg10);
        let v6 = v4;
        emit_batch_settled(v1, 2, arg0.config_hash, &v0, &v6, v5, 0);
    }

    entry fun bet_rflh_slot_1(arg0: &Slot1Config, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<Slot1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg7));
        let v1 = draw_tape(arg5, arg9, arg10);
        let v2 = 0x2::tx_context::sender(arg10);
        let (v3, v4, v5) = settle_rflh_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v1, arg6, arg10);
        let v6 = v3;
        emit_batch_settled(v2, 1, arg0.config_hash, &v0, &v6, v4, v5);
    }

    public fun bonus_free_spins(arg0: u64) : u64 {
        assert!(arg0 <= 15, 20);
        let v0 = x"000000070a0f0f0f0f0f0f0f0f0f0f0f";
        (*0x1::vector::borrow<u8>(&v0, arg0) as u64)
    }

    public fun bonus_instant_h(arg0: u64) : u64 {
        assert!(arg0 <= 15, 20);
        let v0 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        *0x1::vector::borrow<u64>(&v0, arg0)
    }

    public fun bonus_symbol() : u64 {
        11
    }

    public fun bonus_trigger_count() : u64 {
        3
    }

    fun build_batch_plan(arg0: &Slot1Config, arg1: u64, arg2: u64, arg3: u64) : BatchPlan {
        assert!(arg2 >= 1 && arg2 <= 100, 14);
        assert!(arg1 >= arg0.min_line_bet && arg1 <= arg0.max_line_bet, 2);
        assert!(arg1 % 10000000 == 0, 2);
        let v0 = checked_mul_u64(20, arg1);
        assert!(v0 % 100 == 0, 11);
        let v1 = (v0 as u128) * (526 as u128);
        let v2 = (100 as u128) * (1000 as u128);
        assert!(v1 % v2 == 0, 11);
        let v3 = checked_mul_u64(arg2, v0);
        assert!(arg3 >= v3, 15);
        assert!(arg3 <= checked_mul_u64(arg2, checked_mul_u64(20, arg0.max_line_bet)), 15);
        BatchPlan{
            line_bet     : arg1,
            total_bet    : v0,
            bet_unit_h   : v0 / 100,
            fs_unit      : ((v1 / v2) as u64),
            n_spins      : arg2,
            total_escrow : v3,
        }
    }

    fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 6);
        (v0 as u64)
    }

    fun checked_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 6);
        (v0 as u64)
    }

    public fun compute_config_hash() : vector<u8> {
        let v0 = config_bytes();
        0x2::hash::blake2b256(&v0)
    }

    public fun config_bytes() : vector<u8> {
        let v0 = game_tables();
        0x2::bcs::to_bytes<GameTables>(&v0)
    }

    public fun config_hash(arg0: &Slot1Config) : vector<u8> {
        arg0.config_hash
    }

    public fun config_version(arg0: &Slot1Config) : u64 {
        arg0.config_version
    }

    fun draw_tape(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = &mut v0;
        fill_tape(v1, arg1)
    }

    public fun draws_per_spin() : u64 {
        6
    }

    fun emit_batch_settled(arg0: address, arg1: u8, arg2: vector<u8>, arg3: &BatchPlan, arg4: &BatchOutcome, arg5: u64, arg6: u64) {
        let v0 = Slot1BatchSettled{
            player          : arg0,
            asset_type      : arg1,
            config_hash     : arg2,
            line_bet        : arg3.line_bet,
            total_bet       : arg3.total_bet,
            n_spins         : arg3.n_spins,
            budget          : arg4.budget,
            spins           : arg4.spins,
            fs_stops        : arg4.fs_stops,
            fs_prize_draws  : arg4.fs_prize_draws,
            fs_used         : arg4.fs_used,
            fs_retriggers   : arg4.fs_retriggers,
            fs_max_mult     : arg4.fs_max_mult,
            fs_win          : arg4.fs_win,
            spins_played    : arg4.spins_played,
            stake_used      : arg4.stake_used,
            refund          : arg4.refund,
            payout          : arg4.payout,
            paid_from_stake : arg4.paid_from_stake,
            minted_amount   : arg4.minted_amount,
            losing_stake    : arg4.losing_stake,
            burned_amount   : arg5,
            reserve_amount  : arg6,
        };
        0x2::event::emit<Slot1BatchSettled>(v0);
    }

    fun eval_base_spin(arg0: &GameTables, arg1: &BatchPlan, arg2: &vector<u8>, arg3: u64) : (u64, u64, u64) {
        let (v0, v1) = window_and_counts(arg0, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = tape_prize_draw(arg2, arg3);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 20) {
            let v8 = 0x1::vector::borrow<vector<u8>>(&arg0.lines, v7);
            let v9 = *0x1::vector::borrow<u64>(&v3, (*0x1::vector::borrow<u8>(v8, 0) as u64));
            let v10 = *0x1::vector::borrow<u64>(&v3, 3 + (*0x1::vector::borrow<u8>(v8, 1) as u64));
            let v11 = *0x1::vector::borrow<u64>(&v3, 2 * 3 + (*0x1::vector::borrow<u8>(v8, 2) as u64));
            let v12 = *0x1::vector::borrow<u64>(&v3, 3 * 3 + (*0x1::vector::borrow<u8>(v8, 3) as u64));
            let v13 = *0x1::vector::borrow<u64>(&v3, 4 * 3 + (*0x1::vector::borrow<u8>(v8, 4) as u64));
            let v14 = 1 - ((v9 ^ v10) + 15 >> 4);
            let v15 = v14 * (1 - ((v10 ^ v11) + 15 >> 4));
            let v16 = v15 * (1 - ((v11 ^ v12) + 15 >> 4));
            v5 = v5 + *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.line_pays, v9), 1 + v14 + v15 + v16 + v16 * (1 - ((v12 ^ v13) + 15 >> 4)));
            v6 = v6 + (1 - ((v11 ^ 9) + 15 >> 4)) * (1 - ((v12 ^ 9) + 15 >> 4)) * (1 - ((v13 ^ 9) + 15 >> 4));
            v7 = v7 + 1;
        };
        ((v5 + v6 * *0x1::vector::borrow<u64>(&arg0.prize_table, (*0x1::vector::borrow<u8>(&arg0.prize_index, v4) as u64)) * 3) * arg1.line_bet + (*0x1::vector::borrow<u64>(&arg0.scatter_pays_h, *0x1::vector::borrow<u64>(&v2, 10)) + *0x1::vector::borrow<u64>(&arg0.bonus_instant_h, *0x1::vector::borrow<u64>(&v2, 11))) * arg1.bet_unit_h, *0x1::vector::borrow<u64>(&v2, 11), v4)
    }

    fun eval_free_spin(arg0: &GameTables, arg1: &vector<u8>, arg2: u64) : (u64, u64, u64, u64) {
        let (_, v1) = window_and_counts(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = tape_prize_draw(arg1, arg2);
        let v4 = 0;
        let v5 = 1;
        while (v5 <= 8) {
            v4 = v4 + *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.fs_pays_h, v5), *0x1::vector::borrow<u64>(&v2, v5));
            v5 = v5 + 1;
        };
        (v4 + *0x1::vector::borrow<u64>(&arg0.scatter_pays_h, *0x1::vector::borrow<u64>(&v2, 10)) + (1 - ((18446744073709551616 + (3 as u128) - (*0x1::vector::borrow<u64>(&v2, 9) as u128) - 1 >> 64) as u64)) * *0x1::vector::borrow<u64>(&arg0.prize_table, (*0x1::vector::borrow<u8>(&arg0.prize_index, v3) as u64)) * 100, (*0x1::vector::borrow<u8>(&arg0.retrigger_spins, *0x1::vector::borrow<u64>(&v2, 11)) as u64), 1 - ((18446744073709551616 + (3 as u128) - (*0x1::vector::borrow<u64>(&v2, 6) as u128) - 1 >> 64) as u64), v3)
    }

    fun fill_tape(arg0: &mut 0x2::random::RandomGenerator, arg1: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg1 + 50) {
            let v2 = &mut v0;
            let v3 = 0x2::random::generate_u128(arg0);
            let v4 = (40 as u128);
            let v5 = 0;
            while (v5 < 5) {
                0x1::vector::push_back<u8>(v2, ((v3 % v4) as u8));
                v3 = v3 / v4;
                v5 = v5 + 1;
            };
            0x1::vector::push_back<u8>(v2, ((v3 % (200 as u128)) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun free_spin_pay_h(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= 1 && arg0 <= 8, 19);
        assert!(arg1 <= 15, 20);
        let v0 = vector[vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 327, 1308, 5450, 16350, 32700, 54500, 54500, 54500, 54500, 54500, 54500, 54500, 54500], vector[0, 0, 0, 273, 763, 3270, 9810, 18530, 32700, 32700, 32700, 32700, 32700, 32700, 32700, 32700], vector[0, 0, 0, 218, 600, 2398, 7630, 15260, 27250, 27250, 27250, 27250, 27250, 27250, 27250, 27250], vector[0, 0, 0, 174, 545, 1853, 5668, 11445, 21800, 21800, 21800, 21800, 21800, 21800, 21800, 21800], vector[0, 0, 0, 131, 436, 1308, 4360, 8720, 16350, 16350, 16350, 16350, 16350, 16350, 16350, 16350], vector[0, 0, 0, 109, 327, 1090, 3706, 7412, 13080, 13080, 13080, 13080, 13080, 13080, 13080, 13080], vector[0, 0, 0, 76, 240, 654, 2616, 5232, 8720, 8720, 8720, 8720, 8720, 8720, 8720, 8720], vector[0, 0, 0, 65, 196, 545, 2180, 4360, 7630, 7630, 7630, 7630, 7630, 7630, 7630, 7630]];
        *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v0, arg0), arg1)
    }

    public fun fs_cap() : u64 {
        50
    }

    public fun fs_pay_scale_den() : u64 {
        1000
    }

    public fun fs_pay_scale_k() : u64 {
        526
    }

    fun game_tables() : GameTables {
        GameTables{
            reel_len         : (40 as u8),
            strips           : vector[x"080107030408070605080b070208040607030a05080107060402080a05070b06030804070a050206", x"070108020407080605030b070802040607080a0507010806040307080a050206080704030a080506", x"080107020908030607050b08040a090708060205080107030904080607050a020308090704060a05", x"070108050903070608020b0408070905080607030a0805070904080602070a080305090708060a04", x"080107050908030602070b080504090607080a03050708060904020a07080b0605030908070a0406"],
            lines            : vector[x"0101010101", x"0000000000", x"0202020202", x"0001020100", x"0201000102", x"0000010202", x"0202010000", x"0100000001", x"0102020201", x"0001010100", x"0201010102", x"0100010201", x"0102010001", x"0001000100", x"0201020102", x"0101000101", x"0101020101", x"0000010000", x"0202010202", x"0100020001"],
            line_pays        : vector[vector[0, 0, 0, 0, 0, 0], vector[0, 0, 10, 100, 1000, 20000], vector[0, 0, 2, 55, 200, 800], vector[0, 0, 2, 45, 140, 500], vector[0, 0, 0, 40, 115, 400], vector[0, 0, 0, 32, 95, 300], vector[0, 0, 0, 25, 70, 200], vector[0, 0, 0, 15, 42, 110], vector[0, 0, 0, 13, 36, 90], vector[0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0]],
            scatter_pays_h   : vector[0, 0, 0, 100, 400, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500],
            bonus_instant_h  : vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            bonus_spins      : x"000000070a0f0f0f0f0f0f0f0f0f0f0f",
            retrigger_spins  : x"00000305080c0c0c0c0c0c0c0c0c0c0c",
            fs_cap           : (50 as u8),
            fs_pays_h        : vector[vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 327, 1308, 5450, 16350, 32700, 54500, 54500, 54500, 54500, 54500, 54500, 54500, 54500], vector[0, 0, 0, 273, 763, 3270, 9810, 18530, 32700, 32700, 32700, 32700, 32700, 32700, 32700, 32700], vector[0, 0, 0, 218, 600, 2398, 7630, 15260, 27250, 27250, 27250, 27250, 27250, 27250, 27250, 27250], vector[0, 0, 0, 174, 545, 1853, 5668, 11445, 21800, 21800, 21800, 21800, 21800, 21800, 21800, 21800], vector[0, 0, 0, 131, 436, 1308, 4360, 8720, 16350, 16350, 16350, 16350, 16350, 16350, 16350, 16350], vector[0, 0, 0, 109, 327, 1090, 3706, 7412, 13080, 13080, 13080, 13080, 13080, 13080, 13080, 13080], vector[0, 0, 0, 76, 240, 654, 2616, 5232, 8720, 8720, 8720, 8720, 8720, 8720, 8720, 8720], vector[0, 0, 0, 65, 196, 545, 2180, 4360, 7630, 7630, 7630, 7630, 7630, 7630, 7630, 7630]],
            prize_index      : x"000000000000000000000000000000000000000000000000000000000101010101010101010101010101010101010101010101010101010101010202020202020202020202020202020202020202020202020202020202020202020202020303030303030303030303030303030303030303030303030303030304040404040404040404040404040404040404040404040405050505050505050505050505050505050505050606060606060606060606060606070707070707070707070808080808080909090a",
            prize_table      : vector[2, 3, 5, 8, 10, 15, 20, 25, 50, 100, 200],
            prize_base_scale : 3,
            mult_symbol      : (6 as u8),
            mult_min_count   : (3 as u8),
            mult_step        : (1 as u8),
            mult_max         : (10 as u8),
            fs_pay_scale_k   : 526,
            min_line_bet     : 10000000,
            max_line_bet     : 10000000000,
            line_bet_step    : 10000000,
            max_spin_payout  : 1000000000000000,
            max_spins        : (100 as u8),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Slot1Config{
            id                      : 0x2::object::new(arg0),
            config_version          : 1,
            min_line_bet            : 10000000,
            max_line_bet            : 10000000000,
            limit_updates_renounced : false,
            config_hash             : compute_config_hash(),
        };
        0x2::transfer::share_object<Slot1Config>(v0);
    }

    public fun limit_updates_renounced(arg0: &Slot1Config) : bool {
        arg0.limit_updates_renounced
    }

    public fun line_bet_step() : u64 {
        10000000
    }

    public fun line_pay(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= 1 && arg0 <= 11, 19);
        assert!(arg1 <= 5, 20);
        let v0 = vector[vector[0, 0, 0, 0, 0, 0], vector[0, 0, 10, 100, 1000, 20000], vector[0, 0, 2, 55, 200, 800], vector[0, 0, 2, 45, 140, 500], vector[0, 0, 0, 40, 115, 400], vector[0, 0, 0, 32, 95, 300], vector[0, 0, 0, 25, 70, 200], vector[0, 0, 0, 15, 42, 110], vector[0, 0, 0, 13, 36, 90], vector[0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0]];
        *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v0, arg0), arg1)
    }

    public fun line_row(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 < 20 && arg1 < 5, 20);
        let v0 = vector[x"0101010101", x"0000000000", x"0202020202", x"0001020100", x"0201000102", x"0000010202", x"0202010000", x"0100000001", x"0102020201", x"0001010100", x"0201010102", x"0100010201", x"0102010001", x"0001000100", x"0201020102", x"0101000101", x"0101020101", x"0000010000", x"0202010202", x"0100020001"];
        (*0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(&v0, arg0), arg1) as u64)
    }

    public fun max_line_bet(arg0: &Slot1Config) : u64 {
        arg0.max_line_bet
    }

    public fun max_line_bet_ceiling() : u64 {
        10000000000
    }

    public fun max_spin_payout() : u64 {
        1000000000000000
    }

    public fun max_spins() : u64 {
        100
    }

    public fun min_line_bet(arg0: &Slot1Config) : u64 {
        arg0.min_line_bet
    }

    public fun min_line_bet_floor() : u64 {
        10000000
    }

    public fun mult_max() : u64 {
        10
    }

    public fun mult_min_count() : u64 {
        3
    }

    public fun mult_step() : u64 {
        1
    }

    public fun mult_symbol() : u64 {
        6
    }

    public fun num_line_symbols() : u64 {
        8
    }

    public fun num_lines() : u64 {
        20
    }

    public fun num_reels() : u64 {
        5
    }

    public fun num_rows() : u64 {
        3
    }

    public fun num_symbols() : u64 {
        11
    }

    public(friend) fun outcome_budget(arg0: &BatchOutcome) : u64 {
        arg0.budget
    }

    public(friend) fun outcome_fs_max_mult(arg0: &BatchOutcome) : u64 {
        (arg0.fs_max_mult as u64)
    }

    public(friend) fun outcome_fs_prize_draws(arg0: &BatchOutcome) : vector<u8> {
        arg0.fs_prize_draws
    }

    public(friend) fun outcome_fs_retriggers(arg0: &BatchOutcome) : u64 {
        (arg0.fs_retriggers as u64)
    }

    public(friend) fun outcome_fs_stops(arg0: &BatchOutcome) : vector<u8> {
        arg0.fs_stops
    }

    public(friend) fun outcome_fs_used(arg0: &BatchOutcome) : u64 {
        (arg0.fs_used as u64)
    }

    public(friend) fun outcome_fs_win(arg0: &BatchOutcome) : u64 {
        arg0.fs_win
    }

    public(friend) fun outcome_losing_stake(arg0: &BatchOutcome) : u64 {
        arg0.losing_stake
    }

    public(friend) fun outcome_minted_amount(arg0: &BatchOutcome) : u64 {
        arg0.minted_amount
    }

    public(friend) fun outcome_paid_from_stake(arg0: &BatchOutcome) : u64 {
        arg0.paid_from_stake
    }

    public(friend) fun outcome_payout(arg0: &BatchOutcome) : u64 {
        arg0.payout
    }

    public(friend) fun outcome_refund(arg0: &BatchOutcome) : u64 {
        arg0.refund
    }

    public(friend) fun outcome_spins(arg0: &BatchOutcome) : vector<SpinRecord> {
        arg0.spins
    }

    public(friend) fun outcome_spins_played(arg0: &BatchOutcome) : u64 {
        arg0.spins_played
    }

    public(friend) fun outcome_stake_used(arg0: &BatchOutcome) : u64 {
        arg0.stake_used
    }

    public(friend) fun plan_bet_unit_h(arg0: &BatchPlan) : u64 {
        arg0.bet_unit_h
    }

    public(friend) fun plan_fs_unit(arg0: &BatchPlan) : u64 {
        arg0.fs_unit
    }

    public(friend) fun plan_line_bet(arg0: &BatchPlan) : u64 {
        arg0.line_bet
    }

    public(friend) fun plan_n_spins(arg0: &BatchPlan) : u64 {
        arg0.n_spins
    }

    public(friend) fun plan_total_bet(arg0: &BatchPlan) : u64 {
        arg0.total_bet
    }

    public(friend) fun plan_total_escrow(arg0: &BatchPlan) : u64 {
        arg0.total_escrow
    }

    public fun prize_base_scale() : u64 {
        3
    }

    public fun prize_draw_range() : u64 {
        200
    }

    public fun prize_for_draw(arg0: u64) : u64 {
        assert!(arg0 < 200, 20);
        let v0 = x"000000000000000000000000000000000000000000000000000000000101010101010101010101010101010101010101010101010101010101010202020202020202020202020202020202020202020202020202020202020202020202020303030303030303030303030303030303030303030303030303030304040404040404040404040404040404040404040404040405050505050505050505050505050505050505050606060606060606060606060606070707070707070707070808080808080909090a";
        let v1 = vector[2, 3, 5, 8, 10, 15, 20, 25, 50, 100, 200];
        *0x1::vector::borrow<u64>(&v1, (*0x1::vector::borrow<u8>(&v0, arg0) as u64))
    }

    public fun prize_fs_count() : u64 {
        3
    }

    public fun prize_symbol() : u64 {
        9
    }

    public(friend) fun record_base_win(arg0: &SpinRecord) : u64 {
        arg0.base_win
    }

    public(friend) fun record_clipped(arg0: &SpinRecord) : bool {
        arg0.clipped
    }

    public(friend) fun record_counted(arg0: &SpinRecord) : bool {
        arg0.counted
    }

    public(friend) fun record_prize_draw(arg0: &SpinRecord) : u64 {
        (arg0.prize_draw as u64)
    }

    public(friend) fun record_spins_awarded(arg0: &SpinRecord) : u64 {
        (arg0.spins_awarded as u64)
    }

    public(friend) fun record_stops(arg0: &SpinRecord) : vector<u8> {
        arg0.stops
    }

    public fun reel_len() : u64 {
        40
    }

    public fun retrigger_free_spins(arg0: u64) : u64 {
        assert!(arg0 <= 15, 20);
        let v0 = x"00000305080c0c0c0c0c0c0c0c0c0c0c";
        (*0x1::vector::borrow<u8>(&v0, arg0) as u64)
    }

    fun run_batch(arg0: &BatchPlan, arg1: u64, arg2: &vector<u8>) : BatchOutcome {
        assert!(0x1::vector::length<u8>(arg2) == 6 * (arg0.n_spins + 50), 18);
        let v0 = game_tables();
        let v1 = 1;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = arg0.total_bet;
        let v8 = 0x1::vector::empty<SpinRecord>();
        let v9 = 0;
        while (v9 < arg0.n_spins) {
            let v10 = v9 * 6;
            let (v11, v12, v13) = eval_base_spin(&v0, arg0, arg2, v10);
            let v14 = 1 - ((18446744073709551616 + (3 as u128) - (v12 as u128) - 1 >> 64) as u64);
            let v15 = (*0x1::vector::borrow<u8>(&v0.bonus_spins, v12) as u64);
            let v16 = ((18446744073709551616 + (v11 as u128) - (1000000000000000 as u128) - 1 >> 64) as u64);
            let v17 = v16 * 1000000000000000 + (1 - v16) * v11;
            v3 = v3 + v1 * (1 - v14) * v17;
            let v18 = ((18446744073709551616 + (v7 as u128) - (v17 as u128) - 1 >> 64) as u64);
            v6 = v6 + v1 * (1 - v14) * (v18 * v17 + (1 - v18) * v7);
            let v19 = (1 - v1) * v4;
            v4 = v1 * v11 + v19;
            v5 = v5 + v1 * v14 * v15;
            v2 = v2 + v1;
            let v20 = b"";
            let v21 = 0;
            while (v21 < 5) {
                0x1::vector::push_back<u8>(&mut v20, ((v1 * (*0x1::vector::borrow<u8>(arg2, v10 + v21) as u64)) as u8));
                v21 = v21 + 1;
            };
            let v22 = SpinRecord{
                stops         : v20,
                prize_draw    : ((v1 * v13) as u8),
                base_win      : v1 * v11,
                spins_awarded : ((v1 * v14 * v15) as u8),
                clipped       : v1 * (1 - v14) * v16 == 1,
                counted       : v1 == 1,
            };
            0x1::vector::push_back<SpinRecord>(&mut v8, v22);
            v1 = v1 * (1 - v14);
            v9 = v9 + 1;
        };
        let v23 = v5;
        let v24 = 0;
        let v25 = 1;
        let v26 = 0;
        let v27 = 0;
        let v28 = b"";
        let v29 = b"";
        let v30 = 0;
        while (v30 < 50) {
            let v31 = arg0.n_spins * 6 + v30 * 6;
            let v32 = ((18446744073709551616 + (v23 as u128) - 0 - 1 >> 64) as u64);
            let (v33, v34, v35, v36) = eval_free_spin(&v0, arg2, v31);
            v27 = v27 + ((v32 * v33 * v25) as u128);
            let v37 = 50 - v24 - v23;
            let v38 = ((18446744073709551616 + (v37 as u128) - (v34 as u128) - 1 >> 64) as u64);
            let v39 = v38 * v34 + (1 - v38) * v37;
            let v40 = v23 - v32;
            v23 = v40 + v32 * v39;
            v24 = v24 + v32;
            v26 = v26 + v32 * ((18446744073709551616 + (v39 as u128) - 0 - 1 >> 64) as u64);
            let v41 = v25 + v32 * v35 * 1;
            let v42 = 10;
            let v43 = ((18446744073709551616 + (v42 as u128) - (v41 as u128) - 1 >> 64) as u64);
            v25 = v43 * v41 + (1 - v43) * v42;
            let v44 = 0;
            while (v44 < 5) {
                0x1::vector::push_back<u8>(&mut v28, ((v32 * (*0x1::vector::borrow<u8>(arg2, v31 + v44) as u64)) as u8));
                v44 = v44 + 1;
            };
            0x1::vector::push_back<u8>(&mut v29, ((v32 * v36) as u8));
            v30 = v30 + 1;
        };
        let v45 = v27 * (arg0.fs_unit as u128);
        assert!(v45 <= (18446744073709551615 as u128), 6);
        let v46 = (v45 as u64);
        let v47 = checked_add_u64(v4, v46);
        let v48 = ((18446744073709551616 + (v47 as u128) - (1000000000000000 as u128) - 1 >> 64) as u64);
        let v49 = v48 * 1000000000000000 + (1 - v48) * v47;
        let v50 = v3 + (1 - v1) * v49;
        let v51 = ((18446744073709551616 + (v7 as u128) - (v49 as u128) - 1 >> 64) as u64);
        let v52 = v6 + (1 - v1) * (v51 * v49 + (1 - v51) * v7);
        0x1::vector::borrow_mut<SpinRecord>(&mut v8, v2 - 1).clipped = v48 == 1;
        let v53 = v2 * v7;
        assert!(arg1 >= v53, 11);
        BatchOutcome{
            budget          : arg1,
            spins           : v8,
            fs_stops        : v28,
            fs_prize_draws  : v29,
            fs_used         : (v24 as u8),
            fs_retriggers   : (v26 as u8),
            fs_max_mult     : (v25 as u8),
            fs_win          : v46,
            spins_played    : v2,
            stake_used      : v53,
            refund          : arg1 - v53,
            payout          : v50,
            paid_from_stake : v52,
            minted_amount   : v50 - v52,
            losing_stake    : v53 - v52,
        }
    }

    public fun scatter_pay_h(arg0: u64) : u64 {
        assert!(arg0 <= 15, 20);
        let v0 = vector[0, 0, 0, 100, 400, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500];
        *0x1::vector::borrow<u64>(&v0, arg0)
    }

    public fun scatter_symbol() : u64 {
        10
    }

    fun settle_game_credits_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg4: &BatchPlan, arg5: u64, arg6: &vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<Slot1>(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = Slot1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<Slot1>(v1, arg0, arg3, v0, arg5, arg7);
        let v2 = run_batch(arg4, arg5, arg6);
        let v3 = v2.losing_stake;
        let v4 = Slot1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::debit_loss<Slot1>(v4, arg0, arg3, v0, v3, arg7);
        let v5 = Slot1{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<Slot1>(v5, arg0, arg1, arg2, v2.minted_amount, arg8), v0);
        (v2, v3)
    }

    fun settle_rflh_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &BatchPlan, arg5: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg6: &vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<Slot1>(arg0);
        let v0 = run_batch(arg4, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5), arg6);
        let v1 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::current_total_tracked_supply(arg1);
        let v2 = Slot1{dummy_field: false};
        let (v3, v4) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::burn_curve::split_rflh_loss(v0.losing_stake, v1);
        let v5 = Slot1{dummy_field: false};
        let v6 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<Slot1>(v5, arg0, arg1, arg2, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v3, arg8));
        assert!(v6 == v3, 11);
        let v7 = Slot1{dummy_field: false};
        let (v8, v9) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::route_game_reserve_contribution<Slot1>(v7, arg0, arg3, arg2, v1, 0x2::coin::into_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v4, arg8)), arg7);
        let v10 = Slot1{dummy_field: false};
        let v11 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<Slot1>(v10, arg0, arg1, arg2, 0x2::coin::from_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(v9, arg8));
        assert!(v11 == v4 - v8, 11);
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(v0.refund, v0.paid_from_stake), 11);
        0x2::coin::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<Slot1>(v2, arg0, arg1, arg2, v0.minted_amount, arg8));
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(v0.refund, v0.payout), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(arg5, 0x2::tx_context::sender(arg8));
        (v0, v6 + v11, v8)
    }

    public fun strip_symbol(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 < 5 && arg1 < 40, 20);
        let v0 = vector[x"080107030408070605080b070208040607030a05080107060402080a05070b06030804070a050206", x"070108020407080605030b070802040607080a0507010806040307080a050206080704030a080506", x"080107020908030607050b08040a090708060205080107030904080607050a020308090704060a05", x"070108050903070608020b0408070905080607030a0805070904080602070a080305090708060a04", x"080107050908030602070b080504090607080a03050708060904020a07080b0605030908070a0406"];
        (*0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(&v0, arg0), arg1) as u64)
    }

    fun tape_prize_draw(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = (*0x1::vector::borrow<u8>(arg0, arg1 + 5) as u64);
        assert!(v0 < 200, 18);
        v0
    }

    public fun update_limits(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut Slot1Config, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 8);
        assert_valid_limits(arg2, arg3);
        arg1.min_line_bet = arg2;
        arg1.max_line_bet = arg3;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitsUpdated{
            config_id             : 0x2::object::id<Slot1Config>(arg1),
            admin                 : 0x2::tx_context::sender(arg4),
            previous_min_line_bet : arg1.min_line_bet,
            previous_max_line_bet : arg1.max_line_bet,
            new_min_line_bet      : arg2,
            new_max_line_bet      : arg3,
            config_version        : arg1.config_version,
        };
        0x2::event::emit<LimitsUpdated>(v0);
    }

    fun window_and_counts(arg0: &GameTables, arg1: &vector<u8>, arg2: u64) : (vector<u64>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        let v2 = 0;
        while (v2 < 5) {
            let v3 = (*0x1::vector::borrow<u8>(arg1, arg2 + v2) as u64);
            assert!(v3 < 40, 18);
            let v4 = 0x1::vector::borrow<vector<u8>>(&arg0.strips, v2);
            let v5 = 0;
            while (v5 < 3) {
                let v6 = (*0x1::vector::borrow<u8>(v4, (v3 + v5) % 40) as u64);
                0x1::vector::push_back<u64>(&mut v0, v6);
                *0x1::vector::borrow_mut<u64>(&mut v1, v6) = *0x1::vector::borrow<u64>(&v1, v6) + 1;
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

