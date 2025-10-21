module 0x68243fe9679455fdef85af33d483ea9f9655136ff12d6108a112dc70e9555f99::the_game_lord_of_towers {
    struct Race has copy, drop, store {
        kind: u8,
    }

    struct ArmyCounter has store, key {
        id: 0x2::object::UID,
        total_armies_created: u64,
    }

    struct Army has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        owner: address,
        race: Race,
        army_number: u64,
        hero_id: 0x2::object::ID,
        tower_id: 0x2::object::ID,
        equipment_ids: vector<0x2::object::ID>,
    }

    struct Tower has store, key {
        id: 0x2::object::UID,
        race: Race,
        tower_type: u8,
        rarity: u8,
        damage: u64,
        penetration: u64,
        accuracy: u64,
        position_x: u64,
        position_y: u64,
    }

    struct Hero has store, key {
        id: 0x2::object::UID,
        race: Race,
        hero_type: u8,
        health: u64,
        attack: u64,
        speed: u64,
        position_x: u64,
        position_y: u64,
    }

    struct Equipment has store, key {
        id: 0x2::object::UID,
        equipment_type: u8,
        bonus_damage: u64,
        bonus_health: u64,
        bonus_speed: u64,
    }

    struct Enemy has copy, drop {
        enemy_kind: u8,
        health: u64,
        speed: u64,
        wave: u64,
        position_x: u64,
        position_y: u64,
    }

    struct GameState has store, key {
        id: 0x2::object::UID,
        player: address,
        wave_count: u64,
        counter_id: 0x2::object::ID,
        tower_id: 0x2::object::ID,
        hero_id: 0x2::object::ID,
        equipment_ids: vector<0x2::object::ID>,
    }

    struct GameEvent has copy, drop {
        message: vector<u8>,
        player: address,
        wave_count: u64,
    }

    public fun complete_wave(arg0: &mut GameState, arg1: &mut 0x68243fe9679455fdef85af33d483ea9f9655136ff12d6108a112dc70e9555f99::counter::Counter, arg2: &Tower, arg3: &Hero, arg4: &0x2::tx_context::TxContext) {
        0x68243fe9679455fdef85af33d483ea9f9655136ff12d6108a112dc70e9555f99::counter::increment(arg1, arg4);
        arg0.wave_count = 0x68243fe9679455fdef85af33d483ea9f9655136ff12d6108a112dc70e9555f99::counter::get_value(arg1);
        let v0 = GameEvent{
            message    : b"Wave completed with hero and tower!",
            player     : 0x2::tx_context::sender(arg4),
            wave_count : arg0.wave_count,
        };
        0x2::event::emit<GameEvent>(v0);
    }

    public fun create_equipment(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : Equipment {
        let (v0, v1, v2) = get_equipment_stats(arg0);
        Equipment{
            id             : 0x2::object::new(arg1),
            equipment_type : arg0,
            bonus_damage   : v0,
            bonus_health   : v1,
            bonus_speed    : v2,
        }
    }

    public fun create_hero(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Hero {
        let v0 = Race{kind: arg0};
        let (v1, v2, v3) = get_hero_stats(arg0, arg1);
        Hero{
            id         : 0x2::object::new(arg2),
            race       : v0,
            hero_type  : arg1,
            health     : v1,
            attack     : v2,
            speed      : v3,
            position_x : 0,
            position_y : 0,
        }
    }

    public fun create_rare_tower(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Tower {
        let v0 = Race{kind: arg0};
        let (v1, v2, v3) = get_tower_stats(arg0, arg1);
        Tower{
            id          : 0x2::object::new(arg2),
            race        : v0,
            tower_type  : arg1,
            rarity      : 1,
            damage      : v1 * 2,
            penetration : v2 + 10,
            accuracy    : v3 + 5,
            position_x  : 0,
            position_y  : 0,
        }
    }

    public fun create_tower(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Tower {
        let v0 = Race{kind: arg0};
        let (v1, v2, v3) = get_tower_stats(arg0, arg1);
        Tower{
            id          : 0x2::object::new(arg2),
            race        : v0,
            tower_type  : arg1,
            rarity      : 0,
            damage      : v1,
            penetration : v2,
            accuracy    : v3,
            position_x  : 0,
            position_y  : 0,
        }
    }

    public fun equip_item(arg0: &mut GameState, arg1: Equipment, arg2: &0x2::tx_context::TxContext) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.equipment_ids, 0x2::object::id<Equipment>(&arg1));
        0x2::transfer::public_transfer<Equipment>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun form_army(arg0: vector<u8>, arg1: u8, arg2: &mut ArmyCounter, arg3: &mut 0x2::tx_context::TxContext) {
        arg2.total_armies_created = arg2.total_armies_created + 1;
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = *0x1::vector::borrow<u8>(&v1, 20);
        0x2::object::delete(v0);
        let v3 = Race{kind: arg1};
        let v4 = create_hero(arg1, ((v2 % 2) as u8), arg3);
        let v5 = create_tower(arg1, ((v2 % 2) as u8), arg3);
        let v6 = create_equipment(((v2 % 3) as u8), arg3);
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v7, 0x2::object::id<Equipment>(&v6));
        let v8 = Army{
            id            : 0x2::object::new(arg3),
            name          : arg0,
            owner         : 0x2::tx_context::sender(arg3),
            race          : v3,
            army_number   : arg2.total_armies_created,
            hero_id       : 0x2::object::id<Hero>(&v4),
            tower_id      : 0x2::object::id<Tower>(&v5),
            equipment_ids : v7,
        };
        0x2::transfer::public_transfer<Hero>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<Tower>(v5, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<Equipment>(v6, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<Army>(v8, 0x2::tx_context::sender(arg3));
    }

    public fun get_army_number(arg0: &Army) : u64 {
        arg0.army_number
    }

    public fun get_counter_value(arg0: &ArmyCounter) : u64 {
        arg0.total_armies_created
    }

    public fun get_enemy_health(arg0: &Enemy) : u64 {
        arg0.health
    }

    public fun get_enemy_kind(arg0: &Enemy) : u8 {
        arg0.enemy_kind
    }

    public fun get_enemy_position(arg0: &Enemy) : (u64, u64) {
        (arg0.position_x, arg0.position_y)
    }

    public fun get_enemy_speed(arg0: &Enemy) : u64 {
        arg0.speed
    }

    fun get_enemy_stats(arg0: u8, arg1: u64) : (u64, u64) {
        if (arg0 == 0) {
            (100 * arg1, 50)
        } else if (arg0 == 1) {
            (100 * arg1 / 2, 50 + 20)
        } else {
            (100 * arg1 * 2, 50 + 10)
        }
    }

    public fun get_enemy_wave(arg0: &Enemy) : u64 {
        arg0.wave
    }

    public fun get_equipment_bonus_damage(arg0: &Equipment) : u64 {
        arg0.bonus_damage
    }

    public fun get_equipment_bonus_health(arg0: &Equipment) : u64 {
        arg0.bonus_health
    }

    public fun get_equipment_bonus_speed(arg0: &Equipment) : u64 {
        arg0.bonus_speed
    }

    fun get_equipment_stats(arg0: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            (20, 0, 0)
        } else if (arg0 == 1) {
            (0, 50, 0)
        } else {
            (0, 0, 10)
        }
    }

    public fun get_equipment_type(arg0: &Equipment) : u8 {
        arg0.equipment_type
    }

    public fun get_game_state_wave_count(arg0: &GameState) : u64 {
        arg0.wave_count
    }

    public fun get_hero_attack(arg0: &Hero) : u64 {
        arg0.attack
    }

    public fun get_hero_health(arg0: &Hero) : u64 {
        arg0.health
    }

    public fun get_hero_position(arg0: &Hero) : (u64, u64) {
        (arg0.position_x, arg0.position_y)
    }

    public fun get_hero_race_kind(arg0: &Hero) : u8 {
        arg0.race.kind
    }

    public fun get_hero_speed(arg0: &Hero) : u64 {
        arg0.speed
    }

    fun get_hero_stats(arg0: u8, arg1: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            if (arg1 == 0) {
                (100, 50, 70)
            } else {
                (80, 60, 60)
            }
        } else if (arg0 == 1) {
            if (arg1 == 0) {
                (90, 40, 90)
            } else {
                (70, 70, 80)
            }
        } else if (arg0 == 2) {
            if (arg1 == 0) {
                (120, 60, 50)
            } else {
                (100, 50, 60)
            }
        } else if (arg1 == 0) {
            (110, 70, 60)
        } else {
            (90, 80, 50)
        }
    }

    public fun get_hero_type(arg0: &Hero) : u8 {
        arg0.hero_type
    }

    public fun get_tower_accuracy(arg0: &Tower) : u64 {
        arg0.accuracy
    }

    public fun get_tower_damage(arg0: &Tower) : u64 {
        arg0.damage
    }

    public fun get_tower_penetration(arg0: &Tower) : u64 {
        arg0.penetration
    }

    public fun get_tower_position(arg0: &Tower) : (u64, u64) {
        (arg0.position_x, arg0.position_y)
    }

    public fun get_tower_race_kind(arg0: &Tower) : u8 {
        arg0.race.kind
    }

    public fun get_tower_rarity(arg0: &Tower) : u8 {
        arg0.rarity
    }

    fun get_tower_stats(arg0: u8, arg1: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            if (arg1 == 0) {
                (50, 20, 80)
            } else {
                (80, 30, 60)
            }
        } else if (arg0 == 1) {
            if (arg1 == 0) {
                (40, 15, 95)
            } else {
                (45, 10, 90)
            }
        } else if (arg0 == 2) {
            if (arg1 == 0) {
                (60, 50, 70)
            } else {
                (50, 60, 65)
            }
        } else if (arg1 == 0) {
            (70, 25, 60)
        } else {
            (90, 15, 55)
        }
    }

    public fun get_tower_type(arg0: &Tower) : u8 {
        arg0.tower_type
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArmyCounter{
            id                   : 0x2::object::new(arg0),
            total_armies_created : 0,
        };
        0x2::transfer::share_object<ArmyCounter>(v0);
    }

    public fun spawn_wave(arg0: u64) : vector<Enemy> {
        let v0 = if (arg0 > 0) {
            arg0
        } else {
            1
        };
        let v1 = 0x1::vector::empty<Enemy>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = ((v2 % 3) as u8);
            let (v4, v5) = get_enemy_stats(v3, arg0);
            let v6 = Enemy{
                enemy_kind : v3,
                health     : v4,
                speed      : v5,
                wave       : arg0,
                position_x : 100,
                position_y : 50,
            };
            0x1::vector::push_back<Enemy>(&mut v1, v6);
            v2 = v2 + 1;
        };
        v1
    }

    public fun transfer_equipment(arg0: Equipment, arg1: address) {
        0x2::transfer::public_transfer<Equipment>(arg0, arg1);
    }

    public fun transfer_hero(arg0: Hero, arg1: address) {
        0x2::transfer::public_transfer<Hero>(arg0, arg1);
    }

    public fun transfer_tower(arg0: Tower, arg1: address) {
        0x2::transfer::public_transfer<Tower>(arg0, arg1);
    }

    public fun update_hero_position(arg0: &mut Hero, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 < 100 && arg2 < 100, 1000);
        arg0.position_x = arg1;
        arg0.position_y = arg2;
    }

    public fun update_tower_position(arg0: &mut Tower, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 < 100 && arg2 < 100, 1000);
        arg0.position_x = arg1;
        arg0.position_y = arg2;
    }

    // decompiled from Move bytecode v6
}

