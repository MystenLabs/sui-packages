module 0xf3e7f9a28f3f1872b440813b1ba15451af2b7eb3e6680e995b4d9706d0339074::mint_racepool02 {
    struct MONSTER02 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power: u64,
        timelap: u64,
        coef: u64,
        image: 0x1::string::String,
    }

    struct UpgradeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power: u64,
        timelap: u64,
        coef: u64,
        image: 0x1::string::String,
    }

    struct TicketNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        valid_for: 0x1::string::String,
    }

    struct MeccanicoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        bravura: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct PilotaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        aggressivita: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct TrofeoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Participant has copy, drop, store {
        owner: address,
        power: u64,
        timelap: u64,
        coef: u64,
        total_time: u64,
    }

    struct RacePool has store, key {
        id: 0x2::object::UID,
        participants: vector<Participant>,
        started: bool,
    }

    fun swap(arg0: &mut vector<Participant>, arg1: u64, arg2: u64) {
        if (arg1 == arg2) {
            return
        };
        *0x1::vector::borrow_mut<Participant>(arg0, arg1) = *0x1::vector::borrow<Participant>(arg0, arg2);
        *0x1::vector::borrow_mut<Participant>(arg0, arg2) = *0x1::vector::borrow<Participant>(arg0, arg1);
    }

    fun compute_all_total_times(arg0: &mut vector<Participant>) {
        let v0 = 0x1::vector::length<Participant>(arg0);
        compute_total_time_0(arg0, v0);
    }

    fun compute_total_time(arg0: &mut vector<Participant>, arg1: u64) {
        let v0 = 0x1::vector::borrow<Participant>(arg0, arg1);
        let v1 = v0.timelap;
        let v2 = v0.coef;
        0x1::vector::borrow_mut<Participant>(arg0, arg1).total_time = v1 * (v2 + 0) / 100 + v1 * (v2 + 3) / 100 + v1 * (v2 + 6) / 100 + v1 * (v2 + 9) / 100 + v1 * (v2 + 12) / 100 + v1 * (v2 + 0) / 100 + v1 * (v2 + 3) / 100 + v1 * (v2 + 6) / 100 + v1 * (v2 + 9) / 100 + v1 * (v2 + 12) / 100;
    }

    fun compute_total_time_0(arg0: &mut vector<Participant>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = arg1 - 1;
        compute_total_time(arg0, v0);
        compute_total_time_0(arg0, v0);
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 100);
        let v0 = RacePool{
            id           : 0x2::object::new(arg0),
            participants : 0x1::vector::empty<Participant>(),
            started      : false,
        };
        0x2::transfer::share_object<RacePool>(v0);
    }

    public entry fun enter_race(arg0: &mut RacePool, arg1: MONSTER02, arg2: TicketNFT, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.started, 101);
        assert!(0x1::vector::length<Participant>(&arg0.participants) < 8, 102);
        0x2::transfer::public_transfer<TicketNFT>(arg2, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
        let v0 = Participant{
            owner      : 0x2::tx_context::sender(arg3),
            power      : arg1.power,
            timelap    : arg1.timelap,
            coef       : arg1.coef,
            total_time : 0,
        };
        0x1::vector::push_back<Participant>(&mut arg0.participants, v0);
        0x2::transfer::public_transfer<MONSTER02>(arg1, 0x2::tx_context::sender(arg3));
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

    public entry fun mint_meccanico(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2);
        let v0 = MeccanicoNFT{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            bravura : arg1,
            image   : arg2,
        };
        0x2::transfer::public_transfer<MeccanicoNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_monster(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 0);
        let v0 = MONSTER02{
            id      : 0x2::object::new(arg5),
            name    : arg0,
            power   : arg1,
            timelap : arg2,
            coef    : arg3,
            image   : arg4,
        };
        0x2::transfer::public_transfer<MONSTER02>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun mint_pilota(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 3);
        let v0 = PilotaNFT{
            id           : 0x2::object::new(arg3),
            name         : arg0,
            aggressivita : arg1,
            image        : arg2,
        };
        0x2::transfer::public_transfer<PilotaNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_ticket(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 98);
        let v0 = TicketNFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            valid_for : arg1,
        };
        0x2::transfer::public_transfer<TicketNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_trofeo(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 4);
        let v0 = TrofeoNFT{
            id    : 0x2::object::new(arg2),
            name  : arg0,
            image : arg1,
        };
        0x2::transfer::public_transfer<TrofeoNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_upgrade(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 1);
        let v0 = UpgradeNFT{
            id      : 0x2::object::new(arg5),
            name    : arg0,
            power   : arg1,
            timelap : arg2,
            coef    : arg3,
            image   : arg4,
        };
        0x2::transfer::public_transfer<UpgradeNFT>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun reset_pool(arg0: &mut RacePool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 300);
        assert!(arg0.started, 301);
        arg0.participants = 0x1::vector::empty<Participant>();
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

    public entry fun start_race(arg0: &mut RacePool, arg1: &mut 0x2::tx_context::TxContext) {
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

