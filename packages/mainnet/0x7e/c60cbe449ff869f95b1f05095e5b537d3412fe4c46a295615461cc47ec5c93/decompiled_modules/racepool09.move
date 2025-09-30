module 0x7ec60cbe449ff869f95b1f05095e5b537d3412fe4c46a295615461cc47ec5c93::racepool09 {
    struct MONSTER09 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        level_cap: u64,
        power: u64,
        timelap: u64,
        aero: u64,
        brakes: u64,
        sosp: u64,
        image: 0x1::string::String,
        adv_unlocked: u64,
        adv_unspent: u64,
    }

    struct Ticket09NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        valid_for: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Meccanico09NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        bravura: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Pilota09NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        level_cap: u64,
        boost_power: u64,
        boost_timelap: u64,
        boost_aero: u64,
        boost_brakes: u64,
        boost_sosp: u64,
        image: 0x1::string::String,
        adv_unlocked: u64,
        adv_unspent: u64,
    }

    struct GoldTrophy09 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct SilverTrophy09 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct BronzeTrophy09 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct DisplayWitness has drop {
        dummy_field: bool,
    }

    struct ExperienceBank09 has store, key {
        id: 0x2::object::UID,
        addrs: vector<address>,
        balances: vector<u64>,
    }

    struct UpgradeEvent has copy, drop, store {
        owner: address,
        target: u8,
        stat: u8,
        new_level: u64,
        cost: u64,
        nft: address,
    }

    struct RaceConfig09 has copy, drop, store {
        laps: u64,
        base_per_mille: u64,
        w_power: u64,
        w_aero: u64,
        w_brakes: u64,
        w_sosp: u64,
        syn_scale_bps: u64,
        syn_zero_bps: u64,
        syn: vector<u64>,
    }

    struct Participant has copy, drop, store {
        owner: address,
        monster_level: u64,
        power: u64,
        timelap: u64,
        aero: u64,
        brakes: u64,
        sosp: u64,
        total_time: u64,
    }

    struct RacePool09 has store, key {
        id: 0x2::object::UID,
        config: RaceConfig09,
        participants: vector<Participant>,
        used_monsters: vector<address>,
        used_pilots: vector<address>,
        started: bool,
        last_results: vector<Participant>,
    }

    struct PrizeVault09 has store, key {
        id: 0x2::object::UID,
        gold: vector<GoldTrophy09>,
        silver: vector<SilverTrophy09>,
        bronze: vector<BronzeTrophy09>,
        tickets: vector<Ticket09NFT>,
    }

    struct AwardEvent has copy, drop, store {
        rank: u64,
        owner: address,
        exp_amount: u64,
        trophy: u8,
        ticket: bool,
    }

    struct RaceLifecycleEvent has copy, drop, store {
        code: u8,
    }

    struct InitDisplayMonster09 has drop {
        dummy_field: bool,
    }

    struct InitDisplayPilota09 has drop {
        dummy_field: bool,
    }

    struct InitDisplayTicket09 has drop {
        dummy_field: bool,
    }

    struct InitDisplayTrophies09 has drop {
        dummy_field: bool,
    }

    fun swap(arg0: &mut vector<Participant>, arg1: u64, arg2: u64) {
        if (arg1 == arg2) {
            return
        };
        *0x1::vector::borrow_mut<Participant>(arg0, arg1) = *0x1::vector::borrow<Participant>(arg0, arg2);
        *0x1::vector::borrow_mut<Participant>(arg0, arg2) = *0x1::vector::borrow<Participant>(arg0, arg1);
    }

    fun apply_pilot_boosts_m(arg0: &MONSTER09, arg1: &Pilota09NFT) : (u64, u64, u64, u64, u64) {
        (clamp12(arg0.power + arg1.boost_power), clamp12(arg0.timelap + arg1.boost_timelap), clamp12(arg0.aero + arg1.boost_aero), clamp12(arg0.brakes + arg1.boost_brakes), clamp12(arg0.sosp + arg1.boost_sosp))
    }

    fun apply_syn_one(arg0: &vector<u64>, arg1: &RaceConfig09, arg2: u8) : u64 {
        clamp12(apply_syn_pair(apply_syn_pair(apply_syn_pair(apply_syn_pair(apply_syn_pair(*0x1::vector::borrow<u64>(arg0, to_u64_idx(arg2)), arg0, arg1, arg2, 0), arg0, arg1, arg2, 1), arg0, arg1, arg2, 2), arg0, arg1, arg2, 3), arg0, arg1, arg2, 4))
    }

    fun apply_syn_pair(arg0: u64, arg1: &vector<u64>, arg2: &RaceConfig09, arg3: u8, arg4: u8) : u64 {
        if (arg3 == arg4) {
            return arg0
        };
        let v0 = get_syn(arg2, arg3, arg4);
        let v1 = arg2.syn_zero_bps;
        let v2 = if (v0 >= v1) {
            1000 + (v0 - v1) * *0x1::vector::borrow<u64>(arg1, to_u64_idx(arg4)) * 1000 / 12 * arg2.syn_scale_bps
        } else {
            let v3 = (v1 - v0) * *0x1::vector::borrow<u64>(arg1, to_u64_idx(arg4)) * 1000 / 12 * arg2.syn_scale_bps;
            if (v3 >= 1000) {
                1
            } else {
                1000 - v3
            }
        };
        arg0 * v2 / 1000
    }

    fun apply_synergies(arg0: &vector<u64>, arg1: &RaceConfig09) : (u64, u64, u64, u64, u64) {
        (apply_syn_one(arg0, arg1, 0), apply_syn_one(arg0, arg1, 1), apply_syn_one(arg0, arg1, 2), apply_syn_one(arg0, arg1, 3), apply_syn_one(arg0, arg1, 4))
    }

    fun award_loop(arg0: &RacePool09, arg1: &mut ExperienceBank09, arg2: &mut PrizeVault09, arg3: bool, arg4: u64, arg5: u64) {
        if (arg4 >= arg5) {
            return
        };
        let v0 = 0x1::vector::borrow<Participant>(&arg0.participants, arg4);
        let v1 = arg4 + 1;
        if (v1 == 1) {
            let v2 = pop_gold_strict(arg2);
            0x2::transfer::public_transfer<GoldTrophy09>(v2, v0.owner);
            award_tail(arg0, arg1, arg2, arg3, arg4, arg5, v0.owner, v1, 25 - v1, 1);
            return
        };
        if (v1 == 2) {
            let v3 = pop_silver_strict(arg2);
            0x2::transfer::public_transfer<SilverTrophy09>(v3, v0.owner);
            award_tail(arg0, arg1, arg2, arg3, arg4, arg5, v0.owner, v1, 25 - v1, 2);
            return
        };
        if (v1 == 3) {
            let v4 = pop_bronze_strict(arg2);
            0x2::transfer::public_transfer<BronzeTrophy09>(v4, v0.owner);
            award_tail(arg0, arg1, arg2, arg3, arg4, arg5, v0.owner, v1, 25 - v1, 3);
            return
        };
        award_tail(arg0, arg1, arg2, arg3, arg4, arg5, v0.owner, v1, 25 - v1, 0);
    }

    fun award_tail(arg0: &RacePool09, arg1: &mut ExperienceBank09, arg2: &mut PrizeVault09, arg3: bool, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: u64, arg9: u8) {
        let v0 = arg3 && arg7 == 18;
        if (v0) {
            let v1 = pop_ticket_strict(arg2);
            0x2::transfer::public_transfer<Ticket09NFT>(v1, arg6);
        };
        credit_exp(arg1, arg6, arg8);
        let v2 = AwardEvent{
            rank       : arg7,
            owner      : arg6,
            exp_amount : arg8,
            trophy     : arg9,
            ticket     : v0,
        };
        0x2::event::emit<AwardEvent>(v2);
        award_loop(arg0, arg1, arg2, arg3, arg4 + 1, arg5);
    }

    fun base_boost_from_code(arg0: u8) : (u64, u64, u64, u64, u64) {
        if (arg0 == 1) {
            return (1, 0, 0, 0, 0)
        };
        if (arg0 == 2) {
            return (0, 1, 0, 0, 0)
        };
        if (arg0 == 3) {
            return (0, 0, 1, 0, 0)
        };
        if (arg0 == 4) {
            return (0, 0, 0, 1, 0)
        };
        if (arg0 == 5) {
            return (0, 0, 0, 0, 1)
        };
        (1, 0, 0, 0, 0)
    }

    fun build_cfg(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>) : RaceConfig09 {
        RaceConfig09{
            laps           : arg0,
            base_per_mille : arg1,
            w_power        : arg2,
            w_aero         : arg3,
            w_brakes       : arg4,
            w_sosp         : arg5,
            syn_scale_bps  : 10000,
            syn_zero_bps   : 10000,
            syn            : arg6,
        }
    }

    fun clamp12(arg0: u64) : u64 {
        if (arg0 > 12) {
            12
        } else {
            arg0
        }
    }

    fun clamp_add1(arg0: u64) : u64 {
        if (arg0 >= 12) {
            12
        } else {
            arg0 + 1
        }
    }

    fun clone_loop(arg0: &vector<Participant>, arg1: &mut vector<Participant>, arg2: u64, arg3: u64) {
        if (arg2 >= arg3) {
            return
        };
        0x1::vector::push_back<Participant>(arg1, *0x1::vector::borrow<Participant>(arg0, arg2));
        clone_loop(arg0, arg1, arg2 + 1, arg3);
    }

    fun clone_participants(arg0: &vector<Participant>) : vector<Participant> {
        let v0 = 0x1::vector::empty<Participant>();
        let v1 = &mut v0;
        clone_loop(arg0, v1, 0, 0x1::vector::length<Participant>(arg0));
        v0
    }

    fun compute_all_total_times(arg0: &RaceConfig09, arg1: &mut vector<Participant>) {
        let v0 = 0x1::vector::length<Participant>(arg1);
        compute_total_time_0(arg0, arg1, v0);
    }

    fun compute_total_time(arg0: &RaceConfig09, arg1: &mut vector<Participant>, arg2: u64) {
        let v0 = 0x1::vector::borrow<Participant>(arg1, arg2);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, v0.power);
        0x1::vector::push_back<u64>(&mut v1, v0.timelap);
        0x1::vector::push_back<u64>(&mut v1, v0.aero);
        0x1::vector::push_back<u64>(&mut v1, v0.brakes);
        0x1::vector::push_back<u64>(&mut v1, v0.sosp);
        let (v2, v3, v4, v5, v6) = apply_synergies(&v1, arg0);
        let v7 = v2 * arg0.w_power + v4 * arg0.w_aero + v5 * arg0.w_brakes + v6 * arg0.w_sosp;
        let v8 = if (v7 >= arg0.base_per_mille) {
            1
        } else {
            let v9 = arg0.base_per_mille - v7;
            if (v9 < 1) {
                1
            } else {
                v9
            }
        };
        0x1::vector::borrow_mut<Participant>(arg1, arg2).total_time = v3 * v8 / 1000 * arg0.laps;
    }

    fun compute_total_time_0(arg0: &RaceConfig09, arg1: &mut vector<Participant>, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = arg2 - 1;
        compute_total_time(arg0, arg1, v0);
        compute_total_time_0(arg0, arg1, v0);
    }

    fun contains_address(arg0: &vector<address>, arg1: address) : bool {
        contains_loop(arg0, arg1, 0, 0x1::vector::length<address>(arg0))
    }

    fun contains_loop(arg0: &vector<address>, arg1: address, arg2: u64, arg3: u64) : bool {
        if (arg2 >= arg3) {
            return false
        };
        if (*0x1::vector::borrow<address>(arg0, arg2) == arg1) {
            return true
        };
        contains_loop(arg0, arg1, arg2 + 1, arg3)
    }

    public entry fun create_experience_bank09(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        let v0 = ExperienceBank09{
            id       : 0x2::object::new(arg0),
            addrs    : 0x1::vector::empty<address>(),
            balances : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::share_object<ExperienceBank09>(v0);
    }

    public entry fun create_pool09_custom(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        assert!(0x1::vector::length<u64>(&arg6) == 25, 8100);
        let v0 = RaceConfig09{
            laps           : arg0,
            base_per_mille : arg1,
            w_power        : arg2,
            w_aero         : arg3,
            w_brakes       : arg4,
            w_sosp         : arg5,
            syn_scale_bps  : 10000,
            syn_zero_bps   : 10000,
            syn            : arg6,
        };
        share_pool_with_config(v0, arg7);
    }

    public entry fun create_pool09_preset_bal(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        share_pool_with_config(preset_balanced(arg0, arg1), arg2);
    }

    public entry fun create_pool09_preset_bg(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        share_pool_with_config(preset_bumpy_gp(arg0, arg1), arg2);
    }

    public entry fun create_pool09_preset_hd(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        share_pool_with_config(preset_high_downforce(arg0, arg1), arg2);
    }

    public entry fun create_pool09_preset_pc(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        share_pool_with_config(preset_power_circuit(arg0, arg1), arg2);
    }

    public entry fun create_pool09_preset_sg(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        share_pool_with_config(preset_stop_and_go(arg0, arg1), arg2);
    }

    public entry fun create_prize_vault09(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        let v0 = PrizeVault09{
            id      : 0x2::object::new(arg0),
            gold    : 0x1::vector::empty<GoldTrophy09>(),
            silver  : 0x1::vector::empty<SilverTrophy09>(),
            bronze  : 0x1::vector::empty<BronzeTrophy09>(),
            tickets : 0x1::vector::empty<Ticket09NFT>(),
        };
        0x2::transfer::share_object<PrizeVault09>(v0);
    }

    fun credit_exp(arg0: &mut ExperienceBank09, arg1: address, arg2: u64) {
        let (v0, v1) = find_index(&arg0.addrs, arg1, 0, 0x1::vector::length<address>(&arg0.addrs));
        if (v0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.balances, v1) = *0x1::vector::borrow<u64>(&arg0.balances, v1) + arg2;
        } else {
            0x1::vector::push_back<address>(&mut arg0.addrs, arg1);
            0x1::vector::push_back<u64>(&mut arg0.balances, arg2);
        };
    }

    fun debit_exp(arg0: &mut ExperienceBank09, arg1: address, arg2: u64) {
        let (v0, v1) = find_index(&arg0.addrs, arg1, 0, 0x1::vector::length<address>(&arg0.addrs));
        assert!(v0, 7001);
        let v2 = *0x1::vector::borrow<u64>(&arg0.balances, v1);
        assert!(v2 >= arg2, 7002);
        *0x1::vector::borrow_mut<u64>(&mut arg0.balances, v1) = v2 - arg2;
    }

    public entry fun deposit_bronze(arg0: &mut PrizeVault09, arg1: BronzeTrophy09, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        0x1::vector::push_back<BronzeTrophy09>(&mut arg0.bronze, arg1);
    }

    public entry fun deposit_gold(arg0: &mut PrizeVault09, arg1: GoldTrophy09, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        0x1::vector::push_back<GoldTrophy09>(&mut arg0.gold, arg1);
    }

    public entry fun deposit_silver(arg0: &mut PrizeVault09, arg1: SilverTrophy09, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        0x1::vector::push_back<SilverTrophy09>(&mut arg0.silver, arg1);
    }

    public entry fun deposit_ticket(arg0: &mut PrizeVault09, arg1: Ticket09NFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        0x1::vector::push_back<Ticket09NFT>(&mut arg0.tickets, arg1);
    }

    fun enc_bps(arg0: u64, arg1: bool) : u64 {
        if (!arg1) {
            10000 + arg0
        } else {
            10000 - arg0
        }
    }

    public entry fun enter_race09(arg0: &mut RacePool09, arg1: MONSTER09, arg2: Ticket09NFT, arg3: &Pilota09NFT, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.started, 1100);
        assert!(0x1::vector::length<Participant>(&arg0.participants) < 24, 1101);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        assert!(!contains_address(&arg0.used_monsters, v0), 1104);
        assert!(!contains_address(&arg0.used_pilots, v1), 1105);
        0x2::transfer::public_transfer<Ticket09NFT>(arg2, 0x2::tx_context::sender(arg4));
        let (v2, v3, v4, v5, v6) = apply_pilot_boosts_m(&arg1, arg3);
        let v7 = Participant{
            owner         : 0x2::tx_context::sender(arg4),
            monster_level : arg1.level,
            power         : v2,
            timelap       : v3,
            aero          : v4,
            brakes        : v5,
            sosp          : v6,
            total_time    : 0,
        };
        0x1::vector::push_back<Participant>(&mut arg0.participants, v7);
        0x1::vector::push_back<address>(&mut arg0.used_monsters, v0);
        0x1::vector::push_back<address>(&mut arg0.used_pilots, v1);
        0x2::transfer::public_transfer<MONSTER09>(arg1, 0x2::tx_context::sender(arg4));
    }

    public entry fun exp_upgrade_monster(arg0: &mut ExperienceBank09, arg1: &mut MONSTER09, arg2: &Meccanico09NFT, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg1.level + 1;
        assert!(v1 <= arg1.level_cap, 7101);
        let v2 = quote_monster_upgrade_cost(arg1, arg3);
        debit_exp(arg0, v0, v2);
        if (arg3 == 1) {
            arg1.power = clamp_add1(arg1.power);
        } else if (arg3 == 2) {
            arg1.timelap = clamp_add1(arg1.timelap);
        } else if (arg3 == 3) {
            arg1.aero = clamp_add1(arg1.aero);
        } else if (arg3 == 4) {
            arg1.brakes = clamp_add1(arg1.brakes);
        } else {
            assert!(arg3 == 5, 7102);
            arg1.sosp = clamp_add1(arg1.sosp);
        };
        arg1.level = v1;
        let v3 = UpgradeEvent{
            owner     : v0,
            target    : 1,
            stat      : arg3,
            new_level : v1,
            cost      : v2,
            nft       : 0x2::object::uid_to_address(&arg1.id),
        };
        0x2::event::emit<UpgradeEvent>(v3);
    }

    public entry fun exp_upgrade_pilot(arg0: &mut ExperienceBank09, arg1: &mut Pilota09NFT, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.level + 1;
        assert!(v1 <= arg1.level_cap, 7201);
        let v2 = quote_pilot_upgrade_cost(arg1, arg2);
        debit_exp(arg0, v0, v2);
        if (arg2 == 1) {
            arg1.boost_power = clamp_add1(arg1.boost_power);
        } else if (arg2 == 2) {
            arg1.boost_timelap = clamp_add1(arg1.boost_timelap);
        } else if (arg2 == 3) {
            arg1.boost_aero = clamp_add1(arg1.boost_aero);
        } else if (arg2 == 4) {
            arg1.boost_brakes = clamp_add1(arg1.boost_brakes);
        } else {
            assert!(arg2 == 5, 7202);
            arg1.boost_sosp = clamp_add1(arg1.boost_sosp);
        };
        arg1.level = v1;
        let v3 = UpgradeEvent{
            owner     : v0,
            target    : 2,
            stat      : arg2,
            new_level : v1,
            cost      : v2,
            nft       : 0x2::object::uid_to_address(&arg1.id),
        };
        0x2::event::emit<UpgradeEvent>(v3);
    }

    fun find_index(arg0: &vector<address>, arg1: address, arg2: u64, arg3: u64) : (bool, u64) {
        if (arg2 >= arg3) {
            return (false, 0)
        };
        if (*0x1::vector::borrow<address>(arg0, arg2) == arg1) {
            return (true, arg2)
        };
        find_index(arg0, arg1, arg2 + 1, arg3)
    }

    fun find_min_index(arg0: &mut vector<Participant>, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg2
        };
        let v0 = arg1 - 1;
        let v1 = if (0x1::vector::borrow<Participant>(arg0, v0).total_time < 0x1::vector::borrow<Participant>(arg0, arg2).total_time) {
            v0
        } else {
            arg2
        };
        find_min_index(arg0, v0, v1)
    }

    public entry fun finish_race09(arg0: &mut RacePool09, arg1: &mut ExperienceBank09, arg2: &mut PrizeVault09, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        assert!(arg0.started, 1300);
        let v0 = &mut arg0.participants;
        compute_all_total_times(&arg0.config, v0);
        let v1 = &mut arg0.participants;
        sort_by_time(v1);
        arg0.last_results = clone_participants(&arg0.participants);
        award_loop(arg0, arg1, arg2, arg3, 0, 0x1::vector::length<Participant>(&arg0.participants));
        let v2 = RaceLifecycleEvent{code: 2};
        0x2::event::emit<RaceLifecycleEvent>(v2);
    }

    public fun get_exp(arg0: &ExperienceBank09, arg1: address) : u64 {
        let (v0, v1) = find_index(&arg0.addrs, arg1, 0, 0x1::vector::length<address>(&arg0.addrs));
        if (v0) {
            *0x1::vector::borrow<u64>(&arg0.balances, v1)
        } else {
            0
        }
    }

    fun get_syn(arg0: &RaceConfig09, arg1: u8, arg2: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.syn, to_u64_idx(arg1) * 5 + to_u64_idx(arg2))
    }

    public fun init_display_monster09(arg0: InitDisplayMonster09, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<InitDisplayMonster09>(arg0, arg1);
        let v1 = 0x2::display::new<MONSTER09>(&v0, arg1);
        0x2::display::add<MONSTER09>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MONSTER09>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"4d6f6e7374657220237b6e616d657d20e2809420706f776572207b706f7765727d2c206165726f207b6165726f7d2c206272616b6573207b6272616b65737d2c20736f7370207b736f73707d2c206c6170207b74696d656c61707d"));
        0x2::display::add<MONSTER09>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::add<MONSTER09>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://your-site.example/monster/{id}"));
        0x2::display::add<MONSTER09>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://your-site.example"));
        0x2::display::update_version<MONSTER09>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<MONSTER09>>(v1);
        0x2::transfer::public_share_object<0x2::package::Publisher>(v0);
    }

    public entry fun init_display_monster09_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitDisplayMonster09{dummy_field: false};
        init_display_monster09(v0, arg0);
    }

    public fun init_display_pilota09(arg0: InitDisplayPilota09, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<InitDisplayPilota09>(arg0, arg1);
        let v1 = 0x2::display::new<Pilota09NFT>(&v0, arg1);
        0x2::display::add<Pilota09NFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Pilota09NFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"50696c6f746120237b6e616d657d20e28094204c766c207b6c6576656c7d2f7b6c6576656c5f6361707d20e2809420626f6f7374733a20507b626f6f73745f706f7765727d20417b626f6f73745f6165726f7d20427b626f6f73745f6272616b65737d20537b626f6f73745f736f73707d20547b626f6f73745f74696d656c61707d"));
        0x2::display::add<Pilota09NFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::add<Pilota09NFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://your-site.example"));
        0x2::display::update_version<Pilota09NFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<Pilota09NFT>>(v1);
        0x2::transfer::public_share_object<0x2::package::Publisher>(v0);
    }

    public entry fun init_display_pilota09_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitDisplayPilota09{dummy_field: false};
        init_display_pilota09(v0, arg0);
    }

    public fun init_display_ticket09(arg0: InitDisplayTicket09, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<InitDisplayTicket09>(arg0, arg1);
        let v1 = 0x2::display::new<Ticket09NFT>(&v0, arg1);
        0x2::display::add<Ticket09NFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Ticket09NFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Ticket valido per: {valid_for}"));
        0x2::display::add<Ticket09NFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::update_version<Ticket09NFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<Ticket09NFT>>(v1);
        0x2::transfer::public_share_object<0x2::package::Publisher>(v0);
    }

    public entry fun init_display_ticket09_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitDisplayTicket09{dummy_field: false};
        init_display_ticket09(v0, arg0);
    }

    public fun init_display_trophies09(arg0: InitDisplayTrophies09, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<InitDisplayTrophies09>(arg0, arg1);
        let v1 = 0x2::display::new<GoldTrophy09>(&v0, arg1);
        0x2::display::add<GoldTrophy09>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<GoldTrophy09>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::update_version<GoldTrophy09>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<GoldTrophy09>>(v1);
        let v2 = 0x2::display::new<SilverTrophy09>(&v0, arg1);
        0x2::display::add<SilverTrophy09>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SilverTrophy09>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::update_version<SilverTrophy09>(&mut v2);
        0x2::transfer::public_share_object<0x2::display::Display<SilverTrophy09>>(v2);
        let v3 = 0x2::display::new<BronzeTrophy09>(&v0, arg1);
        0x2::display::add<BronzeTrophy09>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BronzeTrophy09>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::update_version<BronzeTrophy09>(&mut v3);
        0x2::transfer::public_share_object<0x2::display::Display<BronzeTrophy09>>(v3);
        0x2::transfer::public_share_object<0x2::package::Publisher>(v0);
    }

    public entry fun init_display_trophies09_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitDisplayTrophies09{dummy_field: false};
        init_display_trophies09(v0, arg0);
    }

    public entry fun mint_meccanico09(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        let v0 = Meccanico09NFT{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            bravura : arg1,
            image   : arg2,
        };
        0x2::transfer::public_transfer<Meccanico09NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_monster09(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 0);
        assert!(arg1 >= 1, 10001);
        let v0 = MONSTER09{
            id           : 0x2::object::new(arg8),
            name         : arg0,
            level        : 0,
            level_cap    : arg1,
            power        : clamp12(arg2),
            timelap      : clamp12(arg3),
            aero         : clamp12(arg4),
            brakes       : clamp12(arg5),
            sosp         : clamp12(arg6),
            image        : arg7,
            adv_unlocked : 0,
            adv_unspent  : 0,
        };
        0x2::transfer::public_transfer<MONSTER09>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun mint_pilota09(arg0: 0x1::string::String, arg1: u64, arg2: u8, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        assert!(arg1 >= 1, 10002);
        let (v0, v1, v2, v3, v4) = base_boost_from_code(arg2);
        let v5 = Pilota09NFT{
            id            : 0x2::object::new(arg4),
            name          : arg0,
            level         : 0,
            level_cap     : arg1,
            boost_power   : v0,
            boost_timelap : v1,
            boost_aero    : v2,
            boost_brakes  : v3,
            boost_sosp    : v4,
            image         : arg3,
            adv_unlocked  : 0,
            adv_unspent   : 0,
        };
        0x2::transfer::public_transfer<Pilota09NFT>(v5, 0x2::tx_context::sender(arg4));
    }

    public entry fun mint_ticket09(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        let v0 = Ticket09NFT{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            valid_for : arg1,
            image     : arg2,
        };
        0x2::transfer::public_transfer<Ticket09NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_trophy_bronze09(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        let v0 = BronzeTrophy09{
            id    : 0x2::object::new(arg1),
            name  : 0x1::string::utf8(b"Bronze Trophy"),
            image : arg0,
        };
        0x2::transfer::public_transfer<BronzeTrophy09>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_trophy_gold09(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        let v0 = GoldTrophy09{
            id    : 0x2::object::new(arg1),
            name  : 0x1::string::utf8(b"Gold Trophy"),
            image : arg0,
        };
        0x2::transfer::public_transfer<GoldTrophy09>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_trophy_silver09(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        let v0 = SilverTrophy09{
            id    : 0x2::object::new(arg1),
            name  : 0x1::string::utf8(b"Silver Trophy"),
            image : arg0,
        };
        0x2::transfer::public_transfer<SilverTrophy09>(v0, 0x2::tx_context::sender(arg1));
    }

    fun pop_bronze_strict(arg0: &mut PrizeVault09) : BronzeTrophy09 {
        assert!(0x1::vector::length<BronzeTrophy09>(&arg0.bronze) > 0, 9003);
        0x1::vector::pop_back<BronzeTrophy09>(&mut arg0.bronze)
    }

    fun pop_gold_strict(arg0: &mut PrizeVault09) : GoldTrophy09 {
        assert!(0x1::vector::length<GoldTrophy09>(&arg0.gold) > 0, 9001);
        0x1::vector::pop_back<GoldTrophy09>(&mut arg0.gold)
    }

    fun pop_silver_strict(arg0: &mut PrizeVault09) : SilverTrophy09 {
        assert!(0x1::vector::length<SilverTrophy09>(&arg0.silver) > 0, 9002);
        0x1::vector::pop_back<SilverTrophy09>(&mut arg0.silver)
    }

    fun pop_ticket_strict(arg0: &mut PrizeVault09) : Ticket09NFT {
        assert!(0x1::vector::length<Ticket09NFT>(&arg0.tickets) > 0, 9004);
        0x1::vector::pop_back<Ticket09NFT>(&mut arg0.tickets)
    }

    fun preset_balanced(arg0: u64, arg1: u64) : RaceConfig09 {
        build_cfg(arg0, arg1, 10, 10, 10, 10, syn_zero())
    }

    fun preset_bumpy_gp(arg0: u64, arg1: u64) : RaceConfig09 {
        let v0 = syn_zero();
        let v1 = &mut v0;
        syn_set(v1, 1, 4, enc_bps(1200, true));
        let v2 = &mut v0;
        syn_set(v2, 1, 3, enc_bps(700, true));
        let v3 = &mut v0;
        syn_set(v3, 1, 0, enc_bps(300, false));
        build_cfg(arg0, arg1, 9, 8, 10, 13, v0)
    }

    fun preset_high_downforce(arg0: u64, arg1: u64) : RaceConfig09 {
        let v0 = syn_zero();
        let v1 = &mut v0;
        syn_set(v1, 1, 2, enc_bps(1500, true));
        let v2 = &mut v0;
        syn_set(v2, 1, 3, enc_bps(800, true));
        let v3 = &mut v0;
        syn_set(v3, 1, 4, enc_bps(600, true));
        let v4 = &mut v0;
        syn_set(v4, 1, 0, enc_bps(400, false));
        let v5 = &mut v0;
        syn_set(v5, 0, 2, enc_bps(300, false));
        build_cfg(arg0, arg1, 8, 14, 8, 6, v0)
    }

    fun preset_power_circuit(arg0: u64, arg1: u64) : RaceConfig09 {
        let v0 = syn_zero();
        let v1 = &mut v0;
        syn_set(v1, 1, 0, enc_bps(500, false));
        let v2 = &mut v0;
        syn_set(v2, 0, 2, enc_bps(200, false));
        build_cfg(arg0, arg1, 15, 6, 5, 4, v0)
    }

    fun preset_stop_and_go(arg0: u64, arg1: u64) : RaceConfig09 {
        let v0 = syn_zero();
        let v1 = &mut v0;
        syn_set(v1, 1, 0, enc_bps(600, false));
        let v2 = &mut v0;
        syn_set(v2, 1, 3, enc_bps(1200, true));
        build_cfg(arg0, arg1, 12, 6, 14, 6, v0)
    }

    public fun quote_monster_upgrade_cost(arg0: &MONSTER09, arg1: u8) : u64 {
        let v0 = if (arg1 == 1) {
            10
        } else if (arg1 == 2) {
            30
        } else if (arg1 == 3) {
            12
        } else if (arg1 == 4) {
            11
        } else if (arg1 == 5) {
            9
        } else {
            0
        };
        (arg0.level + 1) * 10 * v0
    }

    public fun quote_pilot_upgrade_cost(arg0: &Pilota09NFT, arg1: u8) : u64 {
        let v0 = if (arg1 == 1) {
            12
        } else if (arg1 == 2) {
            36
        } else if (arg1 == 3) {
            14
        } else if (arg1 == 4) {
            12
        } else if (arg1 == 5) {
            10
        } else {
            0
        };
        (arg0.level + 1) * 15 * v0
    }

    public entry fun reset_pool09(arg0: &mut RacePool09, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        arg0.participants = 0x1::vector::empty<Participant>();
        arg0.used_monsters = 0x1::vector::empty<address>();
        arg0.used_pilots = 0x1::vector::empty<address>();
        arg0.started = arg1;
        let v0 = RaceLifecycleEvent{code: 3};
        0x2::event::emit<RaceLifecycleEvent>(v0);
    }

    fun share_pool_with_config(arg0: RaceConfig09, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.laps >= 1, 8001);
        assert!(arg0.base_per_mille >= 1, 8002);
        let v0 = RacePool09{
            id            : 0x2::object::new(arg1),
            config        : arg0,
            participants  : 0x1::vector::empty<Participant>(),
            used_monsters : 0x1::vector::empty<address>(),
            used_pilots   : 0x1::vector::empty<address>(),
            started       : false,
            last_results  : 0x1::vector::empty<Participant>(),
        };
        0x2::transfer::share_object<RacePool09>(v0);
    }

    fun sort_by_time(arg0: &mut vector<Participant>) {
        let v0 = 0x1::vector::length<Participant>(arg0);
        sort_recursive(arg0, v0);
    }

    fun sort_recursive(arg0: &mut vector<Participant>, arg1: u64) {
        if (arg1 <= 1) {
            return
        };
        let v0 = arg1 - 1;
        let v1 = find_min_index(arg0, v0, v0);
        swap(arg0, v0, v1);
        sort_recursive(arg0, v0);
    }

    public entry fun start_race09(arg0: &mut RacePool09, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 90000);
        assert!(!arg0.started, 1200);
        assert!(0x1::vector::length<Participant>(&arg0.participants) >= 2, 1201);
        arg0.started = true;
        let v0 = RaceLifecycleEvent{code: 1};
        0x2::event::emit<RaceLifecycleEvent>(v0);
    }

    fun syn_set(arg0: &mut vector<u64>, arg1: u8, arg2: u8, arg3: u64) {
        *0x1::vector::borrow_mut<u64>(arg0, to_u64_idx(arg1) * 5 + to_u64_idx(arg2)) = arg3;
    }

    fun syn_zero() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        syn_zero_fill(v1, 0, 25);
        v0
    }

    fun syn_zero_fill(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        if (arg1 >= arg2) {
            return
        };
        0x1::vector::push_back<u64>(arg0, 10000);
        syn_zero_fill(arg0, arg1 + 1, arg2);
    }

    fun to_u64_idx(arg0: u8) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            2
        } else if (arg0 == 3) {
            3
        } else {
            4
        }
    }

    // decompiled from Move bytecode v6
}

