module 0x1813f4a8709d73039cd7f7ddb5dd0fc791fd99dbb45f8dfbcd720697fa438459::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        price: u64,
        enabled: bool,
        treasury: address,
    }

    struct Monster has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        seed: u64,
        stage: u8,
        attack: u16,
        defense: u16,
        speed: u16,
        created_at: u64,
        last_breed: u64,
        wins: u16,
        losses: u16,
        xp: u32,
        scars: u8,
        broken_horns: u8,
        torn_wings: u8,
        parent1: 0x1::option::Option<0x2::object::ID>,
        parent2: 0x1::option::Option<0x2::object::ID>,
    }

    struct MintEvent has copy, drop {
        monster_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct BattleOutcome has copy, drop {
        winner_id: 0x2::object::ID,
        loser_id: 0x2::object::ID,
        winner_wins: u16,
        loser_losses: u16,
        winner_xp: u32,
        loser_xp: u32,
        loser_scars: u8,
        loser_broken_horns: u8,
        loser_torn_wings: u8,
    }

    struct BreedEvent has copy, drop {
        child_id: 0x2::object::ID,
        parent1: 0x2::object::ID,
        parent2: 0x2::object::ID,
        name: 0x1::string::String,
    }

    fun apply_damage(arg0: &mut Monster, arg1: u8) {
        if (arg0.scars < 255) {
            arg0.scars = arg0.scars + 1;
        };
        let v0 = arg0.stage;
        if (arg0.broken_horns == 0 && arg1 % 16 < 1 + v0) {
            arg0.broken_horns = 1;
        };
        if (arg0.torn_wings == 0 && (arg1 >> 4) % 16 < 1 + v0) {
            arg0.torn_wings = 1;
        };
    }

    public entry fun battle(arg0: &mut Monster, arg1: &mut Monster, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x2::random::generate_u8(&mut v0);
        let v2 = (v1 as u64);
        if ((arg0.attack as u64) + (arg0.speed as u64) + (arg0.stage as u64) * 10 + v2 >= (arg1.attack as u64) + (arg1.speed as u64) + (arg1.stage as u64) * 10 + 255 - v2) {
            arg0.wins = arg0.wins + 1;
            arg0.xp = arg0.xp + 10;
            arg1.losses = arg1.losses + 1;
            arg1.xp = arg1.xp + 2;
            apply_damage(arg1, v1);
            let v3 = BattleOutcome{
                winner_id          : 0x2::object::id<Monster>(arg0),
                loser_id           : 0x2::object::id<Monster>(arg1),
                winner_wins        : arg0.wins,
                loser_losses       : arg1.losses,
                winner_xp          : arg0.xp,
                loser_xp           : arg1.xp,
                loser_scars        : arg1.scars,
                loser_broken_horns : arg1.broken_horns,
                loser_torn_wings   : arg1.torn_wings,
            };
            0x2::event::emit<BattleOutcome>(v3);
        } else {
            arg1.wins = arg1.wins + 1;
            arg1.xp = arg1.xp + 10;
            arg0.losses = arg0.losses + 1;
            arg0.xp = arg0.xp + 2;
            apply_damage(arg0, v1);
            let v4 = BattleOutcome{
                winner_id          : 0x2::object::id<Monster>(arg1),
                loser_id           : 0x2::object::id<Monster>(arg0),
                winner_wins        : arg1.wins,
                loser_losses       : arg0.losses,
                winner_xp          : arg1.xp,
                loser_xp           : arg0.xp,
                loser_scars        : arg0.scars,
                loser_broken_horns : arg0.broken_horns,
                loser_torn_wings   : arg0.torn_wings,
            };
            0x2::event::emit<BattleOutcome>(v4);
        };
    }

    public fun body(arg0: &Monster) : u8 {
        (((arg0.seed >> 24) % 6) as u8)
    }

    public entry fun breed(arg0: &mut Monster, arg1: &mut Monster, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.stage >= 3 && arg1.stage >= 3, 100);
        assert!(v0 > arg0.last_breed + 86400000, 101);
        assert!(v0 > arg1.last_breed + 86400000, 101);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = arg0.seed ^ arg1.seed << 13 ^ arg1.seed >> 51 ^ 0x2::random::generate_u64(&mut v1);
        let v3 = 0x2::object::id<Monster>(arg0);
        let v4 = 0x2::object::id<Monster>(arg1);
        let v5 = Monster{
            id           : 0x2::object::new(arg4),
            name         : generate_name(v2),
            seed         : v2,
            stage        : 0,
            attack       : (arg0.attack + arg1.attack) / 2,
            defense      : (arg0.defense + arg1.defense) / 2,
            speed        : (arg0.speed + arg1.speed) / 2,
            created_at   : v0,
            last_breed   : 0,
            wins         : 0,
            losses       : 0,
            xp           : 0,
            scars        : 0,
            broken_horns : 0,
            torn_wings   : 0,
            parent1      : 0x1::option::some<0x2::object::ID>(v3),
            parent2      : 0x1::option::some<0x2::object::ID>(v4),
        };
        arg0.last_breed = v0;
        arg1.last_breed = v0;
        let v6 = BreedEvent{
            child_id : 0x2::object::id<Monster>(&v5),
            parent1  : v3,
            parent2  : v4,
            name     : v5.name,
        };
        0x2::event::emit<BreedEvent>(v6);
        0x2::transfer::public_transfer<Monster>(v5, 0x2::tx_context::sender(arg4));
    }

    public fun color(arg0: &Monster) : u8 {
        (((arg0.seed >> 56) % 6) as u8)
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun eyes(arg0: &Monster) : u8 {
        (((arg0.seed >> 32) % 5) as u8)
    }

    fun generate_name(arg0: u64) : 0x1::string::String {
        let v0 = vector[b"Zo", b"Lu", b"Ka", b"Py", b"Neo", b"Aqua", b"Sha", b"Elec", b"Ter", b"Vra"];
        let v1 = vector[b"nar", b"mov", b"vra", b"ram", b"mir", b"zoi", b"dow", b"lec", b"mot", b"vex"];
        let v2 = vector[b"ling", b"ra", b"mite", b"beast", b"moth", b"oid", b"born", b"max", b"nyx", b"zor"];
        let v3 = 0x1::vector::empty<u8>();
        let v4 = &mut v3;
        push_bytes(v4, 0x1::vector::borrow<vector<u8>>(&v0, (((arg0 >> 0) % 10) as u64)));
        let v5 = &mut v3;
        push_bytes(v5, 0x1::vector::borrow<vector<u8>>(&v1, (((arg0 >> 8) % 10) as u64)));
        let v6 = &mut v3;
        push_bytes(v6, 0x1::vector::borrow<vector<u8>>(&v2, (((arg0 >> 16) % 10) as u64)));
        0x1::string::utf8(v3)
    }

    public entry fun hatch(arg0: &mut Monster, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.created_at;
        let v1 = if (v0 < 86400000) {
            0
        } else if (v0 < 604800000) {
            1
        } else if (v0 < 2592000000) {
            2
        } else {
            3
        };
        if (v1 > arg0.stage) {
            arg0.stage = v1;
        };
    }

    public fun horns(arg0: &Monster) : u8 {
        (((arg0.seed >> 40) % 4) as u8)
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<MONSTER>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(x"416e617672696e204d6f6e7374657220e280a2205374616765207b73746167657d20e280a220573a7b77696e737d204c3a7b6c6f737365737d20e280a22053636172733a7b73636172737d"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://heart-beat-production.up.railway.app/nft/{id}.svg"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://anavrin.xyz"));
        let v6 = 0x2::display::new_with_fields<Monster>(&v1, v2, v4, arg1);
        0x2::display::update_version<Monster>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Monster>>(v6, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, v0);
        let v8 = MintConfig{
            id       : 0x2::object::new(arg1),
            price    : 0,
            enabled  : true,
            treasury : v0,
        };
        0x2::transfer::share_object<MintConfig>(v8);
    }

    public entry fun list_for_sale(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: Monster, arg3: u64) {
        0x2::kiosk::place_and_list<Monster>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 102);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.price, 102);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0x2::random::generate_u64(&mut v0);
        let v2 = Monster{
            id           : 0x2::object::new(arg4),
            name         : generate_name(v1),
            seed         : v1,
            stage        : 0,
            attack       : ((v1 % 50 + 10) as u16),
            defense      : (((v1 >> 8) % 50 + 10) as u16),
            speed        : (((v1 >> 16) % 50 + 10) as u16),
            created_at   : 0x2::clock::timestamp_ms(arg1),
            last_breed   : 0,
            wins         : 0,
            losses       : 0,
            xp           : 0,
            scars        : 0,
            broken_horns : 0,
            torn_wings   : 0,
            parent1      : 0x1::option::none<0x2::object::ID>(),
            parent2      : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = MintEvent{
            monster_id : 0x2::object::id<Monster>(&v2),
            owner      : 0x2::tx_context::sender(arg4),
            name       : v2.name,
        };
        0x2::event::emit<MintEvent>(v3);
        0x2::transfer::public_transfer<Monster>(v2, 0x2::tx_context::sender(arg4));
    }

    fun push_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_enabled(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.enabled = arg2;
    }

    public entry fun set_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.price = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun species(arg0: &Monster) : u8 {
        ((arg0.seed % 10) as u8)
    }

    public entry fun update_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<Monster>, arg2: 0x1::string::String) {
        0x2::display::edit<Monster>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<Monster>(arg1);
    }

    public fun wings(arg0: &Monster) : u8 {
        (((arg0.seed >> 48) % 3) as u8)
    }

    // decompiled from Move bytecode v6
}

