module 0xd3f5671825ee6237ddb3762541431e33645cc1038bd1276133bbbeccb29687bd::racepool03 {
    struct MONSTER03 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power: u64,
        top_speed: u64,
        timelap: u64,
        aero: u64,
        brakes: u64,
        sosp: u64,
        image: 0x1::string::String,
    }

    struct Ticket03NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        valid_for: 0x1::string::String,
    }

    struct Meccanico03NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        bravura: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Pilota03NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        boost_power: u64,
        boost_top_speed: u64,
        boost_timelap: u64,
        boost_aero: u64,
        boost_brakes: u64,
        boost_sosp: u64,
        image: 0x1::string::String,
    }

    struct LevelUpDriver03NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Upgrade03NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power_delta: u64,
        top_speed_delta: u64,
        timelap_delta: u64,
        aero_delta: u64,
        brakes_delta: u64,
        sosp_delta: u64,
        image: 0x1::string::String,
    }

    struct Participant has copy, drop, store {
        owner: address,
        power: u64,
        top_speed: u64,
        timelap: u64,
        aero: u64,
        brakes: u64,
        sosp: u64,
        total_time: u64,
    }

    struct RacePool03 has store, key {
        id: 0x2::object::UID,
        participants: vector<Participant>,
        used_monsters: vector<address>,
        used_pilots: vector<address>,
        started: bool,
    }

    fun swap(arg0: &mut vector<Participant>, arg1: u64, arg2: u64) {
        if (arg1 == arg2) {
            return
        };
        *0x1::vector::borrow_mut<Participant>(arg0, arg1) = *0x1::vector::borrow<Participant>(arg0, arg2);
        *0x1::vector::borrow_mut<Participant>(arg0, arg2) = *0x1::vector::borrow<Participant>(arg0, arg1);
    }

    fun active_params(arg0: &Pilota03NFT) : u64 {
        count_nonzero6(arg0.boost_power, arg0.boost_top_speed, arg0.boost_timelap, arg0.boost_aero, arg0.boost_brakes, arg0.boost_sosp)
    }

    fun apply_pilot_boosts(arg0: &MONSTER03, arg1: &Pilota03NFT) : (u64, u64, u64, u64, u64, u64) {
        let v0 = arg0.timelap;
        let v1 = if (v0 > arg1.boost_timelap) {
            v0 - arg1.boost_timelap
        } else {
            0
        };
        (arg0.power + arg1.boost_power, arg0.top_speed + arg1.boost_top_speed, v1, arg0.aero + arg1.boost_aero, arg0.brakes + arg1.boost_brakes, arg0.sosp + arg1.boost_sosp)
    }

    public entry fun apply_upgrade03(arg0: &mut MONSTER03, arg1: Upgrade03NFT, arg2: &Meccanico03NFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.timelap_delta;
        arg0.power = arg0.power + arg1.power_delta;
        arg0.top_speed = arg0.top_speed + arg1.top_speed_delta;
        arg0.aero = arg0.aero + arg1.aero_delta;
        arg0.brakes = arg0.brakes + arg1.brakes_delta;
        arg0.sosp = arg0.sosp + arg1.sosp_delta;
        if (arg0.timelap > v0) {
            arg0.timelap = arg0.timelap - v0;
        } else {
            arg0.timelap = 0;
        };
        0x2::transfer::public_transfer<Upgrade03NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    fun base_boost_from_code(arg0: u8) : (u64, u64, u64, u64, u64, u64) {
        if (arg0 == 1) {
            return (1, 0, 0, 0, 0, 0)
        };
        if (arg0 == 2) {
            return (0, 1, 0, 0, 0, 0)
        };
        if (arg0 == 3) {
            return (0, 0, 1, 0, 0, 0)
        };
        if (arg0 == 4) {
            return (0, 0, 0, 1, 0, 0)
        };
        if (arg0 == 5) {
            return (0, 0, 0, 0, 1, 0)
        };
        if (arg0 == 6) {
            return (0, 0, 0, 0, 0, 1)
        };
        (1, 0, 0, 0, 0, 0)
    }

    fun compute_all_total_times(arg0: &mut vector<Participant>) {
        let v0 = 0x1::vector::length<Participant>(arg0);
        compute_total_time_0(arg0, v0);
    }

    fun compute_total_time(arg0: &mut vector<Participant>, arg1: u64) {
        let v0 = 0x1::vector::borrow<Participant>(arg0, arg1);
        let v1 = v0.power / 10 + v0.top_speed / 10 + v0.aero / 20 + v0.brakes / 20 + v0.sosp / 20;
        let v2 = if (v1 >= 1049) {
            1
        } else {
            let v3 = 1050 - v1;
            if (v3 < 1) {
                1
            } else {
                v3
            }
        };
        0x1::vector::borrow_mut<Participant>(arg0, arg1).total_time = v0.timelap * v2 / 1000 * 10;
    }

    fun compute_total_time_0(arg0: &mut vector<Participant>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = arg1 - 1;
        compute_total_time(arg0, v0);
        compute_total_time_0(arg0, v0);
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

    fun count_nonzero6(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg0 > 0) {
            0 + 1
        } else {
            0
        };
        let v1 = if (arg1 > 0) {
            v0 + 1
        } else {
            v0
        };
        let v2 = if (arg2 > 0) {
            v1 + 1
        } else {
            v1
        };
        let v3 = if (arg3 > 0) {
            v2 + 1
        } else {
            v2
        };
        let v4 = if (arg4 > 0) {
            v3 + 1
        } else {
            v3
        };
        if (arg5 > 0) {
            v4 + 1
        } else {
            v4
        }
    }

    public entry fun create_pool03(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 100);
        let v0 = RacePool03{
            id            : 0x2::object::new(arg0),
            participants  : 0x1::vector::empty<Participant>(),
            used_monsters : 0x1::vector::empty<address>(),
            used_pilots   : 0x1::vector::empty<address>(),
            started       : false,
        };
        0x2::transfer::share_object<RacePool03>(v0);
    }

    public entry fun enter_race03(arg0: &mut RacePool03, arg1: MONSTER03, arg2: Ticket03NFT, arg3: &Pilota03NFT, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.started, 101);
        assert!(0x1::vector::length<Participant>(&arg0.participants) < 8, 102);
        assert!(active_params(arg3) <= arg3.level, 103);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        assert!(!contains_address(&arg0.used_monsters, v0), 104);
        assert!(!contains_address(&arg0.used_pilots, v1), 105);
        0x2::transfer::public_transfer<Ticket03NFT>(arg2, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
        let (v2, v3, v4, v5, v6, v7) = apply_pilot_boosts(&arg1, arg3);
        let v8 = Participant{
            owner      : 0x2::tx_context::sender(arg4),
            power      : v2,
            top_speed  : v3,
            timelap    : v4,
            aero       : v5,
            brakes     : v6,
            sosp       : v7,
            total_time : 0,
        };
        0x1::vector::push_back<Participant>(&mut arg0.participants, v8);
        0x1::vector::push_back<address>(&mut arg0.used_monsters, v0);
        0x1::vector::push_back<address>(&mut arg0.used_pilots, v1);
        0x2::transfer::public_transfer<MONSTER03>(arg1, 0x2::tx_context::sender(arg4));
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

    fun inc_boost_by_code(arg0: &mut Pilota03NFT, arg1: u8, arg2: u64) {
        if (arg1 == 1) {
            arg0.boost_power = arg0.boost_power + arg2;
        } else if (arg1 == 2) {
            arg0.boost_top_speed = arg0.boost_top_speed + arg2;
        } else if (arg1 == 3) {
            arg0.boost_timelap = arg0.boost_timelap + arg2;
        } else if (arg1 == 4) {
            arg0.boost_aero = arg0.boost_aero + arg2;
        } else if (arg1 == 5) {
            arg0.boost_brakes = arg0.boost_brakes + arg2;
        } else if (arg1 == 6) {
            arg0.boost_sosp = arg0.boost_sosp + arg2;
        };
    }

    fun is_active_param(arg0: &Pilota03NFT, arg1: u8) : bool {
        if (arg1 == 1) {
            return arg0.boost_power > 0
        };
        if (arg1 == 2) {
            return arg0.boost_top_speed > 0
        };
        if (arg1 == 3) {
            return arg0.boost_timelap > 0
        };
        if (arg1 == 4) {
            return arg0.boost_aero > 0
        };
        if (arg1 == 5) {
            return arg0.boost_brakes > 0
        };
        if (arg1 == 6) {
            return arg0.boost_sosp > 0
        };
        false
    }

    public entry fun mint_levelupdriver03(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 4);
        let v0 = LevelUpDriver03NFT{
            id    : 0x2::object::new(arg2),
            name  : arg0,
            image : arg1,
        };
        0x2::transfer::public_transfer<LevelUpDriver03NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_meccanico03(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2);
        let v0 = Meccanico03NFT{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            bravura : arg1,
            image   : arg2,
        };
        0x2::transfer::public_transfer<Meccanico03NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_monster03(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 0);
        let v0 = MONSTER03{
            id        : 0x2::object::new(arg8),
            name      : arg0,
            power     : arg1,
            top_speed : arg2,
            timelap   : arg3,
            aero      : arg4,
            brakes    : arg5,
            sosp      : arg6,
            image     : arg7,
        };
        0x2::transfer::public_transfer<MONSTER03>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun mint_pilota03(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 3);
        let (v0, v1, v2, v3, v4, v5) = base_boost_from_code(arg1);
        let v6 = Pilota03NFT{
            id              : 0x2::object::new(arg3),
            name            : arg0,
            level           : 1,
            boost_power     : v0,
            boost_top_speed : v1,
            boost_timelap   : v2,
            boost_aero      : v3,
            boost_brakes    : v4,
            boost_sosp      : v5,
            image           : arg2,
        };
        assert!(active_params(&v6) <= v6.level, 31);
        0x2::transfer::public_transfer<Pilota03NFT>(v6, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_ticket03(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 1);
        let v0 = Ticket03NFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            valid_for : arg1,
        };
        0x2::transfer::public_transfer<Ticket03NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_upgrade03(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 5);
        let v0 = Upgrade03NFT{
            id              : 0x2::object::new(arg8),
            name            : arg0,
            power_delta     : arg1,
            top_speed_delta : arg2,
            timelap_delta   : arg3,
            aero_delta      : arg4,
            brakes_delta    : arg5,
            sosp_delta      : arg6,
            image           : arg7,
        };
        0x2::transfer::public_transfer<Upgrade03NFT>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun pilot_add_point(arg0: &mut Pilota03NFT, arg1: LevelUpDriver03NFT, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = is_active_param(arg0, arg2);
        inc_boost_by_code(arg0, arg2, 1);
        if (!v0) {
            assert!(active_params(arg0) <= arg0.level, 42);
        };
        0x2::transfer::public_transfer<LevelUpDriver03NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    public entry fun pilot_level_up(arg0: &mut Pilota03NFT, arg1: LevelUpDriver03NFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.level < 6, 40);
        arg0.level = arg0.level + 1;
        assert!(active_params(arg0) <= arg0.level, 41);
        0x2::transfer::public_transfer<LevelUpDriver03NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    public entry fun reset_pool03(arg0: &mut RacePool03, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 300);
        assert!(arg0.started, 301);
        arg0.participants = 0x1::vector::empty<Participant>();
        arg0.used_monsters = 0x1::vector::empty<address>();
        arg0.used_pilots = 0x1::vector::empty<address>();
        arg0.started = false;
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

    public entry fun start_race03(arg0: &mut RacePool03, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 200);
        assert!(!arg0.started, 201);
        assert!(0x1::vector::length<Participant>(&arg0.participants) >= 2, 202);
        arg0.started = true;
        let v0 = &mut arg0.participants;
        compute_all_total_times(v0);
        let v1 = &mut arg0.participants;
        sort_by_time(v1);
    }

    // decompiled from Move bytecode v6
}

